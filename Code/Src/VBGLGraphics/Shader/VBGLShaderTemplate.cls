VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLShaderTemplate"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private ThisFunc As VBGLShaderFunction
Private Functions() As VBGLShaderFunction

Private Inputt()     As VBGLShaderVariable
Private Output()     As VBGLShaderVariable

Private p_Version    As String
Private p_Pipeline   As String
Private p_ShaderName As String
Private p_NextShader As VBGLShaderTemplate

Public Property Let Version(n_Version       As String)            :     p_Version    = n_Version    : End Property
Public Property Let Pipeline(n_Pipeline     As String)            :     p_Pipeline   = n_Pipeline   : End Property
Public Property Let ShaderName(n_ShaderName As String)            :     p_ShaderName = n_ShaderName : End Property
Public Property Let NextShader(n_NextShader As VBGLShaderTemplate): Set p_NextShader = n_NextShader : End Property

Public Property Get Version()               As String             :     Version      = p_Version    : End Property
Public Property Get Pipeline()              As String             :     Pipeline     = p_Pipeline   : End Property
Public Property Get ShaderName()            As String             :     ShaderName   = p_ShaderName : End Property
Public Property Get NextShader()            As VBGLShaderTemplate : Set NextShader   = p_NextShader : End Property

Public Function Create(n_Pipeline As String, n_Version As String) As VBGLShaderTemplate
    Set Create = New VBGLShaderTemplate
    With Create
        .Pipeline = n_Pipeline
        .Version  = n_Version
        Dim FollowingPipeline As Long : FollowingPipeline = InStr(1, n_Pipeline, "-")

        If FollowingPipeline <> 0 Then
            .ShaderName = Mid(n_Pipeline, 1, FollowingPipeline - 1)
            Dim NewPipeline As String : NewPipeline = Mid(n_Pipeline, FollowingPipeline + 1, Len(n_Pipeline))
            .NextShader = .Create(NewPipeline, n_Version)
        Else
            .ShaderName = n_Pipeline
        End If
    End With
End Function

Public Sub SetUp(Layout As VBGLBufferLayout, Uniforms() As String)
    Call AddLayouts(Layout)
    Call SetUpAll(Uniforms)
End Sub



Private Sub AddLayouts(Layout As VBGLBufferLayout)
    Dim i As Long

    Dim PositionIndex As Long
    Dim TextureIndex  As Long
    Dim NormalIndex   As Long
    Dim ColorIndex    As Long
    Dim Index         As Long
    Dim Category      As String

    With Layout
        For i = 0 To .Size
            Category = .Element(i).GetCategory
            Select Case Category
                Case "Position" : Index = PositionIndex : PositionIndex = PositionIndex + 1
                Case "Texture"  : Index = TextureIndex  : TextureIndex  = TextureIndex  + 1
                Case "Normal"   : Index = NormalIndex   : NormalIndex   = NormalIndex   + 1
                Case "Color"    : Index = ColorIndex    : ColorIndex    = ColorIndex    + 1
            End Select
            Call VBGLShaderVariable.Add(Inputt, "layout (location = " & i & ") in", GetVarType(.Element(i)), "in" & ShaderName & Category & Index)
        Next i
    End With
End Sub

Private Sub SetUpAll(Uniforms() As String)
    Call SetOutput(ShaderName)
    Call AddVertexUniforms(Uniforms)
    Select Case ShaderName
        Case "Vertex"   : Call AddVertexWorkflows()
        Case "Fragment" : Call AddFragmentWorkflows()
    End Select
    Call GetOutputs()
    If Not NextShader Is Nothing Then Call NextShader.SetUpFromInput(CreateForInput(), Uniforms)
End Sub

' The returnValue of the Shader
Private Sub SetOutput(Shader As String)
    Select Case Shader
        Case "Vertex"   : ThisFunc.ReturnFunc = VBGLShaderVariable.Create("out", "vec4", "gl_Position")
        Case "Fragment" : ThisFunc.ReturnFunc = VBGLShaderVariable.Create("out", "vec4", "gl_FragColor")
    End Select
End Sub

Private Function GetVarType(Element As VBGLBufferElement) As String
    Dim Pre As String
    Select Case Element.DataType
        Case GL_DOUBLE        : Pre = "d"
        Case GL_FLOAT         : Pre = ""
        Case GL_UNSIGNED_INT  : Pre = "u"
    End Select
    GetVarType = Pre & "vec" & Element.GetTypeSize
End Function

Private Sub AddVertexUniforms(Uniforms() As String)
    Dim i As Long
    Dim Text() As String
    For i = 0 To Ubound(Uniforms)
        If Uniforms(i) <> Empty Then
            Text = Split(Uniforms(i), "|")
            Call AddVariable(Inputt, "uniform", Text(0), Text(1))
            If ShortenArray(Uniforms, i) = False Then Exit Sub
            i = i - 1
        Else
            Call ShortenArray(Uniforms, i)
            Exit For
        End If
    Next i
End Sub

Private Function ShortenArray(Arr() As String, Index As Long) As Boolean
    Dim i As Long
    Dim NeUSize As Long: NeUSize = Ubound(Arr) - 1
    Dim Temp() As String
    If NeUSize <> -1 Then
        ReDim Temp(NeUSize)
        Dim Counter As Long
        For i = 0 To NeUSize
            If Counter = Index Then Counter = Counter + 1
            Temp(i) = Arr(Counter)
            Counter = Counter + 1
        Next i
        ShortenArray = True
    End If
    Arr = Temp
End Function

Private Sub AddVertexWorkflows()
    Dim i As Long
    Dim Index As Long
    For i = 0 To VSize(Inputt)
        Dim State    As String : State = Inputt(i).State
        Dim Name     As String : Name  = Inputt(i).Name
        Select Case True
            Case State Like "*in*"
                Select Case True
                    Case Name Like "*Position*" Call VBGLShaderWorkflow.Create(ThisFunc.Workflows, VBGLShaderUseOnOutput, "VAR0 * VAR1", ThisFunc.ReturnFunc       , Inputt(i))
                    Case Name Like "*Texture*"  Call VBGLShaderWorkflow.Create(ThisFunc.Workflows, VBGLShaderPass       , "VAR0 = VAR1", ReverseVariable(Inputt(i)), Inputt(i))
                    Case Name Like "*Color*"    Call VBGLShaderWorkflow.Create(ThisFunc.Workflows, VBGLShaderPass       , "VAR0 = VAR1", ReverseVariable(Inputt(i)), Inputt(i))
                    Case Name Like "*Normal*"
                        If FindFunction("Ambient") <> -1 Or FindFunction("Diffuse") <> -1 Or FindFunction("Specular") <> -1 Then
                            Dim ColorResult   As VBGLShaderVariable: ColorResult = MakeVariable("var", "vec3", "ColorResult")
                            Dim AmbientColor  As VBGLShaderVariable
                            Dim DiffuseColor  As VBGLShaderVariable
                            Dim SpecularColor As VBGLShaderVariable
                            Dim LightPosition As VBGLShaderVariable
                            Dim LightColor    As VBGLShaderVariable

                            Call VBGLShaderWorkflow.Create(ThisFunc.Workflows, VBGLShaderAdd, "VAR0", ColorResult)
                            If FindFunction("Ambient")  <> -1 Then Call VBGLShaderWorkflow.Create(ThisFunc.Workflows, VBGLShaderPass, "VAR0 = VAR0", ColorResult, ReverseVariable(Inputt(i)))
                            If FindFunction("Diffuse")  <> -1 Then Call VBGLShaderWorkflow.Create(ThisFunc.Workflows, VBGLShaderPass, "VAR0 = VAR0", ColorResult, ReverseVariable(Inputt(i)))
                            If FindFunction("Specular") <> -1 Then Call VBGLShaderWorkflow.Create(ThisFunc.Workflows, VBGLShaderPass, "VAR0 = VAR0", ColorResult, ReverseVariable(Inputt(i)))
                        End If
                End Select
            Case State Like "uniform"
                Select Case True
                    Case Name Like "*Texture*"   ' Nothing
                    Case Else
                    Call VBGLShaderWorkflow.Create(ThisFunc.Workflows, VBGLShaderUseOnOutput, "VAR0 * VAR1", MakeVariable("var", "vec4", TransformType(ShaderOutput, Inputt(i))) , ShaderOutput)
                End Select
        End Select
    Next i
End Sub

Private Sub AddFragmentWorkflows()
    Dim i As Long
    Dim Index As Long
    For i = 0 To VSize(Inputt)
        Dim State    As String : State = Inputt(i).State
        Dim Name     As String : Name  = Inputt(i).Name
        Dim LastTexture As Long
        Dim LastNormal  As Long
        Select Case True
            Case State Like "*in*"
                Select Case True
                    Case Name Like "*Position*" ' Nothing(shoulnt exist at this point)
                    Case Name Like "*Texture*"
                        Dim Temp As VBGLShaderVariable
                        Temp = Inputt(i)
                        Temp.DataType = "vec4"
                        Call VBGLShaderWorkflow.Create(Workflows, VBGLShaderUseOnOutput, "VAR0 * texture(UNIFORM" & i & ", VAR1)" , Temp, ShaderOutput): LastTexture = i
                    Case Name Like "*Color*"
                        Call VBGLShaderWorkflow.Create(Workflows, VBGLShaderUseOnOutput, "VAR0 * VAR1", Inputt(i), ShaderOutput)
                    Case Name Like "*Normal*" And Not Name Like "*NormalM*"
                        If FindFunction("Ambient") <> -1 Or FindFunction("Diffuse") <> -1 Or FindFunction("Specular") <> -1 Then
                            'Vertex Handling of Normal
                        End If
                End Select
            Case State Like "uniform"
                Dim j As Long
                Select Case True
                    Case Name Like "*Texture*"
                        For j = 0 To USize(Workflows)
                            If Workflows(j).Template Like "*UNIFORM" & LastTexture & "*" Then
                                Workflows(j).Template = Replace(Workflows(j).Template, "UNIFORM" & LastTexture, Name)
                            End If
                        Next j
                    Case Name Like "*Normal*"
                        For j = 0 To USize(Workflows)
                            If Workflows(j).Template Like "*UNIFORM" & LastNormal & "*" Then
                                Workflows(j).Template = Replace(Workflows(j).Template, "UNIFORM" & LastNormal, Name)
                            End If
                        Next j
                    Case Else
                End Select
        End Select
    Next i
End Sub

Private Sub AddVertexNormal(CurrentIn As Long)
    Dim NormalModel As VBGLShaderVariable: NormalModel = MakeVariable("out", "vec3", "outVertexNormalM" & CLng(GetNumericCharacters(Inputt(CurrentIn).Name)))
    Dim Position    As VBGLShaderVariable: Position    = Inputt(FindVariable(Inputt, Replace(Inputt(0).Name, "Normal", "Position")))
    Dim FirstStep   As VBGLShaderVariable
    If FindVariable(Inputt, "Model") <> -1 Then
        Dim Model As VBGLShaderVariable
        Model      = Inputt(FindVariable(Inputt, "Model"))
        FirstStep  = MakeNewVariable("VAR0 * VAR1", Model, Position)
    Else
        FirstStep  = Inputt(CurrentIn)
    End If
    Call VBGLShaderWorkflow.Create(Workflows, VBGLShaderPass, "VAR0 = VAR1", FirstStep, NormalModel)
    Call VBGLShaderWorkflow.Create(Workflows, VBGLShaderPass, "VAR0 = VAR1", Inputt(CurrentIn), ReverseVariable(Inputt(CurrentIn)))
End Sub

Private Sub AddFragmentNormal(CurrentIn As Long, NormalIndex As Long)
    Dim Norm            As VBGLShaderVariable : Norm            = MakeVariable("var", "vec3", "norm"             & NormalIndex)
    Dim Ambient         As VBGLShaderVariable : Ambient         = MakeVariable("var", "vec3", "Ambient"          & NormalIndex)
    Dim LightColor      As VBGLShaderVariable : LightColor      = Inputt(FindVariable(Inputt, "LightColor"       & NormalIndex))
    Dim LightDirection  As VBGLShaderVariable : LightDirection  = MakeVariable("var", "vec3", "LightDirection"   & NormalIndex)
    Dim NormalM         As VBGLShaderVariable : NormalM         = Inputt(FindVariable(Inputt, "outVertexNormalM" & NormalIndex))
    Dim Diff            As VBGLShaderVariable : Diff            = MakeVariable("var", "float", "diff"            & NormalIndex)
    Dim Diffuse         As VBGLShaderVariable : Diffuse         = MakeVariable("var", "vec3", "Diffuse"          & NormalIndex)
    Dim Result          As VBGLShaderVariable : Result          = MakeVariable("var", "vec3", "Result"           & NormalIndex)

    Dim DiffuseResult   As VBGLShaderVariable : DiffuseResult   = MakeNewVariable("VAR0 * VAR1"              , LightColor, Diff)
    Dim NormLightResult As VBGLShaderVariable : NormLightResult = MakeNewVariable("max(dot(VAR0, VAR1), 0.0)", Norm, LightDirection)

    Call VBGLShaderWorkflow.Create(Workflows, "AddWithValue", "VAR0 = 0.2 * VAR1"                                          , LightColor             , Ambient)
    Call VBGLShaderWorkflow.Create(Workflows, "AddWithValue", "VAR0 = normalize(VAR1)"                                     , Inputt(CurrentIn)      , Norm)
    Call VBGLShaderWorkflow.Create(Workflows, "AddWithValue", "VAR0 = normalize(UNIFORM" & CurrentIn & " - VAR1)"          , NormalM                , LightDirection)
    Call VBGLShaderWorkflow.Create(Workflows, "AddWithValue", "VAR0 = VAR1"                                                , NormLightResult        , Diff)
    Call VBGLShaderWorkflow.Create(Workflows, "AddWithValue", "VAR0 = VAR1"                                                , DiffuseResult          , Diffuse)
    Call VBGLShaderWorkflow.Create(Workflows, "AddWithValue", "VAR0 = (Ambient" & NormalIndex & " + VAR1) * ObjectColor"   , Diffuse                , Result)
    Call VBGLShaderWorkflow.Create(Workflows, VBGLShaderUseOnOutput , "VAR0 * VAR1"                                               , Result                 , ShaderOutput)
    Call VBGLShaderWorkflow.Create(Workflows, "MoveOutput"  , Empty                                                         , Diffuse                , Diffuse)
End Sub

Private Sub GetOutputs()
    Dim i As Long
    For i = 0 To USize(Workflows)
        If Workflows(i).WFType = VBGLShaderPass Then
            Call AddVariable(Output, "out", Workflows(i).Goal.DataType, Replace(Workflows(i).Goal.Name, "in", "out"))
        End If
    Next i
End Sub





'Code
Public Function GetShader() As String
    GetShader   = "#version " & Version & vbCrLf
    GetShader   = GetShader & GetVariables(Inputt)
    GetShader   = GetShader & GetVariables(Output)
    GetShader   = GetShader & "void main()" & vbCrLf
    GetShader   = GetShader &  "{" & vbCrLf
    GetShader   = GetShader & Incant & ShaderOutput.Name & " = VAR0" & LineEnd
    GetShader   = CompleteWorkflow(GetShader)
    GetShader   = GetShader &  "}" & vbCrLf
    If Not NextShader Is Nothing Then GetShader   = GetShader & "|" & NextShader.GetShader
End Function

Private Function GetVariables(Arr() As VBGLShaderVariable) As String
    Dim i As Long
    For i = 0 To VSize(Arr)
        GetVariables = GetVariables & Arr(i).State & " " & Arr(i).DataType & " " & Arr(i).Name & LineEnd
    Next i
    GetVariables = GetVariables & vbCrLf
End Function

Private Function CompleteWorkflow(Func As Functionn, Text As String) As String
    Dim i As Long
    Dim NewLine As String
    CompleteWorkflow = Text
    For i = 0 To USize(Workflows)
        CompleteWorkflow = Func.Workflow(i).GetString(CompleteWorkflow)
    Next i
    CompleteWorkflow = Replace(CompleteWorkflow, "GOAL * ", "")
End Function

'Create next shader in pipeline

'State|DataType|Name/ 0
'State|DataType|Name/ 1
'State|DataType|Name/ 2
'State|DataType|Name/ 3
Public Sub SetUpFromInput(InputArr As String, Uniforms() As String)
    Dim Vars() As String
    Vars = Split(InputArr, "/")

    Dim i As Long
    For i = 0 To Ubound(Vars)
        Dim VarValues() As String
        VarValues = Split(Vars(i), "|")
        Call AddVariable(Inputt, "in", VarValues(1), VarValues(2))
    Next i
    Call SetUpAll(Uniforms)
End Sub

'State|DataType|Name/ 0
'State|DataType|Name/ 1
'State|DataType|Name/ 2
'State|DataType|Name/ 3
Private Function CreateForInput() As String
    Dim i As Long
    For i = 0 To VSize(Output)
        CreateForInput = CreateForInput & Output(i).State & "|" & Output(i).DataType & "|" & Output(i).Name & "/"
    Next i
    CreateForInput = Mid(CreateForInput, 1, Len(CreateForInput) - 1)
End Function






' Handle UDT
Private Sub VBGLShaderWorkflow.Create(WF() As VBGLShaderWorkflow, WFType As String, Template As String, ParamArray Vars() As Variant)
    Dim Size As Long: Size = USize(WF) + 1
    ReDim Preserve WF(Size)
    Set WF(Size) = New VBGLShaderWorkflow
    WF(Size).WFType   = WFType
    WF(Size).Template = Template
    Call WF(Size).AddVariable()

    
    Dim i As Long
    Dim Temp() As VBGLShaderVariable
    ReDim Temp(Ubound(Vars))
    For i = 0 To Ubound(Vars)
        Temp(i) = Vars(i)
    Next i
    WF(Size).Vars = Temp
End Sub
Private Function USize(Arr() As VBGLShaderWorkflow)
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr)
End Function

Private Function AddVariable(Shader() As VBGLShaderVariable, State As String, DataType As String, Name As String) As VBGLShaderVariable
    Dim Size As Long: Size = VSize(Shader) + 1
    ReDim Preserve Shader(Size)
    Shader(Size) = MakeVariable(State, DataType, Name)
    AddVariable = Shader(Size)
End Function
Private Function VSize(Arr() As VBGLShaderVariable)
    On Error Resume Next
    VSize = -1
    VSize = Ubound(Arr)
End Function

Private Function ReverseVariable(Var As VBGLShaderVariable) As VBGLShaderVariable
    If Var.State Like "*in*" Then
        ReverseVariable.State = "out"
        ReverseVariable.Name  = Replace(Var.Name, "in", "out")
    Else
        ReverseVariable.State = "in"
        ReverseVariable.Name  = Var.Name
    End If
    ReverseVariable.DataType = Var.DataType
End Function

Private Function FindVariable(Vars() As VBGLShaderVariable, Name As String) As Long
    Dim i As Long
    FindVariable = -1
    For i = 0 To VSize(Vars)
        If Vars(i).Name = Name Then
            FindVariable = i
            Exit For
        End If
    Next i
End Function

Private Function MakeVariable(State As String, DataType As String, Name As String) As VBGLShaderVariable
    MakeVariable.State    = State
    MakeVariable.DataType = DataType
    MakeVariable.Name     = Name
End Function

Private Function MakeNewVariable(Template As String, Goal As VBGLShaderVariable, VAR1 As VBGLShaderVariable) As VBGLShaderVariable
    Dim NewName     As String: NewName = TransformType(Goal, VAR1)
    Dim NewTemplate As String
    NewTemplate = Replace(Template, "GOAL", Goal.Name)
    NewTemplate = Replace(NewTemplate, "VAR1", NewName)
    MakeNewVariable.State    = "var"
    MakeNewVariable.DataType = Goal.DataType
    MakeNewVariable.Name     = NewTemplate
End Function

Private Function FindFunction(Name As String) As Long
    Dim i As Long
    FindFunction = -1
    For i = 0 To FSize(Functions)
        If Functions(i).Name = Name Then
            FindFunction = i
            Exit For
        End If
    Next i
End Function

Private Function FSize(Arr() As Functionn)
    On Error Resume Next
    FSize = -1
    FSize = Ubound(Arr)
End Function