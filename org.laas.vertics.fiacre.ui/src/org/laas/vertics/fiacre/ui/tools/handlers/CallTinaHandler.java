package org.laas.vertics.fiacre.ui.tools.handlers;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.core.runtime.jobs.Job;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.PlatformUI;
import org.laas.vertics.fiacre.ui.tools.internal.FiacreAntRunner;

public class CallTinaHandler extends AbstractHandler {

	public Object execute(ExecutionEvent event) throws ExecutionException {
		final IWorkbench workbench = PlatformUI.getWorkbench();
		final FiacreAntRunner runner = FiacreAntRunner.TinaRunner(workbench);

		if (runner.isReady()) {
			Job job = new Job("Calling Tina...") {
				@Override
				protected IStatus run(IProgressMonitor monitor) {
					if (runner.run(monitor, true)) {
						runner.printTinaOutput();
					}
					runner.checkAndCreateMarkers();
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
		}
		return null;
	}
}
