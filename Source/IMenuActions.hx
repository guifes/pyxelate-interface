package;

interface IMenuActions
{
    function onLoad(path: String): Void;
    function onSave(path: String): Void;
    function onExit(): Void;
    function pyxelate(): Void;
    function onUpdateConfig(config: Config): Void;
}