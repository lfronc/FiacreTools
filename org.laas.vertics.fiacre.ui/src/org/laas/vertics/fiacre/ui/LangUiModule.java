/*
 * generated by Xtext
 */
package org.laas.vertics.fiacre.ui;

import org.eclipse.ui.plugin.AbstractUIPlugin;
import org.eclipse.xtext.ui.editor.autoedit.AbstractEditStrategyProvider;

/**
 * Use this class to register components to be used within the IDE.
 */
public class LangUiModule extends org.laas.vertics.fiacre.ui.AbstractLangUiModule {
	public LangUiModule(AbstractUIPlugin plugin) {
		super(plugin);
	}

    public Class<? extends AbstractEditStrategyProvider>
    bindAbstractEditStrategyProvider() {
    	return org.laas.vertics.fiacre.ui.autoedit.AutoEditStrategyProvider.class;
    }
}
