import sys

from skimage import io
from pyxelate import Pyx, Pal
from pathlib import Path

EXPECT_INPUT_IMAGE = 1
EXPECT_DOWNSAMPLE = 2
EXPECT_PALETTE = 3
EXPECT_DITHER = 4

if __name__ == "__main__":
    expect = None
    input = None
    downsample_by = 6
    palette = 8
    dither = None
    for i, arg in enumerate(sys.argv):
        # print(f"Argument {i:>6}: {arg}")
        if expect == None:
            if   arg == "-i":
                expect = EXPECT_INPUT_IMAGE
            elif arg == "-ds":
                expect = EXPECT_DOWNSAMPLE
            elif arg == "-p":
                expect = EXPECT_PALETTE
            elif arg == "-d":
                expect = EXPECT_DITHER
        else:
            if   expect == EXPECT_INPUT_IMAGE:
                input = arg
            elif expect == EXPECT_DOWNSAMPLE:
                downsample_by = int(arg)
            elif expect == EXPECT_PALETTE:
                palette = int(arg)
            elif expect == EXPECT_DITHER:
                dither = arg
            expect = None
            

# load image with 'skimage.io.imread()'
image = io.imread(input)  

# 1) Instantiate Pyx transformer
pyx = Pyx(factor=downsample_by, palette=palette)

# 2) fit an image, allow Pyxelate to learn the color palette
pyx.fit(image)

# 3) transform image to pixel art using the learned color palette
new_image = pyx.transform(image)


Path("temp").mkdir(parents=True, exist_ok=True)

# save new image with 'skimage.io.imsave()'
io.imsave("temp/output.png", new_image)