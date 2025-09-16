# Layout
#### Version 1.0

Layout is very important for VBGL.
It is the Backbone for how data should be interpreted

## VBGLElement

Represents a single element (attribute) in an OpenGL-style vertex buffer layout.
Encapsulates information about how data should be interpreted, including:

| Property    | Type            | Description |
| --------    | -------         | -------     |
| LayoutType  | VBGLLayoutType  | Describes what data it is and how many data"points" it has
| DataType    | Long            | Describes what type of data the LayoutType has (as OpenGL-Type Like GL_FLOAT)
| Normalized  | Byte            | Describes if the data is normalized or not

Example:


---

### VBGLLayoutType
This is an Enum used to differentiate between LayoutTypes.  
To be able to differentiate between different Layout Categories and their Sizes, the enum needs to be continous and the function `Category` is needed.  
* Position: X, XY, XYZ, XYZW
* Color   : R, G, B, RG, RB, GB, RGBB (alias for RGB), RGBA
* Texture : TxTy
* Normals : NxNY, NxNyNz


### Methods
1. `Create(LayoutType, DataType, Normalized) As VBGLElement`
    * Instantiates a new VBGLElement with the given parameters.
2. `Size() As Long`
    * Returns the number of Points for the given layout type.
    * Example: XYZ  --> 3 Points
    * Example: RGBA --> 4 Points
3. `ByteSize() As Long`
    * Returns the total size (in bytes) of the element, based on its data type and number of components.
    * Example: XYZ  --> 3 Points & DataType Single = 3*4 Bytes = 12 Bytes
    * Example: RGBA --> 4 Points & DataType Byte   = 4*1 Bytes = 4  Bytes
4. Category() As String
    * Returns the category of the element

## VBGLLayout
Defines an entire layout (sequence) of vertex attributes for OpenGL-style rendering.
It is essentially an array of VBGLElement objects, along with metadata about total size and stride.

This class allows easy creation of layouts for vertex buffers containing mixed attributes (positions, colors, normals, texture coordinates, etc.).
It also allows for different DataType combinations.  


### Members

| Property    | Type          | Description |
| --------    | -------       | -------     |
| Size        | Long          | Upperbound of Elements
| ByteSize    | Long          | Total Size of Bytes per Vertex
| Elements    | VBGLElement() | Array(in Order)

### Methods

1. `Create(DataType As vbVarType, Types() As VBGLLayoutType) As VBGLLayout`
    * Creates a new layout from a single data type applied to multiple layout types.
    * Only 1 DataType Allowed

2. `CreateCombined(DataTypes() As vbVarType, Types() As VBGLLayoutType) As VBGLLayout`
    * Creates a layout where each element may have a different data type.
    * Ubound(DataTypes) must equal Ubound(Types).

3. `AddType(DataType As vbVarType, Typee As VBGLLayoutType)`
    * Convenience method to add an element, mapping VB type → OpenGL type.
    `vbSingle`  is `GL_FLOAT`
    `vbDouble`  is `GL_DOUBLE`
    `vbByte`    is `GL_UNSIGNED_BYTE`
    `vbInteger` is `GL_UNSIGNED_INT`

4. `Push(Typee As Long, LayoutType As VBGLLayoutType, Normalized As Byte)`
    * Core method for inserting elements into the layout.
    * Updates Size, resizes p_Elements, and increases ByteSize.
    * Typee is OpenGL-DataType

5. GetEnum(What As String, Size As Long) As VBGLLayoutType
    * Returns the correct VBGLLayoutType based on a category ("Position", "Color", "Texture", "Normal") and a component count.
    * Example: "Position", 3 = VBGLLayoutType.XYZ

### Examples
```vb
Public Sub TestLayout()
    Dim Layout   As VBGLLayout
    Dim Types(2) As VBGLLayoutType

    Types(0) = VBGLLayoutType.XYZ
    Types(1) = VBGLLayoutType.RGBA
    Types(2) = VBGLLayoutType.TxTy

    Set Layout = VBGLLayout.Create(vbSingle, Types)
End Sub
```
DataLayout:  
   4   8   12  16  20  24   28    32      36
----////----////----////----/ / / / - - - -
xxxxyyyyzzzzrrrrggggbbbbaaaaTxTxTxTxTyTyTyTy

```vb
Public Sub TestLayout()
    Dim Layout   As VBGLLayout
    Dim Types(2) As VBGLLayoutType
    Dim DataTypes(2) As vbVarType

    Types(0)     = VBGLLayoutType.XYZ
    Types(1)     = VBGLLayoutType.RGBA
    Types(2)     = VBGLLayoutType.TxTy

    DataTypes(0) = vbInteger
    DataTypes(1) = vbSingle
    DataTypes(2) = vbByte

    Set Layout = VBGLLayout.CreateCombined(DataTypes, Types)
End Sub
```
DataLayout:  
 2 4 6   10  14  18  22  24
--//--////----////----/ /
xxyyzzrrrrggggbbbbaaaaTxTy