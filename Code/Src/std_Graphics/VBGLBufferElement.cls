VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLBufferElement"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Public Enum VBGLBufferLayoutType
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
    RGBB   = 10 ' = RGB but due to the fact that there exists a function called rgb to not cause confusion
    RGBA   = 11
    TxTy   = 12
    NxNY   = 13
    NxNyNz = 14
End Enum

Private p_LayoutType As VBGLBufferLayoutType
Private p_DataType As Long
Private p_Normalized As Byte

Public Property Let LayoutType(n_LayoutType   As VBGLBufferLayoutType) : p_LayoutType = n_LayoutType : End Property
Public Property Let DataType(n_DataType       As Long)                 : p_DataType   = n_DataType   : End Property
Public Property Let Normalized(n_Normalized   As Byte)                 : p_Normalized = n_Normalized : End Property

Public Property Get LayoutType()              As VBGLBufferLayoutType  : LayoutType   = p_LayoutType : End Property
Public Property Get DataType()                As Long                  : DataType     = p_DataType   : End Property
Public Property Get Normalized()              As Byte                  : Normalized   = p_Normalized : End Property

Public Function Create(n_LayoutType As VBGLBufferLayoutType, n_DataType As Long, n_Normalized As Byte) As VBGLBufferElement
    Set Create = New VBGLBufferElement
    With Create
        .LayoutType = n_LayoutType
        .DataType = n_DataType
        .Normalized = n_Normalized
    End With
End Function

Public Function GetTypeSize() As Long
    Select Case LayoutType
        Case VBGLBufferLayoutType.X      : GetTypeSize = 1
        Case VBGLBufferLayoutType.XY     : GetTypeSize = 2
        Case VBGLBufferLayoutType.XYZ    : GetTypeSize = 3
        Case VBGLBufferLayoutType.XYZW   : GetTypeSize = 4
        Case VBGLBufferLayoutType.R      : GetTypeSize = 1
        Case VBGLBufferLayoutType.G      : GetTypeSize = 1
        Case VBGLBufferLayoutType.B      : GetTypeSize = 1
        Case VBGLBufferLayoutType.RG     : GetTypeSize = 2
        Case VBGLBufferLayoutType.RB     : GetTypeSize = 2
        Case VBGLBufferLayoutType.GB     : GetTypeSize = 2
        Case VBGLBufferLayoutType.RGBB   : GetTypeSize = 3
        Case VBGLBufferLayoutType.RGBA   : GetTypeSize = 4
        Case VBGLBufferLayoutType.TxTy   : GetTypeSize = 2
        Case VBGLBufferLayoutType.NxNY   : GetTypeSize = 2
        Case VBGLBufferLayoutType.NxNyNz : GetTypeSize = 3
    End Select
End Function

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
        Case VBGLBufferLayoutType.X      : GetCategory = "Position"
        Case VBGLBufferLayoutType.XY     : GetCategory = "Position"
        Case VBGLBufferLayoutType.XYZ    : GetCategory = "Position"
        Case VBGLBufferLayoutType.XYZW   : GetCategory = "Position"
        Case VBGLBufferLayoutType.R      : GetCategory = "Color"
        Case VBGLBufferLayoutType.G      : GetCategory = "Color"
        Case VBGLBufferLayoutType.B      : GetCategory = "Color"
        Case VBGLBufferLayoutType.RG     : GetCategory = "Color"
        Case VBGLBufferLayoutType.RB     : GetCategory = "Color"
        Case VBGLBufferLayoutType.GB     : GetCategory = "Color"
        Case VBGLBufferLayoutType.RGBB   : GetCategory = "Color"
        Case VBGLBufferLayoutType.RGBA   : GetCategory = "Color"
        Case VBGLBufferLayoutType.TxTy   : GetCategory = "Texture"
        Case VBGLBufferLayoutType.NxNY   : GetCategory = "Normal"
        Case VBGLBufferLayoutType.NxNyNz : GetCategory = "Normal"
    End Select
End Function