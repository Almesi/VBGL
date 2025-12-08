# VBGLDualGrid
### Version 1.0
| X                        | Y                |
| ------------------------ | ---------------- |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLMesh, VBGLTexture, VBGLLayout |
| Tags                     | VBA, OpenGL, Tiles, Dual Grid, Drawable |

## Purpose

`VBGLDualGrid` is a class for managing a dual-grid tile system in OpenGL via VBA. It handles:

* Loading textures from folders or files.
* Creating a tile-based mesh for rendering.
* Providing position and texture coordinate data for rendering.
* Drawing and updating the mesh dynamically.

It implements the `VBGLDrawable` interface to integrate into an OpenGL drawing system.

---

## Overview
The dual grid system divides a grid into 16 possible tile types for partial or full coverage. Tiles are mapped to a mesh, and each tile’s subtextures are used for rendering.

The passed image is expected to implement the subtextures in the following way: 
 ________________________
|           |            |
|           |            |
|     1     |      2     |
|           |            |
|-----------|------------|
|           |            |
|     4     |      8     |
|           |            |
|___________|____________|

Every possible sum is one subtexture
0 is defined, but not used by this class, either way it needs to be included
In total there are 16 different subtiles for every tile

**Tile Types:**
| Name                | Sum |
| ---                 | --- |
| EmptyImage          |  0  |
| UpperLeft           |  1  |
| UpperRight          |  2  |
| UpperRow            |  3  |
| LowerLeft           |  4  |
| LeftColumn          |  5  |
| DiagonalRight       |  6  |
| TriangleUpperLeft   |  7  |
| BottomRight         |  8  |
| DiagonalLeft        |  9  |
| RightColumn         |  10 |
| TriangleUpperRight  |  11 |
| BottomRow           |  12 |
| TriangleBottomLeft  |  13 |
| TriangleBottomRight |  14 |
| Full                |  15 |



### Example
If you have 2 different tile in the following map layout:
1 1
1 2

you will get 2 rectangles to draw:
* TriangleUpperLeft
* BottomRight

With 3 different tiles:
1 1
2 3

you need:
* UpperRow
* BottomLeft
* BottomRight

---

## Properties

| Property   | Type           | Public | Description |
| ---------- | -------------- | ------ | ----------- |
| Mesh       | VBGLMesh       | Yes    | The OpenGL mesh for rendering the grid. |
| TileSet    | VBGLTexture    | Yes    | The texture containing all subtiles for the grid. |
| Layout     | VBGLLayout     | No     | Layout for vertex attributes. |
| BuildData  | Single()       | No     | Internal buffer for vertex data. |
| Tiles      | Long()         | No     | Array of tile indices. |

---

## Methods

### Creation & Loading
| Method                   | Description |
| ------------------------ | ----------- |
| `CreateFromFolder(FolderPath, Recursive)` | Loads tiles from a folder and returns a configured `VBGLDualGrid`. |
| `CreateFromFile(FilePath)` | Loads tiles from a single file. |
| `Create(n_TileSet As VBGLTexture)` | Creates a new `VBGLDualGrid` from an existing texture. |

### Setup & Build
| Method       | Description |
| ------------ | ----------- |
| `SetUp(n_Layout, n_Tiles())` | Configures the layout and tiles array, prepares build buffer. |
| `ParseData(LayoutIndex, n_Data())` | Parses tile data and prepares vertex triangles. |
| `Build()` | Builds the mesh and assigns textures for rendering. |
| `Draw()` | Draws the mesh using OpenGL. |
| `Update(Map(), x, y)` | Updates the mesh data and optionally moves the camera view. |
| `LookAt(x, y, TilesX, TilesY)` | Sets the view and projection matrices for the mesh. |
| `GetPositionData(z())`  | Returns vertex positions with Z-values. |
| `GetSubTextureData()`   | Returns texture coordinates for all tiles. |
| `AddTriangles(VertexSize, DataSize, n_Data(), Index, DataIndex)` | Adds 6 vertices per tile for triangles (1 Rectangle). |
| `AddVertex(VertexSize, DataSize, n_Data(), Index, DataIndex)` | Adds a single vertex to the build buffer. |
| `TileIndices(Corners())` | Computes unique tile indices for subtextures. |
| `GetSubTexture(Tile, Typee)` | Returns the index of a subtexture for a given tile and type. |
| `GetShader()` | Returns a compiled shader with discard for white pixels. |
| `DataCount(VertexSize)` | Returns the total vertex data size. |
| `VertexCount()` | Returns the total number of vertices in the grid. |
| `TileCount()` | Returns the total number of tiles in the grid. |
| `VerticesPerTile()` | Returns `6` (triangles per tile). |
| `UniqueTiles(Corners())` | Returns count of unique tile indices. |
| `GetTile(Tiles(), x, y)` | Returns tile corner indices for a specific grid position. |
| `xVertices(Vertex, Value)` | Returns the X-coordinate for a vertex. |
| `yVertices(Vertex, Value)` | Returns the Y-coordinate for a vertex. |
| `TextureFactory(Manager)` | Creates a texture with OpenGL parameters for a manager. |
| `TypeTypeString()` | Returns an array of tile type names. |
| `Round(Value)` | Rounds a single to nearest integer. |

---

## Example

```vb
    Dim Layout As VBGLLayout
    Set Layout = VBGLPrCoLayoutXYZTxTy

    Dim Tiles() As Long
    Tiles = ArrayLong( _
                            ArrayLong(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 2, 2, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 2), _
                            ArrayLong(2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 1, 0, 2), _
                            ArrayLong(2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 2), _
                            ArrayLong(2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)  _
                        )
    Set CreateGrid = VBGLDualGrid.CreateFromFolder(FolderPath, False)
    Call CreateGrid.SetUp(Layout, Tiles)

    Dim z() As Single
    Call VBGLArrayCreate(z, 0.5, 15, 15)
    Call CreateGrid.ParseData(0, CreateGrid.GetPositionData(z))
    Call CreateGrid.ParseData(1, CreateGrid.GetSubTextureData())
    Call CreateGrid.Build()
```


## Extra Information
XXX

## Dependencies
* VBGLTextureManager

## Testing
XXX

## Lifecycle Notes
During VBGLContext Lifecycle

## See Also:
[TextureManager](..\TextureManager.md)