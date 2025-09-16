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

Implements VBGLIShaderElement

Private Const LineEnd As String = ";" & vbCrLf
Private Const Incant As String = "    "

Public Enum VBGLShaderOperation
    VBGLShaderNothing      = 00 ' Completely useless
    VBGLShaderPass         = 01 ' Used by VBGLShaderTemplate to pass the Variable to the next shader
    VBGLShaderAdd          = 02 ' Declares Variable
    VBGLShaderAddWithValue = 03 ' Declares Variable and assigns it a Value
    VBGLShaderUseOnOutput  = 04 ' Will work the variable(s) into the outputting variable (only void main functions)
    VBGLShaderReturn       = 05 ' Will work the variable(s) into the outputting variable (every custom function)
    VBGLShaderCallFunc     = 06 '
    VBGLShaderMoveOutput   = 07 ' No matter where the output variable is located, this will move it to the bottom of the current function
    VBGLShaderAssign       = 08 '
    VBGLShaderAddOutput    = 09 ' Adds basic output variable to function but doesnt assign value. is a must in void main functions
    VBGLShaderStatement    = 10 '
    VBGLShaderCondition    = 11 '
    VBGLShaderCompare      = 12 '
    VBGLShaderIncrement    = 13 ' The first Variable is also the second variable, as it will increment itself with its operator and the second variable
End Enum

Private p_WFType   As VBGLShaderOperation
Private p_Template As String
Private p_Vars     As VBGLShaderElementCollection

Public Property Let WFType(ByVal n_WFType          As VBGLShaderOperation)          : Let p_WFType      = n_WFType      : End Property
Public Property Let Template(ByVal n_Template      As String)                       : Let p_Template    = n_Template    : End Property
Public Property Let Vars(ByVal n_Vars              As VBGLShaderElementCollection)  : Set p_Vars        = n_Vars        : End Property

Public Property Get WFType()                       As VBGLShaderOperation           : Let WFType        = p_WFType      : End Property
Public Property Get Template()                     As String                        : Let Template      = p_Template    : End Property
Public Property Get Vars()                         As VBGLShaderElementCollection   : Set Vars          = p_Vars        : End Property

Private Function VBGLIShaderElement_GetVariable() As VBGLShaderVariable
    Dim NewTemplate As String
    NewTemplate = TransformVariableOperators(Template)
    Set VBGLIShaderElement_GetVariable = VBGLShaderVariable.Create("var", "workflow", Vars.Transform(NewTemplate).Name)
End Function
Private Function VBGLIShaderElement_GetVariableCall(ByVal WithReturnType As Boolean) As String
    Dim Result As String
    Dim Variable As VBGLShaderVariable
    Set Variable = VBGLIShaderElement_GetVariable
    If WithReturnType Then Result = Variable.ReturnType & " "
    Result = Result & Variable.Name
    VBGLIShaderElement_GetVariableCall = Result
End Function
Private Function VBGLIShaderElement_GetVariableAll() As String
    VBGLIShaderElement_GetVariableAll = VBGLIShaderElement_GetVariableCall
End Function
Private Function VBGLIShaderElement_Element() As Variant
    Set VBGLIShaderElement_Element = Me
End Function

Public Function CreateElement(ByVal n_WFType As VBGLShaderOperation, ByVal n_Template As String, ParamArray Variables() As Variant) As VBGLIShaderElement
    Dim i As Long
    Dim Temp() As VBGLIShaderElement
    Dim Size As Long
    Size = Ubound(Variables)
    If Size <> -1 Then ReDim Temp(Size) 
    For i = 0 To Size
        Set Temp(i) = Variables(i)
    Next i
    Dim TempColl As VBGLShaderElementCollection
    Set TempColl = VBGLShaderElementCollection.CreateArr(Temp)
    Set CreateElement = CreateArr(n_WFType, n_Template, TempColl)
End Function

Public Function Create(ByVal n_WFType As VBGLShaderOperation, ByVal n_Template As String, ParamArray Variables() As Variant) As VBGLShaderWorkflow
    Dim i As Long
    Dim Temp() As VBGLIShaderElement
    Dim Size As Long
    Size = Ubound(Variables)
    If Size <> -1 Then ReDim Temp(Size) 
    For i = 0 To Size
        Set Temp(i) = Variables(i)
    Next i
    Dim TempColl As VBGLShaderElementCollection
    Set TempColl = VBGLShaderElementCollection.CreateArr(Temp)
    Set Create = CreateArr(n_WFType, n_Template, TempColl)
End Function

Public Function CreateArr(ByVal n_WFType As VBGLShaderOperation, ByVal n_Template As String, ByVal Variables As VBGLShaderElementCollection) As VBGLShaderWorkflow
    Set CreateArr = New VBGLShaderWorkflow
    With CreateArr
        .WFType = n_WFType
        .Vars = Variables
        .Template = StdTemplate(n_WFType, n_Template, Variables)
    End With
End Function

'Always send same size for both arrays. Nothing for else-case
Public Function CreateCondition(ByVal Conditions As VBGLShaderElementCollection, ByVal Code As VBGLShaderElementCollection) As VBGLShaderWorkflow
    Dim NewVars() as VBGLIShaderElement
    Call VBGLIntertwine(NewVars, Conditions.Elements, Code.Elements)
    Dim NewCollection As VBGLShaderElementCollection
    Set NewCollection = VBGLShaderElementCollection.CreateArr(NewVars)
    Set CreateCondition = CreateArr(VBGLShaderCondition, Empty, NewCollection)
End Function

Public Function GetString(ByVal Text As String, ByVal Level As Long) As String
    Dim Temp As Variant
    Dim NewLine As String
    NewLine = TransformVariableOperators(Template)
    Set Temp = Vars.Transform(NewLine)
    If IsSomething(Temp) Then NewLine = Temp.Name
    Select Case WFType
        Case VBGLShaderNothing
        Case VBGLShaderPass         : Text = AddNewLine(Text, NewLine, Level)
        Case VBGLShaderAdd          : Text = AddNewLine(Text, NewLine, Level)
        Case VBGLShaderAddWithValue : Text = AddNewLine(Text, NewLine, Level)
        Case VBGLShaderUseOnOutput  : Text = HandleUseOnOutput(Text, NewLine, Vars.Element(0).GetVariable.Name)
        Case VBGLShaderReturn       : Text = AddNewLine(Text, NewLine, Level)
        Case VBGLShaderCallFunc     : Text = AddNewLine(Text, NewLine, Level)
        Case VBGLShaderMoveOutput   : Text = HandleMoveOnOutput(Text, Vars.Element(0).GetVariable.Name)
        Case VBGLShaderAssign       : Text = AddNewLine(Text, NewLine, Level)
        Case VBGLShaderAddOutput    : Text = AddNewLine(Text, NewLine, Level)
        Case VBGLShaderStatement    : Text = AddNewLine(Text, NewLine, Level)
        Case VBGLShaderCondition
            NewLine = Replace(NewLine, Incant, Incantate(Level))
            Text = AddNewLine(Text, NewLine, Level)
        Case VBGLShaderCompare      : Text = AddNewLine(Text, NewLine, Level)
        Case VBGLShaderIncrement    : Text = AddNewLine(Text, NewLine, Level)
    End Select
    GetString = Text
End Function

Private Function AddNewLine(ByVal Text As String, ByVal NewText As String, ByVal Level As Long) As String
    AddNewLine = Text & ReplaceIncantate(NewText, Level) & LineEnd
End Function

Private Function Incantate(ByVal Level As Long) As String
    Dim i As Long
    Dim Result As String
    For i = 1 To Level
        Result = Result & Incant
    Next i
    Incantate = Result
End Function

Private Function ReplaceIncantate(ByVal Text As String, ByVal Level As Long) As String
    Dim Result As String
    Dim Incantion As String
    Incantion = LastIncant(Text)
    Result = Replace(Text, Incantion, Incantion & Incantate(Level))
    
    Dim Lines() As String
    Lines = Split(Result, vbCrLf)

    Dim i As Long
    Result = Empty
    For i = 0 To Ubound(Lines)
        If Ubound(Lines) <> i Then
            Result = Result & Incantate(Level) & Lines(i) & vbCrLf
        Else
            Result = Result & Incantate(Level) & Lines(i)
        End If
    Next i
    ReplaceIncantate = Result
End Function

Private Function LastIncant(ByVal Text As String) As String
    Dim i As Long
    Dim CurrentIncant As String
    CurrentIncant = Incantate(1)
    Do While InStr(1, Text, CurrentIncant)
        CurrentIncant = CurrentIncant & Incant
        i = i + 1
    Loop
    LastIncant = Incantate(i)
End Function

Private Function StdTemplate(ByVal n_WFType As VBGLShaderOperation, ByVal n_Template As String, ByVal Variables As VBGLShaderElementCollection) As String
    Dim Result As String
    Dim StartIndex As Long
    If n_Template <> Empty Then
        Result = n_Template
    Else
        Select Case n_WFType
            Case VBGLShaderNothing      : StartIndex = 0: Result = ""
            Case VBGLShaderPass         : StartIndex = 2: Result = "VAR0 = VAR1REST"
            Case VBGLShaderAdd          : StartIndex = 0: Result = "TVAR0 VAR0"
            Case VBGLShaderAddWithValue : StartIndex = 2: Result = "TVAR0 VAR0 = VAR1REST"
            Case VBGLShaderUseOnOutput  : StartIndex = 2: Result = "VAR0 = VAR1 OVAR1REST"
            Case VBGLShaderReturn       : StartIndex = 1: Result = "return VAR0REST"
            Case VBGLShaderCallFunc     : StartIndex = 2: Result = "VAR0 = VAR1REST"
            Case VBGLShaderMoveOutput   : StartIndex = 0: Result = ""
            Case VBGLShaderAssign       : StartIndex = 2: Result = "VAR0 = VAR1REST"
            Case VBGLShaderAddOutput    : StartIndex = 0: Result = "VAR0 = "
            Case VBGLShaderStatement    : StartIndex = 2: Result = "VAR0 = VAR1REST"
            Case VBGLShaderCondition    : StartIndex = 2: Result = TemplateCondition
            Case VBGLShaderCompare      : StartIndex = 2: Result = "VAR0 == VAR1REST"
            Case VBGLShaderIncrement    : StartIndex = 2: Result = "VAR0 = VAR0 OVAR0 VAR1REST"
        End Select
    End If
    StdTemplate = Replace(Result, "REST", StdTemplateRest(n_WFType, StartIndex, Variables))
End Function

Private Function StdTemplateRest(ByVal n_WFType As VBGLShaderOperation, ByVal StartIndex As Long, ByVal Variables As VBGLShaderElementCollection) As String
    Dim i As Long
    Dim Result As String
    For i = StartIndex To Variables.Size
        Select Case n_WFType
            Case VBGLShaderNothing      : Result = Result & " " & ""
            Case VBGLShaderPass         : Result = Result & " " & "OVAR" & i-1 & " VAR"  & i
            Case VBGLShaderAdd          : Result = Result & " " & "OVAR" & i-1 & " VAR"  & i
            Case VBGLShaderAddWithValue : Result = Result & " " & "OVAR" & i-1 & " VAR"  & i
            Case VBGLShaderUseOnOutput  : Result = Result & " " & "VAR"  & i   & " OVAR" & i
            Case VBGLShaderReturn       : Result = Result & " " & "OVAR" & i-1 & " VAR"  & i
            Case VBGLShaderCallFunc     : Result = Result & " " & "OVAR" & i-1 & " VAR"  & i
            Case VBGLShaderMoveOutput   : Result = Result & " " & ""
            Case VBGLShaderAssign       : Result = Result & " " & "OVAR" & i-1 & " VAR"  & i
            Case VBGLShaderAddOutput    : Result = Result & " " & "VAR"  & i   & " OVAR" & i
            Case VBGLShaderStatement    : Result = Result & " " & "OVAR" & i-1 & " VAR"  & i
            Case VBGLShaderCondition    : Result = Result & ""  & TemplateConditionRest(i, Variables)
            Case VBGLShaderCompare      : Result = Result & " " & " && " & "VAR" & i & " == " & "VAR" & i + 1
            Case VBGLShaderIncrement    : Result = Result & " " & "OVAR0" & " VAR" & i
        End Select
    Next i
    StdTemplateRest = Result
End Function

Private Function HandleUseOnOutput(ByVal Text As String, ByVal CurrentTemplate As String, ByVal Name As String) As String
    Dim Search As String
    Dim Found  As Long
    Dim Result As String

    Search   = Name & " = "
    Found    = InStr(1, Text, Search) + Len(Search)
    Result   = Replace(CurrentTemplate, Search, Empty)
    If Found = InStr(Found, Text, LineEnd) Then
        Result = VBGLMidP(Result, 1, Len(Result) - Len(vbCrLf))
    End If
    Result = VBGLMidP(Text, 1, Found - 1) & Result & VBGLMidP(Text, Found, Len(Text))
    HandleUseOnOutput = Result
End Function

Private Function HandleMoveOnOutput(ByVal Text As String, ByVal Name As String)
    Dim StartPoint As Long
    Dim EndPoint   As Long
    Dim Replacer   As String
    Dim Result     As String

    StartPoint         = FindStartOutput(Text, InStr(1, Text, Name))
    EndPoint           = InStr(StartPoint, Text, LineEnd)
    Replacer           = VBGLMidP(Text, StartPoint, EndPoint + Len(LineEnd) - 1)
    Result             = Replace(Text, Replacer, Empty)
    HandleMoveOnOutput = Result & Replacer
End Function

Private Function FindStartOutput(ByVal Text As String, ByVal CurrentPoint As Long) As Long
    Dim i As Long
    For i = CurrentPoint - Len(vbCrLF) To 0 Step -1
        If Mid(Text, i, Len(vbCrLF)) = vbCrLf Then
            FindStartOutput = i + Len(vbCrLf)
            Exit Function
        End If
    Next i
End Function

Private Function TemplateCondition() As String
    TemplateCondition =                "if(VAR0){" & vbCrLf  & _
                        Incantate(1) & "VAR1"      & LineEnd & _
                        "}REST"
End Function

Private Function TemplateConditionRest(ByVal Index As Long, ByVal Conditions As VBGLShaderElementCollection) As String
    Dim Result As String
    If Index Mod 2 = 0 Then
        If IsSomething(Conditions.Element(Index)) Then
            Result = "elseif(VAR" & Index & "){" & vbCrLf
        Else
            Result = "else{" & vbCrLf
        End If
    Else
        Result = Incantate(1) & "VAR" & Index & LineEnd
        Result = Result & "}"
    End If
    TemplateConditionRest = Result
End Function

Private Function TransformVariableOperators(ByVal Text As String) As String
    Dim i As Long
    Dim Result As String
    Dim Current As VBGLIShaderElement
    If Text = Empty Then Exit Function
    Result = Text
    For i = 0 To Vars.Size
        Set Current = Vars.Element(i)
        If IsSomething(Current) Then
            Result = Replace(Result, "OVAR" & i, Current.GetVariable().Operator)
            Result = Replace(Result, "TVAR" & i, Current.GetVariable().ReturnType)
        End If
    Next i
    TransformVariableOperators = Result
End Function

Public Function Add(ByRef Arr() As VBGLIShaderElement, ByVal Value As VBGLIShaderElement) As VBGLIShaderElement
    Dim Size As Long: Size = USize(Arr) + 1
    ReDim Preserve Arr(Size)
    Set Arr(Size) = Value
    Set Add = Value
End Function