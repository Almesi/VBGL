## TextRendering
### VBGLFontLayout
Uses a VBGLTexture as Bitmap of Characters
Properties:
* Name                 example: Consolas
* Texture              example: C:/Consolas.png
* PixelsPerCharWidth   example: 7
* PixelsPerCharHeigth  example: 13
* CharsPerWidth        example: 16
* Format               example: UTF8 (for total characters in VBGLTexture)
### VBGLFont
Formatting of a part of Text with specific Settings
Properties:
* Text
* Bold
* Italics
* Underscore
* Size
* FontColor(2)
* BackgroundColor(2)
* FontLayout
### VBGLTextBox
Properties:
TopLeft()     To define Position on screen
TopRight()    To define Position on screen
BottomLeft()  To define Position on screen
BottomRight() To define Position on screen
Color()       BackgroundColor
CharsPerLine  Characters until LineBreak
Fonts()       Entire Text with all of its formatting
Mesh          Used for Drawing
Data Format:
For each Character: x, y, z, tx, ty, r, g, b, (a)
For BackgroundColor input is Uniform for Color