VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLGeneralInput"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Implements VBGLIInput

Public Enum VBGLButtonType
    Key   = 0
    Mouse = 1
    Wheel = 2
End Enum

Private Buttons()   As Long
Private Values()    As Long
Private Callables() As VBGLCallable

Private ElseCallable As VBGLCallable

Public Sub AddElse(ByVal Obj As Object, ByVal Method As String, ByVal n_CallType As VBCallType, ByVal n_ArgCount As Long, ParamArray BoundArgs() As Variant)
    Dim ArgsV() As Variant: ArgsV = BoundArgs
    Set ElseCallable = VBGLCallable.Create(Obj, Method, n_CallType, n_ArgCount, ArgsV)
End Sub

Public Sub AddKey(ByVal Value As Long, ByVal Obj As Object, ByVal Method As String, ByVal n_CallType As VBCallType, ByVal n_ArgCount As Long, ParamArray BoundArgs() As Variant)
    Dim ArgsV() As Variant: ArgsV = BoundArgs
    Call Add(VBGLButtonType.Key, Value, Obj, Method, n_CallType, n_ArgCount, ArgsV)
End Sub

Public Sub AddMouse(ByVal Value As Long, ByVal Obj As Object, ByVal Method As String, ByVal n_CallType As VBCallType, ByVal n_ArgCount As Long, ParamArray BoundArgs() As Variant)
    Dim ArgsV() As Variant: ArgsV = BoundArgs
    Call Add(VBGLButtonType.Mouse, Value, Obj, Method, n_CallType, n_ArgCount, ArgsV)
End Sub

Public Sub AddWheel(ByVal Value As Long, ByVal Obj As Object, ByVal Method As String, ByVal n_CallType As VBCallType, ByVal n_ArgCount As Long, ParamArray BoundArgs() As Variant)
    Dim ArgsV() As Variant: ArgsV = BoundArgs
    Call Add(VBGLButtonType.Wheel, Value, Obj, Method, n_CallType, n_ArgCount, ArgsV)
End Sub

Private Sub Add(ByVal Button As VBGLButtonType, ByVal Value As Long, ByVal Obj As Object, ByVal Method As String, ByVal n_CallType As VBCallType, ByVal n_ArgCount As Long, BoundArgs() As Variant)
    Dim Found As VBGLCallable
    Set Found = GetCallable(Button, Value)
    If IsNothing(Found) Then
        Call VBGLAdd(Buttons  , Button)
        Call VBGLAdd(Values   , Value)
        Call VBGLAdd(Callables, VBGLCallable.CreateArr(Obj, Method, n_CallType, n_ArgCount, BoundArgs))
    Else
        Found.Obj       = Obj
        Found.Method    = Method
        Found.CallType  = n_CallType
        Found.ArgCount  = n_ArgCount
        Found.BoundArgs = BoundArgs
    End If
End Sub

' Used for not further defined calling of any button with any Value.
' Use with care
Private Function VBGLIInput_Handle(ByVal Button As Long, ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    VBGLIInput_Handle = HandleArr(Button, Value, ArgsV)
End Function

' Value is Character of Key, args can be x and y
Private Function VBGLIInput_KeyDown(ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    VBGLIInput_KeyDown = HandleArr(VBGLButtonType.Key, Value, ArgsV)
End Function

' Value is Character of Key, args can be x and y
Private Function VBGLIInput_KeyUp(ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    VBGLIInput_KeyUp = HandleArr(VBGLButtonType.Key, Value, ArgsV)
End Function

' Value is 0, args can be x and y
Private Function VBGLIInput_MouseMove(ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    VBGLIInput_MouseMove = HandleArr(VBGLButtonType.Mouse, Value, ArgsV)
End Function

' Value is button mouse, args can be x and y
Private Function VBGLIInput_MouseClick(ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    VBGLIInput_MouseClick = HandleArr(VBGLButtonType.Mouse, Value, ArgsV)
End Function

' Value is Direction of mousewheel, args can be x and y
Private Function VBGLIInput_MouseWheel(ByVal Value As Long, ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    VBGLIInput_MouseWheel = HandleArr(VBGLButtonType.Wheel, Value, ArgsV)
End Function

Private Function HandleArr(ByVal Button As Long, ByVal Value As Long, Args() As Variant) As Variant
    Dim Cal As VBGLCallable
    Set Cal = GetCallable(Button, Value)
    If IsNothing(Cal) Then
        If IsSomething(ElseCallable) Then
            Set Cal = ElseCallable
        Else
            HandleArr = Empty
	        Exit Function
        End If
    End If

    HandleArr = Cal.HandleArr(Args)
End Function

Private Function GetCallable(ByVal Button As VBGLButtonType, ByVal Value As Long) As VBGLCallable
    Dim i As Long
    i = -1
    For i = 0 To USize(Callables)
        If Values(i) = Value And Buttons(i) = Button Then
            Set GetCallable = Callables(i)
            Exit Function
        End If
    Next i
End Function