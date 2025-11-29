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

Private Const TilesPerSprite As Long = 15

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


Private p_Mesh                As VBGLMesh
Private p_TilesInScreenWidth  As Long
Private p_TilesInScreenHeight As Long
Private p_SpriteWidth         As Long
Private p_SpriteHeight        As Long
Private p_TileSet             As VBGLTexture

Private Layout                As VBGLLayout
Private BuildData()           As Single
Private Tiles()               As Long


Public Property Let Mesh(ByVal n_Value                          As VBGLMesh)        : Set p_Mesh                = n_Value               : End Property
Public Property Let TilesInScreenWidth(ByVal n_Value            As Long)            : Let p_TilesInScreenWidth  = n_Value               : End Property
Public Property Let TilesInScreenHeight(ByVal n_Value           As Long)            : Let p_TilesInScreenHeight = n_Value               : End Property
Public Property Let SpriteWidth(ByVal n_Value                   As Long)            : Let p_SpriteWidth         = n_Value               : End Property
Public Property Let SpriteHeight(ByVal n_Value                  As Long)            : Let p_SpriteHeight        = n_Value               : End Property
Public Property Let TileSet(ByVal n_Value                       As VBGLTexture)     : Set p_TileSet             = n_Value               : End Property

Public Property Get Mesh()                                      As VBGLMesh         : Set Mesh                  = p_Mesh                : End Property
Public Property Get TilesInScreenWidth()                        As Long             : Let TilesInScreenWidth    = p_TilesInScreenWidth  : End Property
Public Property Get TilesInScreenHeight()                       As Long             : Let TilesInScreenHeight   = p_TilesInScreenHeight : End Property
Public Property Get SpriteWidth()                               As Long             : Let SpriteWidth           = p_SpriteWidth         : End Property
Public Property Get SpriteHeight()                              As Long             : Let SpriteHeight          = p_SpriteHeight        : End Property
Public Property Get TileSet()                                   As VBGLTexture      : Set TileSet               = p_TileSet             : End Property

Private Sub VBGLDrawable_Draw()
    Call Draw()
End Sub

Public Function Create(ByVal TileSetFilePath As String, ByVal n_SpriteWidth As Long, ByVal n_SpriteHeight As Long, ByVal n_TilesInScreenWidth As Long, ByVal n_TilesInScreenHeight As Long) As VBGLDualGrid
    Dim n_TileSet As VBGLTexture
    Set n_TileSet = AddSubTextures(TileSetFilePath, n_SpriteWidth, n_SpriteHeight, Mode.InRow)
    Set Create = CreateFromTexture(n_TileSet,  n_SpriteWidth, n_SpriteHeight, n_TilesInScreenWidth, n_TilesInScreenHeight)
End Function

Public Function CreateFromTexture(ByVal n_TileSet As VBGLTexture, ByVal n_SpriteWidth As Long, ByVal n_SpriteHeight As Long, ByVal n_TilesInScreenWidth As Long, ByVal n_TilesInScreenHeight As Long) As VBGLDualGrid
    Set CreateFromTexture = New VBGLDualGrid
    With CreateFromTexture
        .SpriteWidth         = n_SpriteWidth
        .SpriteHeight        = n_SpriteHeight
        .TilesInScreenWidth  = n_TilesInScreenWidth
        .TilesInScreenHeight = n_TilesInScreenHeight
        .TileSet             = n_TileSet
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


Private Function AddSubTextures(ByVal TileSetFilePath As String, ByVal n_SpriteWidth As Long, ByVal n_SpriteHeight As Long, ByVal Modee As Mode) As VBGLTexture
    Dim TextureFactory As VBGLTexture
    Set TextureFactory = New VBGLTexture
    TextureFactory.InternalFormat  = GL_RGBA
    TextureFactory.Format          = GL_RGBA
    TextureFactory.GLTextureMin    = GL_NEAREST
    TextureFactory.GLTextureMag    = GL_NEAREST
    TextureFactory.GLTextureWrapS  = GL_CLAMP_TO_EDGE
    TextureFactory.GLTextureWrapT  = GL_CLAMP_TO_EDGE
    
    Dim Texture As VBGLTexture
    Set Texture = TextureFactory.Create(TileSetFilePath)

    Dim xOffset() As Long : xOffset = GetxOffset(n_SpriteWidth , Modee)
    Dim yOffset() As Long : yOffset = GetyOffset(n_SpriteHeight, Modee)

    Dim Count As Long
    Dim Size As Long
    Count = Texture.Height / n_SpriteHeight
    Size = (TilesPerSprite * Count) - 1


    Dim Identifier() As String
    Dim X1()         As Long
    Dim X2()         As Long
    Dim Y1()         As Long
    Dim Y2()         As Long

    ReDim Identifier(Size)
    ReDim X1(Size)
    ReDim X2(Size)
    ReDim Y1(Size)
    ReDim Y2(Size)


    Dim i As Long, j As Long
    For i = 0 To Count - 1
        For j = 0 To TilesPerSprite - 1
            Dim Index As Long
            Index = i * TilesPerSprite + j
            Identifier(Index) = Index
            X1(Index)         = xOffset(j)
            X2(Index)         = xOffset(j) + n_SpriteWidth
            Y1(Index)         = i * n_SpriteHeight + yOffset(j)
            Y2(Index)         = i * n_SpriteHeight + yOffset(j) + n_SpriteHeight
        Next j
    Next i
    

    Dim Factory As VBGLSubTexture
    Set Factory = VBGLSubTexture.CreateFactory(Texture.Width, Texture.Height, True)
    Texture.SubTextures = Factory.CreateFromArray(Identifier, X1, Y1, X2, Y2)
    Set AddSubTextures = Texture
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
        Arr(i) = 15
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

Private Function GetxOffset(ByVal SpriteWidth As Long, ByVal Modee As Mode) As Long()
    Dim ReturnArr() As Long
    ReDim ReturnArr(TilesPerSprite - 1)
    Dim i As Long
    Select Case Modee
        Case Mode.InRow
            For i = 1 To TilesPerSprite -1
                ReturnArr(i) = i * SpriteWidth
            Next i
    End Select
    GetxOffset = ReturnArr
End Function
Private Function GetyOffset(ByVal SpriteHeight As Long, ByVal Modee As Mode) As Long()
    Dim ReturnArr() As Long
    ReDim ReturnArr(TilesPerSprite - 1)
    Dim i As Long
    Select Case Modee
        Case Mode.InRow ' Nothing, as it would only return 0 for all
    End Select
    GetyOffset = ReturnArr
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