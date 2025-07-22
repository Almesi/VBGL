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

Private Const LineEnd As String = ";" & vbCrLf
Private Const Incant As String = "    "

Private ThisFunc    As VBGLShaderFunction
Private Functions() As VBGLShaderFunction

Private Inputt()     As VBGLShaderVariable
Private Output()     As VBGLShaderVariable
Private Workflows()  As VBGLShaderWorkflow

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

Public Function AddFunction(Value As VBGLShaderFunction)
    Dim Size As Long: Size = USize(Functions) + 1
    ReDim Preserve Functions(Size)
    Set Functions(Size) = Value
    Set AddFunction = Value
End Function

Public Sub SetUp(Layout As VBGLLayout, Uniforms() As VBGLShaderVariable)
    Call AddLayouts(Layout)
    Call SetUpNext(Inputt, Uniforms)
End Sub

Private Sub AddLayouts(Layout As VBGLLayout)
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

Public Sub SetUpNext(Inputs() As VBGLShaderVariable, Uniforms() As VBGLShaderVariable)
    Call SetOutput(ShaderName)
    Inputt = Inputs
    Workflows = ThisFunc.Workflows
    Call AddUniforms(Uniforms)
    Select Case ShaderName
        Case "Vertex"   : Call AddVertexWorkflows()
        Case "Fragment" : Call AddFragmentWorkflows()
    End Select
    Call GetOutputs()
    Call ThisFunc.LetWorkflows(Workflows)
    If Not NextShader Is Nothing Then Call NextShader.SetUpNext(ReverseVariables(Output), Uniforms)
End Sub

' The returnValue of the Shader
Private Sub SetOutput(Shader As String)
    Set ThisFunc = New VBGLShaderFunction
    Select Case Shader
        Case "Vertex"
            ThisFunc.ReturnFunc = VBGLShaderVariable.Create("out", "vec4", "gl_Position")
            ThisFunc.ReturnType = "void"
            ThisFunc.Name = "main"
        Case "Fragment"
            ThisFunc.ReturnFunc = VBGLShaderVariable.Create("out", "vec4", "gl_FragColor")
            ThisFunc.ReturnType = "void"
            ThisFunc.Name = "main"
    End Select
End Sub

Private Function GetVarType(Element As VBGLElement) As String
    Dim Pre As String
    Select Case Element.DataType
        Case GL_DOUBLE        : Pre = "d"
        Case GL_FLOAT         : Pre = ""
        Case GL_UNSIGNED_INT  : Pre = "u"
    End Select
    GetVarType = Pre & "vec" & Element.GetTypeSize
End Function



Private Sub AddVertexWorkflows()
    Dim i As Long
    Dim Index As Long
    Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderAddOutput, "VAR0 = " , ThisFunc.ReturnFunc, ThisFunc.ReturnFunc)
    For i = 0 To USize(Inputt)
        Dim State    As String : State = Inputt(i).State
        Dim Name     As String : Name  = Inputt(i).Name
        Select Case True
            Case State Like "*in*"
                Select Case True
                    Case Name Like "*Position*" : Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderUseOnOutput, "VAR0 * VAR1", ThisFunc.ReturnFunc, Inputt(i))
                    Case Name Like "*Texture*"  : Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderPass       , "VAR0 = VAR1", ReverseVariable(Inputt(i)), Inputt(i))
                    Case Name Like "*Color*"    : Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderPass       , "VAR0 = VAR1", ReverseVariable(Inputt(i)), Inputt(i))
                    Case Name Like "*Normal*"   : Call VertexNormal(Inputt(i))
                End Select
            Case State Like "uniform"
                Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderUseOnOutput, "VAR0 * VAR1", ThisFunc.ReturnFunc, Inputt(i))
        End Select
    Next i
    Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderMoveOutput, Empty , ThisFunc.ReturnFunc, ThisFunc.ReturnFunc)
End Sub

Private Sub AddFragmentWorkflows()
    Dim i As Long
    Dim Index As Long
    Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderAddOutput, "VAR0 = " , ThisFunc.ReturnFunc, ThisFunc.ReturnFunc)
    For i = 0 To USize(Inputt)
        Dim State    As String : State = Inputt(i).State
        Dim Name     As String : Name  = Inputt(i).Name
        Dim LastTexture As Long
        Dim LastNormal  As Long
        Select Case True
            Case State Like "*in*"
                Select Case True
                    Case Name Like "*Position#*" ' Nothing(shoulnt exist at this point)
                    Case Name Like "*Texture*"
                        Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderUseOnOutput, "VAR0 * texture(UNIFORM" & i & ", VAR1)", ThisFunc.ReturnFunc, Inputt(i)): LastTexture = i
                    Case Name Like "*Color*"
                        Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderUseOnOutput, "VAR0 * VAR1", Inputt(i), ThisFunc.ReturnFunc)
                    Case Name Like "*Normal*"
                        Call FragmentNormal(Inputt(i))
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
                    Case Else
                End Select
        End Select
    Next i
    Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderMoveOutput, Empty , ThisFunc.ReturnFunc, ThisFunc.ReturnFunc)
End Sub

Private Sub VertexNormal(CurrentVar As VBGLShaderVariable)
    Dim Position As VBGLShaderVariable
    Set Position = VBGLShaderVariable.Create(CurrentVar.State, CurrentVar.DataType, Replace(CurrentVar.Name, "Normal", "Position"))
    Dim FragmentPosition As VBGLShaderVariable
    Set FragmentPosition = VBGLShaderVariable.Create("out", "vec3", "FragmentPosition")
    Dim Model As VBGLShaderVariable
    Set Model = VBGLShaderVariable.Find(Inputt, "Model")
    If Not Model Is Nothing Then
        Dim NormalMatrix As VBGLShaderVariable: Set NormalMatrix = VBGLShaderVariable.Create(Model.State, "mat3", Model.Name)
        Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderPass, "VAR0 = VAR1 * VAR2", FragmentPosition, Model, Position)
        Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderPass, "VAR0 = mat3(transpose(inverse(VAR1))) * VAR2", ReverseVariable(CurrentVar), NormalMatrix, CurrentVar)
    Else
        Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderPass, "VAR0 = VAR1", FragmentPosition, Position)
        Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderPass, "VAR0 = VAR1", ReverseVariable(CurrentVar), CurrentVar)
    End If
End Sub

Private Sub FragmentNormal(CurrentVar As VBGLShaderVariable)
    Dim AmbientColor As VBGLShaderVariable
    Set AmbientColor = VBGLShaderVariable.Find(Inputt, "AmbientColor")
    Dim AmbientFunction  As VBGLShaderFunction
    If Not AmbientColor Is Nothing Then Set AmbientFunction = AddFunction(VBGLShaderFunction.CreateAmbient())

    Dim DiffuseColor As VBGLShaderVariable
    Set DiffuseColor = VBGLShaderVariable.Find(Inputt, "DiffuseColor")
    Dim DiffuseFunction  As VBGLShaderFunction
    If Not DiffuseColor Is Nothing Then Set DiffuseFunction = AddFunction(VBGLShaderFunction.CreateDiffuse())

    Dim SpecularColor As VBGLShaderVariable
    Set SpecularColor = VBGLShaderVariable.Find(Inputt, "SpecularColor")
    Dim SpecularFunction  As VBGLShaderFunction
    If Not SpecularColor Is Nothing Then Set SpecularFunction = AddFunction(VBGLShaderFunction.CreateSpecular())


    If AmbientFunction Is Nothing And DiffuseFunction Is Nothing And SpecularFunction Is Nothing Then
        Else
        Dim ColorResult      As VBGLShaderVariable: Set ColorResult      = VBGLShaderVariable.Create("var", "vec3", "ColorResult")

        Dim FragmentPosition      As VBGLShaderVariable: Set FragmentPosition = VBGLShaderVariable.Find(Inputt, "FragmentPosition") : If FragmentPosition Is Nothing Then Set FragmentPosition   = VBGLShaderVariable.Create("vec3" , "var", "vec3(0.0, 0.0, 0.0)")
        Dim ViewPosition          As VBGLShaderVariable: Set ViewPosition     = VBGLShaderVariable.Find(Inputt, "ViewPosition")     : If ViewPosition     Is Nothing Then Set ViewPosition       = VBGLShaderVariable.Create("vec3" , "var", "vec3(0.0, 0.0, 0.0)")
        Dim AmbientFactor         As VBGLShaderVariable: Set AmbientFactor    = VBGLShaderVariable.Find(Inputt, "AmbientFactor")    : If AmbientFactor    Is Nothing Then Set AmbientFactor      = VBGLShaderVariable.Create("float", "var", "0.2")
        Dim SpecularFactor        As VBGLShaderVariable: Set SpecularFactor   = VBGLShaderVariable.Find(Inputt, "SpecularFactor")   : If SpecularFactor   Is Nothing Then Set SpecularFactor     = VBGLShaderVariable.Create("float", "var", "0.1")
        Dim LightPosition         As VBGLShaderVariable: Set LightPosition    = VBGLShaderVariable.Find(Inputt, "LightPosition")    : If LightPosition    Is Nothing Then Set LightPosition      = VBGLShaderVariable.Create("vec3" , "var", "vec3(0.0, 0.0, 0.0)")
        Dim LightColor            As VBGLShaderVariable: Set LightColor       = VBGLShaderVariable.Find(Inputt, "LightColor")       : If LightColor       Is Nothing Then Set LightColor         = VBGLShaderVariable.Create("vec3" , "var", "vec3(1.0, 1.0, 1.0)")
        Dim Shininess             As VBGLShaderVariable: Set Shininess        = VBGLShaderVariable.Find(Inputt, "Shininess")        : If Shininess        Is Nothing Then Set Shininess          = VBGLShaderVariable.Create("float", "var", "32")

        Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderAddWithValue, "VAR0 = vec3(0.0, 0.0, 0.0)", ColorResult)
        If Not AmbientFunction  Is Nothing Then Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderAssign, "VAR0 = VAR1 + Ambient(VAR2, VAR3)"                                , ColorResult, ColorResult, AmbientColor, AmbientFactor)
        If Not DiffuseFunction  Is Nothing Then Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderAssign, "VAR0 = VAR1 + Diffuse(VAR2, VAR3, VAR4, VAR5)"                    , ColorResult, ColorResult, CurrentVar , LightPosition, FragmentPosition, DiffuseColor)
        If Not SpecularFunction Is Nothing Then Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderAssign, "VAR0 = VAR1 + Specular(VAR2, VAR3, VAR4, VAR5, VAR6, VAR7, VAR8)" , ColorResult, ColorResult, CurrentVar , LightPosition, ViewPosition    , FragmentPosition, SpecularColor, SpecularFactor, Shininess)
        Call VBGLShaderWorkflow.Add(Workflows, VBGLShaderUseOnOutput, "VAR0 * VAR1 * VAR2", ThisFunc.ReturnFunc, ColorResult, LightColor)
    End If
End Sub

Private Sub GetOutputs()
    Dim i As Long
    For i = 0 To USize(Workflows)
        If Workflows(i).WFType = VBGLShaderPass Then
            Call VBGLShaderVariable.AddVariable(Output, Workflows(i).Var(0))
        End If
    Next i
End Sub

Private Sub AddUniforms(Uniforms() As VBGLShaderVariable)
    Dim i As Long
    For i = 0 To Ubound(Uniforms)
        If Not Uniforms(i) Is Nothing Then
            Call VBGLShaderVariable.AddVariable(Inputt, Uniforms(i))
            If ShortenArray(Uniforms, i) = False Then Exit Sub
            i = i - 1
        Else
            Call ShortenArray(Uniforms, i)
            Exit For
        End If
    Next i
End Sub



'Code
Public Function GetShader() As String
    GetShader   = "#version " & Version & vbCrLf
    GetShader   = GetShader & GetVariables(Inputt)
    GetShader   = GetShader & GetVariables(Output)
    Dim i As Long
    For i = 0 To USize(Functions)
        GetShader = GetShader & Functions(i).GetFunction
    Next i
    GetShader = GetShader & ThisFunc.GetFunction
    If Not NextShader Is Nothing Then GetShader   = GetShader & "|" & NextShader.GetShader
End Function

Private Function GetVariables(Arr() As VBGLShaderVariable) As String
    Dim i As Long
    For i = 0 To USize(Arr)
        GetVariables = GetVariables & Arr(i).State & " " & Arr(i).DataType & " " & Arr(i).Name & LineEnd
    Next i
    GetVariables = GetVariables & vbCrLf
End Function

Private Function ReverseVariables(Arr() As VBGLShaderVariable) As VBGLShaderVariable()
    Dim i As Long
    Dim Temp() As VBGLShaderVariable
    ReDim Temp(USize(Arr))
    For i = 0 To USize(Arr)
        Set Temp(i) = ReverseVariable(Arr(i))
    Next i
    ReverseVariables = Temp
End Function





Private Function USize(Arr As Variant) As Long
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr)
End Function

Private Function ReverseVariable(Var As VBGLShaderVariable) As VBGLShaderVariable
    Set ReverseVariable = New VBGLShaderVariable
    If Var.State Like "*in*" Then
        ReverseVariable.State = "out"
        ReverseVariable.Name  = Replace(Var.Name, "in", "out")
    Else
        ReverseVariable.State = "in"
        ReverseVariable.Name  = Var.Name
    End If
    ReverseVariable.DataType = Var.DataType
End Function

Private Function ShortenArray(Arr() As VBGLShaderVariable, Index As Long) As Boolean
    Dim i As Long
    Dim NeUSize As Long: NeUSize = Ubound(Arr) - 1
    Dim Temp() As VBGLShaderVariable
    If NeUSize <> -1 Then
        ReDim Temp(NeUSize)
        Dim Counter As Long
        For i = 0 To NeUSize
            If Counter = Index Then Counter = Counter + 1
            Set Temp(i) = Arr(Counter)
            Counter = Counter + 1
        Next i
        ShortenArray = True
    End If
    Arr = Temp
End Function