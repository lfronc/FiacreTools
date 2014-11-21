package org.laas.vertics.fiacre.ui.tools.internal

import org.eclipse.core.resources.IFile
import org.eclipse.ui.IEditorPart
import org.eclipse.ui.IFileEditorInput
import org.eclipse.ui.IWorkbench

class Utils {
	
	public def static IFile getCurrentFile(IWorkbench workbench) 
	{
		var IFile file = null
		try {
			val IEditorPart editorPart = workbench.getWorkbenchWindows().get(0).getActivePage().getActiveEditor()
			if (editorPart != null) {
				val IFileEditorInput input = editorPart.getEditorInput() as IFileEditorInput
				file = input.getFile()
			}
		} catch (Exception e) {			
		}
		return file
	}
}