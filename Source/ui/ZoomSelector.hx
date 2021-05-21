package ui;

import haxe.ui.events.UIEvent;
import haxe.ui.events.MouseEvent;
import haxe.ui.containers.HBox;

@:build(haxe.ui.macros.ComponentMacros.build("assets/haxeui/zoom_selector.xml"))
class ZoomSelector extends HBox
{
    private var _zoom: Int = 1;

    public function new()
    {
        super();
    }

    public override function set_value(v: Dynamic)
    {
        super.set_value(v);
        
        _zoom = v;

        updateLabelValue();

        return v;
    }

    public override function get_value()
    {
        return (_zoom > 0) ? _zoom : 1/(2 - _zoom);
    }

    @:bind(zoomLabel, UIEvent.CHANGE)
    function onLabelChange(e)
    {
        dispatch(new UIEvent(UIEvent.CHANGE, this));
    }

    @:bind(decreaseButton, MouseEvent.CLICK)
    function onDecrease(e)
    {
        _zoom--;

        updateLabelValue();
    }

    @:bind(increaseButton, MouseEvent.CLICK)
    function onIncrease(e)
    {
        _zoom++;

        updateLabelValue();
    }

    private function updateLabelValue()
    {
        zoomLabel.text = (_zoom > 0) ? Std.string(_zoom) : '1/${2 - _zoom}';
    }
}