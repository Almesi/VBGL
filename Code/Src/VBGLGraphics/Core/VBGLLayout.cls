VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLLayout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

' Important Classes for many other Classes
' Describes an entire DataLayout of passed Data

Private p_Size       As Long
Private p_ByteSize   As Long
Private p_Elements() As VBGLElement

Public Property Let Size(n_Size                      As Long)        : Let p_Size            = n_Size            : End Property
Public Property Let ByteSize(n_ByteSize              As Long)        : Let p_ByteSize        = n_ByteSize        : End Property
Public Property Let Elements(n_Elements()            As VBGLElement) : Let Elements          = p_Elements        : End Property
Public Property Let Element(Index As Long, n_Element As VBGLElement) : Set p_Elements(Index) = n_Element         : End Property

Public Property Get Size()                           As Long         : Let Size              = p_Size            : End Property
Public Property Get ByteSize()                       As Long         : Let ByteSize          = p_ByteSize        : End Property
Public Property Get Elements()                       As VBGLElement(): Let Elements          = p_Elements        : End Property
Public Property Get Element(Index As Long)           As VBGLElement  : Set Element           = p_Elements(Index) : End Property

Public Function Create(DataType As vbVarType, Types() As VBGLLayoutType) As VBGLLayout
    Dim i As Long
    Set Create = New VBGLLayout
    With Create
        For i = 0 To Ubound(Types)
            Call .AddType(DataType, Types(i))
        Next i
    End With
End Function

' Ubound(DataType) has to equal Ubound(Types)
Public Function CreateCombined(DataTypes() As vbVarType, Types() As VBGLLayoutType) As VBGLLayout
    Dim i As Long
    Set Create = New VBGLLayout
    With Create
        For i = 0 To Ubound(Types)
            Call .AddType(DataTypes(i), Types(i))
        Next i
    End With
End Function

Public Sub AddType(DataType As vbVarType, Typee As VBGLLayoutType)
    Select Case DataType
        Case vbSingle  : Call AddFloat(Typee)
        Case vbDouble  : Call AddDouble(Typee)
        Case vbByte    : Call AddUnsignedByte(Typee)
        Case vbInteger : Call AddUnsignedInt(Typee)
    End Select
End Sub

Public Sub AddDouble(LayoutType       As VBGLLayoutType) : Call Push(GL_DOUBLE       , LayoutType, GL_FALSE) : End Sub
Public Sub AddFloat(LayoutType        As VBGLLayoutType) : Call Push(GL_FLOAT        , LayoutType, GL_FALSE) : End Sub
Public Sub AddUnsignedInt(LayoutType  As VBGLLayoutType) : Call Push(GL_UNSIGNED_INT , LayoutType, GL_FALSE) : End Sub
Public Sub AddUnsignedByte(LayoutType As VBGLLayoutType) : Call Push(GL_UNSIGNED_BYTE, LayoutType, GL_TRUE)  : End Sub

Public Sub Push(Typee As Long, LayoutType As VBGLLayoutType, Normalized As Byte)
    Size = Size + 1
    ReDim Preserve p_Elements(Size)
    Element(Size) = VBGLElement.Create(LayoutType, Typee, Normalized)
    ByteSize = ByteSize + Element(Size).GetTypeByteSize
End Sub

Public Function GetEnum(What As String, Size As Long)
    Select Case What
        Case "Position"
            Select Case Size
                Case 1 : GetEnum = VBGLLayoutType.X
                Case 2 : GetEnum = VBGLLayoutType.XY
                Case 3 : GetEnum = VBGLLayoutType.XYZ
                Case 4 : GetEnum = VBGLLayoutType.XYZW
            End Select
        Case "Color"
            Select Case Size
                Case 1 : GetEnum = VBGLLayoutType.R
                Case 1 : GetEnum = VBGLLayoutType.G
                Case 1 : GetEnum = VBGLLayoutType.B
                Case 2 : GetEnum = VBGLLayoutType.RG
                Case 2 : GetEnum = VBGLLayoutType.RB
                Case 2 : GetEnum = VBGLLayoutType.GB
                Case 3 : GetEnum = VBGLLayoutType.RGBB
                Case 4 : GetEnum = VBGLLayoutType.RGBA
            End Select
        Case "Texture"
            Select Case Size
                Case 2 : GetEnum = VBGLLayoutType.TxTy
            End Select
        Case "Normal"
            Select Case Size
                Case 2 : GetEnum = VBGLLayoutType.NxNY
                Case 3 : GetEnum = VBGLLayoutType.NxNyNz
            End Select
    End Select
End Function

Private Sub Class_Initialize()
    Size = -1
End Sub