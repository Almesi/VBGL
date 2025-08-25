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
Private p_Size              As Single
Private p_FontColor()       As Single
Private p_BackgroundColor() As Single
Private p_FontLayout        As VBGLFontLayout

Public Property Let Text(n_Text                       As String)         :  Let p_Text            = n_Text            : End Property
Public Property Let Bold(n_Bold                       As Boolean)        :  Let p_Bold            = n_Bold            : End Property
Public Property Let Italics(n_Italics                 As Boolean)        :  Let p_Italics         = n_Italics         : End Property
Public Property Let Underscore(n_Underscore           As Boolean)        :  Let p_Underscore      = n_Underscore      : End Property
Public Property Let Size(n_Size                       As Single)         :  Let p_Size            = n_Size            : End Property
Public Property Let FontColor(n_FontColor             As Variant)        :  Let p_FontColor       = n_FontColor       : End Property
Public Property Let BackgroundColor(n_BackgroundColor As Variant)        :  Let p_BackgroundColor = n_BackgroundColor : End Property
Public Property Let FontLayout(n_FontLayout           As VBGLFontLayout) :  Set p_FontLayout      = n_FontLayout      : End Property

Public Property Get Text()                            As String          :  Let Text              = p_Text            : End Property
Public Property Get Bold()                            As Boolean         :  Let Bold              = p_Bold            : End Property
Public Property Get Italics()                         As Boolean         :  Let Italics           = p_Italics         : End Property
Public Property Get Underscore()                      As Boolean         :  Let Underscore        = p_Underscore      : End Property
Public Property Get Size()                            As Single          :  Let Size              = p_Size            : End Property
Public Property Get FontColor()                       As Variant         :  Let FontColor         = p_FontColor       : End Property
Public Property Get BackgroundColor()                 As Variant         :  Let BackgroundColor   = p_BackgroundColor : End Property
Public Property Get FontLayout()                      As VBGLFontLayout  :  Set FontLayout        = p_FontLayout      : End Property

Private Sub Class_Initialize()
    ReDim p_FontColor(2)
    ReDim p_BackgroundColor(2)
End Sub