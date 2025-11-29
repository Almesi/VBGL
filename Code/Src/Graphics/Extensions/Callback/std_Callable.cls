VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "std_Callable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private p_Object         As Object
Private p_State          As String
Private p_CallableType   As String
Private p_IsStatic       As String
Private p_Name           As String
Private p_ReturnType     As String
Private p_Arguments()    As std_CallableArg

Private p_ArgsIsFixed As Boolean
Private p_Execute As Boolean
Private p_AutoExecute As Boolean


Public Property Let Object(ByVal         n_Value As Object)    : Set p_Object         = n_Value           : End Property
Public Property Let State(ByVal          n_Value As String)    : Let p_State          = n_Value           : End Property
Public Property Let CallableType(ByVal   n_Value As String)    : Let p_CallableType   = n_Value           : End Property
Public Property Let IsStatic(ByVal       n_Value As String)    : Let p_IsStatic       = n_Value           : End Property
Public Property Let Name(ByVal           n_Value As String)    : Let p_Name           = n_Value           : End Property
Public Property Let Arguments(ByVal      n_Value As Variant)   : Let p_Arguments      = n_Value           : End Property
Public Property Let ReturnType(ByVal     n_Value As String)    : Let p_ReturnType     = n_Value           : End Property

Public Property Get Object()                     As Object     : Set Object           = p_Object          : End Property
Public Property Get State()                      As String     : Let State            = p_State           : End Property
Public Property Get CallableType()               As String     : Let CallableType     = p_CallableType    : End Property
Public Property Get IsStatic()                   As String     : Let IsStatic         = p_IsStatic        : End Property
Public Property Get Name()                       As String     : Let Name             = p_Name            : End Property
Public Property Get Arguments()                  As Variant    : Let Arguments        = p_Arguments       : End Property
Public Property Get ReturnType()                 As String     : Let ReturnType       = p_ReturnType      : End Property

Public Function ArgsIsFixed() As Boolean
    ArgsIsFixed = p_ArgsIsFixed
End Function
Public Function Execute() As Boolean
    Execute = p_Execute
End Function
Public Function AutoExecute() As Boolean
    AutoExecute = p_AutoExecute
End Function

Public Property Get Argument(ByVal Index As Long) As std_CallableArg
    Set Argument = p_Arguments(Index)
End Property

Public Function ArgumentValues() As Variant()
    If TypeName(Object) = "std_Callable" Then
        Dim ObjArgs() As Variant
        ObjArgs = Object.ArgumentValues()
    End If
        Dim MyObjArgs() As Variant
        MyObjArgs = GetAllArgs()
    ArgumentValues = CombineArgs(ObjArgs, MyObjArgs)
End Function


Public Function Clone() As std_Callable
    Set Clone = New std_Callable
    With Clone
        .Object         = Object
        .State          = State
        .CallableType   = CallableType
        .IsStatic       = IsStatic
        .Name           = Name
        .ReturnType     = ReturnType
        .Arguments      = CloneArguments(Arguments)
    End With
End Function

Public Function Create(ByVal n_Object As Object, ByVal n_Name As String, ByVal n_CallType As VBCallType, ByVal n_ArgCount As Long) As std_Callable
    Set Create = New std_Callable
    With Create
        .Object       = n_Object
        .State        = "Public"
        .CallableType = FromCallType(n_CallType)
        .Name         = n_Name
        .Arguments    = CreateArguments(n_ArgCount)
        .ReturnType   = "Variant"
    End With
End Function

Public Function CreateFromText(ByVal n_Object As Object, ByVal Definition As String) As std_Callable
    Set CreateFromText = New std_Callable
    With CreateFromText
        .Object          = n_Object
        Call .ParseDefinition(Definition)
    End With
End Function

Public Function Text() As String
    Dim Result As String
    Result = Result & Iif(Not Object   Is Nothing, TypeName(Object) & ".", Empty)
    Result = Result & Iif(State          <> Empty, State            & " ", Empty)
    Result = Result & Iif(CallableType   <> Empty, CallableType     & " ", Empty)
    Result = Result & Iif(IsStatic       <> Empty, IsStatic         & " ", Empty)

    Result = Result & Iif(Name           <> Empty, Name             & "(", Empty)
    Result = Result & ArgumentText()
    Result = Result & ")"
    Result = Result & Iif(ReturnsValue(CallableType), " As " & ReturnType, Empty)
    Text = Result
End Function

Public Function CallType() As VBCallType
    Select Case UCase(CallableType)
        Case "SUB", "FUNCTION"
            CallType = vbMethod
        Case "PROPERTY GET"
            CallType = vbGet
        Case "PROPERTY LET"
            CallType = vbLet
        Case "PROPERTY SET"
            CallType = vbSet
    End Select
End Function

Public Function ArgCount() As Long
    ArgCount = USize(p_Arguments)
End Function

Private Function ValCount() As Long
    If Param() Then
        Dim ParamCount As Long
        ParamCount = USize(Argument(ArgCount).Values)
        ValCount = (ArgCount - 1) + (ParamCount + 1)
    Else
        ValCount = ArgCount
    End If
End Function

'===================================
'=============EXECUTION=============
'===================================

Public Function Run(ParamArray Args() As Variant) As Variant
    Dim ArgsV() As Variant
    ArgsV = Args
    Call Assign(Run, RunArr(ArgsV))
End Function

Public Function RunArr(ByRef Args() As Variant) As Variant
    If Execute = False Then Exit Function
    If UCase(State) = "PRIVATE" Then
        Debug.Print "Cannot run this Callable, since it is private"
        Exit Function
    End If

    Dim ArgsV() As Variant
    ArgsV = AssignPassedArgs(ArgumentValues, Args, True)
    If Not Object Is Nothing Then
        Call Assign(RunArr, CallByNameVar(ArgsV))
    Else
        Call Assign(RunArr, RunApplication(ArgsV))
    End If
End Function

Public Function Bind(ParamArray Args() As Variant) As std_Callable
    Dim ArgsV() As Variant
    ArgsV = Args
    Set Bind = BindArr(ArgsV)
End Function

Public Function BindArr(ByRef Args() As Variant) As std_Callable
    Dim i As Long
    If Param() Then
        Dim ArgSize As Long
        ArgSize = USize(Args)
        If ArgSize >= 0 Then
            For i = 0 To ArgCount - 1
                Argument(i).Values = Args(i)
            Next i

            Dim Temp() As Variant
            ReDim Temp(ArgSize - (ArgCount))
            For i = ArgCount To USize(Args)
                Call Assign(Temp(i - ArgCount), Args(i))
            Next i
            Argument(ArgCount).Values = Temp
        End If
    Else
        For i = 0 To USize(Args)
            Argument(i).Values = Args(i)
        Next i
    End If
    
    Set BindArr = Me
End Function

Public Function BindRecursive(ParamArray Args() As Variant) As std_Callable
    Dim ArgsV() As Variant
    ArgsV = Args
    Set Bind = BindArrRecursive(ArgsV)
End Function

Public Function BindArrRecursive(ByRef Args() As Variant) As std_Callable
    Dim Size As Long
    Size = USize(Args)
    Dim MyArgs() As Variant
    If TypeName(Object) = "std_Callable" Then
        Call Object.BindArr(ArrayPart(Args, Size - ValCount, Size))
        MyArgs = ArrayPart(Args, 0, Size - ValCount - 1)
    Else
        MyArgs = Args
    End If

    Dim i As Long
    If Param() Then
        Dim ArgSize As Long
        ArgSize = USize(MyArgs)
        If ArgSize >= 0 Then
            For i = 0 To ArgCount - 1
                Argument(i).Values = MyArgs(i)
            Next i

            Dim Temp() As Variant
            ReDim Temp(ArgSize - (ArgCount))
            For i = ArgCount To USize(MyArgs)
                Call Assign(Temp(i - ArgCount), MyArgs(i))
            Next i
            Argument(ArgCount).Values = Temp
        End If
    Else
        For i = 0 To USize(MyArgs)
            Argument(i).Values = MyArgs(i)
        Next i
    End If
    
    Set BindArr = Me
End Function

Public Function FixArgs(ByVal Value As Boolean) As std_Callable
    p_ArgsIsFixed = Value
    Set FixArgs = Me
End Function

Public Function SetExecute(ByVal Value As Boolean) As std_Callable
    p_Execute = Value
    Set SetExecute = Me
End Function

Public Function SetAutoExecute(ByVal Value As Boolean) As std_Callable
    p_AutoExecute = Value
    Set SetAutoExecute = Me
End Function

Private Function CallByNameVar(ByRef AllArgs() As Variant) As Variant
    On Error GoTo Error

    Dim Obj As Object
    Dim NextArgs() As Variant : NextArgs = ArrayPart(AllArgs, 0, USize(AllArgs) - (ValCount + 1))
    Dim Args()     As Variant : Args     = ArrayPart(AllArgs, USize(AllArgs) - ValCount, USize(AllArgs))
    If TypeName(Object) = TypeName(Me) Then
        Set Obj = Object.RunArr(NextArgs)
    Else
        Set Obj = Object
    End If
    
    Select Case USize(Args)
        Case -1: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType))
        Case 0:  Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0)))
        Case 1:  Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1)))
        Case 2:  Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2)))
        Case 3:  Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3)))
        Case 4:  Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4)))
        Case 5:  Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5)))
        Case 6:  Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6)))
        Case 7:  Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7)))
        Case 8:  Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8)))
        Case 9:  Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9)))
        Case 10: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10)))
        Case 11: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11)))
        Case 12: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12)))
        Case 13: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13)))
        Case 14: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14)))
        Case 15: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15)))
        Case 16: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16)))
        Case 17: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17)))
        Case 18: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18)))
        Case 19: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19)))
        Case 20: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20)))
        Case 21: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21)))
        Case 22: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22)))
        Case 23: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23)))
        Case 24: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24)))
        Case 25: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25)))
        Case 26: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25), Args(26)))
        Case 27: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25), Args(26), Args(27)))
        Case 28: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25), Args(26), Args(27), Args(28)))
        Case 29: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25), Args(26), Args(27), Args(28), Args(29)))
        Case 30: Call Assign(CallByNameVar, CallByName(Obj, Name, CallType, Args(0), Args(1), Args(2), Args(3), Args(4), Args(5), Args(6), Args(7), Args(8), Args(9), Args(10), Args(11), Args(12), Args(13), Args(14), Args(15), Args(16), Args(17), Args(18), Args(19), Args(20), Args(21), Args(22), Args(23), Args(24), Args(25), Args(26), Args(27), Args(28), Args(29), Args(30)))
    End Select
    Exit Function
    Error:
    Call RunError("CallByNameVar", Args)
End Function

Private Function RunApplication(ByRef Args() As Variant) As Variant
    On Error GoTo Error
    Select Case USize(Args)
        Case -1: Call Assign(RunApplication, Application.Run(Name))
        Case 0:  Call Assign(RunApplication, Application.Run(Name, (Args(0))))
        Case 1:  Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1))))
        Case 2:  Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2))))
        Case 3:  Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3))))
        Case 4:  Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4))))
        Case 5:  Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5))))
        Case 6:  Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6))))
        Case 7:  Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7))))
        Case 8:  Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8))))
        Case 9:  Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9))))
        Case 10: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10))))
        Case 11: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11))))
        Case 12: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12))))
        Case 13: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13))))
        Case 14: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14))))
        Case 15: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15))))
        Case 16: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16))))
        Case 17: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17))))
        Case 18: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18))))
        Case 19: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19))))
        Case 20: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20))))
        Case 21: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21))))
        Case 22: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22))))
        Case 23: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23))))
        Case 24: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24))))
        Case 25: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24)), (Args(25))))
        Case 26: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24)), (Args(25)), (Args(26))))
        Case 27: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24)), (Args(25)), (Args(26)), (Args(27))))
        Case 28: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24)), (Args(25)), (Args(26)), (Args(27)), (Args(28))))
        Case 29: Call Assign(RunApplication, Application.Run(Name, (Args(0)), (Args(1)), (Args(2)), (Args(3)), (Args(4)), (Args(5)), (Args(6)), (Args(7)), (Args(8)), (Args(9)), (Args(10)), (Args(11)), (Args(12)), (Args(13)), (Args(14)), (Args(15)), (Args(16)), (Args(17)), (Args(18)), (Args(19)), (Args(20)), (Args(21)), (Args(22)), (Args(23)), (Args(24)), (Args(25)), (Args(26)), (Args(27)), (Args(28)), (Args(29))))
    End Select
    Exit Function
    Error:
    Call RunError("RunApplication", Args)
End Function

'===================================
'==========Interpretation===========
'===================================


Private Function AssignPassedArgs(ByRef BoundArgs() As Variant, ByRef Args() As Variant, ByVal RunIt As Boolean) As Variant()
    Dim Size As Long
    Dim Arr() As Variant
    Size = USize(BoundArgs)
    If Size = -1 Then Exit Function
    ReDim Arr(Size)

    Dim i As Long
    For i = 0 To Size
        If ArgsIsFixed Then
            Call Assign(Arr(i), TransformArg(BoundArgs(i), RunIt))
        Else
            If i > USize(Args) Then
                Call Assign(Arr(i), TransformArg(BoundArgs(i), RunIt))
            Else
                If IsMissing(Args(i)) Then
                    Call Assign(Arr(i), TransformArg(BoundArgs(i), RunIt))
                Else
                    Call Assign(Arr(i), TransformArg(Args(i), RunIt))
                End If
            End If
        End If
    Next i
    AssignPassedArgs = Arr
End Function

Private Function GetAllArgs() As Variant()
    Dim FixedArgs() As Variant : FixedArgs = GetFixedArgs()
    Dim ParamArgs() As Variant : ParamArgs = GetParamArgs()
    GetAllArgs = CombineArgs(FixedArgs, ParamArgs)
End Function

Private Function GetFixedArgs() As Variant()
    Dim Arr() As Variant
    Dim Size As Long
    If Param() Then
        Size = ArgCount - 1
    Else
        Size = ArgCount
    End If
    If Size = -1 Then Exit Function
    Dim i As Long
    ReDim Arr(Size)
    For i = 0 To Size
        Call Assign(Arr(i), Argument(i).Values)
    Next i
    GetFixedArgs = Arr
End Function

Private Function GetParamArgs() As Variant()
    Dim Arr() As Variant
    Dim Size As Long
    ' + 1, as this would in a non paramarray would be oversize, this returning nothing
    If Param() Then
        Size = ArgCount
        Dim Temp As Variant
        Temp = Argument(ArgCount).Values
        If USize(Temp) = -1 Then
            Exit Function
        Else
            ReDim Arr(USize(Temp))
        End If
    Else
        Size = ArgCount + 1
    End If
    Dim i As Long
    For i = 0 To USize(Arr)
        Call Assign(Arr(i), Temp(i))
    Next i
    GetParamArgs = Arr
End Function

Private Function CombineArgs(ByRef Args1() As Variant, ByRef Args2() As Variant) As Variant()
    Dim Size As Long
    Dim Result() As Variant
    Dim i As Long
    Dim Index As Long
    
    Size = USize(Args1) + 1 + USize(Args2) + 1
    If Size = 0 Then Exit Function
    ReDim Result(Size - 1)
    
    For i = 0 To USize(Args1)
        Call Assign(Result(Index), Args1(i))
        Index = Index + 1
    Next i
    
    For i = 0 To USize(Args2)
        Call Assign(Result(Index), Args2(i))
        Index = Index + 1
    Next i
    
    CombineArgs = Result
End Function

Private Function GetArgPointers() As Variant()
    Dim Arr() As Variant
    Dim NextArr() As Variant
    If TypeName(Object) = "std_Callable" Then
        NextArr = GetArgPointers()
    Else
        ReDim Arr(0)
        Arr(0) = ValCount
    End If
    GetArgPointers = CombineArgs(Arr, NextArr)
End Function

Private Function TransformArg(ByVal Arg As Variant, ByVal RunIt As Boolean) As Variant
    If RunIt Then
        Call Assign(TransformArg, RunArg(Arg))
    Else
        Call Assign(TransformArg, Arg)
    End If
End Function

Private Function RunArg(ByVal Value As Variant) As Variant
    If TypeName(Value) = "std_Callable" Then
        If Value.AutoExecute Then
            Call Assign(RunArg, Value.Run())
        Else
            Call Assign(RunArg, Value)
        End If
    Else
        Call Assign(RunArg, Value)
    End If
End Function

Private Function VarTypeFromName(ByRef Arg As std_CallableArg, ByVal Inputt As Variant) As Variant
    On Error GoTo Error
    If TypeName(Inputt) = "std_Callable" Then
        If Inputt.ReturnType <> Arg.ReturnType Then
            'Call RunError("VarTypeFromName", Args)
            Debug.Print "Variables not compatible: " & Inputt.ReturnType & " " & Arg.ReturnType
        Else
            Call Assign(VarTypeFromName, Inputt)
        End If
        Exit Function
    End If
    Select Case UCase(Arg.ReturnType)
        Case "INTEGER"         : Call Assign(VarTypeFromName, CInt(Inputt))
        Case "LONG"            : Call Assign(VarTypeFromName, CLng(Inputt))
        Case "SINGLE"          : Call Assign(VarTypeFromName, CSng(Inputt))
        Case "DOUBLE"          : Call Assign(VarTypeFromName, CDbl(Inputt))
        Case "CURRENCY"        : Call Assign(VarTypeFromName, CCur(Inputt))
        Case "STRING"          : Call Assign(VarTypeFromName, CStr(Inputt))
        Case "BOOLEAN"         : Call Assign(VarTypeFromName, CBool(Inputt))
        Case "VARIANT"         : Call Assign(VarTypeFromName, CVar(Inputt))
        Case "BYTE"            : Call Assign(VarTypeFromName, CByte(Inputt))
        Case "DATE"            : Call Assign(VarTypeFromName, CDate(Inputt))
        Case "OBJECT"          : Call Assign(VarTypeFromName, Inputt)
        Case Else              : Call Assign(VarTypeFromName, CVar(Inputt))
    End Select
    Exit Function

    Error:
    Set VarTypeFromName = Err
End Function

Private Function ParamValues(ByRef Args() As Variant) As Variant()
    Dim i As Long
    Dim Temp() As Variant
    If USize(Args) = -1 Then Exit Function
    ReDim Temp(USize(Args) - ArgCount)
    For i = ArgCount To USize(Args)
        Call Assign(Temp(i - ArgCount), Args(i))
    Next i
    ParamValues = Temp
End Function

Private Function ArrayPart(ByRef Args() As Variant, ByVal StartPoint As Long, ByVal EndPoint As Long) As Variant()
    Dim Arr() As Variant
    Dim i As Long
    If USize(Args) < 0 Then Exit Function
    If StartPoint > EndPoint Then Exit Function
    ReDim Arr(EndPoint - StartPoint)
    For i = StartPoint To EndPoint
        Call Assign(Arr(i - StartPoint), Args(i))
    Next i
    ArrayPart = Arr
End Function


'===================================
'==============PARSING==============
'===================================
Public Sub ParseDefinition(ByVal Text As String)
    Dim FunctionPart As String : FunctionPart = MidP(Text, 1, FunctionNameIndex(Text) - 1)
    Dim ArgPart      As String : ArgPart      = MidP(Text, FunctionNameIndex(Text) + 1, ArgumentEndIndex(Text) - 1)
    Dim ReturnPart   As String : ReturnPart   = MidP(Text, ArgumentEndIndex(Text) + 1, Len(Text))

    Dim Temp() As String
    Dim Size   As Long
    Dim i As Long, j As Long

    Temp = Split(FunctionPart, " ")
    Size = USize(Temp)
    For i = 0 To Size - 1
        Dim Text1 As String : Text1 = Temp(i)
        Dim Text2 As String : Text2 = Temp(i + 1)
        If FunctionState(Text1)                 <> Empty Then State          = FunctionState(Text1)
        If FunctionCallableType(Text1, Text2)   <> Empty Then CallableType   = FunctionCallableType(Text1, Text2)
        If FunctionIsStatic(Text1)              <> Empty Then IsStatic       = FunctionIsStatic(Text1)
    Next i
    Name = Temp(Size)

    Temp = Split(ArgPart, ",")
    Size = USize(Temp)
    If Size >= 0 Then ReDim p_Arguments(Size)
    For i = 0 To Size
        Set p_Arguments(i) = std_CallableArg.CreateFromText(Temp(i))
    Next i

    If ReturnsValue(CallableType) Then
        Temp = Split(ReturnPart, " ")
        If USize(Temp) <> -1 Then
            p_ReturnType = Temp(USize(Temp))
        Else
            p_ReturnType = "Variant"
        End If
    End If 
End Sub

Private Function FunctionNameIndex(ByVal Text As String) As Long
    FunctionNameIndex = InStr(1, Text, "(")
End Function

Private Function ArgumentEndIndex(ByVal Text As String) As Long
    Dim Index As Long
    Index = InStrRev(Text, ")")
    ' Case for when returntype of procedure is an array
    If Index = Len(Text) And Not(UCase(Text) Like "* SUB *") And _
                             Not(UCase(Text) Like "* PROPERTY LET *") And _
                             Not(UCase(Text) Like "* PROPERTY SET *") Then
        Index = InStrRev(Mid(Text, 1, Len(Text) - 1), ")")
    End If
    ArgumentEndIndex = Index
End Function

Private Function FunctionState(ByVal Text As String) As String
    Dim nText As String
    nText = UCase(Text)
    If nText = "PUBLIC" Or nText = "PRIVATE" Then
        FunctionState = Text
    End If
End Function

Private Function FunctionCallableType(ByVal Text1 As String, ByVal Text2 As String) As String
    Dim nText1 As String: nText1 = UCase(Text1)
    Dim nText2 As String: nText2 = UCase(Text2)
    If nText1 = "SUB" Or nText1 = "FUNCTION" Then
        FunctionCallableType = Text1
    ElseIf nText1 = "PROPERTY" And (nText2 = "GET" Or nText2 = "LET" Or nText2 = "SET") Then
        FunctionCallableType = Text1 & " " & Text2
    End If
End Function

Private Function FunctionIsStatic(ByVal Text As String) As String
    If UCase(Text) Like "STATIC" Then FunctionIsStatic = Text
End Function

Private Function ReturnsValue(ByVal CallableType As String) As Boolean
    ReturnsValue = UCase(CallableType) Like "FUNCTION" Or _
                   UCase(CallableType) Like "PROPERTY GET"
End Function

Private Function MidP(ByVal Text As String, ByVal StartPoint As Long, ByVal EndPoint As Long) As String
    On Error Resume Next
    MidP = Mid(Text, StartPoint, (EndPoint - StartPoint) + 1)
End Function

Private Function ArgumentText() As String
    Dim i As Long
    Dim Result As String
    For i = 0 To USize(p_Arguments)
        Result = Result & Argument(i).Text & ", "
    Next i
    ArgumentText = MidP(Result, 1, Len(Result) - 2)
End Function

'===================================
'================Misc===============
'===================================
Private Function Param() As Boolean
    If ArgCount = -1 Then Exit Function
    Param = (Argument(ArgCount).Param <> Empty)
End Function

Private Function USize(ByRef Arr As Variant) As Long
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr)
End Function

Private Sub RunError(ByVal Identity As String, Args() As Variant)
    Dim NewError As std_Error
    Set NewError = std_Error.Create("std_Callable", "severe", Identity, "Something went wrong with the Callback VAR0|VAR1", Empty, Me.Text, Err.Description)
    Call CurrentContext.ErrorHandler.Raise(NewError)
End Sub

Private Function FromCallType(ByVal n_CallType As VBCallType) As String
    Select Case n_CallType
        Case vbMethod : FromCallType = "Function"
        Case vbSet    : FromCallType = "Property Set"
        Case vbLet    : FromCallType = "Property Let"
        Case vbGet    : FromCallType = "Property Get"
    End Select
End Function

Private Sub Assign(ByRef Goal As Variant, ByVal Value As Variant)
    If IsObject(Value) Then
        Set Goal = Value
    Else
        Let Goal = Value
    End If
End Sub

Private Function Missing(Optional ByVal DontPopulateThisVariable) As Variant
    Missing = DontPopulateThisVariable
End Function

Private Function CloneArguments(ByVal Args As Variant) As std_CallableArg()
    Dim i As Long
    Dim Arr() As std_CallableArg
    If ArgCount = -1 Then Exit Function
    ReDim Arr(ArgCount)
    For i = 0 To ArgCount
        Set Arr(i) = Args(i).Clone()
    Next i
    CloneArguments = Arr
End Function

Private Function CreateArguments(ByVal Count As Long) As std_CallableArg()
    Dim i As Long
    Dim Arr() As std_CallableArg
    If Count = -1 Then Exit Function
    If Count = -2 Then
        ReDim Arr(0)
        Set Arr(0) = std_CallableArg.CreateFromText("ParamArray Val() As Variant")
    Else
        ReDim Arr(Count)
        For i = 0 To Count
            Set Arr(i) = std_CallableArg.CreateFromText("ByRef Val" & i & " As Variant")
        Next i
    End If
    CreateArguments = Arr
End Function

Private Sub Class_Initialize()
    p_Execute = True
    p_AutoExecute = True
End Sub