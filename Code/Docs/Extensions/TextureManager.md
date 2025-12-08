# Title
### Version 1.0
| X                        | Y                |
| --------                 | -------          |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLContext      |
| Tags                     | OOP, VBA, OpenGL |

## Purpose

2-3 Sentences.

--------------------------------------------------------

## Overview

A high-level explanation of how it works, key concepts, assumptions, constraints, and known side-effects.

Include:
* Required environment (Excel version, references, libraries)
* Dependencies
* Limitations
* Performance considerations


--------------------------------------------------------

## Properties

| Property | Type         | Public | Description |
| -------- | -------      | ------ | -------     |
| Name     | Type         | True   | Text        |

Further Explanation if nessecary to understand method

## Methods
| Property | Type         | Public | Description |
| -------- | -------      | ------ | -------     |
| Create   | XXX          | True   | Text        |

Further Explanation if nessecary to understand method

--------------------------------------------------------

## Examples:  
1. Describe what the Example is about
```vb
Public Sub Test()

End Sub
```
Add multiple examples if needed.

## Extra Information
Design decisions, patterns used, special warnings, or anything relevant.

## Dependencies
* BulletPoints

## Testing
Text

## Lifecycle Notes
When to create, reuse, or destroy instances.
Memory considerations.
Object responsibility boundaries.

## See Also:
[Name](Path)
































# VBGLTextureManager
### Version 1.0
| X                        | Y                |
| --------                 | -------          |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLContext, VBGLTexture, VBGLSubTexture, VBGLITextureMerger |
| Tags                     | OOP, VBA, OpenGL |

## Purpose

Manages and processes multiple textures in VBA, allowing for merging, splitting into subtextures, and transformation (flip/transpose). Simplifies texture loading from files, folders, or raw data arrays for use in OpenGL rendering workflows.  

--------------------------------------------------------

## Overview

`VBGLTextureManager` is a utility class for handling complex texture operations in VBA environments with OpenGL. It provides a central point to load textures from multiple sources, merge them into a single texture, and optionally flip or transpose the data. It also supports subdividing textures into subtextures for easier management in graphics applications.

**Key Concepts:**
* Texture merging using a `VBGLITextureMerger`.
* Managing maximum texture dimensions and byte dimensions.
* Optional transformations (flip and transpose).
* Loading textures from files, folders, or raw data.
* Automatic creation of subtextures.

**Constraints:**
* Requires `VBGLTexture`, `VBGLSubTexture`, `VBGLITextureMerger`, and `stdImage` libraries.
* Assumes data arrays are formatted as BGRA and converts to RGBA internally. (Coming from stdImage.cls)

**Performance Considerations:**
* Large textures or high row/column counts may cause delays.
* OpenGL is limited by the system in the Size of their Textures. In my case the limit is 16384*16384 Pixels
* Flipping and transposing arrays can be memory-intensive for large datasets.

--------------------------------------------------------

## Properties

| Property       | Type                  | Public | Description |
| -------------- | -------------------  | ------ | ----------- |
| Merger         | VBGLITextureMerger    | True   | Interface responsible for merging multiple textures into a single array. |
| MaxHeight      | Long                  | True   | Maximum texture height in pixels. Will overwrite Merger |
| MaxWidth       | Long                  | True   | Maximum texture width in pixels. Will overwrite Merger |
| MaxByteHeight  | Long                  | True   | Maximum byte height (internal data size) for texture. Will overwrite Merger |
| MaxByteWidth   | Long                  | True   | Maximum byte width (internal data size) for texture. Will overwrite Merger |
| Flip           | Boolean               | True   | Indicates whether textures should be flipped vertically during processing. |
| Transpose      | Boolean               | True   | Indicates whether textures should be transposed(x|y-->y|x) during processing. |

--------------------------------------------------------

## Methods

| Method               | Type          | Public | Description |
| -------------------- | ------------- | ------ | ----------- |
| Create               | Function      | True   | Factory method to create a new `VBGLTextureManager` instance with optional maximum dimensions and a merger object. |
| CreateTexture        | Function      | True   | Creates a `VBGLTexture` from the merged helpers and applies flip/transpose transformations. |
| LoadFromFolder       | Function      | True   | Loads textures from all files in a folder (optionally recursively) and maps them into rows and columns. |
| LoadFromFolderArr    | Function      | True   | Internal version of `LoadFromFolder` with string array of names. |
| LoadFromFile         | Function      | True   | Loads a texture from a single file and maps it into rows and columns. |
| LoadFromFileArr      | Function      | True   | Internal version of `LoadFromFile` using string array of names. |
| LoadFromData         | Function      | True   | Loads a texture from a byte array of raw data. |
| LoadFromDataArr      | Function      | True   | Internal version of `LoadFromData` using string array of names. |

**Private/Internal Methods:**

| Method               | Type          | Public | Description |
| -------------------- | ------------- | ------ | ----------- |
| AddHelper            | Sub           | False  | Adds a `VBGLTextureManagerHelper` to the manager, storing its data and metadata. |
| CreateSubTextures    | Function      | False  | Generates subtextures based on loaded helpers and maps them onto a parent texture. |
| SwapColors           | Function      | False  | Converts color channels of a 2D byte array (e.g., BGRA to RGBA) and applies transformations to accomodate for ==memory differences==. |
| TransposeData        | Function      | False  | Transposes a 2D byte array. |
| FlipData             | Function      | False  | Flips a 2D byte array vertically. |
| SwitchXY             | Function      | False  | Swaps the X and Y axes of a 2D byte array. |

==memory differences==
OpenGL uses the following memory setup:
1, 2, 3, 4
5, 6, 7, 8

While VBA uses this memory setup:
1, 3, 5, 7
2, 4, 6, 8

So by transposing the data achieve a different internal layout, but the memory layout is the same:
1, 5
2, 6
3, 7
4, 8

--------------------------------------------------------

## Examples:  

1. Creating a Texture Manager and Loading Textures from a Folder
```vb
    Dim TextureManager As VBGLTextureManager
    Set TextureManager = VBGLTextureManager.Create(VBGLTextureMergerGrid.Create(True))
    Call TextureManager.LoadFromFolder(FolderPath, True, 1, 1, VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpRow, "Name")
    TextureManager.Flip = True
    TextureManager.Transpose = True

    Dim Texture As VBGLTexture
    Set Texture = TextureManager.CreateTexture(VBGLTexture, "TestManager")
```

## Extra Information
Implements Factory design pattern for creating new instances and textures.
Supports hierarchical folder loading for automated asset management.
Flip and transpose operations allow adapting texture orientation for OpenGL.

## Dependencies
* VBGLContext
* VBGLTexture
* VBGLSubTexture
* VBGLITextureMerger
* VBGLTextureManagerHelper
* stdImage

## Testing
* Verify texture merging with multiple images.
* Validate row/column splitting creates correct subtextures.
* Confirm flip and transpose produce expected orientation.
* Test large datasets for memory constraints.

## Lifecycle Notes
Create inbetween VBGLContext lifecycle


## See Also:
[Context](..\..\Core.Context)
[Texture](..\..\Core.Texture)






# VBGLITextureMerger
## Purpose

Defines an interface for texture mergers. Implementing classes provide functionality to combine multiple subtextures into a single byte array suitable for creating a `VBGLTexture` object while updating subtexture positions and dimensions.



# VBGLTextureMergerGrid
### Version 1.0
| X                        | Y                |
| --------                 | -------          |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLTextureManager, VBGLTextureManagerHelper, VBGLITextureMerger |
| Tags                     | OOP, VBA, OpenGL, Texture Merging |

## Purpose

Provides a grid-based implementation of the `VBGLITextureMerger` interface. It merges multiple textures into a single larger texture in either row-first or column-first order while calculating positions, sizes, and managing byte-level data. Ideal for organizing sprite sheets or texture atlases.

--------------------------------------------------------

## Overview

`VBGLTextureMergerGrid` organizes and merges textures in a grid layout. It handles subdividing helper textures into smaller subtextures, calculating maximum dimensions, assigning positions, and combining the data arrays.  

**Key Concepts:**
* Implements `VBGLITextureMerger` interface.
* Supports `ColumnFirst` or `RowFirst` grid arrangements.
* Handles byte-level texture merging and position assignments.
* Dynamically splits textures based on rows and columns.

**Assumptions & Constraints:**
* Dependent on `VBGLTextureManagerHelper` and `VBGLTextureManager` structures.
* Uses OpenGL `GL_MAX_TEXTURE_SIZE` to determine system limits.
* Requires `std_Callable` utility for dynamic property access.

**Performance Considerations:**
* Large numbers of subtextures may increase computation time.
* Byte-level array operations can be memory-intensive for large textures.

--------------------------------------------------------

## Properties

| Property       | Type     | Public | Description |
| -------------- | -------  | ------ | ----------- |
| ColumnFirst    | Boolean  | True   | Determines whether textures are merged column-first (True) or row-first (False). |

--------------------------------------------------------

## Methods

| Method               | Type          | Public | Description |
| -------------------- | ------------- | ------ | ----------- |
| Create               | Function      | True   | Factory method to create a new `VBGLTextureMergerGrid` instance with `ColumnFirst` option. |
| VBGLITextureMerger_Merge | Function  | False  | Implements the `VBGLITextureMerger` interface. Merges multiple `VBGLTextureManagerHelper` objects into a single byte array. Updates maximum dimensions and assigns positions. |
| Init                 | Sub           | Friend | Initializes system texture size based on OpenGL maximum limits. |

**Private/Internal Methods:**

| Method               | Type          | Public | Description |
| -------------------- | ------------- | ------ | ----------- |
| SplitSubTextures     | Function      | False  | Splits complex helpers into individual subtextures. |
| GetSubTextures       | Function      | False  | Extracts subtextures from a helper using row/column splitting. |
| GetSubTextureData    | Function      | False  | Extracts a byte array representing a subtexture from a larger data array. |
| InitMetaData         | Sub           | False  | Initializes MaxWidth, MaxHeight, MaxByteWidth, MaxByteHeight for the merge. |
| CalcMax              | Sub           | False  | Calculates maximum dimension totals for either rows or columns, respecting system limits. |
| Sum                  | Function      | False  | Returns the sum of a specific property across all helpers (e.g., ByteWidth). |
| AssignPositions      | Sub           | False  | Assigns x and y positions to each subtexture in the merged texture. |
| AssignData           | Function      | False  | Combines all subtexture data into a single byte array representing the merged texture. |
| AssignSubData        | Sub           | False  | Helper to copy subtexture byte data into the merged texture at specified coordinates. |

--------------------------------------------------------

## Examples:  

**1. Creating a Grid-Based Merger**
```vb
Dim Merger As VBGLTextureMergerGrid
Set Merger = VBGLTextureMergerGrid.Create(True) ' Column-first merging
```


## Extra Information
* Implements VBGLITextureMerger interface.
* Supports hierarchical texture splitting and flexible merging.
* Handles both logical dimensions (Height/Width) and byte-level dimensions.
* Designed for sprite sheets, texture atlases, and OpenGL texture workflows.

## Dependencies
* VBGLTextureManagerHelper
* VBGLITextureMerger
* std_Callable


## Testing
* Verify proper splitting of complex helpers into subtextures.
* Confirm correct assignment of x/y positions.
* Validate column-first vs row-first merging.
* Test with different system texture size limits.

## Lifecycle Notes
Create inbetween VBGLContext lifecycle

## See Also:











# VBGLTextureManagerHelper
### Version 1.0
| X                        | Y                |
| --------                 | -------          |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLTextureManager, VBGLITextureMerger |
| Tags                     | OOP, VBA, OpenGL, Texture Helper |

## Purpose

Represents a single helper for the `VBGLTextureManager` that contains metadata and raw data for a subtexture. Used to organize textures into rows, columns, or grids and track their positions, sizes, and identifiers.

## Properties

| Property       | Type                                   | Public | Description |
| -------------- | ------------------------------------- | ------ | ----------- |
| Identifier     | String                                 | True   | Unique identifier for this helper. |
| X              | Long                                   | True   | X-position in the merged texture. |
| Y              | Long                                   | True   | Y-position in the merged texture. |
| Width          | Long                                   | True   | Width of the texture in pixels. |
| Height         | Long                                   | True   | Height of the texture in pixels. |
| ByteWidth      | Long                                   | True   | Width in bytes (used for layout with more than 1 color channel). |
| ByteHeight     | Long                                   | True   | Height in bytes (used for layout with more than 1 color channel). |
| RowCount       | Long                                   | True   | Number of rows in a grid layout. |
| ColumnCount    | Long                                   | True   | Number of columns in a grid layout. |
| SetUp          | VBGLTextureManagerHelperSetUp          | True   | Layout type: Column, Row, or Grid. |
| Data           | Byte()                                 | False  | Raw byte array representing the texture. |
| Names          | String()                               | False  | Optional names associated with subtextures in a grid. |