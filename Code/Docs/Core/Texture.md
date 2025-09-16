# Textures
#### Version 1.0

## VBGLTexture
Encapsulates an OpenGL 2D texture object.  
Handles loading from file or raw data, creating and managing OpenGL texture IDs, caching textures to prevent duplicates, and managing sub-textures (regions within a texture, e.g., for sprite sheets).

### Members

| Property        | Type             | Description |
| --------        | -------          | -------     |
| Context         | VBGLContext      | CurrentContext
| ID              | Long             | OpenGL texture ID
| Data            | VBGLData         | [Image Data](Data.md)
| Name            | String           | Name to recognize this Texture apart from just ID
| VBGLSubTexture  | VBGLSubTexture() | All Sub-Textures withing this Texture
| Width           | Long             | Data-Width(1 based)  (Factory-Property)
| Height          | Long             | Data-Height(1 based)  (Factory-Property)
| BPP             | Long             | Bytes Per Pixel  (Factory-Property)
| GLTextureMin    | Long             | OpenGL Value for GL_TEXTURE_MIN_FILTER  (Factory-Property)
| GLTextureMag    | Long             | OpenGL Value for GL_TEXTURE_MAG_FILTER  (Factory-Property)
| GLTextureWrapS  | Long             | OpenGL Value for GL_TEXTURE_WRAP_S  (Factory-Property)
| GLTextureWrapT  | Long             | OpenGL Value for GL_TEXTURE_WRAP_T  (Factory-Property)
| InternalFormat  | Long             | OpenGL Value for InternalFormat  (Factory-Property)
| Format          | Long             | OpenGL Value for Format  (Factory-Property)

### Methods

1. `Create(Path As String, [Name As String]) As VBGLTexture`
    * Loads an image from disk into a new OpenGL texture.
    * Uses [stdImage](https://github.com/sancarn/stdVBA/blob/master/src/stdImage.cls) to read file.
    * Swaps color channels from BGRA(stdImage) As RGBA(OpenGL).
    * Calls CreateFromData

2. `CreateFromData(Data As VBGLData, [Name As String]) As VBGLTexture`
    * Creates a texture from existing VBGLData.
    * Checks cache to avoid duplicates.
    * If new, calls glGenTextures, sets parameters from calling object(Factory), uploads pixels with glTexImage2D.

3. `Factory() As VBGLTexture`
    * Creates a new instance ov VBGLData and copies all of the callers factory-properties on the new instance.

4. `Activate(Index As Long)`
    * Activates the texture unit GL_TEXTURE0 + Index.

5. `Bind()`
    * Activates this texture and updates CurrentContext.

6. `Unbind()`
    * Deactivates any currently bound texture and updates CurrentContext.

### Lifecycle

`Class_Initialize`
Sets default parameters:
* InternalFormat = GL_RGBA
* Format         = GL_RGBA
* GLTextureMin   = GL_LINEAR
* GLTextureMag   = GL_LINEAR
* GLTextureWrapS = GL_CLAMP_TO_EDGE
* GLTextureWrapT = GL_CLAMP_TO_EDGE

`Class_Terminate`
* Deletes the OpenGL texture (glDeleteTextures).
* Unbinds texture from context.

## VBGLSubTexture
Represents a rectangular sub-region of a parent texture (e.g., a sprite in a sprite sheet).
Stores normalized texture coordinates and dimensions.

### Members

| Property        | Type             | Description |
| --------        | -------          | -------     |
| Identifier      | String           | Label for identifying the sub-texture.
| XN1             | Single           | Normalized top-left coordinates.
| YN1             | Single           | Normalized top-left coordinates.
| XN2             | Single           | Normalized bottom-right coordinates.
| YN2             | Single           | Normalized bottom-right coordinates.
| Width           | Long             | Parent texture dimensions.
| Height          | Long             | Parent texture dimensions.
| Flip            | Boolean          | If True, Y coordinates are flipped (to match OpenGL vs. image conventions)

### Methods

1. `CreateFactory(Width As Long, Height As Long, [Flip As Boolean = True]) As VBGLSubTexture`
    * Creates a "base" sub-texture factory, setting the overall parent texture size and flip mode.

2. `CreateFromPoint(ID As String, X1 As Long, Y1 As Long, X2 As Long, Y2 As Long) As VBGLSubTexture`
    * Creates a sub-texture from explicit pixel coordinates.
    * Calls .SetUp to calculate normalized coordinates.

3. `CreateFromLength(ID As String, X1 As Long, Y1 As Long, OffsetX As Long, OffsetY As Long) As VBGLSubTexture`
    * Creates a sub-texture from a starting point (X1, Y1) and width/height counts.

4. `CreateFromArray(IDs() As String, X1() As Long, Y1() As Long, X2() As Long, Y2() As Long) As VBGLSubTexture()`
    * Batch-creates multiple sub-textures from arrays of coordinates.

5. `CreateFromPattern(ID As String, PatternX As Long, PatternY As Long) As VBGLSubTexture()`
    * Generates a grid of sub-textures across the parent texture. Useful for sprite sheets.

6. `SetUp(X1 As Long, Y1 As Long, X2 As Long, Y2 As Long)`
    * Computes normalized coordinates (XN1, YN1, XN2, YN2) from pixel values, respecting Flip.

7. `GetX(Position As String) As Single`
    * Returns X coordinate at "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT".

8. `GetY(Position As String) As Single`
    * Returns Y coordinate at "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT".

### Example
1. Create a texture from a file
```vb
Public Sub TestTextures()
    Dim Texture As VBGLTexture
    With VBGLTexture
        .InternalFormat = GL_RED
        .Format         = GL_RED
    End With
    Set Texture = VBGLTexture.Create("Font.png", "Arial")

    ' Create a sub-texture factory for 256x256 parent texture
    Dim Factory As VBGLSubTexture
    Set Factory = VBGLSubTexture.CreateFactory(Texture.Width, Texture.Height, False)

    ' Define a sprite region (32x32 at top-left corner)
    Dim Chars() As VBGLSubTexture
    ReDim Chars(0)
    Set Chars(0) = Factory.CreateFromLength("A", 0, 0, 32, 32)

    Texture.SubTextures = Chars
End Sub
```