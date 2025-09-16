VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLMesh"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

' Describes 1 drawable instance will all the data it needs

Private p_VAO            As VBGLVertexArray
Private p_EBO            As IBufferIndex    ' Currently Optional for future use, as IndexBuffer doesnt work at the moment
Private p_Textures()     As VBGLTexture     ' Should not go over System-allowed max for your enviroment
Private p_Material       As GLMaterial      ' Optional
Private p_Shader         As VBGLShader      ' Mandatory
Private p_UseIndexBuffer As Boolean         ' Optional
Private p_Orientation    As Long            ' Mandatory

Public Property Let VAO(ByVal n_VAO                                As VBGLVertexArray) : Set p_VAO               = n_VAO              : End Property
Public Property Let EBO(ByVal n_EBO                                As IBufferIndex)    : Set p_EBO               = n_EBO              : End Property
Public Property Let Textures(ByVal n_Textures                      As Variant)         : Let p_Textures          = n_Textures         : End Property
Public Property Let Material(ByVal n_Material                      As GLMaterial)      : Set p_Material          = n_Material         : End Property
Public Property Let Shader(ByVal n_Shader                          As VBGLShader)      : Set p_Shader            = n_Shader           : End Property
Public Property Let UseIndexBuffer(ByVal n_UseIndexBuffer          As Boolean)         : Let p_UseIndexBuffer    = n_UseIndexBuffer   : End Property
Public Property Let Orientation(ByVal n_Orientation                As Long)            : Let p_Orientation       = n_Orientation      : End Property
Public Property Let Texture(ByVal Index As Long, ByVal n_Texture   As VBGLTexture)     : Set p_Textures(Index)   = n_Texture          : End Property

Public Property Get VAO()                                          As VBGLVertexArray  : Set VAO                 = p_VAO              : End Property
Public Property Get EBO()                                          As IBufferIndex     : Set EBO                 = p_EBO              : End Property
Public Property Get Textures()                                     As Variant          : Let Textures            = p_Textures         : End Property
Public Property Get Material()                                     As GLMaterial       : Set Material            = p_Material         : End Property
Public Property Get Shader()                                       As VBGLShader       : Set Shader              = p_Shader           : End Property
Public Property Get UseIndexBuffer()                               As Boolean          : Let UseIndexBuffer      = p_UseIndexBuffer   : End Property
Public Property Get Orientation()                                  As Long             : Let Orientation         = p_Orientation      : End Property
Public Property Get Texture(ByVal Index As Long)                   As VBGLTexture      : Set Texture             = p_Textures(Index)  : End Property

Public Function Create(ByVal n_Shader As VBGLShader, ByVal Layout As VBGLLayout, ByVal Data As VBGLData, Optional ByVal Faces As VBGLFace = Nothing, Optional ByVal n_UseIndexBuffer As Boolean = False) As VBGLMesh
    Set Create = New VBGLMesh
    With Create
        .Shader         = n_Shader
        .VAO            = VBGLVertexArray.Create(Layout, Data)
        .UseIndexBuffer = n_UseIndexBuffer
        .Orientation    = GetOrientation(GetFirstTriangle(Layout, Data))
        If n_UseIndexBuffer Then .EBO = VBGLBuffer.CreateIndexBuffer(GetIndex(Faces))
    End With
End Function

Public Sub Draw()
    Dim i As Long
    Call Shader.Bind()
    If IsSomething(Material) Then
        Shader.Uniforms.Data("AmbientColor")   = Material.ColorAmbient
        Shader.Uniforms.Data("DiffuseColor")   = Material.ColorDiffuse
        Shader.Uniforms.Data("SpecularColor")  = Material.ColorSpecular
        Shader.Uniforms.Data("AmbientFactor")  = 0.1!
        Shader.Uniforms.Data("SpecularFactor") = 0.2!
        Shader.Uniforms.Data("Shininess")      = Material.Shininess
    End If
    For i = 0 To USize(Textures)
        Call Texture(i).Activate(i)
        If Texture(i).Name = Empty Then
            Shader.Uniforms.Data("TextureDiffuse" & i) = i
        Else
            Shader.Uniforms.Data(Texture(i).Name) = i
        End If
        Call Texture(i).Bind()
    Next i
    
    Call VAO.Bind()
    Call glFrontFace(Orientation)
    If UseIndexBuffer Then
        Call EBO.Bind()
        Call glDrawElements(GL_TRIANGLES, EBO.Data.Count, GL_UNSIGNED_INT, 0)
    Else
        Call glDrawArrays(GL_TRIANGLES, 0, VAO.Buffer.Data.Count / VAO.Layout.ByteSize)
    End If
End Sub

Public Function GetOrientation(FirstTriangle() As Single) As Long
    Dim VertexOffset As Long
    Dim PointsPerTriangle As Long
    PointsPerTriangle = 3
    VertexOffset = ((USize(FirstTriangle) + 1) / PointsPerTriangle)
    Dim X() As Single
    Dim Y() As Single

    ReDim X(2)
    ReDim Y(2)

    X(0) = FirstTriangle(0 * VertexOffset + 0)
    Y(0) = FirstTriangle(0 * VertexOffset + 1)
    X(1) = FirstTriangle(1 * VertexOffset + 0)
    Y(1) = FirstTriangle(1 * VertexOffset + 1)
    X(2) = FirstTriangle(2 * VertexOffset + 0)
    Y(2) = FirstTriangle(2 * VertexOffset + 1)

    Dim i As Long
    Dim Sum As Single
    
    For i = 0 To USize(X) - 1
        Sum = Sum + (X(i + 1) - X(i)) * (Y(i + 1) + Y(i))
    Next i
    ' Close polygon (last point with first point)
    Sum = Sum + (X(0) - X(USize(X))) * (Y(0) + Y(USize(Y)))
    
    If Sum > 0 Then
        GetOrientation = GL_CW
    Else
        GetOrientation = GL_CCW
    End If
End Function

Private Function GetIndex(ByVal Faces As VBGLFace) As VBGLData
    Dim Temp As IDataLong
    Set Temp = VBGLData.Create(vbLong)
    Temp.Data = Faces.Vertex
    Set GetIndex = Temp
End Function

Private Function GetFirstTriangle(ByVal Layout As VBGLLayout, ByVal Data As VBGLData) As Single()
    Dim SizeSingle  As Long   : SizeSingle = 4
    Dim NewSize     As Long   : NewSize = (Layout.ByteSize / SizeSingle) * 3
    Dim ReturnArr() As Single : ReDim ReturnArr(NewSize - 1)
    Dim ByteData()  As Byte   : ByteData = Data.Data
    Dim i As Long
    For i = 0 To NewSize - 1
        Call CopyMemory(ReturnArr(i), VarPtr(ByteData(i * SizeSingle)), SizeSingle)
    Next i
    GetFirstTriangle = ReturnArr
End Function