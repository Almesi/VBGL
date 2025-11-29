VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLGeneralInput"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Option Explicit

Implements VBGLIInput

Public Enum VBGLButtonType
    Nott  = -1
    Key   = 0
    KeyUp = 1
    Mouse = 2
    Wheel = 3
End Enum

Private Type KeyHandler
    Button      As VBGLButtonType
    Value       As Long
    Callables   As std_Callables
End Type

Private Keys() As KeyHandler
Private Size As Long

Private ElseCallable As std_Callable
Private AnyCallable  As std_Callable

Public Function Create() As VBGLGeneralInput
    Set Create = New  VBGLGeneralInput
End Function

Public Sub AddElse(ByVal Func As std_Callable)
    Set ElseCallable = std_Callable.Create(Obj, Method, n_CallType, n_ArgCount).BindArr(ArgsV)
End Sub

Public Sub AddAny(ByVal Func As std_Callable)
    Set AnyCallable = std_Callable.Create(Obj, Method, n_CallType, n_ArgCount).BindArr(ArgsV)
End Sub

Public Sub AddKey(ByVal Value As Long, ByVal Func As std_Callable)
    Call Add(VBGLButtonType.Key, Value, Func)
End Sub

Public Sub AddKeyUp(ByVal Value As Long, ByVal Func As std_Callable)
    Call Add(VBGLButtonType.KeyUp, Value, Func)
End Sub

Public Sub AddMouse(ByVal Value As Long, ByVal Func As std_Callable)
    Call Add(VBGLButtonType.Mouse, Value, Func)
End Sub

Public Sub AddWheel(ByVal Value As Long, ByVal Func As std_Callable)
    Call Add(VBGLButtonType.Wheel, Value, Func)
End Sub

Private Sub Add(ByVal Button As VBGLButtonType, ByVal Value As Long, ByVal Func As std_Callable)
    Dim Index As Long
    Index = GetKeysIndex(Button, Value)
    If Index = -1 Then
        Size = Size + 1
        ReDim Preserve Keys(Size)
        Keys(Size).Button = Button
        Keys(Size).Value  = Value
        Set Keys(Size).Callables = std_Callables.Create()
        Index = Size
    End If
    Call Keys(Index).Callables.Add(Func)
End Sub

' Used for not further defined calling of any button with any Value.
' Use with care
Private Function VBGLIInput_Handle(ByVal Button As Long, ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    Call VBGLAssign(VBGLIInput_Handle, RunArr(Button, Value, ArgsV))
End Function

' Value is Character of Key, args can be x and y
Private Function VBGLIInput_KeyDown(ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    Call VBGLAssign(VBGLIInput_KeyDown, RunArr(VBGLButtonType.Key, Value, ArgsV))
End Function

' Value is Character of Key, args can be x and y
Private Function VBGLIInput_KeyUp(ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    Call VBGLAssign(VBGLIInput_KeyUp, RunArr(VBGLButtonType.KeyUp, Value, ArgsV))
End Function

' Value is 0, args can be x and y
Private Function VBGLIInput_MouseMove(ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    Call VBGLAssign(VBGLIInput_MouseMove, RunArr(VBGLButtonType.Mouse, Value, ArgsV))
End Function

' Value is button mouse, args can be x and y
Private Function VBGLIInput_MouseClick(ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    Call VBGLAssign(VBGLIInput_MouseClick, RunArr(VBGLButtonType.Mouse, Value, ArgsV))
End Function

' Value is Direction of mousewheel, args can be x and y
Private Function VBGLIInput_MouseWheel(ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    Call VBGLAssign(VBGLIInput_MouseWheel, RunArr(VBGLButtonType.Wheel, Value, ArgsV))
End Function

Private Function RunArr(ByVal Button As Long, ByVal Value As Long, Args() As Variant) As Variant
    Dim Cal As KeyHandler
    Cal = GetKeys(Button, Value)
    If Cal.Button = VBGLButtonType.Nott Then
        If IsSomething(ElseCallable) Then
            Call VBGLAssign(RunArr, ElseCallable.RunArr(Args))
        Else
            RunArr = Empty
	        Exit Function
        End If
    Else
        Dim i As Long
        For i = 0 To Cal.Callables.Count
            Call VBGLAssign(RunArr, Cal.Callables.Callable(i).RunArr(Args))
        Next i
    End If
    If IsSomething(AnyCallable) Then
        Call VBGLAssign(RunArr, AnyCallable)
    End If

End Function

Private Function GetKeys(ByVal Button As VBGLButtonType, ByVal Value As Long) As KeyHandler
    Dim Found As Long
    Found = GetKeysIndex(Button, Value)
    If Found <> -1 Then
        GetKeys = Keys(Found)
    Else
        GetKeys.Button = VBGLButtonType.Nott
    End If
End Function

Private Function GetKeysIndex(ByVal Button As VBGLButtonType, ByVal Value As Long) As Long
    Dim i As Long
    GetKeysIndex = -1
    For i = 0 To Size
        If Keys(i).Value = Value And Keys(i).Button = Button Then
            GetKeysIndex = i
            Exit Function
        End If
    Next i
End Function

Private Sub Class_Initialize()
    Size = -1
End Sub