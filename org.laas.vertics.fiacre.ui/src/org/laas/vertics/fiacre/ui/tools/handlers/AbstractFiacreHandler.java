package org.laas.vertics.fiacre.ui.tools.handlers;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.resources.IFile;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.IFileEditorInput;
import org.eclipse.ui.IWorkbench;

public abstract class AbstractFiacreHandler extends AbstractHandler {

	public IFile getCurrentFile(IWorkbench workbench) {
		IFile file = null;
		try {
			IEditorPart editorPart = workbench.getWorkbenchWindows()[0].getActivePage().getActiveEditor();
			if (editorPart != null) {
				IFileEditorInput input = (IFileEditorInput)editorPart.getEditorInput();
				file = input.getFile();
			}
		} catch (Exception e) {
			
		}
		return file;
	}
}
