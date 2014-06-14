package org.laas.vertics.fiacre.ui.markers

import java.io.BufferedReader
import java.io.FileReader
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IMarker
import org.eclipse.core.resources.IResource
import org.eclipse.core.runtime.CoreException

class FracMarkers {
	
	def static int create(IFile file, String workspace, String file_name) {
		var frac_result = workspace + "/" + file_name + "_compilation_results/" + file_name + "_frac_result.out"
		var error_count = 0
		try {
			var file_reader = new FileReader(frac_result)
			var buffered_reader = new BufferedReader(file_reader)
			var String line = null
			
			file.deleteMarkers(IMarker.PROBLEM, true, IResource.DEPTH_INFINITE)
			while ( (line = buffered_reader.readLine) != null) {
				if (line.indexOf("Error:") != -1) {
					var line_num = line.substring( line.indexOf("line") + 5, line.indexOf(":",15))
					var error = line.substring(line.indexOf(":") + 1, line.indexOf("line")) + line.substring(line.indexOf(":", 10), line.length())
					
					file.addMarker(error, Integer.parseInt(line_num), IMarker.SEVERITY_ERROR)
					error_count += 1
					
				} else if (line.indexOf("Warning:") != -1) {
					var line_num = line.substring( line.indexOf("line") + 5, line.indexOf(":",15))
					var error = line.substring(line.indexOf(":") + 1, line.indexOf("line")) + line.substring(line.indexOf(":", 10), line.length())
					
					file.addMarker(error, Integer.parseInt(line_num), IMarker.SEVERITY_WARNING)			
				} else if (line.indexOf("cannot compile:") != -1) {
					file.addMarker(line, 1, IMarker.SEVERITY_ERROR)
					error_count += 1
				} else if (line.indexOf("warning: possibly") != -1) {
					file.addMarker(line, 1, IMarker.SEVERITY_WARNING)
					error_count += 1
				}
			}			 
		} catch (Exception e) {			
		}	
		return error_count
	}		
	
	def static void addMarker(IFile file, String message, int line, int severity) {
		try {
			var marker = file.createMarker(IMarker.PROBLEM)
			marker.setAttribute(IMarker.MESSAGE, message)
			marker.setAttribute(IMarker.SEVERITY, severity)
			var mline = if (line == -1) { 1 } else line
			marker.setAttribute(IMarker.LINE_NUMBER, mline)
		} catch (CoreException e) {			
		}
	}
	
}