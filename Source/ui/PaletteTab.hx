package ui;

import model.PaletteConfig;
import haxe.ui.containers.Box;

@:build(haxe.ui.macros.ComponentMacros.build("assets/haxeui/palette_tab.xml"))
class PaletteTab extends Box
{
	public var config(default, null): PaletteConfig;	
	
	var _menuDelegate: IMenuActions;

	public function new()
	{
		super();

		config = new PaletteConfig();

		downsampleProperty.onChange = e ->
		{
			config.downsample = e.target.value;
		};

		paletteProperty.onChange = e ->
		{
			config.palette = Std.parseInt(e.target.value.value);
		};

		ditherProperty.onChange = e ->
		{
			config.dither = e.target.value.text;
		};
	}
}