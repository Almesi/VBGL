# VBGLMesh
## Version 1.0




## Example













# Mesh
### Version 1.0
| X                        | Y                |
| --------                 | -------          |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLContext      |
| Tags                     | OOP, VBA, OpenGL |

## Purpose

Single Object capable of drawing something to the window.

--------------------------------------------------------

## Overview

Represents a drawable mesh object in OpenGL with all the required rendering state:
* Vertex array object (VAO) and optional element buffer object (EBO).
* One or more bound textures.
* Optional material properties (ambient, diffuse, specular, shininess).
* Associated shader program.

It can handle both indexed and non-indexed drawing (with or without IndexBuffer).
This class encapsulates everything needed to render a 3D object in one call to .Draw.


--------------------------------------------------------

## Properties

| Property       | Type            | Description |
| --------       | -------         | -------     |
| VAO            | VBGLVertexArray | Vertex array object.
| EBO            | IBufferIndex    | Index buffer (element buffer). Optional; used only when indexed drawing is enabled.
| Textures       | VBGLTexture()   | Array of textures applied to this mesh.
| Material       | GLMaterial      | Optional material definition (ambient, diffuse, specular properties, shininess).
| Shader         | VBGLShader      | hader program used for rendering. Mandatory.
| UseIndexBuffer | Boolean         | Determines whether to render using indices (glDrawElements) or vertex order (glDrawArrays).
| Orientation    | Long            | Determines winding direction of Triangles.

As of this Version, UseIndexBuffer should be false, as Index Buffers dont work

## Methods
1. `Create(n_Shader As VBGLShader, Layout As VBGLLayout, Data As VBGLData, [Faces As VBGLFace], [n_UseIndexBuffer As Boolean]) As VBGLMesh`
    * Build a new mesh.
    * Creates a VAO from Layout and Data.
    * Optionally creates an index buffer if Faces and n_UseIndexBuffer are provided.
    * Binds the shader.
    * Returns a ready-to-render VBGLMesh.

2. `Draw()`
    * Renders the mesh. Steps:
        + Bind Shader
        + Calls Shader.Bind().
        + If material is present, uploads uniforms (AmbientColor, DiffuseColor, SpecularColor, Shininess, etc.).
        + Iterates all textures, activates each, binds it, and assigns sampler uniforms.
        + Uniform name defaults to "TextureDiffuseN" if Texture(i).Name is empty.
        + Bind VAO
        + Draw Call
            * If UseIndexBuffer = True → glDrawElements.
            * Else → glDrawArrays.

3. `GetIndex(Faces As VBGLFace) As VBGLData`
    * Converts face index data into a VBGLData buffer of type vbLong, which can then be used for the index buffer (EBO).

4. `GetOrientation(FirstTriangle() As Single) As Long`
    * Will check using Trapezoid formula if the first Triangle is clockwise or counterclockwise.
    * VBGLMesh assumes all other following triangles to be the same orientation

--------------------------------------------------------

## Examples:  
1. Simple implementation
```vb
    Public Sub TestMesh
    ' Create shader
    Dim Shader As VBGLShader
    Set Shader = VBGLShader.Create("mesh.vert", "mesh.frag")

    ' Define layout and data
    Dim Layout As VBGLLayout
    Set Layout = VBGLLayout.Create(vbSingle, LayoutTypes, VBGLLayoutType.XYZ, VBGLLayoutType.RGBB)


    ' Basic Triangle with 3 Colors
    Dim Vertices() As Single
    Vertices = ArraySingle( _
                                -1, 0, 0, 1, 0, 0, _ 
                                +0, 1, 0, 0, 0, 0, _
                                +1, 0, 0, 0, 0, 1 _
                          )
    Dim VertexData As IDataSingle
    Set VertexData = VBGLData.CreateSingle(Vertices)

    Dim Mesh As VBGLMesh
    Set Mesh = VBGLMesh.Create(Shader, Layout, VertexData, Nothing, False)

    ' Assign a texture
    Dim Texture As VBGLTexture
    ReDim Texture
    Set Texture = VBGLTexture.CreateFromFile("pic.png")
    Call Mesh.AddTexture(Texture)

    ' Draw in render loop
    Call Mesh.Draw()
End Sub
```

## Extra Information
XXX

## Dependencies
* VBGLContext
* VBGLData
* VBGLBuffer
* VBGLShader
* VBGLVertexArray
* VBGLLayout
* VBGLWindow

## Testing
Basic Testing in Tests Folder

## Lifecycle Notes
Creation and deletion inside VBGL-Object Lifetime

## See Also:
[Context](..\Context)
[Data](..\Data)
[Buffer](..\Buffer)
[Shader](..\Shader)
[VertexArray](..\VertexArray)
[Layout](..\Layout)
[Window](..\Window)