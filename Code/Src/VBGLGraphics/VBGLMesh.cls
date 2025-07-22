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

Private p_VAO            As VBGLVertexArray
Private p_EBO            As IBufferIndex
Private p_Textures()     As VBGLTexture
Private p_Material       As GLMaterial
Private p_Shader         As VBGLShader
Private p_UseIndexBuffer As Boolean

Public Property Let VAO(n_VAO                          As VBGLVertexArray) : Set p_VAO               = n_VAO              : End Property
Public Property Let EBO(n_EBO                          As IBufferIndex)    : Set p_EBO               = n_EBO              : End Property
Public Property Let Textures(n_Textures()              As VBGLTexture)     : Let p_Textures          = n_Textures         : End Property
Public Property Let Material(n_Material                As GLMaterial)      : Set p_Material          = n_Material         : End Property
Public Property Let Shader(n_Shader                    As VBGLShader)      : Set p_Shader            = n_Shader           : End Property
Public Property Let UseIndexBuffer(n_UseIndexBuffer    As Boolean)         : Let p_UseIndexBuffer    = n_UseIndexBuffer   : End Property
Public Property Let Texture(Index As Long, n_Texture   As VBGLTexture)     : Set p_Textures(Index)   = n_Texture          : End Property

Public Property Get VAO()                              As VBGLVertexArray  : Set VAO                 = p_VAO              : End Property
Public Property Get EBO()                              As IBufferIndex     : Set EBO                 = p_EBO              : End Property
Public Property Get Textures()                         As VBGLTexture()    : Let Textures            = p_Textures         : End Property
Public Property Get Material()                         As GLMaterial       : Set Material            = p_Material         : End Property
Public Property Get Shader()                           As VBGLShader       : Set Shader              = p_Shader           : End Property
Public Property Get UseIndexBuffer()                   As Boolean          : Let UseIndexBuffer      = p_UseIndexBuffer   : End Property
Public Property Get Texture(Index As Long)             As VBGLTexture      : Set Texture             = p_Textures(Index)  : End Property

Public Function Create(n_Shader As VBGLShader, Layout As VBGLLayout, Data As VBGLData, Faces As GLFace, Optional n_UseIndexBuffer As Boolean = True) As VBGLMesh
    Set Create = New VBGLMesh
    With Create
        .Shader         = n_Shader
        .VAO            = VBGLVertexArray.Create(Layout, Data)
        .EBO            = VBGLBuffer.CreateIndexBuffer(GetIndex(Faces))
        .UseIndexBuffer = n_UseIndexBuffer
    End With
End Function

Public Sub Draw()
    Dim i As Long
    Call Shader.Bind()
    If Not Material Is Nothing Then
        Call Shader.SetAny("AmbientColor" , Material.ColorAmbient)
        Call Shader.SetAny("DiffuseColor" , Material.ColorDiffuse)
        Call Shader.SetAny("SpecularColor", Material.ColorSpecular)
        Call Shader.SetAny("AmbientFactor", 0.1!)
        Call Shader.SetAny("SpecularFactor", 0.5!)
        Call Shader.SetAny("Shininess", Material.Shininess)
    End If
    For i = 0 To USize(Textures)
        Call Texture(i).Activate(i)
        Call Shader.SetAny("Texture" & Texture(i).Typee & i, i)
        Call Texture(i).Bind()
    Next i
    
    Call VAO.Bind()
    If UseIndexBuffer Then
        Call EBO.Bind()
        Call glDrawElements(GL_TRIANGLES, EBO.Data.Count, GL_UNSIGNED_INT, 0)
    Else
        Call glDrawArrays(GL_TRIANGLES, 0, VAO.Buffer.Data.Count / VAO.Layout.ByteSize)
    End If
End Sub

Private Function GetIndex(Faces As GLFace) As VBGLData
    Dim Temp As IDataLong
    Set Temp = VBGLData.Create(vbLong)
    Temp.Data = Faces.Vertex
    Set GetIndex = Temp
End Function

Private Function USize(Arr As Variant, Optional Dimension As Long = 1)
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr, Dimension)
End Function