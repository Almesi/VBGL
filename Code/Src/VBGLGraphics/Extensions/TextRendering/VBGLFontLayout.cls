VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLFontLayout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_ExPosed = False


Option Explicit

'Texture Object and Properties to designate Characters

Private p_Name                As String
Private p_Texture             As VBGLTexture
Private p_PixelsPerCharWidth  As Long
Private p_PixelsPerCharHeigth As Long
Private p_CharsPerWidth       As Long
Private p_Format              As String

Public Property Let Name(n_Name                                 As String)       : Let p_Name               = n_Name                : End Property
Public Property Let Texture(n_Texture                           As VBGLTexture)  : Set p_Texture            = n_Texture             : End Property
Public Property Let PixelsPerCharWidth(n_PixelsPerCharWidth     As Long)         : Let p_PixelsPerCharWidth = n_PixelsPerCharWidth  : End Property
Public Property Let PixelsPerCharHeigth(n_PixelsPerCharHeigth   As Long)         : Let p_PixelsPerCharHeigth= n_PixelsPerCharHeigth : End Property
Public Property Let CharsPerWidth(n_CharsPerWidth               As Long)         : Let p_CharsPerWidth      = n_CharsPerWidth       : End Property
Public Property Let Format(n_Format                             As String)       : Let p_Format             = n_Format              : End Property

Public Property Get Name()                                      As String        : Let Name                 = p_Name                : End Property
Public Property Get Texture()                                   As VBGLTexture   : Set Texture              = p_Texture             : End Property
Public Property Get PixelsPerCharWidth()                        As Long          : Let PixelsPerCharWidth   = p_PixelsPerCharWidth  : End Property
Public Property Get PixelsPerCharHeigth()                       As Long          : Let PixelsPerCharHeigth  = p_PixelsPerCharHeigth : End Property
Public Property Get CharsPerWidth()                             As Long          : Let CharsPerWidth        = p_CharsPerWidth       : End Property
Public Property Get Format()                                    As String        : Let Format               = p_Format              : End Property

Public Function Create(FilePath As String, n_PixelsPerCharWidth As Long, n_PixelsPerCharHeigth As Long, n_CharsPerWidth As Long, n_Format As String, Optional n_Name As String = Empty) As VBGLFontLayout
    Set Create = New VBGLFontLayout
    With Create
        .Texture             = VBGLTexture.Create(FilePath, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, "Diffuse")
        .PixelsPerCharWidth  = n_PixelsPerCharWidth
        .PixelsPerCharHeigth = n_PixelsPerCharHeigth
        .CharsPerWidth       = n_CharsPerWidth
        .Format              = n_Format
        If n_Name = Empty Then
            Dim StartPoint As Long: StartPoint = InStrRev(FilePath, "\")
            Dim EndPoint   As Long: EndPoint   = InStrRev(FilePath, ".")
            .Name = VBGLMidP(FilePath, StartPoint + 1, EndPoint - 1)
        Else
            .Name = n_Name
        End If
    End With
End Function