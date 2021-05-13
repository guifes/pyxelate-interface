package;

import model.PaletteConfig;
import model.InputConfig;

interface IMenuActions
{
    function onLoad(path: String): Void;
    function onSave(path: String): Void;
    function onExit(): Void;
    function pyxelateWithInput(config: InputConfig): Void;
    function pyxelateWithPalette(config: PaletteConfig): Void;
}