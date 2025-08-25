VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLTextBox"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_ExPosed = False


Option Explicit

Private p_TopLeft()     As Single
Private p_TopRight()    As Single
Private p_BottomLeft()  As Single
Private p_BottomRight() As Single
Private p_Color()       As Single
Private p_CharsPerLine  As Long
Private p_Fonts()       As VBGLFont
Private p_Mesh          As VBGLMesh

Private XOffset         As Single
Private YOffset         As Single
Private RowOffset       As Single
Private ColumnOffset    As Single

Public Property Let TopLeft(n_TopLeft           As Variant)  : Let p_TopLeft      = n_TopLeft      : End Property
Public Property Let TopRight(n_TopRight         As Variant)  : Let p_TopRight     = n_TopRight     : End Property
Public Property Let BottomLeft(n_BottomLeft     As Variant)  : Let p_BottomLeft   = n_BottomLeft   : End Property
Public Property Let BottomRight(n_BottomRight   As Variant)  : Let p_BottomRight  = n_BottomRight  : End Property
Public Property Let Color(n_Color               As Variant)  : Let p_Color        = n_Color        : End Property
Public Property Let CharsPerLine(n_CharsPerLine As Long)     : Let p_CharsPerLine = n_CharsPerLine : End Property
Public Property Let Fonts(n_Fonts               As Variant)  : Let p_Fonts        = n_Fonts        : End Property
Public Property Let Mesh(n_Mesh                 As VBGLMesh) : Set p_Mesh         = n_Mesh         : End Property
Public Property Let Font(Index As Long, n_Font  As VBGLFont) : Set p_Fonts(Index) = n_Font         : End Property

Public Property Get TopLeft()                   As Variant   : Let TopLeft        = p_TopLeft      : End Property
Public Property Get TopRight()                  As Variant   : Let TopRight       = p_TopRight     : End Property
Public Property Get BottomLeft()                As Variant   : Let BottomLeft     = p_BottomLeft   : End Property
Public Property Get BottomRight()               As Variant   : Let BottomRight    = p_BottomRight  : End Property
Public Property Get Color()                     As Variant   : Let Color          = p_Color        : End Property
Public Property Get CharsPerLine()              As Long      : Let CharsPerLine   = p_CharsPerLine : End Property
Public Property Get Fonts()                     As Variant   : Let Fonts          = p_Fonts        : End Property
Public Property Get Mesh()                      As VBGLMesh  : Set Mesh           = p_Mesh         : End Property
Public Property Get Font(Index As Long)         As VBGLFont  : Set Font           = p_Fonts(Index) : End Property

'Currently no Handling for if no fonts are passed
Public Function Create(n_TopLeft() As Single, n_TopRight() As Single, n_BottomLeft() As Single, n_BottomRight() As Single, n_Color() As Single, n_CharsPerLine As Long, Optional n_Fonts As Variant) As VBGLTextBox
    Set Create = New VBGLTextBox
    With Create
        .TopLeft      = n_TopLeft
        .TopRight     = n_TopRight
        .BottomLeft   = n_BottomLeft
        .BottomRight  = n_BottomRight
        .Color        = n_Color
        .CharsPerLine = n_CharsPerLine
        .Fonts        = n_Fonts
    End With
End Function

Public Sub CreateMesh()
    Dim LayoutTypes() As VBGLLayoutType
    ReDim LayoutTypes(2)
    LayoutTypes(0) = VBGLLayout.GetEnum("Position", PositionDimensions)
    LayoutTypes(1) = VBGLLayout.GetEnum("Texture" , TextureDimensions)
    LayoutTypes(2) = VBGLLayout.GetEnum("Color"   , ColorDimensions)
    Dim Layout As VBGLLayout
    Set Layout = VBGLLayout.Create(vbSingle, LayoutTypes)

    Dim ShaderTemplate As VBGLShaderTemplate
    Dim Uniforms As New VBGLShaderElementCollection
    Call Uniforms.Add(VBGLShaderVariable.Create("inVertexTexture0:inTextboxPosition", "vec" & USize(Color) + 1, "TextboxPosition", "*"))
    Call Uniforms.Add(VBGLShaderVariable.Create("inVertexColor0:inFontColor"  , "vec" & USize(Color) + 1, "FontColor"      , "*"))
    Call Uniforms.Add(Nothing)
    Call Uniforms.Add(VBGLShaderVariable.Create(VBGLShaderStateUniform       , "sampler2D"             , "TextboxTexture" , "*"))
    Call Uniforms.Add(VBGLShaderVariable.Create(VBGLShaderStateUniform       , "vec" & USize(Color) + 1, "BackgroundColor", "*"))
    Set ShaderTemplate = VBGLShaderTemplate.Create("Vertex-Fragment", "460 core")
    Call ShaderTemplate.SetUp(Layout, Uniforms)
    Dim Code As String: Code = ShaderTemplate.GetShader
    Debug.Print Code

    Dim Shader As VBGLShader
    Set Shader = VBGLShader.CreateFromText(Code)

    Mesh = VBGLMesh.Create(Shader, Layout, GetData(), Nothing, False)

    Dim i As Long
    Dim Textures() As VBGLTexture
    ReDim Textures(UBound(Fonts))
    For i = 0 To Ubound(Fonts)
        Set Textures(i) = Font(i).FontLayout.Texture
        Textures(i).Name = "TextboxTexture"
    Next i
    Mesh.Textures = Textures
End Sub

Public Sub UpdateData()
    Dim Data As VBGLData
    Set Data = GetData()
    Call Mesh.VAO.Buffer.Update(Data.Data, Data.Count)
End Sub

Public Sub Draw()
    Call Mesh.Shader.Bind()
    Call Mesh.Shader.SetAny("BackgroundColor", Color)
    If IsSomething(Mesh) Then Call Mesh.Draw()
End Sub

Private Function GetData() As VBGLData
    Dim Length      As Long  : Length = GetNewSize()
    Dim Arr()       As Single: ReDim Arr(Length - 1)
    Dim CurrDir()   As Single: CurrDir = p_TopLeft

    Dim Index As Long
    Dim i As Long, j As Long
    Dim Char As Long
    Dim CharCount As Long

    Dim Text As String

    For i = 0 To Ubound(p_Fonts)
        Call HandleText(Arr, Index, p_Fonts(i), CurrDir, CharCount)
    Next i

    Dim Temp As IDataSingle
    Set Temp = VBGLData.Create(vbSingle)
    Temp.Data = Arr
    Set GetData = Temp
    GetData.Count = (UBound(Arr) + 1) * 4
End Function

Private Sub HandleText(Arr() As Single, Index As Long, Font As VBGLFont, CurrDir() As Single, CharCount As Long)
    Dim i As Long
    For i = 1 To Len(Font.Text)
        Call HandleChar(Arr, Index, AscW(Mid(Font.Text, i, 1)), CurrDir, Font, CharCount)
    Next i
End Sub

Private Sub HandleChar(Arr() As Single, Index As Long, Char As Long, CurrDir() As Single, Font As VBGLFont, CharCount As Long)
    Dim CharsPerWidth As Long
    CharsPerWidth = Font.FontLayout.CharsPerWidth
    Dim RowCount As Single
    If Font.FontLayout.Format = "UTF8" Then
        RowCount = 256 / CharsPerWidth
    ElseIf Font.FontLayout.Format = "UTF16" Then
        RowCount = 65536 / CharsPerWidth
    End If
    XOffSet      = 1 / CharsPerWidth * 2
    YOffSet      = XOffSet * (Font.FontLayout.PixelsPerCharHeigth / Font.FontLayout.PixelsPerCharWidth) * 2
    ColumnOffset = 1 / CharsPerWidth
    RowOffset    = 1 / RowCount
    
    Dim i As Long
    Select Case Char
        Case AscW(vbCr)
            CurrDir(0) = p_TopLeft(0)
        Case AscW(vbLf)
            CurrDir(1) = CurrDir(1) - YOffSet
        Case 0 To 31
          'Unprintable Characters
        Case Else
            Call HandleNormalChar(Arr, Index, Char, CurrDir, Font)
    End Select
    CharCount = CharCount + 1
    If CharCount Mod CharsPerLine = 0 Then
        CurrDir(0) = p_TopLeft(0)
        CurrDir(1) = CurrDir(1) - YOffSet
    End If
End Sub

Private Sub HandleNormalChar(Arr() As Single, Index As Long, Char As Long, CurrDir() As Single, Font As VBGLFont)
    Dim i As Long
    For i = 1 To VerticesPerChar
        Call Add(Arr, Index, CurrDir)
        Call HandlePosition(CurrDir, i)

        Dim TexturePos() As Single
        ReDim TexturePos(TextureDimensions - 1)
        Call HandleTexture(TexturePos, Char, Font.FontLayout.CharsPerWidth, i)
        Call Add(Arr, Index, TexturePos)

        Dim Temp() As Single
        Temp = Font.FontColor
        Call Add(Arr, Index, Temp)
    Next i
End Sub

Private Sub HandlePosition(CurrDir() As Single, CurrentVertex As Long)
    Select Case CurrentVertex
        Case 1
            CurrDir(1) = CurrDir(1) - YOffSet
        Case 2
            CurrDir(0) = CurrDir(0) + XOffSet
            CurrDir(1) = CurrDir(1) + YOffSet
        Case 3
            CurrDir(0) = CurrDir(0) - XOffSet
            CurrDir(1) = CurrDir(1) - YOffSet
        Case 4
            CurrDir(0) = CurrDir(0) + XOffSet
        Case 5
            CurrDir(1) = CurrDir(1) + YOffSet
        Case 6
    End Select
End Sub

Private Sub HandleTexture(TexturePos() As Single, Char As Long, CharsPerWidth As Single, CurrentVertex As Long)
    TexturePos(0) = (Char Mod CharsPerWidth) * ColumnOffset
    TexturePos(1) = 1 - CLng(Char / CharsPerWidth) * RowOffset
    Select Case CurrentVertex
        Case 1
        Case 2
            TexturePos(1) = TexturePos(1) - RowOffset
        Case 3
            TexturePos(0) = TexturePos(0) + ColumnOffset
        Case 4
            TexturePos(1) = TexturePos(1) - RowOffset
        Case 5
            TexturePos(0) = TexturePos(0) + ColumnOffset
            TexturePos(1) = TexturePos(1) - RowOffset
        Case 6
            TexturePos(0) = TexturePos(0) + ColumnOffset
    End Select
End Sub


Private Function VerticesPerChar() As Long
    VerticesPerChar = 6
End Function
Private Function Dimensions() As Long
    Dimensions = PositionDimensions + TextureDimensions + ColorDimensions
End Function
Private Function PositionDimensions() As Long
    PositionDimensions = UBound(TopLeft) + 1
End Function
Private Function TextureDimensions()  As Long
    TextureDimensions  = 2
End Function
Private Function ColorDimensions() As Long
    ColorDimensions    = Ubound(p_Fonts(0).FontColor) + 1
End Function
Private Function GetNewSize() As Long
    Dim Length              As Long
    Dim i                   As Long

    For i = 0 To Ubound(p_Fonts)
        Length = Length + Len(p_Fonts(i).Text)    
    Next i
    GetNewSize = Length * VerticesPerChar * Dimensions
End Function
Private Sub Add(Arr() As Single, Index As Long, Data() As Single)
    Dim i As Long
    For i = 0 To Ubound(Data)
        Arr(Index) = Data(i)
        Index = Index + 1
    Next i
End Sub