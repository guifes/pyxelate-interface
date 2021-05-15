package ui;

import lime.ui.FileDialogType;
import haxe.ui.events.MouseEvent;
import lime.ui.FileDialog;
import openfl.display.BitmapData;
import haxe.ui.containers.VBox;

@:build(haxe.ui.macros.ComponentMacros.build("assets/haxeui/root.xml"))
class Root extends VBox
{
	var _menuDelegate: IMenuActions;
	var _inputTab: InputTab;
	var _paletteTab: PaletteTab;
	var _dialog: PyxelatingDialog;

	public function new(menuDelegate: IMenuActions)
	{
		super();
		
		_menuDelegate = menuDelegate;

		_dialog = new PyxelatingDialog();
		_inputTab = new InputTab();
		_paletteTab = new PaletteTab();

		configTabView.addComponent(_inputTab);
		configTabView.addComponent(_paletteTab);

		loadMenuButton.onClick = openLoadFileDialog;
		saveMenuButton.onClick = openSaveFileDialog;
		quitMenuButton.onClick = quit;
		pyxelateButton.onClick = pyxelate;
	}

	function pyxelate(event: MouseEvent)
	{
        _dialog.showDialog(true);

		if(configTabView.selectedPage == _inputTab)
			_menuDelegate.pyxelateWithInput(_inputTab.config);
		else if(configTabView.selectedPage == _paletteTab)
			_menuDelegate.pyxelateWithPalette(_paletteTab.config);
	}

	function quit(event: MouseEvent)
	{
		_menuDelegate.onExit();
	}

	function openSaveFileDialog(event: MouseEvent)
	{
		var dialog = new FileDialog();
		dialog.browse(FileDialogType.SAVE, "png", null, "Save input image");
		dialog.onSelect.add(path -> _menuDelegate.onSave(path));
	}

	function openLoadFileDialog(event: MouseEvent)
	{
		var dialog = new FileDialog();
		dialog.browse(FileDialogType.OPEN, null, null, "Load input image");
		dialog.onSelect.add(path -> _menuDelegate.onLoad(path));
	}
	
	public function displayInputImage(bitmapData: BitmapData)
	{
		inputImage.resource = bitmapData;
		inputImageDimensionsLabel.text = '${bitmapData.width}x${bitmapData.height}';
	}

	public function displayOutputImage(bitmapData: BitmapData)
	{
		outputImage.width = inputImage.width;
		outputImage.height = inputImage.height;
		outputImage.resource = bitmapData;

		outputImageDimensionsLabel.text = '${bitmapData.width}x${bitmapData.height}';

		_dialog.hideDialog(null);
	}
}