VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLFont"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_ExPosed = False


Option Explicit

' 1 Font instance with text where the settings apply to

Private p_Text              As String
Private p_Bold              As Boolean
Private p_Italics           As Boolean
Private p_Underscore        As Boolean
Private p_FontColor()       As Single
Private p_FontLayout        As VBGLFontLayout
Private p_Scalee            As Single

Public Property Let Text(ByVal n_Text                 As String)         :  Let p_Text            = n_Text            : End Property
Public Property Let Bold(ByVal n_Bold                 As Boolean)        :  Let p_Bold            = n_Bold            : End Property
Public Property Let Italics(ByVal n_Italics           As Boolean)        :  Let p_Italics         = n_Italics         : End Property
Public Property Let Underscore(ByVal n_Underscore     As Boolean)        :  Let p_Underscore      = n_Underscore      : End Property
Public Property Let FontColor(ByVal n_FontColor       As Variant)        :  Let p_FontColor       = n_FontColor       : End Property
Public Property Let FontLayout(ByVal n_FontLayout     As VBGLFontLayout) :  Set p_FontLayout      = n_FontLayout      : End Property
Public Property Let Scalee(ByVal n_Scalee             As Single)         :  Let p_Scalee          = n_Scalee          : End Property

Public Property Get Text()                            As String          :  Let Text              = p_Text            : End Property
Public Property Get Bold()                            As Boolean         :  Let Bold              = p_Bold            : End Property
Public Property Get Italics()                         As Boolean         :  Let Italics           = p_Italics         : End Property
Public Property Get Underscore()                      As Boolean         :  Let Underscore        = p_Underscore      : End Property
Public Property Get FontColor()                       As Variant         :  Let FontColor         = p_FontColor       : End Property
Public Property Get FontLayout()                      As VBGLFontLayout  :  Set FontLayout        = p_FontLayout      : End Property
Public Property Get Scalee()                          As Single          :  Let Scalee            = p_Scalee          : End Property

Public Sub AddText(ByVal NewText As String)
    Select Case True
        Case AscW(NewText) = 8
            Text = VBGLMidP(Text, 1, Len(Text) - 1)
        Case Else
            Text = Text & NewText
    End Select
End Sub

Public Function GetData(ByVal Text As String, ByVal xStart As Single, ByVal yStart As Single) As Single()
    GetData = FontLayout.GetData(Text, p_FontColor, Scalee, xStart, yStart)
End Function

Public Function DataSize() As Long
    Dim Vertices As Long : Vertices = 6
    Dim PrintableText As String
    PrintableText = Replace(Text, vbCrLf, Empty)
    DataSize = Len(PrintableText) * VertexSize * Vertices
End Function

Public Function VertexSize() As Long
    Dim Position As Long : Position = 3
    Dim Texture  As Long : Texture  = 2
    Dim Color    As Long : Color    = USize(FontColor) + 1
    VertexSize = Position + Texture + Color
End Function

Private Sub Class_Initialize()
    ReDim p_FontColor(2)
    Scalee = 1
End Sub