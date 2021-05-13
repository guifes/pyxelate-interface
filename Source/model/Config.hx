package model;

class Config
{
    public var downsample: Int;
    public var dither: String;

    public function new()
    {
        downsample = 6;
        dither = "none";
    }
}