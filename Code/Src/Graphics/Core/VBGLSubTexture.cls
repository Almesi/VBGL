VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLSubTexture"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

'1 is top left, 2 is bottom right

Private p_Identifier As String
Private p_XN1        As Single
Private p_YN1        As Single
Private p_XN2        As Single
Private p_YN2        As Single
Private p_Width      As Long
Private p_Height     As Long
Private p_Flip       As Boolean
'Factory Properties

Public Property Let Identifier(ByVal n_Identifier   As String) : p_Identifier = n_Identifier : End Property
Public Property Let XN1(ByVal n_XN1                 As Single) : p_XN1        = n_XN1        : End Property
Public Property Let YN1(ByVal n_YN1                 As Single) : p_YN1        = n_YN1        : End Property
Public Property Let XN2(ByVal n_XN2                 As Single) : p_XN2        = n_XN2        : End Property
Public Property Let YN2(ByVal n_YN2                 As Single) : p_YN2        = n_YN2        : End Property
Public Property Let Width(ByVal n_Width             As Long)   : p_Width      = n_Width      : End Property
Public Property Let Height(ByVal n_Height           As Long)   : p_Height     = n_Height     : End Property
Public Property Let Flip(ByVal n_Flip               As Boolean): p_Flip       = n_Flip       : End Property

Public Property Get Identifier()                    As String  : Identifier   = p_Identifier : End Property
Public Property Get XN1()                           As Single  : XN1          = p_XN1        : End Property
Public Property Get YN1()                           As Single  : YN1          = p_YN1        : End Property
Public Property Get XN2()                           As Single  : XN2          = p_XN2        : End Property
Public Property Get YN2()                           As Single  : YN2          = p_YN2        : End Property
Public Property Get Width()                         As Long    : Width        = p_Width      : End Property
Public Property Get Height()                        As Long    : Height       = p_Height     : End Property
Public Property Get Flip()                          As Boolean : Flip         = p_Flip       : End Property



Public Function CreateFactory(ByVal n_Width As Long, ByVal n_Height As Long, Optional ByVal n_Flip As Boolean = True) As VBGLSubTexture
    Set CreateFactory = New VBGLSubTexture
    With CreateFactory
        .Width  = n_Width
        .Height = n_Height
        .Flip   = n_Flip
    End With
End Function

Public Function CreateFromPoint(ByVal n_Identifier As String, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As VBGLSubTexture
    Set CreateFromPoint = New VBGLSubTexture
    With CreateFromPoint
        .Identifier = n_Identifier
        .Width = Width
        .height = Height
        .Flip = Flip
        Call .SetUp(X1, Y1, X2, Y2)
    End With
End Function

Public Function CreateFromLength(ByVal n_Identifier As String, ByVal X1 As Long, ByVal Y1 As Long, ByVal OffsetX As Long, ByVal OffsetY As Long) As VBGLSubTexture
    Dim X2 As Long: X2 = X1 + OffsetX
    Dim Y2 As Long: Y2 = Y1 + OffsetY
    Set CreateFromLength = CreateFromPoint(n_Identifier, X1, Y1, X2, Y2)
End Function

'X2 and Y2 have the same usize as identifier
Public Function CreateFromArray(ByRef n_Identifier() As String, ByRef X1() As Long, ByRef Y1() As Long, ByRef X2() As Long, ByRef Y2() As Long) As VBGLSubTexture()
    Dim Size As Long: Size = USize(n_Identifier)
    Dim i As Long
    Dim ReturnArr() As VBGLSubTexture
    ReDim ReturnArr(Size)
    For i = 0 To Size
        Set ReturnArr(i) = CreateFromPoint(n_Identifier(i), X1(i), Y1(i), X2(i), Y2(i))
    Next i
    CreateFromArray = ReturnArr
End Function

Public Function CreateFromPattern(ByVal n_Identifier As String, ByVal PatternX As Long, ByVal PatternY As Long) As VBGLSubTexture()
    Dim XCount As Long: XCount = PatternX - Width
    Dim YCount As Long: YCount = PatternY - Height
    Dim i As Long, j As Long
    Dim ReturnArr() As VBGLSubTexture
    ReDim ReturnArr(XCount * YCount - 1)
    For i = 0 To YCount - 1
        For j = 0 To XCount - 1
            Dim CurrentIndex As Long
            CurrentIndex = i * XCount + j
            Set ReturnArr(CurrentIndex) = CreateFromPoint(n_Identifier, PatternX * i, PatternY * j, PatternX * (i + 1), PatternY * (j + 1))
        Next j
    Next i
    CreateFromArray = ReturnArr
End Function

Public Sub SetUp(ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long)
    XN1 = (X1 / Width)
    XN2 = (X2 / Width)
    If Flip Then
        YN1 = 1 - (Y1 / Height)
        YN2 = 1 - (Y2 / Height)
    Else
        YN1 = Y1 / Height
        YN2 = Y2 / Height
    End If
End Sub

Public Function GetX(ByVal Position As String) As Single
    Select Case UCase(Position)
        Case "TOPLEFT"     : GetX = XN1
        Case "TOPRIGHT"    : GetX = XN2
        Case "BOTTOMLEFT"  : GetX = XN1
        Case "BOTTOMRIGHT" : GetX = XN2
    End Select
End Function
Public Function GetY(ByVal Position As String) As Single
    Select Case UCase(Position)
        Case "TOPLEFT"     : GetY = YN1
        Case "TOPRIGHT"    : GetY = YN1
        Case "BOTTOMLEFT"  : GetY = YN2
        Case "BOTTOMRIGHT" : GetY = YN2
    End Select
End Function

Public Function GetRectangle() As Single()
    Dim Arr() As Single
    ReDim Arr(11)
    Arr(00) = GetX("TopLeft")
    Arr(01) = GetY("TopLeft")
    Arr(02) = GetX("TopRight")
    Arr(03) = GetY("TopRight")
    Arr(04) = GetX("BottomLeft")
    Arr(05) = GetY("BottomLeft")
    Arr(06) = GetX("TopRight")
    Arr(07) = GetY("TopRight")
    Arr(08) = GetX("BottomRight")
    Arr(09) = GetY("BottomRight")
    Arr(10) = GetX("BottomLeft")
    Arr(11) = GetY("BottomLeft")
    GetRectangle = Arr
End Function