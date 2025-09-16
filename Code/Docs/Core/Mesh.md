# VBGLMesh
## Version 1.0

Represents a drawable mesh object in OpenGL with all the required rendering state:
* Vertex array object (VAO) and optional element buffer object (EBO).
* One or more bound textures.
* Optional material properties (ambient, diffuse, specular, shininess).
* Associated shader program.

It can handle both indexed and non-indexed drawing (with or without IndexBuffer).
This class encapsulates everything needed to render a 3D object in one call to .Draw.

## Members

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

## Example
```vb
    Public Sub TestMesh
    ' Create shader
    Dim Shader As VBGLShader
    Set Shader = VBGLShader.Create("mesh.vert", "mesh.frag")

    ' Define layout and data
    Dim LayoutTypes(1) As VBGLLayoutType
    LayoutTypes(0) = VBGLLayoutType.XYZ
    LayoutTypes(1) = VBGLLayoutType.RGBB
    Dim Layout As VBGLLayout
    Set Layout = VBGLLayout.Create(vbSingle, LayoutTypes)


    ' Basic Triangle with 3 Colors
    Dim Vertices() As Single
    ReDim Vertices(17)
    Vertices(00) = -1: Vertices(01) = 0: Vertices(02) = 0: Vertices(03) = 1: Vertices(04) = 0: Vertices(05) = 0 
    Vertices(06) = +0: Vertices(07) = 1: Vertices(08) = 0: Vertices(09) = 0: Vertices(10) = 0: Vertices(11) = 0
    Vertices(12) = +1: Vertices(13) = 0: Vertices(14) = 0: Vertices(15) = 0: Vertices(16) = 0: Vertices(17) = 1
    Dim VertexData As IDataSingle
    Set VertexData = VBGLData.CreateSingle(Vertices)

    Dim Mesh As VBGLMesh
    Set Mesh = VBGLMesh.Create(Shader, Layout, VertexData, Nothing, False)

    ' Assign a texture
    Dim Texture() As VBGLTexture
    ReDim Texture(0)
    Set Texture(0) = VBGLTexture.CreateFromFile("diffuse.png")
    Mesh.Textures(0) = Texture

    ' Draw in render loop
    Mesh.Draw
End Sub
```