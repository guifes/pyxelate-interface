package ui;

import haxe.ui.containers.dialogs.Dialog;

@:build(haxe.ui.macros.ComponentMacros.build("assets/haxeui/pyxelating_dialog.xml"))
class PyxelatingDialog extends Dialog
{
    public function new()
    {
        super();

        title = "Pyxelating";
    }
}