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
Private Const Incant  As String = "    "

Private ThisFunc     As VBGLIShaderElement
Private Functions    As VBGLShaderElementCollection
Private Inputs       As VBGLShaderElementCollection
Private Outputs      As VBGLShaderElementCollection

'Temporary Arrays for ThisFunc
Private Workflows    As VBGLShaderElementCollection
Private Variables    As VBGLShaderElementCollection

Private p_Version    As String
Private p_Pipeline   As String
Private p_ShaderName As String
Private p_NextShader As VBGLShaderTemplate

Public Property Let Version(n_Version       As String)            : Let p_Version    = n_Version    : End Property
Public Property Let Pipeline(n_Pipeline     As String)            : Let p_Pipeline   = n_Pipeline   : End Property
Public Property Let ShaderName(n_ShaderName As String)            : Let p_ShaderName = n_ShaderName : End Property
Public Property Let NextShader(n_NextShader As VBGLShaderTemplate): Set p_NextShader = n_NextShader : End Property

Public Property Get Version()               As String             : Let Version      = p_Version    : End Property
Public Property Get Pipeline()              As String             : Let Pipeline     = p_Pipeline   : End Property
Public Property Get ShaderName()            As String             : Let ShaderName   = p_ShaderName : End Property
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

Public Sub SetUp(Layout As VBGLLayout, Uniforms As VBGLShaderElementCollection, Optional Operator As String = "*")
    Call AddLayouts(Layout, Operator)
    Call SetUpNext(Inputs, Uniforms)
End Sub

Private Sub AddLayouts(Layout As VBGLLayout, Operator As String)
    Dim i As Long

    Dim PositionIndex As Long
    Dim TextureIndex  As Long
    Dim NormalIndex   As Long
    Dim ColorIndex    As Long
    Dim Index         As Long
    Dim Category      As String
    Dim State         As String
    Dim ReturnType    As String
    Dim Name          As String

    With Layout
        For i = 0 To .Size
            Category = .Element(i).GetCategory
            Select Case Category
                Case "Position" : Index = PositionIndex : PositionIndex = PositionIndex + 1
                Case "Texture"  : Index = TextureIndex  : TextureIndex  = TextureIndex  + 1
                Case "Normal"   : Index = NormalIndex   : NormalIndex   = NormalIndex   + 1
                Case "Color"    : Index = ColorIndex    : ColorIndex    = ColorIndex    + 1
            End Select
            State      = Replace(VBGLShaderStateLayout, "x", i)
            ReturnType = GetVarType(.Element(i))
            Name       = VBGLShaderStateIn & ShaderName & Category & Index
            Call Inputs.Add(VBGLShaderVariable.CreateElement(State, ReturnType, Name, Operator))
        Next i
    End With
End Sub

Public Sub SetUpNext(n_Inputs As VBGLShaderElementCollection, Uniforms As VBGLShaderElementCollection)
    Call SetOutput(ShaderName)
    Set Inputs = n_Inputs
    Set Workflows = ThisFunc.Element.Workflows
    Set Variables = ThisFunc.Element.Variables
    Call HandleUniforms(Uniforms)
    Select Case ShaderName
        Case "Vertex"   : Call AddVertex()
        Case "Fragment" : Call AddFragment()
    End Select
    Call GetOutputs()
    ThisFunc.Element.Workflows = Workflows
    ThisFunc.Element.Variables = Variables
    If IsSomething(NextShader) Then
        Call NextShader.SetUpNext(Outputs.Reverse, Uniforms)
    End If
End Sub

Public Function GetShader() As String
    Dim Result As String
    Result   = "#version " & Version & vbCrLf
    Result   = Result & GetVariables(Inputs)
    Result   = Result & GetVariables(Outputs)

    Dim i As Long
    For i = 0 To Functions.Size
        If Functions.Element(i).Element.Compile Then Result = Result & Functions.Element(i).GetVariableAll()
    Next i

    Result = Result & ThisFunc.GetVariableAll()
    If IsSomething(NextShader) Then
        Result = Result & "|" & NextShader.GetShader()
    End If
    GetShader = Result
End Function

Private Sub AddVertex()
    Dim i As Long
    Dim Index As Long
    Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddOutput, Empty, ThisFunc.Element.ReturnVar))
    For i = 0 To Inputs.Size
        Dim State    As String : State = Inputs.Element(i).GetVariable.State
        Dim Name     As String : Name  = Inputs.Element(i).GetVariable.Name
        Select Case True
            Case State Like "layout*in*"
                Select Case True
                    Case Name Like "*Position#*"   : Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderUseOnOutput, Empty, ThisFunc.Element.ReturnVar, Inputs.Element(i)))
                    Case Name Like "*Texture#*"    : Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderPass       , Empty, Inputs.Element(i).Element.Reverse, Inputs.Element(i)))
                    Case Name Like "*Color#*"      : Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderPass       , Empty, Inputs.Element(i).Element.Reverse, Inputs.Element(i)))
                    Case Name Like "*Normal#*"     : Call VertexNormal(Inputs.Element(i))
                    Case Else
                        Dim NewVar As VBGLIShaderElement
                        Set NewVar = Inputs.Element(i).GetVariable.Clone()
                        NewVar.GetVariable.State = VBGLShaderStateOut
                        NewVar.GetVariable.Name = Replace(NewVar.GetVariable.Name , "in", Empty)
                        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderPass, Empty, NewVar, Inputs.Element(i)))
                End Select
            Case State Like VBGLShaderStateUniformOut
                Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderUseOnOutput, Empty, ThisFunc.Element.ReturnVar, Inputs.Element(i)))
        End Select
    Next i
    Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderMoveOutput, Empty , ThisFunc.Element.ReturnVar))
End Sub

Private Sub AddFragment()
    Dim i As Long
    Dim Index As Long
    Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddOutput, Empty, ThisFunc.Element.ReturnVar))
    For i = 0 To Inputs.Size
        Dim State    As String : State = Inputs.Element(i).GetVariable.State
        Dim Name     As String : Name  = Inputs.Element(i).GetVariable.Name
        Select Case True
            Case State Like "*in*"
                Select Case True
                    Case Name Like "*Position#*" ' Nothing(shoulnt exist at this point)
                    Case Name Like "*Texture#*"
                        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderUseOnOutput, Empty, ThisFunc.Element.ReturnVar, VBGLShaderFunction.TextureFunction.CreateNewArguments("UNIFORM", Inputs.Element(i).GetVariable.Name)))
                    Case Name Like "*Color#*"
                        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderUseOnOutput, Empty, ThisFunc.Element.ReturnVar, Inputs.Element(i)))
                    Case Name Like "*Normal#*"
                        Call FragmentNormal(Inputs.Element(i))
                    Case Else
                        Select Case Name
                            Case "TextboxPosition" : Call FragmentTexture(Inputs.Element(i))
                        End Select
                End Select
            Case State Like VBGLShaderStateUniformOut
                Select Case True
                    Case Name Like "*Texture*"
                        Call AssignTextureUniformName(Name)
                    Case Else
                        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderUseOnOutput, "VAR0 = VAR1 OVAR1", ThisFunc.Element.ReturnVar, Inputs.Element(i)))
                End Select
        End Select
    Next i
    Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderMoveOutput, Empty , ThisFunc.Element.ReturnVar))
End Sub

Private Sub VertexNormal(CurrentVar As VBGLIShaderElement)
    Dim Position         As VBGLIShaderElement : Set Position = VBGLShaderVariable.CreateElement(CurrentVar.GetVariable.State, CurrentVar.GetVariable.ReturnType, Replace(CurrentVar.GetVariable.Name, "Normal", "Position"), "*")
    Dim FragmentPosition As VBGLIShaderElement : Set FragmentPosition = VBGLShaderVariable.CreateElement(VBGLShaderStateOut, "vec3", "FragmentPosition", "*")
    Dim Model            As VBGLIShaderElement : Set Model = Inputs.Find("Model")
    If IsSomething(Model) Then
        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderPass, Empty, FragmentPosition, Model, Position))
        Dim NewInverse As VBGLIShaderElement
        Dim ClonedModel As VBGLIShaderElement
        Set ClonedModel = Model.GetVariable.Clone()
        Set NewInverse = VBGLShaderFunction.InverseFunction.CreateNewArgumentsVar(ClonedModel)
        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderPass, Empty, CurrentVar.GetVariable.Reverse, VBGLShaderFunction.TransposeFunction.CreateNewArgumentsVar(NewInverse), CurrentVar))
    Else
        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderPass, Empty, FragmentPosition, Position))
        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderPass, Empty, CurrentVar.GetVariable.Reverse, CurrentVar))
    End If
End Sub

Private Sub FragmentNormal(CurrentVar As VBGLIShaderElement)
    Dim AmbientColor     As VBGLIShaderElement :   Set AmbientColor = Inputs.Find("AmbientColor")
    Dim AmbientFunction  As VBGLShaderFunction :   If IsSomething(AmbientColor) Then Set AmbientFunction = Functions.Add(VBGLShaderFunction.CreateAmbient())
    Dim DiffuseColor     As VBGLIShaderElement :   Set DiffuseColor = Inputs.Find("DiffuseColor")
    Dim DiffuseFunction  As VBGLShaderFunction :   If IsSomething(DiffuseColor) Then Set DiffuseFunction = Functions.Add(VBGLShaderFunction.CreateDiffuse())
    Dim SpecularColor    As VBGLIShaderElement :   Set SpecularColor = Inputs.Find("SpecularColor")
    Dim SpecularFunction As VBGLShaderFunction :   If IsSomething(SpecularColor) Then Set SpecularFunction = Functions.Add(VBGLShaderFunction.CreateSpecular())

    If IsSomething(AmbientFunction) Or IsSomething(DiffuseFunction) Or IsSomething(SpecularFunction) Then
        Dim ColorResult As VBGLIShaderElement
        Set ColorResult = AddColorResult(False)

        Dim FragmentPosition      As VBGLIShaderElement: Set FragmentPosition = Inputs.Find("FragmentPosition") : If IsNothing(FragmentPosition) Then Set FragmentPosition   = VBGLShaderVariable.Constructvec3()
        Dim ViewPosition          As VBGLIShaderElement: Set ViewPosition     = Inputs.Find("ViewPosition")     : If IsNothing(ViewPosition)     Then Set ViewPosition       = VBGLShaderVariable.Constructvec3()
        Dim AmbientFactor         As VBGLIShaderElement: Set AmbientFactor    = Inputs.Find("AmbientFactor")    : If IsNothing(AmbientFactor)    Then Set AmbientFactor      = VBGLShaderVariable.Construct("float", "*", "0.2")
        Dim SpecularFactor        As VBGLIShaderElement: Set SpecularFactor   = Inputs.Find("SpecularFactor")   : If IsNothing(SpecularFactor)   Then Set SpecularFactor     = VBGLShaderVariable.Construct("float", "*", "0.1")
        Dim LightPosition         As VBGLIShaderElement: Set LightPosition    = Inputs.Find("LightPosition")    : If IsNothing(LightPosition)    Then Set LightPosition      = VBGLShaderVariable.Constructvec3()
        Dim LightColor            As VBGLIShaderElement: Set LightColor       = Inputs.Find("LightColor")       : If IsNothing(LightColor)       Then Set LightColor         = VBGLShaderVariable.Constructvec3()
        Dim Shininess             As VBGLIShaderElement: Set Shininess        = Inputs.Find("Shininess")        : If IsNothing(Shininess)        Then Set Shininess          = VBGLShaderVariable.Construct("float", "*", "32")

        If IsSomething(AmbientFunction)  Then Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderIncrement, "VAR0 = VAR0 + VAR1" , ColorResult, AmbientFunction.CreateNewArgumentsVar(AmbientColor , AmbientFactor)))
        If IsSomething(DiffuseFunction)  Then Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderIncrement, "VAR0 = VAR0 + VAR1" , ColorResult, DiffuseFunction.CreateNewArgumentsVar(CurrentVar   , LightPosition, FragmentPosition, DiffuseColor)))
        If IsSomething(SpecularFunction) Then Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderIncrement, "VAR0 = VAR0 + VAR1" , ColorResult, SpecularFunction.CreateNewArgumentsVar(CurrentVar  , LightPosition, ViewPosition    , FragmentPosition, SpecularColor, SpecularFactor, Shininess)))
        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAssign   , "VAR0 = VAR1 * VAR2" , ColorResult, ColorResult, LightColor))
        Call AddColorResult(True)
    End If
End Sub

Private Sub FragmentTexture(CurrentVar As VBGLIShaderElement)
    Dim BackgroundColor    As VBGLIShaderElement :   Set BackgroundColor = Inputs.Find("BackgroundColor")
    Dim FontColor          As VBGLIShaderElement :   Set FontColor       = Inputs.Find("FontColor")
    Dim TextboxTexture     As VBGLIShaderElement :   Set TextboxTexture  = Inputs.Find("TextboxTexture")
    Dim TextureboxFunction As VBGLShaderFunction

    If IsSomething(BackgroundColor) And IsSomething(FontColor) And IsSomething(TextboxTexture) Then
        Set TextureboxFunction = Functions.Add(VBGLShaderFunction.CreateTexturebox())

        Dim NewTexture As VBGLIShaderElement
        Set NewTexture = VBGLShaderFunction.TextureFunction.CreateNewArgumentsVar(TextboxTexture, CurrentVar)
        
        Dim ColorResult As VBGLIShaderElement
        Set ColorResult = AddColorResult(False)
        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderIncrement, "VAR0 = VAR0 + VAR1" , ColorResult, TextureboxFunction.CreateNewArgumentsVar(NewTexture.GetVariable.CloneElement(), BackgroundColor.GetVariable.CloneElement(), FontColor.GetVariable.CloneElement())))
        Call AddColorResult(True)
    End If
End Sub

Private Function AddColorResult(UseOnOutput As Boolean) As VBGLIShaderElement
    Dim ColorResult As VBGLIShaderElement
    Set ColorResult = Variables.Find("ColorResult")
    If IsNothing(ColorResult) Then
        Set ColorResult = Variables.AddUnique(VBGLShaderVariable.CreateElement("var", "vec4", "ColorResult", "*"))
        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddWithValue, Empty, ColorResult, VBGLShaderVariable.Constructvec4))
    End If
    If UseOnOutput Then
        Call Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderUseOnOutput, Empty, ThisFunc.Element.ReturnVar, ColorResult))
    End If
    Set AddColorResult = ColorResult
End Function

Private Sub GetOutputs()
    Dim i As Long
    For i = 0 To Workflows.Size
        If Workflows.Element(i).Element.WFType = VBGLShaderPass Then
            Call Outputs.Add(Workflows.Element(i).Element.Vars.Element(0))
        End If
    Next i
End Sub

Private Sub HandleUniforms(Uniforms As VBGLShaderElementCollection)
    Dim i As Long
    Dim Uniform As VBGLIShaderElement
    For i = 0 To Uniforms.Size
        Set Uniform = Uniforms.Element(i)
        If IsSomething(Uniform) Then
            If Uniform.GetVariable.State Like "*:*" Then
                Dim Names() As String
                Names = Split(Uniform.GetVariable.State, ":")
                Dim Found As VBGLIShaderElement
                Set Found = Inputs.Find(Names(0))
                If IsSomething(Found) Then
                    Found.GetVariable.Name = Names(1)
                End If
            Else
                Call Inputs.Add(Uniforms.Element(i))
            End If
            If ShortenArray(Uniforms, i) = False Then Exit Sub
            i = i - 1
        Else
            Call ShortenArray(Uniforms, i)
            Exit For
        End If
    Next i
End Sub

Private Sub AssignTextureUniformName(Name As String)
    Dim i As Long
    Dim CurrentWF As VBGLShaderWorkflow
    Dim CurrentVar As VBGLIShaderElement
    Dim CurrentFuncArg As VBGLShaderVariable
    For i = 0 To Workflows.Size
        Set CurrentWF = Workflows.Element(i).Element
        If CurrentWF.Vars.Size > 0 Then
            Set CurrentVar = CurrentWF.Vars.Element(1)
            If TypeName(CurrentVar.Element) = "VBGLShaderFunction" Then
                ' First Argument that should be UNIFORM to replace with new name
                Set CurrentFuncArg = CurrentVar.Element.Arguments.Element(0).GetVariable
                If CurrentFuncArg.Name Like "*UNIFORM*" Then
                    CurrentFuncArg.Name = Replace(CurrentFuncArg.Name, "UNIFORM", Name)
                End If
            End If
        End If
    Next i
End Sub


' Get all non-function variables
Private Function GetVariables(Arr As VBGLShaderElementCollection) As String
    Dim i As Long
    Dim State    As String
    Dim ReturnType As String
    Dim Name     As String
    For i = 0 To Arr.Size
        With Arr.Element(i).GetVariable
            State      = IIf(.State = VBGLShaderStateUniformOut, "uniform", .State)
            ReturnType = .ReturnType
            Name       = .Name
            GetVariables = GetVariables & State & " " & ReturnType & " " & Name & LineEnd
        End With
    Next i
    GetVariables = GetVariables & vbCrLf
End Function


' The returnValue of the Shader
Private Sub SetOutput(Shader As String)
    Set ThisFunc = New VBGLShaderFunction
    Dim VersionNumber As Long
    VersionNumber = CLng(VBGLGetNumericCharacters(Version))
    Select Case Shader
        Case "Vertex"
            ThisFunc.Element.ReturnVar  = VBGLShaderVariable.Create(VBGLShaderStateOut, "vec4", "gl_Position", "*")
        Case "Fragment"
            If VersionNumber >= 430 Then
                Dim NewOutput As VBGLIShaderElement
                Set NewOutput = VBGLShaderVariable.Create(VBGLShaderStateOut, "vec4", "FragColor", "*")
                Call Outputs.Add(NewOutput)
                ThisFunc.Element.ReturnVar  = NewOutput
            Else
                ThisFunc.Element.ReturnVar  = VBGLShaderVariable.Create(VBGLShaderStateOut, "vec4", "gl_FragColor", "*")
            End If
    End Select
    ThisFunc.Element.ReturnType = "void"
    ThisFunc.Element.Name       = "main"
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

Private Function ShortenArray(Arr As VBGLShaderElementCollection, Index As Long) As Boolean
    Dim i As Long
    Dim NewSize As Long: NewSize = Arr.Size - 1
    Dim Temp() As VBGLIShaderElement
    If NewSize <> -1 Then
        ReDim Temp(NewSize)
        Dim Counter As Long
        For i = 0 To NewSize
            If Counter = Index Then Counter = Counter + 1
            Set Temp(i) = Arr.Element(Counter)
            Counter = Counter + 1
        Next i
        ShortenArray = True
    End If
    Arr.Elements = Temp
End Function

Private Sub Class_Initialize()
    Set Functions = New VBGLShaderElementCollection
    Set Inputs    = New VBGLShaderElementCollection
    Set Outputs   = New VBGLShaderElementCollection
    Set Workflows = New VBGLShaderElementCollection
    Set Variables = New VBGLShaderElementCollection
End Sub