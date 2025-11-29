VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLTextBox"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit


Implements VBGLDrawable


Private p_Properties    As VBGLProperties
Private p_CharsPerLine  As Long            ' Whole Number example: 1 to 16 is one line, so character 17 will be on line 2
Private p_LinesPerPage  As Long            ' Lines that will be printed to the textbox under current line. 0 = no lines = no printing
Private p_Pages         As Long            ' Count of Pages. 0 = no pages = no printing
Private p_LineOffset    As Single          ' Offset in 0 to 1 to start the next line
Private p_Fonts()       As VBGLFont        ' Fonts that will be intepreted
Private p_Mesh          As VBGLMesh        ' Handle for Rendering
Private p_BoxMesh       As VBGLMesh        ' Handle for Rendering

Public Property Let Properties(ByVal n_Properties           As VBGLProperties)  : Set p_Properties      = n_Properties      : End Property
Public Property Let CharsPerLine(ByVal n_CharsPerLine       As Long)            : Let p_CharsPerLine    = n_CharsPerLine    : End Property
Public Property Let LinesPerPage(ByVal n_LinesPerPage       As Long)            : Let p_LinesPerPage    = n_LinesPerPage    : End Property
Public Property Let Pages(ByVal n_Pages                     As Long)            : Let p_Pages           = n_Pages           : End Property
Public Property Let LineOffset(ByVal n_LineOffset           As Single)          : Let p_LineOffset      = n_LineOffset      : End Property
Public Property Let Fonts(ByVal n_Fonts                     As Variant)         : Let p_Fonts           = n_Fonts           : End Property
Public Property Let Mesh(ByVal n_Mesh                       As VBGLMesh)        : Set p_Mesh            = n_Mesh            : End Property
Public Property Let BoxMesh(ByVal n_BoxMesh                 As VBGLMesh)        : Set p_BoxMesh         = n_BoxMesh         : End Property
Public Property Let Font(ByVal Index As Long, ByVal n_Font  As VBGLFont)        : Set p_Fonts(Index)    = n_Font            : End Property

Public Property Get Properties()                            As VBGLProperties   : Set Properties        = p_Properties      : End Property
Public Property Get CharsPerLine()                          As Long             : Let CharsPerLine      = p_CharsPerLine    : End Property
Public Property Get LinesPerPage()                          As Long             : Let LinesPerPage      = p_LinesPerPage    : End Property
Public Property Get Pages()                                 As Long             : Let Pages             = p_Pages           : End Property
Public Property Get LineOffset()                            As Single           : Let LineOffset        = p_LineOffset      : End Property
Public Property Get Fonts()                                 As Variant          : Let Fonts             = p_Fonts           : End Property
Public Property Get Mesh()                                  As VBGLMesh         : Set Mesh              = p_Mesh            : End Property
Public Property Get BoxMesh()                               As VBGLMesh         : Set BoxMesh           = p_BoxMesh         : End Property
Public Property Get Font(ByVal Index As Long)               As VBGLFont         : Set Font              = p_Fonts(Index)    : End Property


Private Sub VBGLDrawable_Draw()
    Call Draw()
End Sub


Public Function Factory() As VBGLTextBox
    Set Factory = New VBGLTextBox
    With Factory
        .Properties     = Properties
        .CharsPerLine   = CharsPerLine
        .LinesPerPage   = LinesPerPage
        .Pages          = Pages
        .LineOffset     = LineOffset
    End With
End Function

Public Function Create(ByVal n_Properties As VBGLProperties, ByRef n_Fonts() As VBGLFont) As VBGLTextBox
    Set Create = Factory()
    With Create
        .Properties = n_Properties
        .Fonts      = n_Fonts
        .Mesh       = .CreateMesh()
        .BoxMesh    = .CreateBoxMesh()
    End With
End Function

Public Function CreateFromText(ByVal n_Properties As VBGLProperties, ByVal Text As String, ByVal FontLayout As VBGLFontLayout) As VBGLTextBox
    Dim n_Font() As VBGLFont
    ReDim n_Font(0)
    Set n_Font(0) = VBGLFont.Create(Text, FontLayout)
    n_Font(0).BackgroundColor = n_Properties.GetValueFamily("Color*")
    Set CreateFromText = Create(n_Properties, n_Font)
End Function

Public Function CreateMesh() As VBGLMesh
    Set CreateMesh = VBGLMesh.Create(VBGLPrCoShaderText, VBGLPrCoLayoutText, GetData(), Nothing, False)

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
    Dim ColorDimensions    As Long: ColorDimensions    = 4

    Dim Layout As VBGLLayout
    Dim Shader As VBGLShader
    If IsSomething(BoxTexture) Then
        Set Layout = VBGLPrCoLayoutXYZRGBATxTy
        Set Shader = VBGLPrCoShaderXYZRGBATxTy
    Else
        Set Layout = VBGLPrCoLayoutXYZRGBA
        Set Shader = VBGLPrCoShaderXYZRGBA
    End If

    Set CreateBoxMesh = VBGLMesh.Create(Shader, Layout, GetBoxData(), Nothing, False)
    If IsSomething(BoxTexture) Then
        Call CreateBoxMesh.AddTexture(BoxTexture)
    End If
End Function

Public Function CreateProperties(ByVal Dimensions As Long, ByVal ColorDimensions As Long) As VBGLProperties
    Dim i As Long
    Set CreateProperties = New VBGLProperties
    With CreateProperties
        For i = 0 To Dimensions
            .AddProperty(InterpretProperty("TopLeft", i))
            .AddProperty(InterpretProperty("TopRight", i))
            .AddProperty(InterpretProperty("BottomLeft", i))
            .AddProperty(InterpretProperty("BottomRight", i))
        Next i
        For i = 0 To ColorDimensions
            .AddProperty(InterpretProperty("Color", i))
        Next i
    End With
End Function

Public Sub Draw()
    If IsSomething(Mesh) Then
        Dim Temp As Long
        Temp = CurrentContext.GetDepthFunc()
        Call CurrentContext.DepthFunc(GL_LEQUAL)
        Call BoxMesh.Draw()
        Call Mesh.Draw()
        Call CurrentContext.DepthFunc(Temp)
    End If
End Sub

Public Sub UpdateData()
    Dim Data As VBGLData
    Set Data = GetData()
    Call Mesh.VAO.Buffer.Update(Data)
End Sub


Private Function GetData() As VBGLData
    Dim Lines() As String
    Lines = GetLines()


    Dim FontSwitch() As Long
    FontSwitch = GetFontSwitchLength
    Dim FontIndex As Long

    Dim xStart As Single: xStart = Properties.Value("TopLeftX")
    Dim yStart As Single: yStart = Properties.Value("TopLeftY")

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
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("TopLeft*"))
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("Color*"))
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(0, 1))
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("TopRight*"))
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("Color*"))
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(1, 1))
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("BottomLeft*"))
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("Color*"))
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(0, 0))

    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("TopRight*"))
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("Color*"))
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(1, 1))
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("BottomRight*"))
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("Color*"))
    If IsSomething(Texture) Then Call VBGLMerge(ReturnArr, Array(1, 0))
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("BottomLeft*"))
    Call VBGLMerge(ReturnArr, Properties.GetValueFamily("Color*"))
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

Private Function InterpretProperty(ByVal Name As String, ByVal Index As Long) As String
    Dim ArrT() As Variant: ArrT = Array("X", "Y", "Z", "W")
    Dim ArrC() As Variant: ArrC = Array("R", "G", "B" ,"A")
    Select Case Name
        Case "Color" : InterpretProperty = Name & ArrC(Index)
        Case Else    : InterpretProperty = Name & ArrT(Index)
    End Select
End Function