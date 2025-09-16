VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLElement"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Public Enum VBGLLayoutType
    X      = 00
    XY     = 01
    XYZ    = 02
    XYZW   = 03
    R      = 04
    G      = 05
    B      = 06
    RG     = 07
    RB     = 08
    GB     = 09
    RGBB   = 10 ' = RGB but due to the fact that there exists a function called rgb to not cause name conflicts
    RGBA   = 11
    TxTy   = 12
    NxNY   = 13
    NxNyNz = 14
End Enum

Private p_LayoutType As VBGLLayoutType ' How the data should be Interpreted
Private p_DataType   As Long           ' OpenGL DataType of LayoutType
Private p_Normalized As Byte           ' Currently just used for Legacy reasons from TheCherno´s OpenGL Tutorial series. Might have more functionality in future

Public Property Let LayoutType(n_LayoutType   As VBGLLayoutType)       : p_LayoutType = n_LayoutType : End Property
Public Property Let DataType(n_DataType       As Long)                 : p_DataType   = n_DataType   : End Property
Public Property Let Normalized(n_Normalized   As Byte)                 : p_Normalized = n_Normalized : End Property

Public Property Get LayoutType()              As VBGLLayoutType        : LayoutType   = p_LayoutType : End Property
Public Property Get DataType()                As Long                  : DataType     = p_DataType   : End Property
Public Property Get Normalized()              As Byte                  : Normalized   = p_Normalized : End Property

Public Function Create(ByVal n_LayoutType As VBGLLayoutType, ByVal n_DataType As Long, ByVal n_Normalized As Byte) As VBGLElement
    Set Create = New VBGLElement
    With Create
        .LayoutType = n_LayoutType
        .DataType = n_DataType
        .Normalized = n_Normalized
    End With
End Function

' Used for operations where it needs to find the size of the Type
' Enums cannot have this value assigned directly because when searching something it might find something different first and assume the wrong type
' Example XYZ has the same size as RGB, but since XYZ is declared first it will always use that
Public Function Size() As Long
    Select Case LayoutType
        Case VBGLLayoutType.X      : Size = 1
        Case VBGLLayoutType.XY     : Size = 2
        Case VBGLLayoutType.XYZ    : Size = 3
        Case VBGLLayoutType.XYZW   : Size = 4
        Case VBGLLayoutType.R      : Size = 1
        Case VBGLLayoutType.G      : Size = 1
        Case VBGLLayoutType.B      : Size = 1
        Case VBGLLayoutType.RG     : Size = 2
        Case VBGLLayoutType.RB     : Size = 2
        Case VBGLLayoutType.GB     : Size = 2
        Case VBGLLayoutType.RGBB   : Size = 3
        Case VBGLLayoutType.RGBA   : Size = 4
        Case VBGLLayoutType.TxTy   : Size = 2
        Case VBGLLayoutType.NxNY   : Size = 2
        Case VBGLLayoutType.NxNyNz : Size = 3
    End Select
End Function

' Total ByteSize of 1 Layout
Public Function ByteSize() As Long
    Select Case DataType
        Case GL_DOUBLE        : ByteSize = 8 * Size()
        Case GL_FLOAT         : ByteSize = 4 * Size()
        Case GL_UNSIGNED_INT  : ByteSize = 4 * Size()
        Case GL_UNSIGNED_BYTE : ByteSize = 1 * Size()
        Case Else             : ByteSize = 0
    End Select
End Function

Public Function Category() As String
    Select Case LayoutType
        Case VBGLLayoutType.X      : Category = "Position"
        Case VBGLLayoutType.XY     : Category = "Position"
        Case VBGLLayoutType.XYZ    : Category = "Position"
        Case VBGLLayoutType.XYZW   : Category = "Position"
        Case VBGLLayoutType.R      : Category = "Color"
        Case VBGLLayoutType.G      : Category = "Color"
        Case VBGLLayoutType.B      : Category = "Color"
        Case VBGLLayoutType.RG     : Category = "Color"
        Case VBGLLayoutType.RB     : Category = "Color"
        Case VBGLLayoutType.GB     : Category = "Color"
        Case VBGLLayoutType.RGBB   : Category = "Color"
        Case VBGLLayoutType.RGBA   : Category = "Color"
        Case VBGLLayoutType.TxTy   : Category = "Texture"
        Case VBGLLayoutType.NxNY   : Category = "Normal"
        Case VBGLLayoutType.NxNyNz : Category = "Normal"
    End Select
End Function