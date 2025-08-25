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

Public Function Create(n_LayoutType As VBGLLayoutType, n_DataType As Long, n_Normalized As Byte) As VBGLElement
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
Public Function GetTypeSize() As Long
    Select Case LayoutType
        Case VBGLLayoutType.X      : GetTypeSize = 1
        Case VBGLLayoutType.XY     : GetTypeSize = 2
        Case VBGLLayoutType.XYZ    : GetTypeSize = 3
        Case VBGLLayoutType.XYZW   : GetTypeSize = 4
        Case VBGLLayoutType.R      : GetTypeSize = 1
        Case VBGLLayoutType.G      : GetTypeSize = 1
        Case VBGLLayoutType.B      : GetTypeSize = 1
        Case VBGLLayoutType.RG     : GetTypeSize = 2
        Case VBGLLayoutType.RB     : GetTypeSize = 2
        Case VBGLLayoutType.GB     : GetTypeSize = 2
        Case VBGLLayoutType.RGBB   : GetTypeSize = 3
        Case VBGLLayoutType.RGBA   : GetTypeSize = 4
        Case VBGLLayoutType.TxTy   : GetTypeSize = 2
        Case VBGLLayoutType.NxNY   : GetTypeSize = 2
        Case VBGLLayoutType.NxNyNz : GetTypeSize = 3
    End Select
End Function

' Total ByteSize of 1 Layout
Public Function GetTypeByteSize() As Long
    Select Case DataType
        Case GL_DOUBLE        : GetTypeByteSize = 8 * GetTypeSize()
        Case GL_FLOAT         : GetTypeByteSize = 4 * GetTypeSize()
        Case GL_UNSIGNED_INT  : GetTypeByteSize = 4 * GetTypeSize()
        Case GL_UNSIGNED_BYTE : GetTypeByteSize = 1 * GetTypeSize()
        Case Else             : GetTypeByteSize = 0
    End Select
End Function

Public Function GetCategory() As String
    Select Case LayoutType
        Case VBGLLayoutType.X      : GetCategory = "Position"
        Case VBGLLayoutType.XY     : GetCategory = "Position"
        Case VBGLLayoutType.XYZ    : GetCategory = "Position"
        Case VBGLLayoutType.XYZW   : GetCategory = "Position"
        Case VBGLLayoutType.R      : GetCategory = "Color"
        Case VBGLLayoutType.G      : GetCategory = "Color"
        Case VBGLLayoutType.B      : GetCategory = "Color"
        Case VBGLLayoutType.RG     : GetCategory = "Color"
        Case VBGLLayoutType.RB     : GetCategory = "Color"
        Case VBGLLayoutType.GB     : GetCategory = "Color"
        Case VBGLLayoutType.RGBB   : GetCategory = "Color"
        Case VBGLLayoutType.RGBA   : GetCategory = "Color"
        Case VBGLLayoutType.TxTy   : GetCategory = "Texture"
        Case VBGLLayoutType.NxNY   : GetCategory = "Normal"
        Case VBGLLayoutType.NxNyNz : GetCategory = "Normal"
    End Select
End Function