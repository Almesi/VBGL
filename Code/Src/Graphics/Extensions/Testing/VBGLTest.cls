VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private p_Callable  As std_Callable
Private p_Name      As String
Private p_Result    As Variant
Private p_Errorr    As String
Private p_HasRun    As Boolean
Private p_Passed    As Boolean
Private p_StartTime As Single
Private p_EndTime   As Single


Public Property  Let Callable(ByVal     Value As std_Callable): Set p_Callable   = Value       : End Property
Public Property  Let Name(ByVal         Value As String)      : Let p_Name       = Value       : End Property
Private Property Let Result(ByVal       Value As Variant)     : Let p_Result     = Value       : End Property
Private Property Let Errorr(ByVal       Value As String)      : Let p_Errorr     = Value       : End Property
Private Property Let HasRun(ByVal       Value As Boolean)     : Let p_HasRun     = Value       : End Property
Private Property Let Passed(ByVal       Value As Boolean)     : Let p_Passed     = Value       : End Property
Private Property Let StartTime(ByVal    Value As Single)      : Let p_StartTime  = Value       : End Property
Private Property Let EndTime(ByVal      Value As Single)      : Let p_EndTime    = Value       : End Property

Public Property Get Callable()                As std_Callable : Set Callable     = p_Callable  : End Property
Public Property Get Name()                    As String       : Let Name         = p_Name      : End Property
Public Property Get Result()                  As Variant      : Let Result       = p_Result    : End Property
Public Property Get Errorr()                  As String       : Let Errorr       = p_Errorr    : End Property
Public Property Get HasRun()                  As Boolean      : Let HasRun       = p_HasRun    : End Property
Public Property Get Passed()                  As Boolean      : Let Passed       = p_Passed    : End Property
Public Property Get StartTime()               As Single       : Let StartTime    = p_StartTime : End Property
Public Property Get EndTime()                 As Single       : Let EndTime      = p_EndTime   : End Property

Public Function Create(ByVal n_Callable As std_Callable, Optional ByVal n_Name As String = Empty) As VBGLTest
    Set Create = New VBGLTest
    With Create
        .Callable = n_Callable
        .Name = IIf(n_Name = Empty, n_Callable.Name, n_Name)
    End With
End Function

Public Function Run(ByVal Expected As Variant, ParamArray Args() As Variant) As Boolean

    Dim i As Long
    Dim n_Args() As Variant
    n_Args = Args

    On Error GoTo Error
    HasRun = True
    StartTime = Timer
    Result = Callable.RunArr(n_Args)
    EndTime = Timer
    Passed = True
    If IsMissing(Expected) Then
        Run = Passed
    Else
        Run = VBGLCompare(Result, Expected)
    End If
    HasRun = True
    Exit Function

    Error:
    Errorr = Err.Description
End Function
Public Function Assert(ByVal Expected As Variant) As Boolean
    Assert = Run(Expected)
    If Assert = False Then
        Debug.Assert False
    ElseIf CBool(Result) = False Then
        Debug.Assert False
    End If
End Function

Public Function RunTime() As Single
    RunTime = EndTime - StartTime
End Function