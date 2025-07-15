VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Mesh"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private Declare PtrSafe Sub CopyMemory Lib "kernel32" Alias "RtlCopyMemory" (ByRef Destination As Any, ByVal Source As Any, ByVal Length As Long)

Private p_VAO            As VBGLVertexArray
Private p_EBO            As IBufferIndex
Private p_Textures()     As VBGLTexture
Private p_Shader         As VBGLShader
Private p_UseIndexBuffer As Boolean

Public Property Let VAO(n_VAO                       As VBGLVertexArray) : Set p_VAO            = n_VAO            : End Property
Public Property Let EBO(n_EBO                       As IBufferIndex)    : Set p_EBO            = n_EBO            : End Property
Public Property Let Textures(n_Textures()           As VBGLTexture)     : Let p_Textures       = n_Textures       : End Property
Public Property Let Shader(n_Shader                 As VBGLShader)      : Set p_Shader         = n_Shader         : End Property
Public Property Let UseIndexBuffer(n_UseIndexBuffer As Boolean)         : Let p_UseIndexBuffer = n_UseIndexBuffer : End Property

Public Property Get VAO()                           As VBGLVertexArray  : Set VAO              = p_VAO            : End Property
Public Property Get EBO()                           As IBufferIndex     : Set EBO              = p_EBO            : End Property
Public Property Get Textures()                      As VBGLTexture()    : Let Textures         = p_Textures       : End Property
Public Property Get Shader()                        As VBGLShader       : Set Shader           = p_Shader         : End Property
Public Property Get UseIndexBuffer()                As Boolean          : Let UseIndexBuffer   = p_UseIndexBuffer : End Property

Public Function Create(Group As GLGroup, Optional n_UseIndexBuffer As Boolean = True) As Mesh
    Set Create = New Mesh
    Dim Layout  As VBGLBufferLayout: Set Layout = CreateFromGroup(Group, "Layout")
    Dim Data    As VBGLData        : Set Data   = CreateFromGroup(Group, "Data")
    Dim Faces   As GLFace          : Set Faces  = CreateFromGroup(Group, "Faces")
    With Create
        .VAO            = VBGLVertexArray.Create(Layout, Data)
        .EBO            = VBGLBuffer.CreateIndexBuffer(GetIndex(Faces))
        .UseIndexBuffer = n_UseIndexBuffer
    End With
End Function

Public Sub Draw()
    Call Shader.Bind()
    Dim i As Long
    For i = 0 To USize(p_Textures)
        Call p_Textures(i).Activate(i)
        Call Shader.Set1i("Texture" & p_Textures(i).Typee & i, i)
        Call p_Textures(i).Bind()
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

Public Sub GetShader(Group As GLGroup, LoadedShaders() As VBGLShader)
    Dim i As Long
    Dim Code As String
    Dim Template As VBGLShaderTemplate
    Set Template = VBGLShaderTemplate.Create("Vertex-Fragment", "460 core")
    'Temp
    Dim Uni() As String
    ReDim Uni(7)
    Uni(0) = "mat4|Model"
    Uni(1) = "mat4|View"
    Uni(2) = "mat4|Projection"
    Uni(3) = Empty
    Uni(4) = "sampler2D|TextureDiffuse0"
    Uni(5) = "vec3|NormalPosition"
    Uni(6) = "vec3|LightColor0"
    Uni(7) = "vec3|ObjectColor"

    Call Template.SetUp(VAO.Layout, Uni)
    Code = Template.GetShader
    Debug.Print Code
    '

    For i = 0 To USize(LoadedShaders)
        If LoadedShaders(i).Code = Code Then
            Shader = LoadedShaders(i)
            Exit Sub
        End If
    Next i
    Shader = VBGLShader.CreateFromText(Code)
    ReDim LoadedShaders(USize(LoadedShaders) + 1)
    Set LoadedShaders(USize(LoadedShaders)) = Shader
End Sub

Public Sub GetTextures(Group As GLGroup, Materials() As GLMaterial, LoadedTextures() As VBGLTexture)
    Dim i As Long, j As Long
    Dim Material As String
    Dim Arr() As VBGLTexture

    For i = 0 To Group.Count
        Material = Group.SubGroup(i).Material
        If Material <> Empty Then
            For j = 0 To USize(Materials)
                If Materials(j).Name = Material Then
                    Call AddTexture(LoadedTextures, Materials(j).MapTexture)
                    Call AddTexture(LoadedTextures, Materials(j).MapAmbient)
                    Call AddTexture(LoadedTextures, Materials(j).MapDiffuse)
                    Call AddTexture(LoadedTextures, Materials(j).MapSpecular)
                End If
            Next j
        End If
    Next i
End Sub

Private Function AddTexture(LoadedTextures() As VBGLTexture, FilePath As String) As Long
    Dim i As Long
    Dim Size As Long
    If FilePath = Empty Then
        Exit Function
    End If

    Size = USize(p_Textures)
    For i = 0 To USize(LoadedTextures)
        If LoadedTextures(i).FilePath = FilePath Then
            Exit For
        End If
    Next i
    Size = Size + 1
    ReDim Preserve p_Textures(Size)
    If i > Size Then
        'Call Loader.Add(FilePath)
        ReDim Preserve LoadedTextures(USize(LoadedTextures) + 1)
        Set LoadedTextures(USize(LoadedTextures)) = VBGLTexture.Create(FilePath, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, "Diffuse")
        Set p_Textures(Size) = LoadedTextures(USize(LoadedTextures))
    Else
        Set p_Textures(Size) = LoadedTextures(i)
    End If
End Function

'Go through each Subgroup, combine or split data and then get the bytedata
Private Function CreateFromGroup(Group As GLGroup, GetWhat As String) As Variant
    Dim i As Long

    Dim Subgroups() As GLSubGroup
    Subgroups = Group.Subgroups
    For i = 0 To Group.Count
        Dim VMaxIndex As Long: If Not Subgroups(i).Vertices Is Nothing Then VMaxIndex = UpdateSize(VMaxIndex, Subgroups(i).Vertices.Count , True)
        Dim VMinIndex As Long: If Not Subgroups(i).Vertices Is Nothing Then VMinIndex = UpdateSize(VMinIndex, Subgroups(i).Vertices.Count , False)
        Dim TMaxIndex As Long: If Not Subgroups(i).Textures Is Nothing Then TMaxIndex = UpdateSize(TMaxIndex, Subgroups(i).Textures.Count , True)
        Dim TMinIndex As Long: If Not Subgroups(i).Textures Is Nothing Then TMinIndex = UpdateSize(TMinIndex, Subgroups(i).Textures.Count , False)
        Dim NMaxIndex As Long: If Not Subgroups(i).Normals  Is Nothing Then NMaxIndex = UpdateSize(NMaxIndex, Subgroups(i).Normals.Count  , True)
        Dim NMinIndex As Long: If Not Subgroups(i).Normals  Is Nothing Then NMinIndex = UpdateSize(NMinIndex, Subgroups(i).Normals.Count  , False)
        Dim CMaxIndex As Long: If Not Subgroups(i).Colors   Is Nothing Then CMaxIndex = UpdateSize(CMaxIndex, Subgroups(i).Colors.Count   , True)
        Dim CMinIndex As Long: If Not Subgroups(i).Colors   Is Nothing Then CMinIndex = UpdateSize(CMinIndex, Subgroups(i).Colors.Count   , False)
        Dim FMaxIndex As Long: If Not Subgroups(i).Faces    Is Nothing Then FMaxIndex = UpdateSize(FMaxIndex, Subgroups(i).Faces.Count    , True)
        Dim FMinIndex As Long: If Not Subgroups(i).Faces    Is Nothing Then FMinIndex = UpdateSize(FMinIndex, Subgroups(i).Faces.Count    , False)
    Next i

    If FMaxIndex < VMaxIndex Or FMaxIndex < TMaxIndex Or FMaxIndex < NMaxIndex Or FMaxIndex < CMaxIndex Then
        Debug.Print "Group: " & Group.Name & "has invalid Max Face-VertexSize: ", FMaxIndex, VMaxIndex, TMaxIndex, NMaxIndex, CMaxIndex
        Exit Function
    End If
    If FMinIndex > VMinIndex Or FMinIndex > TMinIndex Or FMinIndex > NMinIndex Or FMinIndex > CMinIndex Then 
        Debug.Print "Group: " & Group.Name & "has invalid Min Face-VertexSize: ", FMaxIndex, VMaxIndex, TMaxIndex, NMaxIndex, CMinIndex
        Exit Function
    End If

    For i = 0 To Group.Count
        Dim VArr As GLVertex
        Dim TArr As GLVertex
        Dim NArr As GLVertex
        Dim CArr As GLVertex
        Dim FArr As GLFace
        If Not Subgroups(i).Vertices Is Nothing Then If VMaxIndex = Subgroups(i).Vertices.Count  And VMinIndex = 0 Then Set VArr = Subgroups(i).Vertices
        If Not Subgroups(i).Textures Is Nothing Then If TMaxIndex = Subgroups(i).Textures.Count  And TMinIndex = 0 Then Set TArr = Subgroups(i).Textures
        If Not Subgroups(i).Normals  Is Nothing Then If NMaxIndex = Subgroups(i).Normals.Count   And NMinIndex = 0 Then Set NArr = Subgroups(i).Normals
        If Not Subgroups(i).Colors   Is Nothing Then If CMaxIndex = Subgroups(i).Colors.Count    And CMinIndex = 0 Then Set CArr = Subgroups(i).Colors
        If Not Subgroups(i).Faces    Is Nothing Then If FMaxIndex = Subgroups(i).Faces.Count     And FMinIndex = 0 Then Set FArr = Subgroups(i).Faces
    Next i
    If GetWhat = "Layout" Then
        Set CreateFromGroup = CreateLayout(VArr, TArr, NArr, CArr)
    ElseIf GetWhat = "Data" Then
        Set CreateFromGroup = CreateData(CreateLayout(VArr, TArr, NArr, CArr), 1, FArr, VArr, TArr, NArr, CArr)
    ElseIf GetWhat = "Faces" Then
        Set CreateFromGroup = FArr
    Else
    End If
End Function

Private Function CreateData(Layout As VBGLBufferLayout, StartIndex As Long, Faces As GLFace, Vertices As GLVertex, Textures As GLVertex, Normals As GLVertex, Colors As GLVertex) As IDataByte
    Dim NewSize As Long: NewSize = Faces.Count * Layout.ByteSize()
    Dim ReturnArr()   As Byte: ReDim ReturnArr(NewSize - 1)

    Dim ArrV()  As Byte: If Not Vertices Is Nothing Then ArrV = Vertices.Vertices.ByteData
    Dim ArrT()  As Byte: If Not Textures Is Nothing Then ArrT = Textures.Vertices.ByteData
    Dim ArrN()  As Byte: If Not Normals  Is Nothing Then ArrN = Normals.Vertices.ByteData
    Dim ArrC()  As Byte: If Not Colors   Is Nothing Then ArrC = Colors.Vertices.ByteData

    Dim ArrVB   As Long: If Not Vertices Is Nothing Then ArrVB = Vertices.Element.GetTypeByteSize
    Dim ArrTB   As Long: If Not Textures Is Nothing Then ArrTB = Textures.Element.GetTypeByteSize
    Dim ArrNB   As Long: If Not Normals  Is Nothing Then ArrNB = Normals.Element.GetTypeByteSize
    Dim ArrCB   As Long: If Not Colors   Is Nothing Then ArrCB = Colors.Element.GetTypeByteSize

    Dim ArrVF() As Long: If Not Vertices Is Nothing Then ArrVF = Faces.Vertex()
    Dim ArrTF() As Long: If Not Textures Is Nothing Then ArrTF = Faces.Texture()
    Dim ArrNF() As Long: If Not Normals  Is Nothing Then ArrNF = Faces.Normal()
    Dim ArrCF() As Long: If Not Colors   Is Nothing Then ArrCF = Faces.Color()

    Dim ByteSize As Long

    Dim i As Long, j As Long
    For i = 0 To Faces.Count - 1
        For j = 0 To Ubound(Layout.Elements)

            Dim Index As Long
            Dim Length As Long
            Dim Offset As Long
            Dim Pointer As LongPtr
            Select Case True
                Case Layout.Element(j).GetCategory = "Position"
                    Length = ArrVB
                    Index = (ArrVF(i) - StartIndex) * Length
                    Pointer = VarPtr(ArrV(Index))
                Case Layout.Element(j).GetCategory = "Texture"
                    Length = ArrTB
                    Index = (ArrTF(i) - StartIndex) * Length
                    Pointer = VarPtr(ArrT(Index))
                Case Layout.Element(j).GetCategory = "Normal"
                    Length = ArrNB
                    Index = (ArrNF(i) - StartIndex) * Length
                    Pointer = VarPtr(ArrN(Index))
                Case Layout.Element(j).GetCategory = "Color"
                    Length = ArrCB
                    Index = (ArrCF(i) - StartIndex) * Length
                    Pointer = VarPtr(ArrC(Index))
            End Select
            Call CopyMemory(ReturnArr(Offset), Pointer, Length)
            Offset = Offset + Length
        Next j
    Next i
    Set CreateData = VBGLData.Create(vbByte)
    CreateData.Data = ReturnArr
End Function

Private Function CreateLayout(Vertices As GLVertex, Textures As GLVertex, Normals As GLVertex, Colors As GLVertex) As VBGLBufferLayout
    Dim Types() As VBGLBufferLayoutType

    Dim Size As Long
    Size = -1
    If Not Vertices Is Nothing Then Size = Size + 1: ReDim Preserve Types(Size): Types(Size) = Vertices.Element.LayoutType
    If Not Textures Is Nothing Then Size = Size + 1: ReDim Preserve Types(Size): Types(Size) = Textures.Element.LayoutType
    If Not Normals Is Nothing  Then Size = Size + 1: ReDim Preserve Types(Size): Types(Size) = Normals.Element.LayoutType
    If Not Colors Is Nothing   Then Size = Size + 1: ReDim Preserve Types(Size): Types(Size) = Colors.Element.LayoutType
    Set CreateLayout = VBGLBufferLayout.Create(vbSingle, Types)
End Function

Private Function USize(Arr As Variant, Optional Dimension As Long = 1)
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr, Dimension)
End Function

Private Function LSize(Arr As Variant, Optional Dimension As Long = 1)
    On Error Resume Next
    LSize = -1
    LSize = Lbound(Arr, Dimension)
End Function

Private Function UpdateSize(PreviousValue As Long, Count As Long, Max As Boolean)
    If Count = -1 Then
        UpdateSize = PreviousValue
        Exit Function
    End If
    If Max Then
        If Count > PreviousValue Then
            UpdateSize = Count
        Else
            UpdateSize = PreviousValue
        End If
    Else
        If PreviousValue > Count Then
            UpdateSize = Count
        Else
            UpdateSize = PreviousValue
        End If
    End If
End Function