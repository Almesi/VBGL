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
    Mouse = 1
    Wheel = 2
End Enum

Private Type KeyHandler
    Button      As VBGLButtonType
    Value       As Long
    Callables() As VBGLCallable
End Type

Private Keys() As KeyHandler
Private Size As Long

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
    Dim Index As Long
    Index = GetKeysIndex(Button, Value)
    If Index = -1 Then
        Size = Size + 1
        ReDim Preserve Keys(Size)
        Keys(Size).Button = Button
        Keys(Size).Value  = Value
        Index = Size
    End If
        
    Dim Temp() As VBGLCallable
    Temp = Keys(Index).Callables
    Call VBGLAdd(Temp, VBGLCallable.CreateArr(Obj, Method, n_CallType, n_ArgCount, BoundArgs))
    Keys(Index).Callables = Temp
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
    Dim Cal As KeyHandler
    Cal = GetKeys(Button, Value)
    If Cal.Button = VBGLButtonType.Nott Then
        If IsSomething(ElseCallable) Then
            HandleArr = ElseCallable.HandleArr(Args)
        Else
            HandleArr = Empty
	        Exit Function
        End If
    Else
        Dim i As Long
        For i = 0 To USize(Cal.Callables)
            HandleArr = Cal.Callables(i).HandleArr(Args)
        Next i
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