package ui;

import lime.ui.FileDialogType;
import haxe.ui.events.MouseEvent;
import lime.ui.FileDialog;
import openfl.display.BitmapData;
import haxe.ui.containers.VBox;

typedef ImageSize = {
	width: Int,
	height: Int
};

@:build(haxe.ui.macros.ComponentMacros.build("assets/haxeui/root.xml"))
class Root extends VBox
{
	var _menuDelegate: IMenuActions;
	var _inputTab: InputTab;
	var _paletteTab: PaletteTab;
	var _dialog: PyxelatingDialog;
	var _inputImageSize: ImageSize;
	var _outputImageSize: ImageSize;

	public function new(menuDelegate: IMenuActions)
	{
		super();
		
		_menuDelegate = menuDelegate;

		_inputTab = new InputTab();
		_paletteTab = new PaletteTab();

		configTabView.addComponent(_inputTab);
		configTabView.addComponent(_paletteTab);

		loadMenuButton.onClick = openLoadFileDialog;
		saveMenuButton.onClick = openSaveFileDialog;
		quitMenuButton.onClick = quit;
		pyxelateButton.onClick = pyxelate;
		inputZoomSelector.onChange = e -> updateInputImageSize();
		outputZoomSelector.onChange = e -> updateOutputImageSize();
	}

	function pyxelate(event: MouseEvent)
	{
		_dialog = new PyxelatingDialog();
		_dialog.closable = false;
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
		_inputImageSize = {
			width: bitmapData.width,
			height: bitmapData.height
		};

		inputImage.width = _inputImageSize.width;
		inputImage.height = _inputImageSize.height;

		inputImage.resource = bitmapData;

		inputImageDimensionsLabel.text = '${_inputImageSize.width}x${_inputImageSize.height}';

		inputZoomSelector.value = 1;

		updateInputImageSize();
	}

	public function displayOutputImage(bitmapData: BitmapData)
	{
		_outputImageSize = {
			width: bitmapData.width,
			height: bitmapData.height
		};
		
		outputImage.width = _outputImageSize.width;
		outputImage.height = _outputImageSize.height;

		outputImage.resource = bitmapData;

		outputImageDimensionsLabel.text = '${_outputImageSize.width}x${_outputImageSize.height}';

		updateOutputImageSize();
		
		_dialog.hideDialog(null);
	}

	private function updateInputImageSize()
	{
		if(_inputImageSize != null)
		{
			inputImage.width = _inputImageSize.width * inputZoomSelector.value;
			inputImage.height = _inputImageSize.height * inputZoomSelector.value;

			inputImageContainer.width = (inputImage.width > inputImageScrollview.width) ? inputImage.width : inputImageScrollview.width;
			inputImageContainer.height = (inputImage.height > inputImageScrollview.height) ? inputImage.height : inputImageScrollview.height;
		}
	}

	private function updateOutputImageSize()
	{
		if(_outputImageSize != null)
		{
			outputImage.width = _outputImageSize.width * outputZoomSelector.value;
			outputImage.height = _outputImageSize.height * outputZoomSelector.value;

			outputImageContainer.width = (outputImage.width > outputImageScrollview.width) ? outputImage.width : outputImageScrollview.width;
			outputImageContainer.height = (outputImage.height > outputImageScrollview.height) ? outputImage.height : outputImageScrollview.height;
		}
	}
}