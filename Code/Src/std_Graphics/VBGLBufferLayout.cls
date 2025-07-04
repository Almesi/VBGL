VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLBufferLayout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Size As Long
Private p_ByteSize As Long
Private p_Elements() As VBGLBufferElement

Public Property Let Size(n_Size As Long)
    p_Size = n_Size
End Property
Public Property Get Size() As Long
    Size = p_Size
End Property

Public Property Let ByteSize(n_ByteSize As Long)
    p_ByteSize = n_ByteSize
End Property
Public Property Get ByteSize() As Long
    ByteSize = p_ByteSize
End Property

Public Property Let Elements(n_Elements() As VBGLBufferElement)
    Elements = p_Elements
End Property
Public Property Get Elements() As VBGLBufferElement()
    Elements = p_Elements
End Property

Public Property Let Element(Index As Long, n_Element As VBGLBufferElement)
    Set p_Elements(Index) = n_Element
End Property
Public Property Get Element(Index As Long) As VBGLBufferElement
    Set Element = p_Elements(Index)
End Property

Public Function Create(DataType As vbVarType, Types() As VBGLBufferLayoutType) As VBGLBufferLayout
    Dim i As Long
    Set Create = New VBGLBufferLayout
    With Create
        For i = 0 To Ubound(Types)
            Select Case DataType
                Case vbSingle  : Call .AddFloat(Types(i))
                Case vbDouble  : Call .AddDouble(Types(i))
                Case vbByte    : Call .AddUnsignedByte(Types(i))
                Case vbInteger : Call .AddUnsignedInt(Types(i))
            End Select
        Next i
    End With
End Function

Public Sub AddDouble(LayoutType       As VBGLBufferLayoutType) : Call Push(GL_DOUBLE       , LayoutType, GL_FALSE) : End Sub
Public Sub AddFloat(LayoutType        As VBGLBufferLayoutType) : Call Push(GL_FLOAT        , LayoutType, GL_FALSE) : End Sub
Public Sub AddUnsignedInt(LayoutType  As VBGLBufferLayoutType) : Call Push(GL_UNSIGNED_INT , LayoutType, GL_FALSE) : End Sub
Public Sub AddUnsignedByte(LayoutType As VBGLBufferLayoutType) : Call Push(GL_UNSIGNED_BYTE, LayoutType, GL_TRUE)  : End Sub

Public Sub Push(Typee As Long, LayoutType As VBGLBufferLayoutType, Normalized As Byte)
    Size = Size + 1
    ReDim Preserve p_Elements(Size)
    Element(Size) = VBGLBufferElement.Create(LayoutType, Typee, Normalized)
    ByteSize = ByteSize + Element(Size).GetTypeByteSize
End Sub

Public Function GetEnum(What As String, Size As Long)
    Select Case What
        Case "Position"
            Select Case Size
                Case 1 : GetEnum = VBGLBufferLayoutType.X
                Case 2 : GetEnum = VBGLBufferLayoutType.XY
                Case 3 : GetEnum = VBGLBufferLayoutType.XYZ
                Case 4 : GetEnum = VBGLBufferLayoutType.XYZW
            End Select
        Case "Color"
            Select Case Size
                Case 1 : GetEnum = VBGLBufferLayoutType.R
                Case 1 : GetEnum = VBGLBufferLayoutType.G
                Case 1 : GetEnum = VBGLBufferLayoutType.B
                Case 2 : GetEnum = VBGLBufferLayoutType.RG
                Case 2 : GetEnum = VBGLBufferLayoutType.RB
                Case 2 : GetEnum = VBGLBufferLayoutType.GB
                Case 3 : GetEnum = VBGLBufferLayoutType.RGBB
                Case 4 : GetEnum = VBGLBufferLayoutType.RGBA
            End Select
        Case "Texture"
            Select Case Size
                Case 2 : GetEnum = VBGLBufferLayoutType.TxTy
            End Select
        Case "Normal"
            Select Case Size
                Case 2 : GetEnum = VBGLBufferLayoutType.NxNY
                Case 3 : GetEnum = VBGLBufferLayoutType.NxNyNz
            End Select
    End Select
End Function

Private Sub Class_Initialize()
    Size = -1
End Sub