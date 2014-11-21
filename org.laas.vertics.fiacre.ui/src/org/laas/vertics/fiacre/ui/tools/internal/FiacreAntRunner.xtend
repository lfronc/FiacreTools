package org.laas.vertics.fiacre.ui.tools.internal

import java.io.BufferedReader
import java.io.File
import java.io.FileReader
import java.io.IOException
import java.nio.file.Files
import java.util.List
import org.eclipse.ant.core.AntRunner
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IResource
import org.eclipse.core.runtime.CoreException
import org.eclipse.core.runtime.FileLocator
import org.eclipse.core.runtime.IProgressMonitor
import org.eclipse.core.runtime.Path
import org.eclipse.jface.dialogs.MessageDialog
import org.eclipse.ui.IWorkbench
import org.eclipse.ui.console.ConsolePlugin
import org.eclipse.ui.console.MessageConsole
import org.eclipse.ui.console.MessageConsoleStream
import org.laas.vertics.fiacre.ui.internal.LangActivator
import org.laas.vertics.fiacre.ui.markers.FracMarkers
import org.laas.vertics.fiacre.ui.preferences.PreferenceConstants

class FiacreAntRunner {
	public static val SCRIPT = "compile.xml"
	public static val CALL_MAKE_TARGETS = #["callMake"]
	public static val CALL_TINA_TARGETS = #["callTina"]
	
	private var mRunner = new AntRunner()
	private var File mScript
	private var IFile mFile
	private var String mWorkspace
	private var String mFileName
	private var String mConsoleName = "AntRunner"
	private var MessageConsole mConsole = null;
	private var MessageConsoleStream mConsoleStream = null;
	private var List<String> mTargets

	public static def MakeRunner(IWorkbench workbench) {
		val runner = new FiacreAntRunner(SCRIPT, CALL_MAKE_TARGETS, workbench)
		runner.setConsoleStream("Model compilation")
		return runner
	}

	public static def TinaRunner(IWorkbench workbench) {
		val runner = new FiacreAntRunner(SCRIPT, CALL_TINA_TARGETS, workbench)
		runner.setConsoleStream("Model compilation and exploration")
		return runner
	}
	
	public new(String script, List<String> targets, IWorkbench workbench) {
		setConsoleStream("FiacreAntRunner")
		mScript = getAntFile(workbench, script)
		mFile = Utils.getCurrentFile(workbench)
		var file_name = mFile.name
		mFileName = file_name.substring(0, file_name.lastIndexOf('.'))
		mWorkspace = mFile.parent.location.toString
		mTargets = targets		
	}

	public def boolean isReady() {
		if (mFile == null || !mFile.isFcr) {
			mConsoleStream.write("Not a '.fcr' file");
			return false
		}
		if (mScript == null) {
			mConsoleStream.write("Could not create Ant file...");
			return false
		}
		return true
	}

	public def boolean run(IProgressMonitor progress_monitor, boolean longtask) {

		// load preferences		
		var preferences = LangActivator.instance.preferenceStore
		val tina_path = preferences.getString(PreferenceConstants.TINA_PATH_PREF)
		val frac_path = preferences.getString(PreferenceConstants.FRAC_PATH_PREF)

		mConsoleStream.println("Tina path " + tina_path)
		mConsoleStream.println("frac path " + frac_path)

		// bind script
		mRunner.executionTargets = mTargets
		mRunner.buildFileLocation = mScript.absolutePath
		val arg1 = "-DdirTinaPath=" + tina_path;
		val arg2 = "-DdirFracPath=" + frac_path;
		val arg3 = "-DdirWorkspace=" + mWorkspace;
		val arg4 = "-DfracFileName=" + mFileName;
		mRunner.setArguments(#[arg1, arg2, arg3, arg4])

		// cleanup workspace and refresh project
		cleanup()
		refreshProject()

		// run
		try {
			mConsoleStream.println("Starting Ant...")
			mConsoleStream.flush()
			if (longtask) {
				progress_monitor.beginTask("", IProgressMonitor.UNKNOWN)
				progress_monitor.worked(IProgressMonitor.UNKNOWN)
			}
			mRunner.run() // progress_monitor)			
			if (progress_monitor.canceled) {
				mConsoleStream.println("Ant execution cancelled")
				refreshProject()
				return false
			} else {
				progress_monitor.done()
			}
			mConsoleStream.println("Ant executed...")

		} catch (CoreException e) {
			mConsoleStream.println("Error : " + e.message)
			e.printStackTrace()
		}

		refreshProject()
		return true
	}

	private def refreshProject() {
		try {
			mFile.project.refreshLocal(IResource.DEPTH_INFINITE, null)
		} catch (CoreException e) {
			e.printStackTrace()
		}
	}

	public def checkAndCreateMarkers() {
		val errors = FracMarkers.create(mFile, mWorkspace, mFileName)
		if (errors > 0) {
			val msg = errors.toString + " error" + (if(errors > 1) "s" else "") +
				" found during compilation, see fiacre model file."
			mConsoleStream.println(msg)
		} /*else {
			mConsoleStream.println("Frac compilation success.")
		} */
	}

	private def File getAntFile(IWorkbench workbench, String script) {
		var file = new File(System.getProperty("java.io.tmpdir") + "/org.laas.vertics.fiacre." + script)

		if (!file.exists) {

			// copy ant script from bundle
			try {
				var istream = FileLocator.openStream(LangActivator.instance.bundle,
					new Path("/ant-files/" + script), false)
				Files.copy(istream, file.absoluteFile.toPath);
				file.deleteOnExit()
			} catch (IOException e) {
				MessageDialog.openError(workbench.activeWorkbenchWindow.shell, "Copying Ant File", e.message)
			}
		}
		return file
	}

	public def void setConsoleStream(String consoleName) {
		if ((consoleName != mConsoleName) && (mConsole != null)) {
			ConsolePlugin.getDefault().consoleManager.removeConsoles(#[mConsole])
			mConsole = null
		}
		if (mConsole == null) {
			mConsole = new MessageConsole(consoleName, null);
			mConsoleName = consoleName
			mConsole.activate()
			ConsolePlugin.getDefault().consoleManager.addConsoles(#[mConsole])
		}

		mConsoleStream = mConsole.newMessageStream()
	}

	private def compilation_results(String workspace, String file_name) {
		return workspace + "/" + file_name + "_compilation_results/"
	}

	private def cleanup() {
		_delete(compilation_results(mWorkspace, mFileName))
	}

	private def _delete(String path) {
		try {
			var file = new File(path)
			file.delete()
		} catch (IOException e) {
		}
	}

	public def printTinaOutput() {
		mConsoleStream.println("Tina output:")
		try {
			var tina_result = mWorkspace + "/" + mFileName + "_compilation_results/" + mFileName +
				"_tina_result.out"
			var file_reader = new FileReader(tina_result)
			var buffered_reader = new BufferedReader(file_reader)
			var String line = null
			while ((line = buffered_reader.readLine) != null) {
				mConsoleStream.println(line)
			}
			mConsoleStream.println()
		} catch (Exception e) {
		}
	}

	private def static boolean isFcr(IFile file) {
		return file.fileExtension == "fcr"
	}
}
