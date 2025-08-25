VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "std_Error"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Category As String
Private p_Severity As String
Private p_Identity As String
Private p_Template As String
Private p_Handle   As String
Private p_Values() As IErrorInterpret

Public Property Let Category(n_Category  As String)         :    p_Category  = n_Category      : End Property
Public Property Let Severity(n_Severity  As String)         :    p_Severity  = n_Severity      : End Property
Public Property Let Identity(n_Identity  As String)         :    p_Identity  = n_Identity      : End Property
Public Property Let Template(n_Template  As String)         :    p_Template  = n_Template      : End Property
Public Property Let Handle(n_Handle      As String)         :    p_Handle    = n_Handle        : End Property
Public Property Let Values(n_Values      As Variant)        :    p_Values    = n_Values        : End Property

Public Property Get Category()            As String         :     Category   = p_Category      : End Property
Public Property Get Severity()            As String         :     Severity   = p_Severity      : End Property
Public Property Get Identity()            As String         :     Identity   = p_Identity      : End Property
Public Property Get Template()            As String         :     Template   = p_Template      : End Property
Public Property Get Handle()              As String         :     Handle     = p_Handle        : End Property
Public Property Get Values()              As Variant        :     Values     = p_Values        : End Property
Public Property Get Value(Index As Long)  As IErrorInterpret: Set Value      = p_Values(Index) : End Property

Public Function Create(n_Category As String, n_Severity As String, n_Identity As String, n_Template As String, n_Handle As String, ParamArray n_Values() As Variant) As std_Error
    Dim i As Long
    Dim Temp() As IErrorInterpret
    If Ubound(n_Values) >= 0 Then
        ReDim Temp(Ubound(n_Values))
        For i = 0 To Ubound(n_Values)
            If TypeName(n_Values(i)) = "IErrorInterpret" Then
                Set Temp(i) = n_Values(i)
            Else
                Set Temp(i) = std_ErrorInterpret.Create(n_Values(i))
            End If 
        Next i
    End If
    Set Create = CreateArr(n_Category, n_Severity, n_Identity, n_Template, n_Handle, Temp)
End Function

Public Function CreateArr(n_Category As String, n_Severity As String, n_Identity As String, n_Template As String, n_Handle As String, n_Values() As IErrorInterpret) As std_Error
    Set CreateArr = New std_Error
    With CreateArr
        .Category = n_Category
        .Severity = n_Severity
        .Identity = n_Identity
        .Template = n_Template
        .Handle   = n_Handle
        .Values   = n_Values
    End With
End Function

Public Function CreateArrVar(n_Category As String, n_Severity As String, n_Identity As String, n_Template As String, n_Handle As String, n_Values() As Variant) As std_Error
    Dim i As Long
    Dim Temp() As IErrorInterpret
    ReDim Temp(Ubound(n_Values))
    For i = 0 To Ubound(n_Values)
        Set Temp(i) = std_ErrorInterpret.Create(n_Values)
    Next i
    Set CreateArrVar = CreateArr(n_Category, n_Severity, n_Identity, n_Template, n_Handle, Temp)
End Function

Public Function HandleDebug() As String
    If Handle <> Empty Then Call Application.Run(Handle)
    HandleDebug = Message()
End Function

Public Function Message() As String
    Dim Result As String
    Result = Result & "Category: " & Category & "|"
    Result = Result & "Severity: " & Severity & "|"
    Result = Result & "Identity: " & Identity & "|"
    Result = Result & "Template: " & Template & "|"

    Dim i As Long
    For i = 0 To Ubound(Values)
        Result = Replace(Result, "VAR" & i, Value(i).Interpret)
    Next i
    Message = Result
End Function