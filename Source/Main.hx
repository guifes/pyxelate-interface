package;

import sys.thread.Thread;
import model.PaletteConfig;
import model.InputConfig;
import ui.Root;
import sys.io.File;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import haxe.ui.Toolkit;

class Main extends Sprite implements IMenuActions
{
	var _root: Root;
	var _imagePath: String;

	public function new()
	{
		super();

		Toolkit.init();

		_root = new Root(this);

		addChild(_root);
	}

	public function getLoadedImage(): String
	{
		return _imagePath;
	}

	public function pyxelateWithInput(config: InputConfig)
	{
		var params = [];

		params.push("assets/python/index.py");
		params.push("-i");
		params.push(_imagePath);
		params.push("-ds");
		params.push('${config.downsample}');
		params.push("-p");
		params.push('${config.palette}');
		params.push("-d");
		params.push('${config.dither}');

		Thread.create(() -> {
			var status = Sys.command("python", params);
		
			var bytes = File.getBytes("temp/output.png");
			var bitmapData = BitmapData.fromBytes(bytes);
			
			_root.displayOutputImage(bitmapData);
		});
	}

	public function pyxelateWithPalette(config: PaletteConfig)
	{
		var params = [];

		params.push("assets/python/index.py");
		params.push("-i");
		params.push(_imagePath);
		params.push("-ds");
		params.push('${config.downsample}');
		params.push("-pt");
		params.push('${config.palette}');
		params.push("-d");
		params.push('${config.dither}');

		Thread.create(() -> {
			var status = Sys.command("python", params);

			var bytes = File.getBytes("temp/output.png");
			var bitmapData = BitmapData.fromBytes(bytes);
			
			_root.displayOutputImage(bitmapData);
		});
	}

	public function onLoad(path:String)
	{
		_imagePath = path;

		var bytes = File.getBytes(path);
		var bitmapData = BitmapData.fromBytes(bytes);

		_root.displayInputImage(bitmapData);
	}

	public function onSave(path: String)
	{
		var bytes = File.getBytes("temp/output.png");
		File.saveBytes(path, bytes);
	}

	public function onExit()
	{
		Sys.exit(0);
	}
}