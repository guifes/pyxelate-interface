package model;

@:enum
abstract PaletteType(Int) to Int from Int {
    var TELETEXT = 1;
    var CGA_MODE4_PAL1 = 2;
    var CGA_MODE5_PAL1 = 3;
    var CGA_MODE4_PAL2 = 4;
    var ZX_SPECTRUM = 5;
    var APPLE_II_LO = 6;
    var APPLE_II_HI = 7;
    var COMMODORE_64 = 8;
    var GAMEBOY_COMBO_UP = 9;
    var GAMEBOY_COMBO_DOWN = 10;
    var GAMEBOY_COMBO_LEFT = 11;
    var GAMEBOY_COMBO_RIGHT = 12;
    var GAMEBOY_A_UP = 13;
    var GAMEBOY_A_DOWN = 14;
    var GAMEBOY_A_LEFT = 15;
    var GAMEBOY_A_RIGHT = 16;
    var GAMEBOY_B_UP = 17;
    var GAMEBOY_B_DOWN = 18;
    var GAMEBOY_B_LEFT = 19;
    var GAMEBOY_B_RIGHT = 20;
    var GAMEBOY_ORIGINAL = 21;
    var GAMEBOY_POCKET = 22;
    var GAMEBOY_VIRTUALBOY = 23;
    var MICROSOFT_WINDOWS_16 = 24;
    var MICROSOFT_WINDOWS_20 = 25;
    var MICROSOFT_WINDOWS_PAINT = 26;
    var PICO_8 = 27;
    var MSX = 28;
    var MONO_OBRADINN_IBM = 29;
    var MONO_OBRADINN_MAC = 30;
    var MONO_BJG = 31;
    var MONO_BW = 32;
    var MONO_PHOSPHOR_AMBER = 33;
    var MONO_PHOSPHOR_LTAMBER = 34;
    var MONO_PHOSPHOR_GREEN1 = 35;
    var MONO_PHOSPHOR_GREEN2 = 36;
    var MONO_PHOSPHOR_GREEN3 = 37;
    var MONO_PHOSPHOR_APPLE = 38;
    var MONO_PHOSPHOR_APPLEC = 39;
}

class PaletteConfig extends Config
{
    public var palette: PaletteType;

    public function new()
    {
        super();
        
        palette = PaletteType.TELETEXT;
    }
}