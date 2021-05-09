package;

import sys.io.File;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import haxe.ui.Toolkit;

class Main extends Sprite implements IMenuActions
{
	var _root: Root;
	var _config: Config;
	var _imagePath: String;

	public function new()
	{
		super();

		Toolkit.init();

		_config = new Config();

		_root = new Root(this, _config);

		stage.addChild(_root);
	}

	public function getLoadedImage(): String
	{
		return _imagePath;
	}

	public function pyxelate()
	{
		var params = [];

		params.push("assets/python/index.py");
		params.push("-i");
		params.push(_imagePath);
		params.push("-ds");
		params.push('${_config.downsample}');
		params.push("-p");
		params.push('${_config.palette}');
		params.push("-d");
		params.push('${_config.dither}');

		var status = Sys.command("python", params);

		var bytes = File.getBytes("temp/output.png");
		var bitmapData = BitmapData.fromBytes(bytes);
		
		_root.displayOutputImage(bitmapData);
	}

	public function onUpdateConfig(config: Config)
	{
		_config = config;
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