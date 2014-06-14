package org.laas.vertics.fiacre.ui.autoedit

import org.eclipse.jface.text.IDocument
import org.eclipse.xtext.ui.editor.autoedit.DefaultAutoEditStrategyProvider

class AutoEditStrategyProvider extends DefaultAutoEditStrategyProvider {

	override configureCompoundBracesBlocks(IEditStrategyAcceptor acceptor) {
		acceptor.accept(compoundMultiLineTerminals.newInstanceFor("{", "}").and("(", ")"),
			IDocument.DEFAULT_CONTENT_TYPE);
	}

	override configureSquareBrackets(IEditStrategyAcceptor acceptor) {
	}

}
