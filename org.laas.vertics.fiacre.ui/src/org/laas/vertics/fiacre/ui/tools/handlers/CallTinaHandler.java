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

public class CallTinaHandler extends AbstractFiacreHandler {

	public Object execute(ExecutionEvent event) throws ExecutionException {
		final IWorkbench workbench = PlatformUI.getWorkbench();
		final IFile file = getCurrentFile(workbench);
		final FiacreAntRunner runner = new FiacreAntRunner();

		Job job = new Job("Call tina on " + file.getName()) {
			@Override
			protected IStatus run(IProgressMonitor monitor) {
				runner.callTina(workbench, file, file.getParent().getLocation().toString(), monitor);
				return Status.OK_STATUS;
			}

			@Override
			protected void canceling() {
				try {
					getThread().interrupt();
				} catch (SecurityException se) {
					// pass..
				}
				super.canceling();
			}
			
			
		};
		job.schedule();
		return null;
	}

}
