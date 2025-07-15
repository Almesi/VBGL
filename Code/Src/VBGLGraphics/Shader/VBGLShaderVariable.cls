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


p_State    As String
p_DataType As String
p_Name     As String

Public Property Let State(n_State       As String): p_State    = n_State    : End Property
Public Property Let DataType(n_DataType As String): p_DataType = n_DataType : End Property
Public Property Let Name(n_Name         As String): p_Name     = n_Name     : End Property

Public Property Get State()             As String : State      = p_State    : End Property
Public Property Get DataType()          As String : DataType   = p_DataType : End Property
Public Property Get Name()              As String : Name       = p_Name     : End Property

Public Function Create(n_State As String, n_DataType As String, n_Name As String) As VBGLShaderVariable
    Set Create = New VBGLShaderVariable
    With Create
        .State    =             n_State
        .DataType =          n_DataType
        .Name     =          n_Name
    End With
End Function

Public Function Add(Arr() As VBGLShaderVariable, n_State As String, n_DataType As String, n_Name As String) As VBGLShaderVariable
    Dim NewVar As VBGLShaderVariable
    Set NewVar = Create(n_State, n_DataType, n_Name)
    Dim Size As Long : Size = -1
    On Error Resume Next
    Size = Ubound(Arr) + 1
    ReDim Preserve Arr(Size)
    Set Arr(Size) = NewVar
    Set Add = NewVar
End Function