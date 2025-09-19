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

Private p_TopLeft()     As Single    ' vec3
Private p_TopRight()    As Single    ' vec3
Private p_BottomLeft()  As Single    ' vec3
Private p_BottomRight() As Single    ' vec3
Private p_Color()       As Single    ' vec1 to vec4
Private p_CharsPerLine  As Long      ' Whole Number example: 1 to 16 is one line, so character 17 will be on line 2
Private p_LinesPerPage  As Long      ' Lines that will be printed to the textbox under current line. 0 = no lines = no printing
Private p_Pages         As Long      ' Count of Pages. 0 = no pages = no printing
Private p_LineOffset    As Single    ' Offset in 0 to 1 to start the next line
Private p_Fonts()       As VBGLFont  ' Fonts that will be intepreted
Private p_Mesh          As VBGLMesh  ' Handle for Rendering
Private p_BoxMesh       As VBGLMesh  ' Handle for Rendering

Public Property Let TopLeft(ByVal n_TopLeft                 As Variant)  : Let p_TopLeft      = n_TopLeft      : End Property
Public Property Let TopRight(ByVal n_TopRight               As Variant)  : Let p_TopRight     = n_TopRight     : End Property
Public Property Let BottomLeft(ByVal n_BottomLeft           As Variant)  : Let p_BottomLeft   = n_BottomLeft   : End Property
Public Property Let BottomRight(ByVal n_BottomRight         As Variant)  : Let p_BottomRight  = n_BottomRight  : End Property
Public Property Let Color(ByVal n_Color                     As Variant)  : Let p_Color        = n_Color        : End Property
Public Property Let CharsPerLine(ByVal n_CharsPerLine       As Long)     : Let p_CharsPerLine = n_CharsPerLine : End Property
Public Property Let LinesPerPage(ByVal n_LinesPerPage       As Long)     : Let p_LinesPerPage = n_LinesPerPage : End Property
Public Property Let Pages(ByVal n_Pages                     As Long)     : Let p_Pages        = n_Pages        : End Property
Public Property Let LineOffset(ByVal n_LineOffset           As Single)   : Let p_LineOffset   = n_LineOffset   : End Property
Public Property Let Fonts(ByVal n_Fonts                     As Variant)  : Let p_Fonts        = n_Fonts        : End Property
Public Property Let Mesh(ByVal n_Mesh                       As VBGLMesh) : Set p_Mesh         = n_Mesh         : End Property
Public Property Let BoxMesh(ByVal n_BoxMesh                 As VBGLMesh) : Set p_BoxMesh      = n_BoxMesh      : End Property
Public Property Let Font(ByVal Index As Long, ByVal n_Font  As VBGLFont) : Set p_Fonts(Index) = n_Font         : End Property

Public Property Get TopLeft()                               As Variant   : Let TopLeft        = p_TopLeft      : End Property
Public Property Get TopRight()                              As Variant   : Let TopRight       = p_TopRight     : End Property
Public Property Get BottomLeft()                            As Variant   : Let BottomLeft     = p_BottomLeft   : End Property
Public Property Get BottomRight()                           As Variant   : Let BottomRight    = p_BottomRight  : End Property
Public Property Get Color()                                 As Variant   : Let Color          = p_Color        : End Property
Public Property Get CharsPerLine()                          As Long      : Let CharsPerLine   = p_CharsPerLine : End Property
Public Property Get LinesPerPage()                          As Long      : Let LinesPerPage   = p_LinesPerPage : End Property
Public Property Get Pages()                                 As Long      : Let Pages          = p_Pages        : End Property
Public Property Get LineOffset()                            As Single    : Let LineOffset     = p_LineOffset   : End Property
Public Property Get Fonts()                                 As Variant   : Let Fonts          = p_Fonts        : End Property
Public Property Get Mesh()                                  As VBGLMesh  : Set Mesh           = p_Mesh         : End Property
Public Property Get BoxMesh()                               As VBGLMesh  : Set BoxMesh        = p_BoxMesh      : End Property
Public Property Get Font(ByVal Index As Long)               As VBGLFont  : Set Font           = p_Fonts(Index) : End Property


Public Function Factory() As VBGLTextBox
    Set Factory = New VBGLTextBox
    With Factory
        .TopLeft        = TopLeft
        .TopRight       = TopRight
        .BottomLeft     = BottomLeft
        .BottomRight    = BottomRight
        .Color          = Color
        .CharsPerLine   = CharsPerLine
        .LinesPerPage   = LinesPerPage
        .Pages          = Pages
        .LineOffset     = LineOffset
    End With
End Function

Public Function Create(ByRef n_Fonts() As VBGLFont) As VBGLTextBox
    Set Create = Factory()
    With Create
        .Fonts   = n_Fonts
        .Mesh    = .CreateMesh()
        .BoxMesh = .CreateBoxMesh()
    End With
End Function

Public Function CreateFromText(ByVal Text As String, ByVal FontLayout As VBGLFontLayout) As VBGLTextBox
    Dim n_Font() As VBGLFont
    ReDim n_Font(0)
    Set n_Font(0) = VBGLFont.Create(Text, FontLayout)
    n_Font(0).BackgroundColor = Color
    Set CreateFromText = Create(n_Font)
End Function

Public Function CreateMesh() As VBGLMesh
    Dim PositionDimensions  As Long: PositionDimensions     = 3
    Dim TextureDimensions   As Long: TextureDimensions      = 2
    Dim FontColorDimensions As Long: FontColorDimensions    = USize(Font(0).FontColor) + 1
    Dim BackColorDimensions As Long: BackColorDimensions    = USize(Font(0).BackgroundColor) + 1

    Dim LayoutTypes() As VBGLLayoutType
    ReDim LayoutTypes(3)
    LayoutTypes(0) = VBGLLayout.GetEnum("Position", PositionDimensions)
    LayoutTypes(1) = VBGLLayout.GetEnum("Color"   , FontColorDimensions)
    LayoutTypes(2) = VBGLLayout.GetEnum("Color"   , BackColorDimensions)
    LayoutTypes(3) = VBGLLayout.GetEnum("Texture" , TextureDimensions)
    Dim Layout As VBGLLayout
    Set Layout = VBGLLayout.Create(vbSingle, LayoutTypes)

    Dim ShaderTemplate As VBGLShaderTemplate
    Dim Uniforms As New VBGLShaderElementCollection
    Call Uniforms.Add(VBGLShaderVariable.Create("inVertexTexture0:inTextboxPosition", "vec" & USize(Color) + 1, "TextboxPosition", "*"))
    Call Uniforms.Add(VBGLShaderVariable.Create("inVertexColor0:inFontColor"        , "vec" & USize(Color) + 1, "FontColor"      , "*"))
    Call Uniforms.Add(VBGLShaderVariable.Create("inVertexColor1:inBackgroundColor"  , "vec" & USize(Color) + 1, "BackgroundColor", "*"))
    Call Uniforms.Add(Nothing)
    Call Uniforms.Add(VBGLShaderVariable.Create(VBGLShaderStateUniformOut       , "sampler2D"             , "TextboxTexture" , "*"))
    Set ShaderTemplate = VBGLShaderTemplate.Create("Vertex-Fragment", "460 core")
    Call ShaderTemplate.SetUp(Layout, Uniforms)
    Dim Code As String: Code = ShaderTemplate.GetShader
    Debug.Print Code

    Dim Shader As VBGLShader
    Set Shader = VBGLShader.CreateFromText(Code)

    Set CreateMesh = VBGLMesh.Create(Shader, Layout, GetData(), Nothing, False)

    Dim i As Long
    Dim Texture As VBGLTexture
    ' Currently only 1 texture, as i will not work with more
    For i = 0 To 0
        Set Texture = Font(i).FontLayout.Texture
        Texture.Name = "TextboxTexture"
        Call CreateMesh.AddTexture(Texture)
    Next i
End Function

Public Function CreateBoxMesh(ByVal Optional BoxTexture As VBGLTexture = Nothing) As VBGLMesh
    Dim PositionDimensions As Long: PositionDimensions = 3
    Dim TextureDimensions  As Long: TextureDimensions  = 2
    Dim ColorDimensions    As Long: ColorDimensions    = USize(Color) + 1

    Dim LayoutTypes() As VBGLLayoutType
    If IsSomething(BoxTexture) Then
        ReDim LayoutTypes(2)
        LayoutTypes(0) = VBGLLayout.GetEnum("Position", PositionDimensions)
        LayoutTypes(1) = VBGLLayout.GetEnum("Color"   , ColorDimensions)
        LayoutTypes(2) = VBGLLayout.GetEnum("Texture" , TextureDimensions)
    Else
        ReDim LayoutTypes(1)
        LayoutTypes(0) = VBGLLayout.GetEnum("Position", PositionDimensions)
        LayoutTypes(1) = VBGLLayout.GetEnum("Color"   , ColorDimensions)
    End If
    Dim Layout As VBGLLayout
    Set Layout = VBGLLayout.Create(vbSingle, LayoutTypes)

    Dim ShaderTemplate As VBGLShaderTemplate
    Dim Uniforms As New VBGLShaderElementCollection
    Call Uniforms.Add(Nothing)
    Call Uniforms.Add(VBGLShaderVariable.Create(VBGLShaderStateUniformOut, "sampler2D", "TextboxTexture" , "*"))
    Set ShaderTemplate = VBGLShaderTemplate.Create("Vertex-Fragment", "460 core")
    Call ShaderTemplate.SetUp(Layout, Uniforms)
    Dim Code As String: Code = ShaderTemplate.GetShader
    Debug.Print Code

    Dim Shader As VBGLShader
    Set Shader = VBGLShader.CreateFromText(Code)

    Set CreateBoxMesh = VBGLMesh.Create(Shader, Layout, GetBoxData(), Nothing, False)

    If IsSomething(BoxTexture) Then
        Call CreateBoxMesh.AddTexture(BoxTexture)
    End If
End Function

Public Sub Draw()
    If IsSomething(Mesh) Then   
        Call Mesh.Draw()
        Call BoxMesh.Draw()
    End If
End Sub

Public Sub UpdateData()
    Dim Data As VBGLData
    Set Data = GetData()
    Call Mesh.VAO.Buffer.Update(Data, Data.Count)
End Sub


Private Function GetData() As VBGLData
    Dim Lines() As String
    Lines = GetLines()


    Dim FontSwitch() As Long
    FontSwitch = GetFontSwitchLength
    Dim FontIndex As Long
    Dim xStart As Single: xStart = p_TopLeft(0)
    Dim yStart As Single: yStart = p_TopLeft(1)

    Dim i As Long
    Dim CharCount As Long
    Dim Arr() As Single
    Dim Size As Long
    Dim ReturnArr() As Single
    Redim ReturnArr(GetSize() - 1)

    Dim Offset As Long
    For i = 0 To USize(Lines)
        If Lines(i) <> Empty Then
            Arr = ProcessLine(Lines(i), CharCount, FontSwitch, FontIndex, xStart, yStart)
            Size = USize(Arr) + 1
            Call CopyMemory(ReturnArr(Offset), VarPtr(Arr(0)), Size * Len(Arr(0)))
            Offset = Offset + Size
            If FontIndex =< USize(Fonts) Then
                yStart = yStart - HandleLine(Font(FontIndex))
            End If
        End If
    Next i

    Dim Temp() As Byte
    Dim NewSize As Long
    NewSize = (USize(ReturnArr) + 1) * LenB(ReturnArr(0))
    ReDim Temp(NewSize - 1)
    Call CopyMemory(Temp(0), VarPtr(ReturnArr(0)), NewSize)
    Set GetData = VBGLData.CreateByte(Temp)
End Function

Private Function GetBoxData(Optional ByVal Texture As VBGLTexture) As VBGLData
    Dim ReturnArr() As Single
    Call VBGLMerge(ReturnArr, TopLeft)
    Call VBGLMerge(ReturnArr, Color)
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(0, 1))
    Call VBGLMerge(ReturnArr, TopRight)
    Call VBGLMerge(ReturnArr, Color)
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(1, 1))
    Call VBGLMerge(ReturnArr, BottomLeft)
    Call VBGLMerge(ReturnArr, Color)
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(0, 0))

    Call VBGLMerge(ReturnArr, TopRight)
    Call VBGLMerge(ReturnArr, Color)
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(1, 1))
    Call VBGLMerge(ReturnArr, BottomRight)
    Call VBGLMerge(ReturnArr, Color)
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(1, 0))
    Call VBGLMerge(ReturnArr, BottomLeft)
    Call VBGLMerge(ReturnArr, Color)
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(0, 0))

    Dim Temp() As Byte
    Dim NewSize As Long
    NewSize = (USize(ReturnArr) + 1) * LenB(ReturnArr(0))
    ReDim Temp(NewSize - 1)
    Call CopyMemory(Temp(0), VarPtr(ReturnArr(0)), NewSize)
    Set GetBoxData = VBGLData.CreateByte(Temp)
End Function

Private Function ProcessLine(ByVal Line As String, ByRef CharCount As Long, ByRef FontSwitch() As Long, ByRef FontIndex As Long, ByVal xStart As Single, ByRef yStart As Single) As Single()
    Dim ReturnArr() As Single
    Dim Rest() As Single

    Dim FontText As String
    FontText = Font(FontIndex).Text

    Dim Condition As Long
    Condition = (CharCount + Len(Line)) - FontSwitch(FontIndex)

    Dim Text As String
    If Condition = 0 Then
        Text = Line
        ReturnArr = Font(FontIndex).GetData(Text, xStart, yStart)
        FontIndex = FontIndex + 1
    ElseIf Condition > 0 Then
        Text = VBGLMidP(Line, 1, Len(Line) - Condition)
        ReturnArr = Font(FontIndex).GetData(Text, xStart, yStart)
        FontIndex = FontIndex + 1
        Text = VBGLMidP(Line, Len(Line) - Condition, Condition)
        Rest = Font(FontIndex).GetData(Text, xStart, yStart)
        Call VBGLMerge(ReturnArr, Rest)
    ElseIf Condition < 0 Then
        Text = Line
        ReturnArr = Font(FontIndex).GetData(Text, xStart, yStart)
    End If
    CharCount = CharCount + Len(Line)
    ProcessLine = ReturnArr
End Function

'Returns an array of indices, that represent an index between fonts
Private Function GetFontSwitchLength() As Long()
    Dim i As Long
    Dim ReturnArr() As Long
    Dim TextNoLineFeed As String
    ReDim ReturnArr(USize(Fonts))
    For i = 0 To USize(Fonts)
        TextNoLineFeed = Replace(Font(i).Text, vbCrLf, Empty)
        If i = 0 Then
            ReturnArr(i) = Len(TextNoLineFeed)
        Else
            ReturnArr(i) = Len(TextNoLineFeed) + ReturnArr(i - 1)
        End If
    Next i
    GetFontSwitchLength = ReturnArr
End Function

Private Function HandleLine(ByVal CurrentFont As VBGLFont) As Single
    If LineOffset <> 0 Then
        HandleLine = LineOffset
    Else
        Dim CharOffset As Single
        CharOffset = (CurrentFont.FontLayout.MaxHeight * CurrentContext.CurrentWindow.NormalHeight)
        HandleLine = CharOffset
    End If
End Function

Private Function GetLines() As String()
    Dim i As Long
    Dim Text As String
    For i = 0 To USize(Fonts)
        Text = Text & Font(i).Text
    Next i

    Dim LinesByLinefeed() As String
    LinesByLinefeed = Split(Text, vbCrLf)
    If LinesByLinefeed(Usize(LinesByLinefeed)) = Empty Then
        Call VBGLArrayPop(LinesByLinefeed)
    End If

    Dim ReturnArr() As String
    For i = 0 To Usize(LinesByLinefeed)
        Call VBGLMerge(ReturnArr, SplitByLength(LinesByLinefeed(i), CharsPerLine))
    Next i
    GetLines = ReturnArr
End Function

Private Function GetSize() As Long
    Dim ReturnValue As Long
    Dim i As Long
    For i = 0 To USize(Fonts)
        ReturnValue = ReturnValue + Font(i).DataSize
    Next i
    GetSize = ReturnValue
End Function