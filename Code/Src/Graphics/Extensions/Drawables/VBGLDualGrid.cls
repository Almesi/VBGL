VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLDualGrid"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private Const TilesPerSprite As Long = 16 ' On of them is an empty sprite

Implements VBGLDrawable



' ________________________
'|           |            |
'|           |            |
'|     1     |      2     |
'|           |            |
'|-----------|------------|
'|           |            |
'|     4     |      8     |
'|           |            |
'|___________|____________|

Private Enum TileType
    EmptyImage          = 0
    UpperLeft           = 1
    UpperRight          = 2
    UpperRow            = 3
    LowerLeft           = 4
    LeftColumn          = 5
    DiagonalRight       = 6
    TriangleUpperLeft   = 7
    BottomRight         = 8
    DiagonalLeft        = 9
    RightColumn         = 10
    TriangleUpperRight  = 11
    BottomRow           = 12
    TriangleBottomLeft  = 13
    TriangleBottomRight = 14
    Full                = 15
End Enum

Private Enum Mode
    InRow = 0
End Enum


Private p_Mesh      As VBGLMesh
Private p_TileSet   As VBGLTexture

Private Layout      As VBGLLayout
Private BuildData() As Single
Private Tiles()     As Long


Public Property Let Mesh(ByVal n_Value                          As VBGLMesh)           : Set p_Mesh                = n_Value               : End Property
Public Property Let TileSet(ByVal n_Value                       As VBGLTexture)        : Set p_TileSet             = n_Value               : End Property

Public Property Get Mesh()                                      As VBGLMesh            : Set Mesh                  = p_Mesh                : End Property
Public Property Get TileSet()                                   As VBGLTexture         : Set TileSet               = p_TileSet             : End Property

Private Sub VBGLDrawable_Draw()
    Call Draw()
End Sub


Public Function CreateFromFolder(ByVal FolderPath As String, ByVal Recursive As Boolean) As VBGLDualGrid
    Dim Manager As VBGLTextureManager
    Set Manager = VBGLTextureManager.Create(VBGLTextureMergerGrid.Create(False))
    Manager.Flip = False
    Manager.Transpose = True
    Call Manager.LoadFromFolderArr(FolderPath, _
                                Recursive, _
                                4 , _
                                4 , _
                                VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpGrid, _
                                TypeTypeString)
    Dim Texture As VBGLTexture
    Set Texture = Manager.CreateTexture(TextureFactory(Manager), "DualGrid", Empty)

    Set CreateFromFolder = Create(Texture)
End Function

Public Function CreateFromFile(ByVal FilePath As String) As VBGLDualGrid
    Dim Manager As VBGLTextureManager
    Set Manager = VBGLTextureManager.Create(VBGLTextureMergerGrid.Create(False))
    Manager.Flip = True
    Call Manager.LoadFromFileArr(FolderPath, _
                                TilesPerSprite, _
                                VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpGrid, _
                                TypeTypeString)
    Dim Texture As VBGLTexture
    Set Texture = Manager.CreateTexture(TextureFactory(Manager), "DualGrid", Empty)

    Set CreateFromFolder = Create(Texture)
End Function

Public Function Create(ByVal n_TileSet As VBGLTexture) As VBGLDualGrid
    Set Create = New VBGLDualGrid
    With Create
        .TileSet = n_TileSet
    End With
End Function

Public Sub SetUp(ByVal n_Layout As VBGLLayout, ByRef n_Tiles() As Long)
    Set Layout = n_Layout
    Tiles  = n_Tiles
    ReDim BuildData(DataCount(Layout.VertexSize) - 1)
End Sub

Public Sub ParseData(ByVal LayoutIndex As Long, ByRef n_Data() As Single)
    Dim x As Long, y As Long
    Dim DataSize   As Long :   DataSize   = Layout.Element(LayoutIndex).Size
    Dim VertexSize As Long :   VertexSize = Layout.VertexSize
    Dim Index      As Long :   Index      = Layout.VertexSizeFromIndex(LayoutIndex - 1)
    Dim DataIndex As Long

    For y = 0 To USize(Tiles, 1)
        For x = 0 To USize(Tiles, 2)
            Dim Uniques As Long
            Uniques = UniqueTiles(GetTile(Tiles, x, y))
            
            Dim i As Long

            For i = 0 To Uniques
                Call AddTriangles(VertexSize, DataSize, n_Data, Index, DataIndex)
            Next i
        Next x
    Next y
End Sub

Public Sub Build()
    Dim Data As IDataSingle
    Set Data = VBGLData.CreateSingle(BuildData)
    Mesh = VBGLMesh.Create(GetShader, Layout, Data)
    Call Mesh.AddTexture(TileSet)

    'Dim i As Long, x As Long, y As Long, f As Long
'
    'Dim ShowData() As Byte : ShowData   = TileSet.Data.ByteData
    'Dim Offset     As Long : Offset     = 5
    'Dim ByteSize   As Long : ByteSize   = 4
    'Dim Max        As Long : Max        = USize(BuildData)
'
    'For y = 0 To USize(ShowData, 2)
    '    For x = 0 To USize(ShowData, 1) Step+4
    '        Dim Color As Long
    '        Color = RGB(ShowData(x + 0, y), ShowData(x + 1, y), ShowData(x + 2, y))
    '        Range("A1").Offset(y, x / 4).Interior.Color = Color
    '    Next x
    'Next y
'
    'For i = 3 To Max Step +(Offset * 6)
    '    Dim OffX   As Long : OffX   = BuildData(i - 3)
    '    Dim OffY   As Long : OffY   = BuildData(i - 2)
    '    Dim StartX As Long : StartX = Round(BuildData(i)                    * TileSet.Width)
    '    Dim StartY As Long : StartY = Round(BuildData(i + 1)                * TileSet.Height) -1
    '    Dim EndX   As Long : EndX   = Round(BuildData(i + (Offset * 4))     * TileSet.Width)  -1
    '    Dim EndY   As Long : EndY   = Round(BuildData(i + (Offset * 4) + 1) * TileSet.Height) -1
    '    If StartX = -1 Then StartX = 0
    '    If StartY = -1 Then StartY = 0
    '    If EndX   = -1 Then EndX   = 0
    '    If EndY   = -1 Then EndY   = 0
    '    For y = StartY To EndY
    '        For x = StartX To EndX
    '            Dim XPos As Long : XPos = (OffX * 16) + (x - StartX)
    '            Dim YPos As Long : YPos = 64 + (Abs(OffY) * 16) + y
    '            Color = RGB(ShowData(x*4 + 0, y), ShowData(x*4 + 1, y), ShowData(x*4 + 2, y))
    '            If Color <> RGB(255, 255, 255) Then
    '                Range("A1").Offset(YPos, XPos).Interior.Color = Color
    '            End If
    '        Next x
    '    Next y
    'Next i
End Sub

Public Sub Draw()
    Call Mesh.Draw()
End Sub

Public Sub Update(ByRef Map() As Long, Optional x As Long = -1, Optional y As Long = -1)
    'Dim Temp() As Single      : Let Temp = GetMapData(Mesh.Texture(0), Map)
    Dim Data   As IDataSingle : Set Data = VBGLData.CreateSingle(Temp)
    Call Mesh.VAO.Buffer.Update(Data)
    If x <> -1 And y <> -1 Then Call LookAt(x, y)
End Sub

Public Sub LookAt(ByVal x As Long, ByVal y As Long, ByVal TilesX As Long, ByVal TilesY As Long)
    Dim ViewData As IMatrixSingle
    Set ViewData = VBGLMatrix.Create(vbSingle, 3, 3)
    Call ViewData.Diagonals(1)
    ViewData.Item(0, 3) = -x
    ViewData.Item(1, 3) = +y
    Mesh.Shader.Uniforms.Data("View") = ViewData.Data

    Dim ProjData As IMatrixSingle
    Set ProjData = VBGLMatrix.Create(vbSingle, 3, 3)
    Call ProjData.Diagonals(1)
    ProjData.Item(0, 0) = 2 / TilesX
    ProjData.Item(1, 1) = 2 / TilesY
    Mesh.Shader.Uniforms.Data("Proj") = ProjData.Data
End Sub

Public Function GetPositionData(ByRef z() As Single) As Single()
    Dim MaxY        As Long   : MaxY        = USize(z, 1)
    Dim MaxX        As Long   : MaxX        = USize(z, 2)
    Dim Offset      As Long   : Offset      = 3
    Dim ReturnArr() As Single : ReDim ReturnArr(DataCount(Offset) - 1)

    Dim y As Long, x As Long, u As Long, v As Long
    For y = 0 To MaxY
        For x = 0 To MaxX
            For u = 0 To UniqueTiles(GetTile(Tiles, x, y))
                For v = 0 To VerticesPerTile - 1
                    Dim Index As Long
                    ReturnArr(Index + 00) = xVertices(v, x)
                    ReturnArr(Index + 01) = yVertices(v, -y)
                    ReturnArr(Index + 02) = z(y, x)
                    Index = Index + Offset
                Next v
            Next u
        Next x
    Next y
    GetPositionData = ReturnArr
End Function

Public Function GetSubTextureData() As Single()
    Dim Offset      As Long   : Offset     = 2
    Dim ReturnArr() As Single : ReDim ReturnArr(DataCount(Offset))
    Dim y As Long, x As Long, u As Long
    For y = 0 To USize(Tiles, 1)
        For x = 0 To USize(Tiles, 2)
            Dim Uniques() As Long
            Uniques = TileIndices(GetTile(Tiles, x, y))
            For u = 0 To USize(Uniques)
                Dim Index As Long
                ReturnArr(Index + 00) = TileSet.SubTexture(Uniques(u)).GetX("TopLeft")
                ReturnArr(Index + 01) = TileSet.SubTexture(Uniques(u)).GetY("TopLeft")
                ReturnArr(Index + 02) = TileSet.SubTexture(Uniques(u)).GetX("TopRight")
                ReturnArr(Index + 03) = TileSet.SubTexture(Uniques(u)).GetY("TopRight")
                ReturnArr(Index + 04) = TileSet.SubTexture(Uniques(u)).GetX("BottomLeft")
                ReturnArr(Index + 05) = TileSet.SubTexture(Uniques(u)).GetY("BottomLeft")
                ReturnArr(Index + 06) = TileSet.SubTexture(Uniques(u)).GetX("TopRight")
                ReturnArr(Index + 07) = TileSet.SubTexture(Uniques(u)).GetY("TopRight")
                ReturnArr(Index + 08) = TileSet.SubTexture(Uniques(u)).GetX("BottomRight")
                ReturnArr(Index + 09) = TileSet.SubTexture(Uniques(u)).GetY("BottomRight")
                ReturnArr(Index + 10) = TileSet.SubTexture(Uniques(u)).GetX("BottomLeft")
                ReturnArr(Index + 11) = TileSet.SubTexture(Uniques(u)).GetY("BottomLeft")
                Index = Index + (Offset * VerticesPerTile)
            Next u
        Next x
    Next y
    GetSubTextureData = ReturnArr
End Function


Private Sub AddTriangles(ByVal VertexSize As Long, ByVal DataSize As Long, ByRef n_Data() As Single, ByRef Index As Long, ByRef DataIndex As Long)
    Call AddVertex(VertexSize, DataSize, n_Data, Index, DataIndex)
    Call AddVertex(VertexSize, DataSize, n_Data, Index, DataIndex)
    Call AddVertex(VertexSize, DataSize, n_Data, Index, DataIndex)
    Call AddVertex(VertexSize, DataSize, n_Data, Index, DataIndex)
    Call AddVertex(VertexSize, DataSize, n_Data, Index, DataIndex)
    Call AddVertex(VertexSize, DataSize, n_Data, Index, DataIndex)
End Sub

Private Sub AddVertex(ByVal VertexSize As Long, ByVal DataSize As Long, ByRef n_Data() As Single, ByRef Index As Long, ByRef DataIndex As Long)
    Dim i As Long
    For i = 0 To DataSize - 1
        BuildData(Index + i) = n_Data(DataIndex + i)
    Next i
    Index     = Index     + VertexSize
    DataIndex = DataIndex + DataSize
End Sub

Private Function TileIndices(ByRef Corners() As Long) As Long()
    Dim i As Long, j As Long
    Dim Arr() As Long
    ReDim Arr(USize(Corners))
    
    For i = 0 To USize(Corners)
        Arr(i) = TilesPerSprite
        For j = 0 To USize(Corners)
            If Corners(i) <> Corners(j) Then
                Arr(i) = CLng(Arr(i) - (2 ^ j))
            End If
        Next j
        Arr(i) = GetSubTexture(Corners(i), Arr(i))
    Next i

    Dim ReturnArr() As Long
    For i = 0 To USize(Corners)
        Call VBGLAddUnique(ReturnArr, Arr(i))
    Next i
    TileIndices = ReturnArr
End Function

Private Function GetSubTexture(ByVal Tile As Long, ByVal Typee As TileType) As Long
    GetSubTexture = (Tile * TilesPerSprite) + (Typee - 1)
End Function

Private Function GetShader() As VBGLShader
    Dim Uniforms As New VBGLShaderElementCollection
    Call Uniforms.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniformOut, "mat4", "View", "*"))
    Call Uniforms.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniformOut, "mat4", "Proj", "*"))
    Call Uniforms.Add(Nothing)
    Call Uniforms.Add(VBGLShaderVariable.Create(VBGLShaderStateUniformOut, "sampler2D", "TextureDiffuse0" , "*"))

    Dim ShaderTemplate As VBGLShaderTemplate
    Set ShaderTemplate = VBGLShaderTemplate.Create("Vertex-Fragment", "460 core")

    Call ShaderTemplate.SetUp(Layout, Uniforms)
    Dim Code As String
    Code = ShaderTemplate.GetShader()
    Code = Replace(Code, "FragColor = texture(TextureDiffuse0, outVertexTexture0);", "if (texture(TextureDiffuse0, outVertexTexture0).rgb == vec3(1.0)){" & vbCrLf & "    discard;" & vbCrLf & "}" & vbCrLf & "    FragColor = texture(TextureDiffuse0, outVertexTexture0);")
    Debug.Print Code
    Set GetShader = VBGLShader.CreateFromText(Code)
End Function

Private Function DataCount(ByVal VertexSize As Long) As Long
    DataCount = VertexCount * VertexSize
End Function

Private Function VertexCount() As Long
    VertexCount = TileCount * VerticesPerTile
End Function

Private Function TileCount() As Long
    Dim x As Long
    Dim y As Long

    Dim Result As Long
    For y = 0 To USize(Tiles, 1)
        For x = 0 To USize(Tiles, 2)
            Result = Result + (UniqueTiles(GetTile(Tiles, x, y)) + 1)
        Next x
    Next y
    TileCount = Result
End Function

Private Function VerticesPerTile() As Long
    VerticesPerTile = 6
End Function

Private Function UniqueTiles(ByRef Corners() As Long) As Integer
    Dim i As Integer, j As Integer
    Dim Result As Integer
    Dim Unique As Boolean

    For i = 0 To USize(Corners)
        Unique = True
        For j = 0 To i - 1
            If Corners(i) = Corners(j) Then
                Unique = False
                Exit For
            End If
        Next j
        If Unique Then
            Result = Result + 1
        End If
    Next i
    
    UniqueTiles = Result - 1
End Function

Private Function GetTile(ByRef Tiles() As Long, ByVal x As Long, ByVal y As Long) As Long()
    Dim Result() As Long
    ReDim Result(3)
    If (x    ) =< USize(Tiles, 2) And (y    ) =< USize(Tiles, 1) Then Result(0) = CLng(Tiles(y, x))
    If (x + 1) =< USize(Tiles, 2) And (y    ) =< USize(Tiles, 1) Then Result(1) = CLng(Tiles(y, x + 1))
    If (x    ) =< USize(Tiles, 2) And (y + 1) =< USize(Tiles, 1) Then Result(2) = CLng(Tiles(y + 1, x))
    If (x + 1) =< USize(Tiles, 2) And (y + 1) =< USize(Tiles, 1) Then Result(3) = CLng(Tiles(y + 1, x + 1))
    GetTile = Result
End Function

Private Function xVertices(ByVal Vertex As Long, ByVal Value As Long) As Long
    Select Case Vertex
        Case 0 : xVertices = Value
        Case 1 : xVertices = Value + 1
        Case 2 : xVertices = Value
        Case 3 : xVertices = Value + 1
        Case 4 : xVertices = Value + 1
        Case 5 : xVertices = Value
    End Select
End Function
Private Function yVertices(ByVal Vertex As Long, ByVal Value As Long) As Long
    Select Case Vertex
        Case 0 : yVertices = Value
        Case 1 : yVertices = Value
        Case 2 : yVertices = Value - 1
        Case 3 : yVertices = Value
        Case 4 : yVertices = Value - 1
        Case 5 : yVertices = Value - 1
    End Select
End Function

Private Function TextureFactory(ByVal Manager As VBGLTextureManager) As VBGLTexture
    Set TextureFactory = New VBGLTexture
    With TextureFactory
        .Width           = Manager.MaxWidth
        .Height          = Manager.MaxHeight
        .BPP             = 4
        .InternalFormat  = GL_RGBA
        .Format          = GL_RGBA
        .GLTextureMin    = GL_NEAREST
        .GLTextureMag    = GL_NEAREST
        .GLTextureWrapS  = GL_CLAMP_TO_EDGE
        .GLTextureWrapT  = GL_CLAMP_TO_EDGE
    End With
End Function 

Private Function TypeTypeString() As String()
    Dim Arr() As String
    ReDim Arr(TilesPerSprite - 1)
    Arr(00) = "EmptyImage"
    Arr(01) = "UpperLeft"
    Arr(02) = "UpperRight"
    Arr(03) = "UpperRow"
    Arr(04) = "LowerLeft"
    Arr(05) = "LeftColumn"
    Arr(06) = "DiagonalRight"
    Arr(07) = "TriangleUpperLeft"
    Arr(08) = "BottomRight"
    Arr(09) = "DiagonalLeft"
    Arr(10) = "RightColumn"
    Arr(11) = "TriangleUpperRight"
    Arr(12) = "BottomRow"
    Arr(13) = "TriangleBottomLeft"
    Arr(14) = "TriangleBottomRight"
    Arr(15) = "Full"
    TypeTypeString = Arr
End Function

Private Function Round(ByVal Value As Single) As Long
    Dim Whole As Long
    Whole = Int(Value)
    If Value-Whole >= 0.5 Then
        Round = Whole + 1
    Else
        Round = Whole
    End If
End Function