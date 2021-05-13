import sys

from skimage import io
from pyxelate import Pyx, Pal
from pathlib import Path

EXPECT_INPUT_IMAGE = 1
EXPECT_DOWNSAMPLE = 2
EXPECT_PALETTE = 3
EXPECT_DITHER = 4
EXPECT_PALETTE_TYPE = 5

INPUT_MODE = 1
PALETTE_MODE = 2
COLORS_MODE = 3
IMAGE_MODE = 4

def intToPal(i):
    if i == 1:
        return Pal.TELETEXT
    elif i == 2:
        return Pal.CGA_MODE4_PAL1
    elif i == 3:
        return Pal.CGA_MODE5_PAL1
    elif i == 4:
        return Pal.CGA_MODE4_PAL2
    elif i == 5:
        return Pal.ZX_SPECTRUM
    elif i == 6:
        return Pal.APPLE_II_LO
    elif i == 7:
        return Pal.APPLE_II_HI
    elif i == 8:
        return Pal.COMMODORE_64
    elif i == 9:
        return Pal.GAMEBOY_COMBO_UP
    elif i == 10:
        return Pal.GAMEBOY_COMBO_DOWN
    elif i == 11:
        return Pal.GAMEBOY_COMBO_LEFT
    elif i == 12:
        return Pal.GAMEBOY_COMBO_RIGHT
    elif i == 13:
        return Pal.GAMEBOY_A_UP
    elif i == 14:
        return Pal.GAMEBOY_A_DOWN
    elif i == 15:
        return Pal.GAMEBOY_A_LEFT
    elif i == 16:
        return Pal.GAMEBOY_A_RIGHT
    elif i == 17:
        return Pal.GAMEBOY_B_UP
    elif i == 18:
        return Pal.GAMEBOY_B_DOWN
    elif i == 19:
        return Pal.GAMEBOY_B_LEFT
    elif i == 20:
        return Pal.GAMEBOY_B_RIGHT
    elif i == 21:
        return Pal.GAMEBOY_ORIGINAL
    elif i == 22:
        return Pal.GAMEBOY_POCKET
    elif i == 23:
        return Pal.GAMEBOY_VIRTUALBOY
    elif i == 24:
        return Pal.MICROSOFT_WINDOWS_16
    elif i == 25:
        return Pal.MICROSOFT_WINDOWS_20
    elif i == 26:
        return Pal.MICROSOFT_WINDOWS_PAINT
    elif i == 27:
        return Pal.PICO_8
    elif i == 28:
        return Pal.MSX
    elif i == 29:
        return Pal.MONO_OBRADINN_IBM
    elif i == 30:
        return Pal.MONO_OBRADINN_MAC
    elif i == 31:
        return Pal.MONO_BJG
    elif i == 32:
        return Pal.MONO_BW
    elif i == 33:
        return Pal.MONO_PHOSPHOR_AMBER
    elif i == 34:
        return Pal.MONO_PHOSPHOR_LTAMBER
    elif i == 35:
        return Pal.MONO_PHOSPHOR_GREEN1
    elif i == 36:
        return Pal.MONO_PHOSPHOR_GREEN2
    elif i == 37:
        return Pal.MONO_PHOSPHOR_GREEN3
    elif i == 38:
        return Pal.MONO_PHOSPHOR_APPLE
    elif i == 39:
        return Pal.MONO_PHOSPHOR_APPLEC

if __name__ == "__main__":
    expect = None
    input = None
    
    mode = INPUT_MODE

    downsample_by = 6
    dither = "none"

    palette = 8

    for i, arg in enumerate(sys.argv):
        # print(f"Argument {i:>6}: {arg}")
        if expect == None:
            if   arg == "-i":
                expect = EXPECT_INPUT_IMAGE
            elif arg == "-ds":
                expect = EXPECT_DOWNSAMPLE
            elif arg == "-d":
                expect = EXPECT_DITHER
            elif arg == "-p":
                mode = INPUT_MODE
                expect = EXPECT_PALETTE
            elif arg == "-pt":
                mode = PALETTE_MODE
                expect = EXPECT_PALETTE_TYPE
        else:
            if   expect == EXPECT_INPUT_IMAGE:
                input = arg
            elif expect == EXPECT_DOWNSAMPLE:
                downsample_by = int(arg)
            elif expect == EXPECT_DITHER:
                dither = arg
            elif expect == EXPECT_PALETTE:
                palette = int(arg)
            elif expect == EXPECT_PALETTE_TYPE:
                palette = intToPal(int(arg))
            expect = None

# load image with 'skimage.io.imread()'
image = io.imread(input)  

# 1) Instantiate Pyx transformer
pyx = Pyx(factor=downsample_by,palette=palette,dither=dither)

# 2) fit an image, allow Pyxelate to learn the color palette
pyx.fit(image)

# 3) transform image to pixel art using the learned color palette
new_image = pyx.transform(image)

Path("temp").mkdir(parents=True, exist_ok=True)

# save new image with 'skimage.io.imsave()'
io.imsave("temp/output.png", new_image)