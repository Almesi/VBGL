VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLCallable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Option Explicit

Private p_Obj           As Object
Private p_Method        As String
Private p_CallType      As VBCallType
Private p_BoundArgs()   As Variant
Private p_ArgCount      As Long

Public Property Let Obj(ByVal n_Obj             As Object)     : Set p_Obj       = n_Obj         : End Property
Public Property Let Method(ByVal n_Method       As String)     : Let p_Method    = n_Method      : End Property
Public Property Let CallType(ByVal n_CallType   As VBCallType) : Let p_CallType  = n_CallType    : End Property
Public Property Let BoundArgs(ByVal n_BoundArgs As Variant)    : Let p_BoundArgs = n_BoundArgs   : End Property
Public Property Let ArgCount(ByVal n_ArgCount   As Long)       : Let p_ArgCount  = n_ArgCount    : End Property

Public Property Get Obj()                       As Object      : Set Obj         = p_Obj         : End Property
Public Property Get Method()                    As String      : Let Method      = p_Method      : End Property
Public Property Get CallType()                  As VBCallType  : Let CallType    = p_CallType    : End Property
Public Property Get BoundArgs()                 As Variant     : Let BoundArgs   = p_BoundArgs   : End Property
Public Property Get ArgCount()                  As Long        : Let ArgCount    = p_ArgCount    : End Property

Public Function Create(ByVal n_Obj As Object, ByVal n_Method As String, ByVal n_CallType As VBCallType, ByVal n_ArgCount As Long, ParamArray n_BoundArgs() As Variant) As VBGLCallable
    Dim ArgsV() As Variant
    ArgsV = n_BoundArgs
    Set Create = CreateArr(n_Obj, n_Method, n_CallType, n_ArgCount, ArgsV)
End Function

Public Function CreateArr(ByVal n_Obj As Object, ByVal n_Method As String, ByVal n_CallType As VBCallType, ByVal n_ArgCount As Long, n_BoundArgs() As Variant) As VBGLCallable
    Set CreateArr = New VBGLCallable
    With CreateArr 
        .Obj       = n_Obj
        .Method    = n_Method
        .CallType  = n_CallType
        .ArgCount  = n_ArgCount
        .BoundArgs = CreateBoundArgs(n_ArgCount, n_BoundArgs)
    End With
End Function

Public Function Handle(ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    Call VBGLAssign(Handle, HandleArr(ArgsV))
End Function

Public Function HandleArr(Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = MergeWithBoundArgs(Args)
    ArgsV = HandleArgs(ArgsV)
    If IsSomething(Obj) Then
        Call VBGLAssign(HandleArr, CallByNameVar(ArgsV))
    Else
        Call VBGLAssign(HandleArr, RunApplication(ArgsV))
    End If
End Function

Private Function HandleArgs(Args() As Variant) As Variant()
    Dim i As Long
    Dim ReturnArr() As Variant
    If USize(Args) = -1 Then Exit Function
    ReDim ReturnArr(ArgCount)
    For i = 0 To ArgCount
        Select Case TypeName(Args(i))
            Case "VBGLCallable": Call VBGLAssign(ReturnArr(i), Args(i).Handle())
            Case Else          : Call VBGLAssign(ReturnArr(i), Args(i))
        End Select
    Next i
    HandleArgs = ReturnArr
End Function

Private Function MergeWithBoundArgs(Args() As Variant) As Variant()
    Dim i As Long
    Dim ReturnArr() As Variant
    If ArgCount = -1 Then Exit Function
    If USize(BoundArgs) <> ArgCount And USize(Args) <> ArgCount Then
        Call HandleError("MergeWithBoundsArgs", Args)
        Exit Function
    End If
    ReDim ReturnArr(ArgCount)
    For i = 0 To ArgCount
        If IsMissing(p_BoundArgs(i)) Then
            Call VBGLAssign(ReturnArr(i), Args(i))
        Else
            Call VBGLAssign(ReturnArr(i), p_BoundArgs(i))
        End If
    Next i
    MergeWithBoundArgs = ReturnArr
End Function

Private Function CallByNameVar(Args() As Variant) As Variant
    On Error GoTo Error
    Select Case USize(Args)
        Case -1: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType))
        Case 0:  Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0)))
        Case 1:  Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1)))
        Case 2:  Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2)))
        Case 3:  Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3)))
        Case 4:  Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4)))
        Case 5:  Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5)))
        Case 6:  Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6)))
        Case 7:  Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7)))
        Case 8:  Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8)))
        Case 9:  Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9)))
        Case 10: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10)))
        Case 11: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11)))
        Case 12: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12)))
        Case 13: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13)))
        Case 14: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14)))
        Case 15: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15)))
        Case 16: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16)))
        Case 17: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17)))
        Case 18: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18)))
        Case 19: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19)))
        Case 20: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20)))
        Case 21: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21)))
        Case 22: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22)))
        Case 23: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23)))
        Case 24: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24)))
        Case 25: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25)))
        Case 26: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25), Args(26)))
        Case 27: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25), Args(26), Args(27)))
        Case 28: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25), Args(26), Args(27), Args(28)))
        Case 29: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25), Args(26), Args(27), Args(28), Args(29)))
        Case 30: Call VBGLAssign(CallByNameVar, CallByName(Obj, Method, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25), Args(26), Args(27), Args(28), Args(29), Args(30)))
    End Select
    Exit Function
    Error:
    Call HandleError("CallByNameVar", Args)
End Function

Private Function RunApplication(Args() As Variant) As Variant
    On Error GoTo Error
    Select Case USize(Args)
        Case -1: Call VBGLAssign(RunApplication, Application.Run(Method))
        Case 0:  Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0))))
        Case 1:  Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1))))
        Case 2:  Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2))))
        Case 3:  Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3))))
        Case 4:  Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4))))
        Case 5:  Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5))))
        Case 6:  Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6))))
        Case 7:  Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7))))
        Case 8:  Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8))))
        Case 9:  Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9))))
        Case 10: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10))))
        Case 11: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11))))
        Case 12: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12))))
        Case 13: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13))))
        Case 14: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14))))
        Case 15: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15))))
        Case 16: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16))))
        Case 17: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17))))
        Case 18: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18))))
        Case 19: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19))))
        Case 20: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20))))
        Case 21: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21))))
        Case 22: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22))))
        Case 23: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23))))
        Case 24: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24))))
        Case 25: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24)), (Args(25))))
        Case 26: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24)), (Args(25)), (Args(26))))
        Case 27: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24)), (Args(25)), (Args(26)), (Args(27))))
        Case 28: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24)), (Args(25)), (Args(26)), (Args(27)), (Args(28))))
        Case 29: Call VBGLAssign(RunApplication, Application.Run(Method, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24)), (Args(25)), (Args(26)), (Args(27)), (Args(28)), (Args(29))))
    End Select
    Exit Function
    Error:
    Call HandleError("RunApplication", Args)
End Function

Private Function CreateBoundArgs(n_ArgCount As Long, BoundArgs() As Variant, Optional DontPopulate As Variant) As Variant()
    Dim ReturnArr() As Variant
    If n_ArgCount = -1 Then Exit Function
    ReDim ReturnArr(n_ArgCount)
    Dim i As Long
    For i = 0 To n_ArgCount
        If USize(BoundArgs) >= i Then
            Call VBGLAssign(ReturnArr(i), BoundArgs(i))
        Else
            Call VBGLAssign(ReturnArr(i), DontPopulate)
        End If
    Next i
    CreateBoundArgs = ReturnArr
End Function

Private Sub HandleError(ByVal Identity As String, Args() As Variant)
    Dim NewError As std_Error
    Set NewError = std_Error.Create("VBGLCallable", "severe", Identity, "Something went wrong with the Callback VAR0 (Object: VAR1, CallType: VAR2, ArgCount: VAR3, passed ArgCount: VAR4)| VAR5", Empty, Method, Obj, CallType, ArgCount, USize(Args), Err.Description)
    Call CurrentContext.ErrorHandler.Raise(NewError)
End Sub