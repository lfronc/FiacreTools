package org.laas.vertics.fiacre.ui.tools.handlers;

import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.core.runtime.jobs.Job;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.PlatformUI;
import org.laas.vertics.fiacre.ui.tools.internal.FiacreAntRunner;

/**
 * Our sample handler extends AbstractHandler, an IHandler base class.
 * 
 * @see org.eclipse.core.commands.IHandler
 * @see org.eclipse.core.commands.AbstractHandler
 */
public class CompileHandler extends AbstractFiacreHandler {
	/**
	 * The constructor.
	 */
	public CompileHandler() {
	}

	/**
	 * the command has been executed, so extract extract the needed information
	 * from the application context.
	 */
	public Object execute(ExecutionEvent event) throws ExecutionException {
		final IWorkbench workbench = PlatformUI.getWorkbench();
		final IFile file = getCurrentFile(workbench);
		final FiacreAntRunner runner = new FiacreAntRunner();

		Job job = new Job("Compiling " + file.getName()) {
			@Override
			protected IStatus run(IProgressMonitor monitor) {
				runner.compile(workbench, file, file.getParent().getLocation().toString(), monitor);
				return Status.OK_STATUS;				
			}
		};
		job.schedule();
		return null;
	}
}
