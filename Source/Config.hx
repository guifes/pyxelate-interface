package;

class Config
{
    public var downsample: Int;
    public var palette: Int;
    public var dither: String;

    public function new()
    {
        downsample = 6;
        palette = 8;
        dither = "none";
    }
}