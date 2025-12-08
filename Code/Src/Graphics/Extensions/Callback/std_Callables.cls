VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "std_Callables"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private p_Callables() As std_Callable
Private p_Count As Long

Public Property Get Count() As Long
    Count = p_Count
End Property

Public Property Get Callable(ByVal Index As Long) As std_Callable
    Set Callable = p_Callables(Index)
End Property

Public Function Create() As std_Callables
    Set Create = New std_Callables
End Function

Public Sub Add(ByVal n_Callable As std_Callable)
    Call VBGLAdd(p_Callables, n_Callable)
    p_Count = USize(p_Callables)
End Sub

Public Function Run() As Variant
    Dim i As Long
    For i = 0 To Count
        Call VBGLAssign(Run, Callable(i).Run())
    Next i
End Function

Private Sub Class_Initialize()
    p_Count = -1
End Sub