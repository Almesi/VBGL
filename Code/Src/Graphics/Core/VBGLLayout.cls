VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLLayout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

' Important Classes for many other Classes
' Describes an entire DataLayout of passed Data
' All ByRef Arr should be ByVal, as they are not used directly.
' But since VBA only allows ByRef Arrays this comment is needed

Private p_Size       As Long
Private p_VertexSize As Long
Private p_ByteSize   As Long
Private p_Elements() As VBGLElement

Public Property Let Size(ByVal n_Size                            As Long)        : Let p_Size            = n_Size            : End Property
Public Property Let VertexSize(ByVal n_VertexSize                As Long)        : Let p_VertexSize      = n_VertexSize      : End Property
Public Property Let ByteSize(ByVal n_ByteSize                    As Long)        : Let p_ByteSize        = n_ByteSize        : End Property
Public Property Let Elements(ByRef n_Elements()                  As VBGLElement) : Let Elements          = p_Elements        : End Property
Public Property Let Element(ByVal Index As Long, ByVal n_Element As VBGLElement) : Set p_Elements(Index) = n_Element         : End Property

Public Property Get Size()                                       As Long         : Let Size              = p_Size            : End Property
Public Property Get VertexSize()                                 As Long         : Let VertexSize        = p_VertexSize      : End Property
Public Property Get ByteSize()                                   As Long         : Let ByteSize          = p_ByteSize        : End Property
Public Property Get Elements()                                   As VBGLElement(): Let Elements          = p_Elements        : End Property
Public Property Get Element(ByVal Index As Long)                 As VBGLElement  : Set Element           = p_Elements(Index) : End Property

' Types has to be an array of VBGLLayoutType
Public Function Create(ByVal DataType As vbVarType, ParamArray Types() As Variant) As VBGLLayout
    Dim i As Long
    Set Create = New VBGLLayout
    With Create
        For i = 0 To Ubound(Types)
            If TypeName(Types(i)) <> "Long" Then
                GoTo Error
            End If
            Call .AddType(DataType, Types(i))
        Next i
    End With
    Exit Function

    Error:
    Debug.Assert False
    Call CurrentContext.ErrorHandler.Raise(std_Error.Create("VBGLLayout", "severe", "Create", "Types(VAR0) is of Type VAR1", Empty, i, TypeName(Types(i))))
End Function

Public Function CreateArr(ByVal DataType As vbVarType, ByRef Types() As VBGLLayoutType) As VBGLLayout
    Dim i As Long
    Set CreateArr = New VBGLLayout
    With CreateArr
        For i = 0 To Ubound(Types)
            Call .AddType(DataType, Types(i))
        Next i
    End With
End Function

' Ubound(DataType) has to equal Ubound(Types)
Public Function CreateCombined(ByRef DataTypes() As vbVarType, ByRef Types() As VBGLLayoutType) As VBGLLayout
    Dim i As Long
    Set CreateCombined = New VBGLLayout
    With CreateCombined
        For i = 0 To Ubound(Types)
            Call .AddType(DataTypes(i), Types(i))
        Next i
    End With
End Function

Public Sub AddType(ByVal DataType As vbVarType, ByVal Typee As VBGLLayoutType)
    Select Case DataType
        Case vbSingle  : Call AddFloat(Typee)
        Case vbDouble  : Call AddDouble(Typee)
        Case vbByte    : Call AddUnsignedByte(Typee)
        Case vbInteger : Call AddUnsignedInt(Typee)
    End Select
End Sub

Public Function GetEnum(ByVal What As String, ByVal Size As Long)
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

Public Function VertexSizeFromIndex(ByVal Index As Long) As Long
    Dim i As Long
    Dim Result As Long
    For i = 0 To Index
        Result = Result + Element(i).Size
    Next i
    VertexSizeFromIndex = Result
End Function

Public Function StartPoint(ByVal Index As Long) As Long
    Dim i As Long
    Dim Result As Long
    For i = 1 To Index
        Result = Result + Element(i).Size
    Next i
    StartPoint = Result
End Function


Public Sub AddDouble(ByVal LayoutType       As VBGLLayoutType) : Call Push(GL_DOUBLE       , LayoutType, GL_FALSE) : End Sub
Public Sub AddFloat(ByVal LayoutType        As VBGLLayoutType) : Call Push(GL_FLOAT        , LayoutType, GL_FALSE) : End Sub
Public Sub AddUnsignedInt(ByVal LayoutType  As VBGLLayoutType) : Call Push(GL_UNSIGNED_INT , LayoutType, GL_FALSE) : End Sub
Public Sub AddUnsignedByte(ByVal LayoutType As VBGLLayoutType) : Call Push(GL_UNSIGNED_BYTE, LayoutType, GL_TRUE)  : End Sub

Private Sub Push(ByVal Typee As Long, ByVal LayoutType As VBGLLayoutType, ByVal Normalized As Byte)
    Size = Size + 1
    ReDim Preserve p_Elements(Size)
    Element(Size) = VBGLElement.Create(LayoutType, Typee, Normalized)
    ByteSize = ByteSize + Element(Size).ByteSize
    VertexSize = VertexSize + Element(Size).Size
End Sub

Private Sub Class_Initialize()
    Size = -1
End Sub