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
    VBGLShaderAssign       = 8
    VBGLShaderAddOutput    = 9
End Enum

Private p_WFType   As VBGLShaderOperation
Private p_Template As String
Private p_Vars()   As VBGLShaderVariable

Public Property Let WFType(n_WFType     As VBGLShaderOperation)               :     p_WFType     = n_WFType      : End Property
Public Property Let Template(n_Template As String)                            :     p_Template   = n_Template    : End Property
Public Property Let Var(Index           As Long, n_Var As VBGLShaderVariable) : Set p_Var(Index) = n_Var         : End Property

Public Property Get WFType()            As VBGLShaderOperation                :     WFType       = p_WFType      : End Property
Public Property Get Template()          As String                             :     Template     = p_Template    : End Property
Public Property Get Vars()              As VBGLShaderVariable()               :     Vars         = p_Vars        : End Property
Public Property Get Var(Index           As Long) As VBGLShaderVariable        : Set Var          = p_Vars(Index) : End Property

Public Sub LetVars(n_Vars() As VBGLShaderVariable)
    p_Vars = n_Vars
End Sub

Public Function Create(n_WFType As VBGLShaderOperation, n_Template As String, ParamArray Variables() As Variant) As VBGLShaderWorkflow
    Dim i As Long
    Dim Temp() As VBGLShaderVariable
    ReDim Temp(Ubound(Variables))
    For i = 0 To Ubound(Variables)
        Set Temp(i) = Variables(i)
    Next i
    Set Create = CreateArr(n_WFType, n_Template, Temp)
End Function

Public Function CreateArr(n_WFType As VBGLShaderOperation, n_Template As String, Variables() As VBGLShaderVariable) As VBGLShaderWorkflow
    Set CreateArr = New VBGLShaderWorkflow
    With CreateArr
        .WFType = n_WFType
        .Template = n_Template
        Call .LetVars(Variables)
    End With
End Function

Public Function Add(Arr() As VBGLShaderWorkflow, n_WFType As VBGLShaderOperation, n_Template As String, ParamArray Variables() As Variant) As VBGLShaderWorkflow
    Dim i As Long
    Dim Temp() As VBGLShaderVariable
    ReDim Temp(Ubound(Variables))
    For i = 0 To Ubound(Variables)
        Set Temp(i) = Variables(i)
    Next i
    Dim NewWF As VBGLShaderWorkflow
    Set NewWF = CreateArr(n_WFType, n_Template, Temp)
    Set Add = AddWorkflow(Arr, NewWF)
End Function

Public Function AddWorkflow(Arr() As VBGLShaderWorkflow, Value As VBGLShaderWorkflow) As VBGLShaderWorkflow
    Dim Size As Long : Size = USize(Arr) + 1
    ReDim Preserve Arr(Size)
    Set Arr(Size) = Value
    Set AddWorkflow = Value
End Function

Public Function GetString(ByVal Text As String) As String
    Dim NewLine As String
    NewLine = TransformVariables()
    Select Case WFType
        Case VBGLShaderNothing
        Case VBGLShaderPass
            Text = Text & Incant & NewLine & LineEnd
        Case VBGLShaderAdd
            NewLine = Var(0).DataType & " " & NewLine
            Text = Text & Incant & NewLine & LineEnd
        Case VBGLShaderAddWithValue
            NewLine = Var(0).DataType & " " & NewLine
            Text = Text & Incant & NewLine & LineEnd
        Case VBGLShaderUseOnOutput
            Dim Search   As String: Search   = Var(0).Name & " = "
            Dim Found    As Long  : Found    = InStr(1, Text, Search) + Len(Search)
            NewLine = Replace(NewLine, Var(0).Name, Empty)
            Text = MidP(Text, 1, Found - 1) & NewLine & MidP(Text, Found, Len(Text))
        Case VBGLShaderReturn
            Text = Text & Incant & "return " & NewLine & LineEnd
        Case VBGLShaderCallFunc
            Text = Text & Incant & NewLine & LineEnd
        Case VBGLShaderMoveOutput
            Dim StartPoint As Long  : StartPoint = InStr(1, Text, Incant & Var(0).Name)
            Dim EndPoint   As Long  : EndPoint   = InStr(StartPoint, Text, LineEnd)
            Dim Replacer   As String: Replacer   = MidP(Text, StartPoint, EndPoint + Len(LineEnd) - 1)
            Replacer = Replace(Replacer, "GOAL * ", Empty)
            Text = Replace(Text, Replacer, Empty)
            Text = Text & Replacer
        Case VBGLShaderAssign
            Text = Text & Incant & NewLine & LineEnd
        Case VBGLShaderAddOutput
            Text = Text & Incant & NewLine & LineEnd
    End Select
    GetString = Text
End Function

Private Function TransformVariables() As String
    Dim i As Long
    Dim NewLine As String
    If Template = Empty Then Exit Function
    NewLine = Template
    Dim ResultVar As VBGLShaderVariable
    Set ResultVar = Var(USize(Vars))
    For i = USize(Vars) To 1 Step-1
        Dim StartPoint  As Long  : StartPoint  = InStr(1, NewLine, "VAR" & i - 1)
        Dim EndPoint    As Long  : EndPoint    = InStr(1, NewLine, "VAR" & i)
        If EndPoint = 0 Then
            EndPoint = Len("VAR" & i - 1)
        Else
            EndPoint = EndPoint + Len("VAR" & i) - 1
        End If
        Dim Text         As String: Text         = MidP(NewLine, StartPoint, EndPoint)
        Set ResultVar = MakeNewVariable(Var(i - 1), ResultVar, i - 1, i, Text)
        NewLine = Replace(NewLine, Text, "VAR" & i - 1)
        'NewLine = Replace(NewLine, "VAR" & i - 1, ResultVar.Name)
    Next i
    TransformVariables = Replace(NewLine, "VAR0", ResultVar.Name)
End Function

Private Function MakeNewVariable(Var1 As VBGLShaderVariable, Var2 As VBGLShaderVariable, Index1 As Long , Index2 As Long, Text As String) As VBGLShaderVariable
    Dim State    As String: State    = "var"
    Dim DataType As String: DataType = Var1.DataType
    Dim Name     As String
    Name = Text
    Name = Replace(Name, "VAR" & Index1, Var1.Name)
    Name = Replace(Name, "VAR" & Index2, TransformType(Var1, Var2))
    Set MakeNewVariable = VBGLShaderVariable.Create(State, DataType, Name)
End Function

Private Function TransformType(Var1 As VBGLShaderVariable, Var2 As VBGLShaderVariable) As String
    ' To stop transformation of vec2 Texture into a vec4
    If Var2.Name Like "*Texture*" Then
        TransformType = Var2.Name
        Exit Function
    End If
    Dim VAR1Size   As String            : VAR1Size      = GetNumericCharacters(Var1.DataType)
    Dim Var2Size   As String            : Var2Size      = GetNumericCharacters(Var2.DataType)
    Dim Offset     As Long
    If IsNumeric(VAR1Size) And IsNumeric(Var2Size) Then
        Offset = CLng(VAR1Size) - CLng(Var2Size)
    Else
        Offset = 0
    End If
    Dim ReturnType As String
    Select Case True 
        Case Var1.DataType Like "*vec*" And Var2.DataType Like "*mat*" : ReturnType = Replace(Var1.DataType , VAR1Size, "")  & VAR1Size
        Case Var1.DataType Like "*mat*" And Var2.DataType Like "*vec*" : ReturnType = Replace(Var2.DataType , Var2Size, "")  & VAR1Size
        Case Else                                                      : ReturnType = Replace(Var1.DataType , VAR1Size , "") & VAR1Size
    End Select
    Select Case Offset
        Case +0: TransformType = Var2.Name
        Case +1: TransformType = ReturnType & "(" & Var2.Name & ", 1.0)"
        Case +2: TransformType = ReturnType & "(" & Var2.Name & ", 1.0, 1.0)"
        Case +3: TransformType = ReturnType & "(" & Var2.Name & ", 1.0, 1.0, 1.0)"
        Case -1: TransformType = ReturnType & "(" & Var2.Name & ")"
        Case -2: TransformType = ReturnType & "(" & Var2.Name & ")"
        Case -3: TransformType = ReturnType & "(" & Var2.Name & ")"
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

Private Function USize(Arr As Variant)
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr)
End Function