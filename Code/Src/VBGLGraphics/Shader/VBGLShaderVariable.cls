VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLShaderVariable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit


Private p_State    As String
Private p_DataType As String
Private p_Name     As String

Public Property Let State(n_State       As String): p_State    = n_State    : End Property
Public Property Let DataType(n_DataType As String): p_DataType = n_DataType : End Property
Public Property Let Name(n_Name         As String): p_Name     = n_Name     : End Property

Public Property Get State()             As String : State      = p_State    : End Property
Public Property Get DataType()          As String : DataType   = p_DataType : End Property
Public Property Get Name()              As String : Name       = p_Name     : End Property

Public Function Create(n_State As String, n_DataType As String, n_Name As String) As VBGLShaderVariable
    Set Create = New VBGLShaderVariable
    With Create
        .State    = n_State
        .DataType = n_DataType
        .Name     = n_Name
    End With
End Function

Public Function Add(Arr() As VBGLShaderVariable, n_State As String, n_DataType As String, n_Name As String) As VBGLShaderVariable
    Dim NewVar As VBGLShaderVariable
    Set NewVar = Create(n_State, n_DataType, n_Name)
    Set Add = AddVariable(Arr, NewVar)
End Function

Public Function AddVariable(Arr() As VBGLShaderVariable, Value As VBGLShaderVariable) As VBGLShaderVariable
    Dim Size As Long: Size = USize(Arr) + 1
    ReDim Preserve Arr(Size)
    Set Arr(Size) = Value
    Set AddVariable = Value
End Function

Public Function Find(Arr() As VBGLShaderVariable, Name As String) As VBGLShaderVariable
    Dim i As Long
    For i = 0 To USize(Arr)
        If Arr(i).Name = Name Then
            Set Find = Arr(i)
            Exit For
        End If
    Next i
End Function

Private Function USize(Arr As Variant) As Long
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr)
End Function