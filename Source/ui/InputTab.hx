package ui;

import model.InputConfig;
import haxe.ui.containers.Box;

@:build(haxe.ui.macros.ComponentMacros.build("assets/haxeui/input_tab.xml"))
class InputTab extends Box
{
	public var config(default, null): InputConfig;

	var _menuDelegate: IMenuActions;
	
	public function new()
	{
		super();
		
		config = new InputConfig();

		downsampleProperty.onChange = e ->
		{
			config.downsample = e.target.value;
		};

		paletteProperty.onChange = e ->
		{
			config.palette = e.target.value;
		};

		ditherProperty.onChange = e ->
		{
			config.dither = e.target.value.text;
		};
	}
}