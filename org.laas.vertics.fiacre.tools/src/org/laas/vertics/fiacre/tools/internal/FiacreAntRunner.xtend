package org.laas.vertics.fiacre.tools.internal

import java.io.BufferedReader
import java.io.File
import java.io.FileReader
import java.io.IOException
import java.nio.file.Files
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
import org.laas.vertics.fiacre.ui.internal.LangActivator
import org.laas.vertics.fiacre.ui.markers.FracMarkers
import org.laas.vertics.fiacre.ui.preferences.PreferenceConstants

class FiacreAntRunner {
	var runner = new AntRunner()
	
	public def compile(IWorkbench workbench, IFile file, String workspace, IProgressMonitor progress_monitor) {
		runner.stop;
		var preferences = LangActivator.instance.preferenceStore
		var consoleStream = getConsoleStream("Frac results")

		if (file.fileExtension != "fcr") {
			consoleStream.write("Not a '.fcr' file");
			return
		}

		var file_name = file.name
		file_name = file_name.substring(0, file_name.lastIndexOf('.'))

		val tina_path = preferences.getString(PreferenceConstants.TINA_PATH_PREF)
		val frac_path = preferences.getString(PreferenceConstants.FRAC_PATH_PREF)

		consoleStream.println("Tina path " + tina_path)
		consoleStream.println("frac path " + frac_path)

		var antFile = getAntFile(workbench, "compile")
		
		runner.executionTargets = #["callMake"]
		runner.buildFileLocation = antFile.absolutePath
		val arg1 = "-DdirTinaPath=" + tina_path;
		val arg2 = "-DdirFracPath=" + frac_path;
		val arg3 = "-DdirWorkspace=" + workspace;
		val arg4 = "-DfracFileName=" + file_name;
		runner.setArguments(#[arg1, arg2, arg3, arg4])
		try {
			consoleStream.println("Starting Ant...")
			consoleStream.flush()
			runner.run(progress_monitor)
			consoleStream.println("Ant executed...")

			val errors = FracMarkers.create(file, workspace, file_name)
			if (errors > 0) {
				val msg = errors.toString + " error" + (if(errors > 1) "s" else "") +
					" found during compilation, see fiacre model file."
				consoleStream.println(msg)
			} else {
				consoleStream.println("Frac compilation success.")
			}

		} catch (CoreException e) {
			consoleStream.println("Error : " + e.message)
			e.printStackTrace()
		}

		try {
			file.project.refreshLocal(IResource.DEPTH_INFINITE, null)
		} catch (CoreException e) {
			e.printStackTrace()
		}
	}
	
	public def callTina(IWorkbench workbench, IFile file, String workspace, IProgressMonitor progress_monitor
	) {
		runner.stop;
		var preferences = LangActivator.instance.preferenceStore
		var consoleStream = getConsoleStream("Tina results")

		if (file.fileExtension != "fcr") {
			consoleStream.write("Not a '.fcr' file");
			return
		}

		var file_name = file.name
		file_name = file_name.substring(0, file_name.lastIndexOf('.'))

		val tina_path = preferences.getString(PreferenceConstants.TINA_PATH_PREF)
		val frac_path = preferences.getString(PreferenceConstants.FRAC_PATH_PREF)

		consoleStream.println("Tina path " + tina_path)
		consoleStream.println("frac path " + frac_path)

		var antFile = getAntFile(workbench, "compile")		
		runner.executionTargets = #["callTina"]
		
		runner.buildFileLocation = antFile.absolutePath
		val arg1 = "-DdirTinaPath=" + tina_path;
		val arg2 = "-DdirFracPath=" + frac_path;
		val arg3 = "-DdirWorkspace=" + workspace;
		val arg4 = "-DfracFileName=" + file_name;
		runner.setArguments(#[arg1, arg2, arg3, arg4])
		
		// cleanup tina output
		var tina_result = workspace + "/" + file_name + "_compilation_results/" + file_name + "_tina_result.out"
		var tina_file = new File(tina_result)
		try {
			tina_file.delete
		} catch (IOException e) {
			/* silent */
		}		
		
		try {			
			consoleStream.println("Starting Ant...")
			consoleStream.flush()
			progress_monitor.beginTask("", IProgressMonitor.UNKNOWN)
			progress_monitor.worked(IProgressMonitor.UNKNOWN)
			runner.run() // progress_monitor)
			progress_monitor.done()
			
			if (progress_monitor.canceled) {
				consoleStream.println("Ant execution cancelled")
				return;
			}
			consoleStream.println("Ant executed...")

			val errors = FracMarkers.create(file, workspace, file_name)
			if (errors > 0) {
				val msg = errors.toString + " error" + (if(errors > 1) "s" else "") +
					" found during compilation, see fiacre model file."
				consoleStream.println(msg)
			} else {
				consoleStream.println("Tina output:")
				
				try {
					var file_reader = new FileReader(tina_result)
					var buffered_reader = new BufferedReader(file_reader)
					var String line = null	
					while ( (line = buffered_reader.readLine) != null) {
						consoleStream.println(line)
					}
					consoleStream.println()									
				} catch (Exception e) {
				}				
			}

		} catch (CoreException e) {
			consoleStream.println("Error : " + e.message)
			e.printStackTrace()
		}

		try {
			file.project.refreshLocal(IResource.DEPTH_INFINITE, null)
		} catch (CoreException e) {
			e.printStackTrace()
		}
	}
	

	def File getAntFile(IWorkbench workbench, String name) {

		// TODO update paths
		var file = new File(System.getProperty("java.io.tmpdir") + "/" + name + ".xml")

		if (!file.exists) {

			// copy ant script from bundle
			try {
				var istream = FileLocator.openStream(LangActivator.instance.bundle,
					new Path("/ant-files/" + name + ".xml"), false)

				//file.createNewFile
				//file.deleteOnExit
				Files.copy(istream, file.absoluteFile.toPath);
				file.deleteOnExit()
			} catch (IOException e) {
				MessageDialog.openError(workbench.activeWorkbenchWindow.shell, "Copying Ant File", e.message)
			}
		}
		return file
	}

	private def getConsoleStream(String consoleName) {
		var console = new MessageConsole(consoleName, null)
		console.activate()
		ConsolePlugin.getDefault().consoleManager.addConsoles(#[console])
		return console.newMessageStream()
	}

}
