# VBGLList
### Version 1.0
| X                        | Y                |
| ------------------------ | ---------------- |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLDrawable, VBGLFrame, VBGLProperties |
| Tags                     | VBA, OpenGL, UI, Grid, Drawable, List |

## Purpose

`VBGLList` is a class for creating and managing a dynamic list of drawable elements in an OpenGL context using VBA. It supports:

* Row and column management for arranging elements.
* Individual and global control over width, height, padding, and column count.
* Background colors per element.
* Rendering via the `VBGLDrawable` interface.
* Automatic frame creation for each element to manage scissor and viewport regions.

It implements the `VBGLDrawable` interface for integration into an OpenGL rendering system.

---

## Constants

| Constant                | Type   | Value   | Description |
| ----------------------- | ------ | ------- | ----------- |
| DEFAULT_WIDTH           | Single | 0.1     | Default width of an element. |
| DEFAULT_HEIGHT          | Single | 0.1     | Default height of an element. |
| DEFAULT_PADDING         | Single | 0.01    | Default padding between elements. |
| DEFAULT_COLUMNCOUNT     | Long   | -1      | Default column count for rows. |

---

## Types

### `Element`

| Field            | Type           | Description |
| ---------------- | -------------- | ----------- |
| Drawable         | VBGLDrawable   | The drawable object for the element. |
| Frame            | VBGLFrame      | OpenGL frame managing scissor and viewport. |
| BackgroundColor  | Single()       | RGBA color for background. |
| X                | Single         | X position of the element. |
| Padding          | Single         | Padding to the next element. |
| Width            | Single         | Width of the element. |

### `ItemRow`

| Field            | Type           | Description |
| ---------------- | -------------- | ----------- |
| Elements         | Element()      | Array of elements in this row. |
| ColumnCount      | Long           | Number of columns in the row. |
| X                | Single         | X position of the row. |
| Y                | Single         | Y position of the row. |
| Height           | Single         | Height of the row. |

---

## Properties

| Property              | Type             | Description |
| --------------------- | ---------------- | ----------- |
| Properties            | VBGLProperties   | Global properties for list placement and behavior. |
| GlobalHeight          | Single           | Default height for all rows. |
| GlobalWidth           | Single           | Default width for all elements. |
| GlobalPadding         | Single           | Default padding between elements. |
| GlobalColumnCount     | Long             | Default column count per row. |

---

## Methods

### Creation & Initialization
| Method                       | Description |
| ---------------------------- | ----------- |
| `Create(n_Properties, Height, Width, Padding, ColumnCount)` | Creates a new `VBGLList` with optional global settings. |
| `CreateProperties()`          | Creates a `VBGLProperties` object with default "X", "Y", "Z" properties. |
| `Draw()`                     | Draws all rows and elements, binding their frames and clearing backgrounds. |
| `VBGLDrawable_Draw()`         | Implements `VBGLDrawable` interface to call `Draw()`. |
| `AddRow()`                    | Adds a new row to the list, setting default Y and X positions. |
| `AddRows(Count)`              | Adds multiple rows at once. |
| `SetRowHeight(Row, Value)`    | Sets height for a specific row. |
| `SetRowHeightAll(Value)`      | Sets height for all rows. |
| `SetRowHeights(ParamArray Values())` | Sets multiple row heights using a parameter array. |
| `AddElement(Row, Element, BackgroundColor)` | Adds a drawable element to a specified row with optional background color. |
| `GetElement(Row, Column)`     | Returns the drawable object at a specific row and column. |
| `SetColumnWidth(Row, Column, Value)` | Sets the width of a specific column in a specific row. |
| `SetColumnWidthAll(Value)`    | Sets width of all columns in all rows. |
| `SetColumnWidths(Row, ParamArray Values())` | Sets widths for multiple columns in a row using a parameter array. |
| `SetWidth(Row, Column, Value)` | Internal helper to assign width. |
| `SetBackgroundColor(Row, Column, Color)` | Assigns a background color to a specific element. |
| `CreateFrame(Row, Column)`    | Creates a `VBGLFrame` for an element with correct scissor and viewport. |
| `Map(Input, Low1, High1, Low2, High2)` | Maps a value from one range to another. |
| `MapD(Input, Low1, High1, Low2, High2)` | Scaled mapping using `Range` and `Ratio`. |
| `Range(Input, Low, High)`     | Normalizes input to 0–1 range. |
| `Ratio(Input, Low, High)`     | Scales normalized value to a target range. |

---

## Example

```vb
Private Function CreateList(ByVal LoadFilePath As String, ByVal FilePath As String, ByVal ImageFolder As String) As VBGLList
    Dim Temp As VBGLProperties
    Set Temp = VBGLProperties.Create()
    Temp.Value("X") = -0.1!
    Temp.Value("Y") = 0.1!
    Temp.Value("Z") = 0.0!

    Dim WhiteBackground(3) As Single
    WhiteBackground(0) = 1
    WhiteBackground(1) = 1
    WhiteBackground(2) = 1
    WhiteBackground(3) = 1
    Dim RedBackground(3) As Single
    RedBackground(0) = 1
    RedBackground(3) = 1

    Set CreateList = VBGLList.Create(Temp)
    With CreateList
        Call .AddRows(1)

        Call .AddElement(0, CreateTextBox("Apple", LoadFilePath, FilePath), WhiteBackground)
        Call .AddElement(0, CreateFruit(ImageFolder & "\Apple.png"), WhiteBackground)

        Call .AddElement(1, CreateTextBox("Banana", LoadFilePath, FilePath), RedBackground)
        Call .AddElement(1, CreateFruit(ImageFolder & "\Banana.png"), RedBackground)
    End With
End Function
```
---

## Extra Information

* The list is flexible in size, dynamically handling rows and columns.
* Each element gets its own OpenGL frame for scissor and viewport control.
* Background colors are optional but supported per element.
* Implements `VBGLDrawable` to integrate seamlessly with OpenGL rendering pipelines.
* Provides global defaults that can be overridden per element or row.
* Row positioning is automatically calculated based on heights and previous rows.
* Due to having many seperate Subwindows and a lot of drawcalls this class may tank your performance

## Dependencies
* VBGLContext

## Testing
Tested with VBGLMesh and VBGLTextBox

## Lifecycle Notes
During VBGLContext Lifecycle

## See Also: