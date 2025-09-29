VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLShaderFunction"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Implements VBGLIShaderElement

Private p_Name        As String                        ' Name
Private p_ReturnType  As String                        ' ReturnType
Private p_ReturnVar   As VBGLShaderVariable            ' ReturnVariable if Name and ReturnType are not the same as ReturnVariable
Private p_Compile     As Boolean                       ' Should it be compiled or does the compiler know what to do with the function?
Private p_Arguments   As VBGLShaderElementCollection   ' Input
Private p_Workflows   As VBGLShaderElementCollection   ' What happens in the Function
Private p_Variables   As VBGLShaderElementCollection   ' In function declared variables

Public Property Let Name(ByVal n_Name                        As String)                       : Let p_Name              = n_Name               : End Property
Public Property Let ReturnType(ByVal n_ReturnType            As String)                       : Let p_ReturnType        = n_ReturnType         : End Property
Public Property Let ReturnVar(ByVal n_ReturnVar              As VBGLShaderVariable)           : Set p_ReturnVar         = n_ReturnVar          : End Property
Public Property Let Compile(ByVal n_Compile                  As Boolean)                      : Let p_Compile           = n_Compile            : End Property
Public Property Let Arguments(ByVal n_Arguments              As VBGLShaderElementCollection)  : Set p_Arguments         = n_Arguments          : End Property
Public Property Let Workflows(ByVal n_Workflows              As VBGLShaderElementCollection)  : Set p_Workflows         = n_Workflows          : End Property
Public Property Let Variables(ByVal n_Variables              As VBGLShaderElementCollection)  : Set p_Variables         = n_Variables          : End Property

Public Property Get Name()                                   As String                        : Let Name                = p_Name               : End Property
Public Property Get ReturnType()                             As String                        : Let ReturnType          = p_ReturnType         : End Property
Public Property Get ReturnVar()                              As VBGLShaderVariable            : Set ReturnVar           = p_ReturnVar          : End Property
Public Property Get Compile()                                As Boolean                       : Let Compile             = p_Compile            : End Property
Public Property Get Arguments()                              As VBGLShaderElementCollection   : Set Arguments           = p_Arguments          : End Property
Public Property Get Workflows()                              As VBGLShaderElementCollection   : Set Workflows           = p_Workflows          : End Property
Public Property Get Variables()                              As VBGLShaderElementCollection   : Set Variables           = p_Variables          : End Property

Private Function VBGLIShaderElement_GetVariable() As VBGLShaderVariable
    Set VBGLIShaderElement_GetVariable = p_ReturnVar
    VBGLIShaderElement_GetVariable.Name = VBGLIShaderElement_GetVariableCall(False)
End Function
Private Function VBGLIShaderElement_GetVariableCall(ByVal WithReturnType As Boolean) As String
    Dim i As Long
    Dim Result As String
    Result = Name & "("
    For i = 0 To Arguments.Size
        Result = Result & Arguments.Element(i).GetVariableCall(WithReturnType) & ", "
    Next i
    Result = Result & ")"
    Result = Replace(Result, ", )", ")")
    VBGLIShaderElement_GetVariableCall = Result
End Function
Private Function VBGLIShaderElement_GetVariableAll() As String
    Dim i As Long
    
    Dim Level As Long
    Level = 1
    
    Dim Result As String
    Result = ReturnType & " " & VBGLIShaderElement_GetVariableCall(True) & vbCrLf
    Result = Result & "{" & vbCrLf
    For i = 0 To Workflows.Size
        Result = Workflows.Element(i).Element.GetString(Result, Level)
    Next i
    Result = Result & "}" & vbCrLf & vbCrLf
    VBGLIShaderElement_GetVariableAll = Result
End Function
Private Function VBGLIShaderElement_Element() As Variant
    Set VBGLIShaderElement_Element = Me
End Function


Public Function Create(ByVal n_Name As String, ByVal n_ReturnType As String, ByVal n_ReturnVar As VBGLShaderVariable, ByVal n_Compile As Boolean, ByVal n_Arguments As VBGLShaderElementCollection, ByVal n_Workflows As VBGLShaderElementCollection, Optional ByVal n_Variables As VBGLShaderElementCollection = Nothing) As VBGLShaderFunction
    Set Create = New VBGLShaderFunction
    With Create
        .Name       = n_Name
        .ReturnType = n_ReturnType
        .ReturnVar  = n_ReturnVar
        .Compile    = n_Compile
        .Arguments  = n_Arguments
        .Workflows  = n_Workflows
        If IsSomething(n_Variables) Then .Variables = n_Variables
    End With
End Function

Public Function CreateElement(ByVal n_Name As String, ByVal n_ReturnType As String, ByVal n_ReturnVar As VBGLShaderVariable, ByVal n_Compile As Boolean, ByVal n_Arguments As VBGLShaderElementCollection, ByVal n_Workflows As VBGLShaderElementCollection, Optional ByVal n_Variables As VBGLShaderElementCollection = Nothing) As VBGLIShaderElement
    Set CreateElement = Create(n_Name, n_ReturnType, n_ReturnVar, n_Compile, n_Arguments, n_Workflows, n_Variables)
End Function

' These Functions are Functions, that dont need to be compiled, since GLSL knows how to deal with them
Public Function LengthFunction()     As VBGLShaderFunction : Set LengthFunction     = VBGLShaderFunction.CreateUnincludable("float" , "length"    , VBGLShaderVariable.CreateElement("var", "vec3"      , "Vertex"))                                                                                                                              : End Function
Public Function NormalizeFunction()  As VBGLShaderFunction : Set NormalizeFunction  = VBGLShaderFunction.CreateUnincludable("vec3"  , "normalize" , VBGLShaderVariable.CreateElement("var", "vec3"      , "Vertex"))                                                                                                                              : End Function
Public Function InverseFunction()    As VBGLShaderFunction : Set InverseFunction    = VBGLShaderFunction.CreateUnincludable("mat3"  , "inverse"   , VBGLShaderVariable.CreateElement("var", "mat3"      , "Matrix"))                                                                                                                              : End Function
Public Function TransposeFunction()  As VBGLShaderFunction : Set TransposeFunction  = VBGLShaderFunction.CreateUnincludable("mat3"  , "transpose" , VBGLShaderVariable.CreateElement("var", "mat3"      , "Matrix"))                                                                                                                              : End Function
Public Function TextureFunction()    As VBGLShaderFunction : Set TextureFunction    = VBGLShaderFunction.CreateUnincludable("vec4"  , "texture"   , VBGLShaderVariable.CreateElement("var", "sampler2D" , "Uniform")  , VBGLShaderVariable.CreateElement("var", "vec2", "Position"))                                                              : End Function
Public Function DotFunction()        As VBGLShaderFunction : Set DotFunction        = VBGLShaderFunction.CreateUnincludable("float" , "dot"       , VBGLShaderVariable.CreateElement("var", "vec3"      , "Vertex0")  , VBGLShaderVariable.CreateElement("var", "vec3", "Vertex1"))                                                               : End Function
Public Function CrossFunction()      As VBGLShaderFunction : Set CrossFunction      = VBGLShaderFunction.CreateUnincludable("vec3"  , "cross"     , VBGLShaderVariable.CreateElement("var", "vec3"      , "Vertex0")  , VBGLShaderVariable.CreateElement("var", "vec3", "Vertex1"))                                                               : End Function
Public Function ReflectFunction()    As VBGLShaderFunction : Set ReflectFunction    = VBGLShaderFunction.CreateUnincludable("vec3"  , "reflect"   , VBGLShaderVariable.CreateElement("var", "vec3"      , "Incident") , VBGLShaderVariable.CreateElement("var", "vec3", "Normal"))                                                                : End Function
Public Function StepFunction()       As VBGLShaderFunction : Set StepFunction       = VBGLShaderFunction.CreateUnincludable("float" , "step"      , VBGLShaderVariable.CreateElement("var", "float"     , "edge")     , VBGLShaderVariable.CreateElement("var", "float", "x"))                                                                    : End Function
Public Function ModFunction()        As VBGLShaderFunction : Set ModFunction        = VBGLShaderFunction.CreateUnincludable("float" , "mod"       , VBGLShaderVariable.CreateElement("var", "float"     , "x")        , VBGLShaderVariable.CreateElement("var", "float", "y"))                                                                    : End Function
Public Function PowFunction()        As VBGLShaderFunction : Set PowFunction        = VBGLShaderFunction.CreateUnincludable("float" , "pow"       , VBGLShaderVariable.CreateElement("var", "float"     , "base")     , VBGLShaderVariable.CreateElement("var", "float", "exponent"))                                                             : End Function
Public Function MinFunction()        As VBGLShaderFunction : Set MinFunction        = VBGLShaderFunction.CreateUnincludable("float" , "min"       , VBGLShaderVariable.CreateElement("var", "float"     , "a")        , VBGLShaderVariable.CreateElement("var", "float", "b"))                                                                    : End Function
Public Function MaxFunction()        As VBGLShaderFunction : Set MaxFunction        = VBGLShaderFunction.CreateUnincludable("float" , "max"       , VBGLShaderVariable.CreateElement("var", "float"     , "a")        , VBGLShaderVariable.CreateElement("var", "float", "b"))                                                                    : End Function
Public Function ClampFunction()      As VBGLShaderFunction : Set ClampFunction      = VBGLShaderFunction.CreateUnincludable("float" , "clamp"     , VBGLShaderVariable.CreateElement("var", "float"     , "Vertex0")  , VBGLShaderVariable.CreateElement("var", "float", "Vertex1"), VBGLShaderVariable.CreateElement("var", "float", "Vertex2")) : End Function
Public Function MixFunction()        As VBGLShaderFunction : Set MixFunction        = VBGLShaderFunction.CreateUnincludable("float" , "mix"       , VBGLShaderVariable.CreateElement("var", "float"     , "x")        , VBGLShaderVariable.CreateElement("var", "float", "y")      , VBGLShaderVariable.CreateElement("var", "float", "a"))       : End Function
Public Function RefractFunction()    As VBGLShaderFunction : Set RefractFunction    = VBGLShaderFunction.CreateUnincludable("vec3"  , "refract"   , VBGLShaderVariable.CreateElement("var", "vec3"      , "Incident") , VBGLShaderVariable.CreateElement("var", "vec3", "Normal")  , VBGLShaderVariable.CreateElement("var", "float", "eta"))     : End Function
Public Function SmoothstepFunction() As VBGLShaderFunction : Set SmoothstepFunction = VBGLShaderFunction.CreateUnincludable("float" , "smoothstep", VBGLShaderVariable.CreateElement("var", "float"     , "edge0")    , VBGLShaderVariable.CreateElement("var", "float", "edge1")  , VBGLShaderVariable.CreateElement("var", "float", "x"))       : End Function

' These Functions need to be compiled to work
Public Function CreateAmbient() As VBGLShaderFunction
    Dim n_ReturnType As String            : Let n_ReturnType = "vec3"
    Dim n_Name       As String            : Let n_Name       = "Ambient"
    Dim n_ReturnVar As VBGLShaderVariable : Set n_ReturnVar = VBGLShaderVariable.Create("func", n_ReturnType, n_Name, "*")

    Dim n_Arguments As New VBGLShaderElementCollection
    Dim Color  As VBGLIShaderElement: Set Color  = n_Arguments.Add(VBGLShaderVariable.CreateElement("var", "vec3" , "Color", "*"))
    Dim Factor As VBGLIShaderElement: Set Factor = n_Arguments.Add(VBGLShaderVariable.CreateElement("var", "float", "Factor", "*"))

    Dim n_Workflows As New VBGLShaderElementCollection
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderReturn, Empty, Color, Factor))

    Set CreateAmbient = Create(n_Name, n_ReturnType, n_ReturnVar, True, n_Arguments, n_Workflows)
End Function
Public Function CreateDiffuse() As VBGLShaderFunction
    Dim n_ReturnType As String            : Let n_ReturnType = "vec3"
    Dim n_Name       As String            : Let n_Name       = "Diffuse"
    Dim n_ReturnVar  As VBGLShaderVariable: Set n_ReturnVar = VBGLShaderVariable.Create("func", n_ReturnType, n_Name, "*")

    Dim n_Arguments As New VBGLShaderElementCollection
    Dim Normal        As VBGLIShaderElement: Set Normal        = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec3", "Normal", "*"))
    Dim LightPosition As VBGLIShaderElement: Set LightPosition = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec3", "LightPosition", "*"))
    Dim FragPosition  As VBGLIShaderElement: Set FragPosition  = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec3", "FragPosition", "*"))
    Dim Color         As VBGLIShaderElement: Set Color         = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec3", "Color", "*"))

    Dim n_Variables As New VBGLShaderElementCollection
    Dim Norm           As VBGLIShaderElement: Set Norm           = n_Variables.Add(VBGLShaderVariable.CreateElement("var", "vec3" , "Norm", "*"))
    Dim LightDirection As VBGLIShaderElement: Set LightDirection = n_Variables.Add(VBGLShaderVariable.CreateElement("var", "vec3" , "LightDirection", "*"))
    Dim Diff           As VBGLIShaderElement: Set Diff           = n_Variables.Add(VBGLShaderVariable.CreateElement("var", "float", "Diff", "*"))

    Dim n_Workflows As New VBGLShaderElementCollection
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddWithValue , Empty, Norm , CreateFromText("normalize(VAR0)", Normal)))
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddWithValue , Empty, LightDirection , CreateFromText("normalize(VAR0 - VAR1)", LightPosition, FragPosition)))    
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddWithValue , Empty, Diff , CreateFromText("max(dot(VAR0, VAR1), 0.0)", Norm, LightPosition)))
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderReturn       , Empty, Diff , Color))
    Set CreateDiffuse = Create(n_Name, n_ReturnType, n_ReturnVar, True, n_Arguments, n_Workflows, n_Variables)
End Function
Public Function CreateSpecular() As VBGLShaderFunction
    Dim n_ReturnType As String            : Let n_ReturnType = "vec3"
    Dim n_Name       As String            : Let n_Name       = "Specular"
    Dim n_ReturnVar As VBGLShaderVariable: Set n_ReturnVar = VBGLShaderVariable.Create("func", n_ReturnType, n_Name, "*")

    Dim n_Arguments As New VBGLShaderElementCollection
    Dim Normal        As VBGLIShaderElement: Set Normal        = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec3" , "Normal", "*"))
    Dim LightPosition As VBGLIShaderElement: Set LightPosition = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec3" , "LightPosition", "*"))
    Dim ViewPosition  As VBGLIShaderElement: Set ViewPosition  = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec3" , "ViewPosition", "*"))
    Dim FragPosition  As VBGLIShaderElement: Set FragPosition  = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec3" , "FragPosition", "*"))
    Dim Color         As VBGLIShaderElement: Set Color         = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec3" , "Color", "*"))
    Dim Factor        As VBGLIShaderElement: Set Factor        = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "float", "Factor", "*"))
    Dim Shininess     As VBGLIShaderElement: Set Shininess     = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "float", "Shininess", "*"))


    Dim n_Variables As New VBGLShaderElementCollection
    Dim Norm             As VBGLIShaderElement: Set Norm             = n_Variables.Add(VBGLShaderVariable.CreateElement("var", "vec3" , "Norm", "*"))
    Dim LightDirection   As VBGLIShaderElement: Set LightDirection   = n_Variables.Add(VBGLShaderVariable.CreateElement("var", "vec3" , "LightDirection", "*"))
    Dim Spec             As VBGLIShaderElement: Set Spec             = n_Variables.Add(VBGLShaderVariable.CreateElement("var", "float", "Spec", "*"))
    Dim ViewDirection    As VBGLIShaderElement: Set ViewDirection    = n_Variables.Add(VBGLShaderVariable.CreateElement("var", "vec3" , "ViewDirection", "*"))
    Dim ReflectDirection As VBGLIShaderElement: Set ReflectDirection = n_Variables.Add(VBGLShaderVariable.CreateElement("var", "vec3" , "ReflectDirection", "*"))

    Dim n_Workflows As New VBGLShaderElementCollection
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddWithValue, Empty, Norm , CreateFromText("normalize(VAR0)", Normal)))
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddWithValue, Empty, LightDirection , CreateFromText("normalize(VAR0 - VAR1)", LightPosition, FragPosition)))
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddWithValue, Empty, ViewDirection , CreateFromText("normalize(VAR0 - VAR1)", ViewPosition, FragPosition)))
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddWithValue, Empty, ReflectDirection , CreateFromText("reflect(-VAR0, VAR1)", LightDirection, Norm)))
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderAddWithValue, Empty, Spec , CreateFromText("pow(max(dot(VAR0, VAR1), 0.0), VAR2)", ViewDirection, ReflectDirection, Shininess)))
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderReturn      , Empty, Spec , Color, Factor))
    Set CreateSpecular = Create(n_Name, n_ReturnType, n_ReturnVar, True, n_Arguments, n_Workflows, n_Variables)
End Function
Public Function CreateTexturebox() As VBGLShaderFunction
    Dim n_ReturnType As String            : Let n_ReturnType = "vec4"
    Dim n_Name       As String            : Let n_Name       = "Texturebox"
    Dim n_ReturnVar As VBGLShaderVariable: Set n_ReturnVar = VBGLShaderVariable.Create("func", n_ReturnType, n_Name, "*")

    Dim n_Arguments As New VBGLShaderElementCollection
    Dim Texture         As VBGLIShaderElement: Set Texture         = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec4"     , "Texture", "*"))
    Dim BackgroundColor As VBGLIShaderElement: Set BackgroundColor = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec4"     , "BackgroundColor", "*"))
    Dim FontColor       As VBGLIShaderElement: Set FontColor       = n_Arguments.Add(VBGLShaderVariable.CreateElement("arg", "vec4"     , "FontColor", "*"))

    Dim Condition As New VBGLShaderElementCollection
    Call Condition.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderCompare, "VAR0.r != 0.0", Texture))
    Call Condition.Add(Nothing)

    Dim Code As New VBGLShaderElementCollection
    Call Code.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderReturn, "return vec4(VAR0.xyz, VAR1.r)", FontColor, Texture))
    Call Code.Add(VBGLShaderWorkflow.CreateElement(VBGLShaderReturn, Empty, BackgroundColor))

    Dim n_Variables As New VBGLShaderElementCollection
    Dim n_Workflows As New VBGLShaderElementCollection
    Call n_Workflows.Add(VBGLShaderWorkflow.CreateCondition(Condition, Code))
    Set CreateTexturebox = Create(n_Name, n_ReturnType, n_ReturnVar, True, n_Arguments, n_Workflows, n_Variables)
End Function

Public Function CreateNewArguments(ParamArray NewArguments() As Variant) As VBGLShaderFunction
    Dim Temp As Variant: Temp = NewArguments
    Set CreateNewArguments = CloneArguments(Temp)
End Function
Public Function CreateNewArgumentsVar(ParamArray NewArguments() As Variant) As VBGLShaderFunction
    Dim Temp As Variant: Temp = NewArguments
    Set CreateNewArgumentsVar = CloneArguments(Temp)
End Function
Public Function CreateNewArgumentsArr(NewArguments() As String) As VBGLShaderFunction
    Set CreateNewArgumentsArr = CloneArguments(NewArguments)
End Function
Public Function CreateNewArgumentsVarArr(NewArguments() As VBGLIShaderElement) As VBGLShaderFunction
    Set CreateNewArgumentsVarArr = CloneArguments(NewArguments)
End Function
Public Function CreateUnincludable(ByVal n_ReturnType As String, ByVal n_Name As String, ParamArray n_Arguments() As Variant) As VBGLShaderFunction
    Dim n_ReturnVar  As VBGLShaderVariable
    Set n_ReturnVar  = VBGLShaderVariable.Create("func", n_ReturnType, n_Name, "*")
    Dim Temp As Variant: Temp = n_Arguments
    Dim i As Long
    Set CreateUnincludable = CloneArguments(Temp)
    CreateUnincludable.ReturnVar  = n_ReturnVar
    CreateUnincludable.ReturnType = n_ReturnType
    CreateUnincludable.Name       = n_Name
End Function
Public Function CloneArguments(ByVal Arr As Variant) As VBGLShaderFunction
    Dim i As Long
    Dim ClonedArguments() As VBGLIShaderElement
    ReDim ClonedArguments(USize(Arr))
    If TypeName(Arr(0)) = "String" Then
        For i = 0 To USize(Arr)
            Set ClonedArguments(i) = Arguments.Element(i)
            ClonedArguments(i).GetVariable.Name = Arr(i)
        Next i
    Else
        For i = 0 To USize(Arr)
            Set ClonedArguments(i) = Arr(i)
            If Arguments.Size >= i Then
                ClonedArguments(i).GetVariable.Name = Arguments.Element(i).Element.TransformType(Arr(i).GetVariable)
            End If
        Next i
    End If
    Dim Temp As VBGLShaderElementCollection
    Set Temp = VBGLShaderElementCollection.CreateArr(ClonedArguments)
    Set CloneArguments = Create(Name, ReturnType, ReturnVar, Compile, Temp, Workflows)
    CloneArguments.Compile = False
End Function





Private Function CreateFromText(ByVal Template As String, ParamArray Variables() As Variant) As VBGLShaderFunction
    Dim Parsed As New Collection
    Dim CurrentFunction As VBGLShaderFunction
    Dim VariablesArr As New VBGLShaderElementCollection
    Dim i As Long
    Dim Temp As VBGLIShaderElement
    For i = 0 To Ubound(Variables)
        Set Temp = Variables(i)
        Call VariablesArr.Add(Temp)
    Next i
    Set Parsed = ParseFunctions(Template)
    Set CurrentFunction = GetFunctionFromName(CStr(Parsed(1)(0)))
    Call ProcessParsed(Parsed(1)(1), CurrentFunction, VariablesArr)
    Set CreateFromText = CurrentFunction
End Function

Private Sub ProcessParsed(ByVal Parsed As Variant, ByRef CurrentFunction As VBGLShaderFunction, ByVal Variables As VBGLShaderElementCollection)
    Dim i As Long
    Dim NewNames() As VBGLIShaderElement
    Dim Size As Long
    Dim NewFunction As VBGLShaderFunction
    Size = -1
    For i = 1 To Parsed.Count
        If IsArray(Parsed(i)) Then
            Set NewFunction = GetFunctionFromName(CStr(Parsed(i)(0)))
            Call ProcessParsed(Parsed(i)(1), NewFunction, Variables)
            Size = Size + 1
            ReDim Preserve NewNames(Size)
            Set NewNames(Size) = NewFunction
        Else
            Size = Size + 1
            ReDim Preserve NewNames(Size)
            Set NewNames(Size) = InterpretValue(CStr(Parsed(i)), Variables)
        End If
    Next i
    Set CurrentFunction = CurrentFunction.CreateNewArgumentsVarArr(NewNames)
End Sub

Private Function ParseFunctions(ByRef Text As String, Optional ByRef Pos As Long = 1) As Collection
    Dim Result As New Collection
    Dim Token As String
    Dim Name As String
    Dim Char As String
    Dim ArgList As Collection
    Dim InQuotes As Boolean
    
    Do While Pos <= Len(Text)
        Char = Mid(Text, Pos, 1)
        Select Case Char
            Case "("
                ' Start of a nested function
                Name = Trim(Token)
                Token = ""
                Pos = Pos + 1
                Set ArgList = ParseFunctions(Text, Pos)
                Result.Add Array(Name, ArgList)
            Case ")"
                ' End of this level
                If Trim(Token) <> "" Then
                    Result.Add Trim(Token)
                    Token = ""
                End If
                Exit Do
            Case ","
                ' New argument
                If Trim(Token) <> "" Then
                    Result.Add Trim(Token)
                    Token = ""
                End If
            Case Else
                Token = Token & Char
        End Select
        Pos = Pos + 1
    Loop
    
    If Trim(Token) <> "" Then
        Result.Add Trim(Token)
    End If

    Set ParseFunctions = Result
End Function

Private Function GetFunctionFromName(ByVal Name As String) As VBGLShaderFunction
    Select Case LCase(Name)
        Case "length"     : Set GetFunctionFromName = LengthFunction()
        Case "normalize"  : Set GetFunctionFromName = NormalizeFunction()
        Case "inverse"    : Set GetFunctionFromName = InverseFunction()
        Case "transpose"  : Set GetFunctionFromName = TransposeFunction()
        Case "texture"    : Set GetFunctionFromName = TextureFunction()
        Case "dot"        : Set GetFunctionFromName = DotFunction()
        Case "cross"      : Set GetFunctionFromName = CrossFunction()
        Case "reflect"    : Set GetFunctionFromName = ReflectFunction()
        Case "step"       : Set GetFunctionFromName = StepFunction()
        Case "mod"        : Set GetFunctionFromName = ModFunction()
        Case "pow"        : Set GetFunctionFromName = PowFunction()
        Case "min"        : Set GetFunctionFromName = MinFunction()
        Case "max"        : Set GetFunctionFromName = MaxFunction()
        Case "clamp"      : Set GetFunctionFromName = ClampFunction()
        Case "mix"        : Set GetFunctionFromName = MixFunction()
        Case "refract"    : Set GetFunctionFromName = RefractFunction()
        Case "smoothstep" : Set GetFunctionFromName = SmoothstepFunction()
    End Select
End Function

Private Function InterpretValue(ByVal Text As String, ByVal Variables As VBGLShaderElementCollection) As VBGLIShaderElement
    Dim Result As VBGLShaderVariable
    Select Case True
        Case Text Like "*VAR*VAR*"
            Set Result = Variables.Transform(Text)
            Result.Name = VBGLMidP(Text, 1, InStr(1, Text, "VAR") - 1) & Result.Name
        Case Text Like "*VAR*"
            Set Result = Variables.Element(CLng(VBGLGetNumericCharacters(Text))).Element.Clone
            Result.Name = VBGLMidP(Text, 1, InStr(1, Text, "VAR") - 1) & Result.Name
        Case IsNumeric(Text)
            Set Result = VBGLShaderVariable.CreateElement("var", "var", Text)
        Case IsSomething(GetFunctionFromName(Text))
            Set Result = GetFunctionFromName(Text)
        Case Else
            Set Result = VBGLShaderVariable.CreateElement("var", "var", Text)
    End Select
    Set InterpretValue = Result
End Function

Private Sub Class_Initialize()
    Set p_Arguments = New VBGLShaderElementCollection
    Set p_Workflows = New VBGLShaderElementCollection
    Set p_Variables = New VBGLShaderElementCollection
End Sub