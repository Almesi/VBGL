VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLShaderWorkflow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private Const LineEnd As String = ";" & vbCrLf
Private Const Incant As String = "    "

Public Enum VBGLShaderOperation
    VBGLShaderNothing      = 0
    VBGLShaderPass         = 1
    VBGLShaderAdd          = 2
    VBGLShaderAddWithValue = 3
    VBGLShaderUseOnOutput  = 4
    VBGLShaderReturn       = 5
    VBGLShaderCallFunc     = 6
    VBGLShaderMoveOutput   = 7
End Enum

Private p_WFType   As VBGLShaderOperation
Private p_Template As String
Private p_Vars()   As VBGLShaderVariable

Public Property Let WFType(n_WFType     As VBGLShaderOperation)               :     p_WFType     = n_WFType     : End Property
Public Property Let Template(n_Template As String)                            :     p_Template   = n_Template   : End Property
Public Property Let Vars(n_Vars()       As VBGLShaderVariable)                :     p_Vars       = n_Vars       : End Property
Public Property Let Var(Index           As Long, n_Var As VBGLShaderVariable) : Set p_Var(Index) = n_Var        : End Property

Public Property Get WFType()            As VBGLShaderOperation                :     WFType       = p_WFType     : End Property
Public Property Get Template()          As String                             :     Template     = p_Template   : End Property
Public Property Get Vars()              As VBGLShaderVariable()               :     Vars         = p_Vars       : End Property
Public Property Get Var(Index           As Long) As VBGLShaderVariable        : Set Var          = p_Var(Index) : End Property

Public Function Create(n_WFType As Operation, n_Template As String, ParamArray Variables() As Variant) As VBGLShaderWorkflow
    Set Create = New VBGLShaderWorkflow
    With Create
        .WFType = n_WFType
        .Template = n_Template
        Dim i As Long
        Dim Temp() As VBGLShaderVariable
        ReDim Temp(Ubound(Variables))
        For i = 0 To Ubound(Variables)
            Set Temp(i) = Variables(i)
        Next i
        .Vars = Temp
    End With
End Function

Public Function GetString(Text As String) As String
    Dim i As Long
    Dim NewLine As String
    GetString = Text
    NewLine = Template
    For i = 0 To VSize(Vars)
        NewLine = Replace(NewLine, "VAR" & i, TransformType(i)) 
    Next i
    Select Case WFType
        Case VBGLShaderNothing
        Case VBGLShaderPass
            GetString = GetString & Incant & NewLine & LineEnd
        Case VBGLShaderAdd
            NewLine = Var(0).DataType & " " & NewLine
            GetString = GetString & Incant & NewLine & LineEnd
        Case VBGLShaderAddWithValue
            NewLine = Var(0).DataType & " " & NewLine
            GetString = GetString & NewLine
        Case VBGLShaderUseOnOutput
            GetString = Replace(GetString, "GOAL", NewLine)
        Case VBGLShaderReturn
            GetString = GetString & Incant & NewLine & LineEnd
        Case VBGLShaderCallFunc
            GetString = GetString & Incant & NewLine & LineEnd
        Case VBGLShaderMoveOutput
            Dim StartPoint As Long  : StartPoint = InStr(1, GetString, Incant & Var(0).Name)
            Dim EndPoint   As Long  : EndPoint   = InStr(StartPoint, GetString, LineEnd)
            Dim Replacer   As String: Replacer   = MidP(GetString, StartPoint, EndPoint + Len(LineEnd) - 1)
            GetString = Replace(GetString, Replacer, Empty)
            GetString = GetString & Replacer
    End Select
End Function

Private Function TransformType(Index As Long) As String
    Dim Var0       As VBGLShaderVariable: Set Var0      = Var(0)
    Dim VarI       As VBGLShaderVariable: Set VarI      = Var(Index)
    Dim VAR0Size   As String            : VAR0Size      = GetNumericCharacters(Var0.DataType)
    Dim VARISize   As String            : VARISize      = GetNumericCharacters(VarI.DataType)
    Dim Offset     As Long
    If IsNumeric(VAR0Size) And IsNumeric(VARISize) Then
        Offset = CLng(VAR0Size) - CLng(VARISize)
    Else
        Offset = 0
    End If
    Dim ReturnType As String
    Select Case True 
        Case Var0.DataType Like "*vec*" And VarI.DataType Like "*mat*" : ReturnType = Replace(Var0.DataType , VAR0Size, "")  & VAR0Size
        Case Var0.DataType Like "*mat*" And VarI.DataType Like "*vec*" : ReturnType = Replace(VarI.DataType , VARISize, "")  & VAR0Size
        Case Else                                                      : ReturnType = Replace(Var0.DataType , VAR0Size , "") & VAR0Size
    End Select
    Select Case Offset
        Case +0: TransformType = VarI.Name
        Case +1: TransformType = ReturnType & "(" & VarI.Name & ", 1.0)"
        Case +2: TransformType = ReturnType & "(" & VarI.Name & ", 1.0, 1.0)"
        Case +3: TransformType = ReturnType & "(" & VarI.Name & ", 1.0, 1.0, 1.0)"
        Case -1: TransformType = ReturnType & "(" & VarI.Name & ")"
        Case -2: TransformType = ReturnType & "(" & VarI.Name & ")"
        Case -3: TransformType = ReturnType & "(" & VarI.Name & ")"
    End Select
End Function

Private Function MidP(Text As String, VAR1Point As Long, EndPoint As Long) As String
    MidP = Mid(Text, VAR1Point, (EndPoint - VAR1Point) + 1)
End Function

Private Function GetNumericCharacters(Text As String) As String
    Dim i As Integer
    Dim ch As String

    For i = 1 To Len(Text)
        ch = Mid(Text, i, 1)
        If ch Like "#" Then
            GetNumericCharacters = GetNumericCharacters & ch
        End If
    Next i
End Function

Private Function VSize(Arr() As VBGLShaderVariable)
    On Error Resume Next
    VSize = -1
    VSize = Ubound(Arr)
End Function