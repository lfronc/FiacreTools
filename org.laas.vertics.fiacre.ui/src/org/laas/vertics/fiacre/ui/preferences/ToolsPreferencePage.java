package org.laas.vertics.fiacre.ui.preferences;

import java.io.File;

import org.eclipse.jface.preference.IPreferencePageContainer;
import org.eclipse.jface.preference.IPreferenceStore;
import org.eclipse.jface.resource.ImageDescriptor;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.DirectoryDialog;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.IWorkbenchPreferencePage;
import org.laas.vertics.fiacre.ui.internal.LangActivator;

public class ToolsPreferencePage implements IWorkbenchPreferencePage {
	private String DESCRIPTION = "Fiacre Tools Configuration Page";
	private String MESSAGE = "Fiacre Tools Configuration Page";
	private String TITLE = "Fiacre Tools";

	private String mDescription = DESCRIPTION;
	private String mTitle = TITLE;

	private Composite mComposite;
	private Text textFracPath;
	private Text textTinaPath;
	private Button btnBrowseFracPath;
	private Button btnBrowseTinaPath;
	private Button btnAutoFracPath;
	private Button btnAutoTinaPath;
	
	private boolean mValidState;
	
	private void validate() {
		File file1 = new File(textFracPath.getText());
		File file2 = new File(textTinaPath.getText());
		
		System.out.println(" 1 : " + file1.exists());
		System.out.println(" 2 : " + file2.exists());
		System.out.println(" 3 : " + file1.isDirectory());
		System.out.println(" 4 : " + file2.isDirectory());
		
		mValidState = file1.exists() && file2.exists() && file1.isDirectory() && file2.isDirectory();		
	}
	
	public boolean isValid() {		
		return true;
	}

	public boolean okToLeave() {
		return true;
	}

	public boolean performCancel() {
		return true;
	}

	public boolean performOk() {
		if (!mValidState) {
			return false;
		}

		IPreferenceStore store = LangActivator.getInstance()
				.getPreferenceStore();
		store.setValue(PreferenceConstants.FRAC_PATH_PREF,
				textFracPath.getText());
		store.setValue(PreferenceConstants.TINA_PATH_PREF,
				textTinaPath.getText());
		return true;
	}

	public void setContainer(IPreferencePageContainer preferencePageContainer) {
		// TODO Auto-generated method stub
	}

	public void setSize(Point size) {
		// TODO Auto-generated method stub
	}

	/**
	 * @wbp.parser.entryPoint
	 */
	public void createControl(Composite parent) {
		IPreferenceStore store = LangActivator.getInstance()
				.getPreferenceStore();
		mComposite = new Composite(parent, SWT.NONE);
		mComposite.setLayout(new GridLayout(4, false));
		final Shell shell = parent.getShell();

		Label lblFracPath = new Label(mComposite, SWT.NONE);
		lblFracPath.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false,
				false, 1, 1));
		lblFracPath.setText("Frac path :");

		textFracPath = new Text(mComposite, SWT.BORDER);
		textFracPath.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true,
				false, 1, 1));

		btnBrowseFracPath = new Button(mComposite, SWT.NONE);
		btnBrowseFracPath.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				DirectoryDialog dialog = new DirectoryDialog(shell);
				dialog.setMessage("Select frac path");
				String result = dialog.open();
				if (result != null) {
					textFracPath.setText(result);
				}
				validate();
			}
		});
		btnBrowseFracPath.setText("Browse..");

		btnAutoFracPath = new Button(mComposite, SWT.NONE);
		btnAutoFracPath.setText("Auto..");

		Label lblTinaPath = new Label(mComposite, SWT.NONE);
		lblTinaPath.setLayoutData(new GridData(SWT.RIGHT, SWT.CENTER, false,
				false, 1, 1));
		lblTinaPath.setText("Tina path :");

		textTinaPath = new Text(mComposite, SWT.BORDER);		
		textTinaPath.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true,
				false, 1, 1));

		btnBrowseTinaPath = new Button(mComposite, SWT.NONE);
		btnBrowseTinaPath.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				DirectoryDialog dialog = new DirectoryDialog(shell);
				dialog.setMessage("Select tina path");
				String result = dialog.open();
				if (result != null) {
					textTinaPath.setText(result);
				}
				validate();
			}
		});
		btnBrowseTinaPath.setText("Browse..");

		btnAutoTinaPath = new Button(mComposite, SWT.NONE);
		btnAutoTinaPath.setText("Auto..");
				
		textFracPath.setText(store.getString(PreferenceConstants.FRAC_PATH_PREF));
		textTinaPath.setText(store.getString(PreferenceConstants.TINA_PATH_PREF));
		validate();
	}

	public void dispose() {
	}

	public Control getControl() {
		return mComposite;
	}

	public String getDescription() {
		return mDescription;
	}

	public String getErrorMessage() {
		return null;
	}

	public Image getImage() {
		return null;
	}

	public String getMessage() {
		return MESSAGE;
	}

	public String getTitle() {
		return mTitle;
	}

	public void performHelp() {
	}

	public void setDescription(String description) {
		mDescription = description;
	}

	public void setImageDescriptor(ImageDescriptor image) {
	}

	public void setTitle(String title) {
		mTitle = title;
	}

	public void setVisible(boolean visible) {
		mComposite.setVisible(visible);
	}

	public void init(IWorkbench workbench) {
		IPreferenceStore store = LangActivator.getInstance().getPreferenceStore();
		if (store.getString(PreferenceConstants.FRAC_PATH_PREF).equals("")) {
			store.setValue(PreferenceConstants.FRAC_PATH_PREF, PreferenceConstants.FRAC_PATH_DEFAULT);
		}
		if (store.getString(PreferenceConstants.TINA_PATH_PREF).equals("")) {
			store.setValue(PreferenceConstants.TINA_PATH_PREF, PreferenceConstants.TINA_PATH_DEFAULT);
		}
	}

	public Point computeSize() {
		return mComposite.computeSize(SWT.DEFAULT, SWT.DEFAULT);
	}

}
