# VBGL Font and TextBox Classes Documentation
#### Using Core Version 1.0

## Class 1: `VBGLFontLayout`
Represents a font layout, storing character metrics, texture data, and providing methods to generate vertex data for rendering text.
Uses FreeType to generate a big BitMap with all characters of a given Font and Size

### Properties

| Property    | Type        | Description |
|-------------|-------------|-------------|
| `Name`      | String      | Name of the font layout. |
| `CharCount` | Long        | Total number of characters in the layout. |
| `Size`      | Long        | Font size in pixels. |
| `Texture`   | VBGLTexture | Texture object storing all character glyphs. |
| `FirstChar` | Long        | Unicode value of the first character in the font. |
| `MaxWidth`  | Long        | Maximum width among all characters. |
| `MaxHeight` | Long        | Maximum height among all characters. |
| `BPP`       | Long        | Bytes per pixel in the texture. |

### Methods

1. `Create(LoadFilePath, FontFilePath, n_Size, [n_Name])`  
    * Loads a font and returns a `VBGLFontLayout` object.
    * LoadFilePath is the Path to `FreeType.dll`

2. `GetData(Text, FontColor(), Scalee, xStart, yStart)`  
    * Generates vertex data for a string of text using the font layout and color.
    * Scalee is a Factor that will scale the positions. This is to save up on Bitmap creation time, as bigger bitmaps take more time
    * xStart and yStart is the Position, from where it will start generating

3. `SetUp(Face, [n_Name])`  
    * Initializes the font layout by calculating maximum values and character textures.

4. `CharacterByteSize(ColorSize)`  
    * Calculates the byte size for a single character vertex, including position, color, and texture data.

5. `CalculateBaseLine()`  
    * Computes the baseline of the font based on character heights.

### Private Helpers

1. `LoadFont` --> Will load a FreeType Instance and return Library and Face Pointer
2. `GetMaxValues` --> Will determine the Max-Values like CharCount, MaxHeight, MaxWidth
3. `GetCharacters` --> Will Create a BitMap for each Character and then add it to the return array
4. `CopyBitMap` --> Copies the Bitmap into the return Array
  Internal methods for loading font data, creating textures, and building vertex arrays.

---

## Class 2: `VBGLFont`
Represents a single font instance with associated text and rendering attributes.

### Properties

| Property     | Type           | Description |
|--------------|----------------|-------------|
| `Text`       | String         | Text to render. |
| `Bold`       | Boolean        | ==CURRENTLY UNUSED== Bold style toggle. |
| `Italics`    | Boolean        | ==CURRENTLY UNUSED== Italic style toggle. |
| `Underscore` | Boolean        | ==CURRENTLY UNUSED== Underline style toggle. |
| `FontColor`  | Single()       | Color array for text, Can be Red to RGBA. |
| `FontLayout` | VBGLFontLayout | Associated font layout. |
| `Scalee`     | Single         | Scale factor for rendering size. |

### Methods

1. `AddText(NewText)`  
    * Adds new text to the font instance
    * handles unprintable characters.

2. `GetData(Text, xStart, yStart)`  
    * Returns vertex data for the specified text using the associated `FontLayout`.

3. `DataSize()`  
    * Calculates the total size of the vertex data for the current text.

4. `VertexSize()`  
    * Returns the size of a single vertex, including position, texture, and color.

---

## Class 3: `VBGLTextBox`
Represents a text box for rendering multiple lines of text with multiple fonts, including color and position management.

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `TopLeft`      | Single()   | 3D coordinates of the textbox corners. |
| `TopRight`     | Single()   | ==Currently unused== 3D coordinates of the textbox corners. |
| `BottomLeft`   | Single()   | ==Currently unused== 3D coordinates of the textbox corners. |
| `BottomRight`  | Single()   | ==Currently unused== 3D coordinates of the textbox corners. |
| `Color`        | Single()   | Background color of the text. |
| `CharsPerLine` | Long       | Number of characters per line. |
| `LinesPerPage` | Long       | Number of lines per page. |
| `Pages`        | Long       | ==Currently unused== Total pages of text. |
| `LineOffset`   | Single     | Vertical offset for line spacing. |
| `Fonts`        | VBGLFont() | Array of font objects used in the textbox. |
| `Mesh`         | VBGLMesh   | Mesh object used for rendering. |

### Methods

1. `Factory()`  
    * Creates a new `VBGLTextBox` instance with the same properties.

2. `Create(n_Fonts())`  
    * Creates a `VBGLTextBox` instance and initializes its mesh with the provided fonts.

3. `CreateFromText(Text, FontLayout)`  
    * Creates a `VBGLTextBox` with a single font and text.

4. `CreateMesh()`  
    * Generates the mesh for rendering, including layout, shader, and vertex data.

5. `Draw()`  
    * Renders the text box using the associated mesh and shader.

6. `UpdateData()`  
    * Updates the mesh vertex buffer with the current text and font data.

### Private Helpers

1. `GetData()`  
    * Collects all vertex data for the textbox, including handling multiple lines and fonts.
    * Seperates all text into lines, seperated by vbCrlf and CharsPerLine

2. `ProcessLine(Line, CharCount, FontSwitch(), FontIndex, xStart, yStart)`  
    * Processes a single line of text into vertex data.

3. `GetFontSwitchLength()`  
    * Returns indices representing text length per font for multi-font text.
    * Used to determine when a font(with its color and other settings) is finished

4. `HandleLine(CurrentFont)`  
    * Calculates vertical spacing for a line of text.
    * Either LineOffset or total Size of current FontLayout

5. `GetLines()`  
    * Splits the text into lines based on line breaks and `CharsPerLine`.

6. `GetSize()`  
    * Calculates the total vertex data size for all fonts in the textbox.

---

### Notes

1. All classes utilize FreeType (`FT_*` functions) for font loading and glyph handling.  
    * The corresponding Functions can be found in the `FreeTypeDeclaration.bas` File
2. Vertex data includes position (x, y, z), color, and texture coordinates (tx, ty).  
3. `VBGLTextBox` supports multi-font text rendering with proper line wrapping.  