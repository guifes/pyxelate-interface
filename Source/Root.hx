package;

import lime.ui.FileDialogType;
import haxe.ui.events.MouseEvent;
import lime.ui.FileDialog;
import openfl.display.BitmapData;
import haxe.ui.containers.VBox;

@:build(haxe.ui.macros.ComponentMacros.build("assets/haxeui/root.xml"))
class Root extends VBox
{
	var _menuDelegate: IMenuActions;
	var _config: Config;	

	public function new(menuDelegate: IMenuActions, config: Config)
	{
		super();

		_config = config;
		_menuDelegate = menuDelegate;

		loadMenuButton.onClick = openLoadFileDialog;
		saveMenuButton.onClick = openSaveFileDialog;
		quitMenuButton.onClick = quit;
		pyxelateButton.onClick = pyxelate;

		downsampleProperty.onChange = e ->
		{
			_config.downsample = e.target.value;
			_menuDelegate.onUpdateConfig(_config);
		};

		paletteProperty.onChange = e ->
		{
			_config.palette = e.target.value;
			_menuDelegate.onUpdateConfig(_config);
		};

		ditherProperty.onChange = e ->
		{
			_config.dither = e.target.value.text;
			_menuDelegate.onUpdateConfig(_config);
		};
	}

	function pyxelate(event: MouseEvent)
	{
		_menuDelegate.pyxelate();
	}

	function quit(event: MouseEvent)
	{
		_menuDelegate.onExit();
	}

	function openSaveFileDialog(event: MouseEvent)
	{
		var dialog = new FileDialog();
		dialog.browse(FileDialogType.SAVE);
		dialog.onSelect.add(path -> _menuDelegate.onSave(path));
	}

	function openLoadFileDialog(event: MouseEvent)
	{
		var dialog = new FileDialog();
		dialog.browse(FileDialogType.OPEN);
		dialog.onSelect.add(path -> _menuDelegate.onLoad(path));
	}
	
	public function displayInputImage(bitmapData: BitmapData)
	{
		inputImage.resource = bitmapData;
	}

	public function displayOutputImage(bitmapData: BitmapData)
	{
		outputImage.width = inputImage.width;
		outputImage.height = inputImage.height;
		outputImage.resource = bitmapData;
	}
}
