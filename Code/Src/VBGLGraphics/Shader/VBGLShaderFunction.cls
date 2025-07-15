VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLShaderFunction"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Name        As String
Private p_ReturnType  As String
Private p_ReturnFunc  As VBGLShaderVariable
Private p_Arguments() As VBGLShaderVariable
Private p_Workflows() As VBGLShaderWorkflow

Public Property Let Name(n_Name             As String)              : p_Name       = n_Name       : End Property
Public Property Let ReturnType(n_ReturnType As String)              : p_ReturnType = n_ReturnType : End Property
Public Property Let ReturnFunc(n_ReturnFunc As VBGLShaderVariable)  : p_ReturnFunc = n_ReturnFunc : End Property
Public Property Let Arguments(n_Arguments() As VBGLShaderVariable)  : p_Arguments  = n_Arguments  : End Property
Public Property Let Workflows(n_Workflows() As VBGLShaderWorkflow)  : p_Workflows  = n_Workflows  : End Property

Public Property Get Name()                  As String               : Name         = p_Name       : End Property
Public Property Get ReturnType()            As String               : ReturnType   = p_ReturnType : End Property
Public Property Get ReturnFunc()            As VBGLShaderVariable   : ReturnFunc   = p_ReturnFunc : End Property
Public Property Get Arguments()             As VBGLShaderVariable() : Arguments    = p_Arguments  : End Property
Public Property Get Workflows()             As VBGLShaderWorkflow() : Workflows    = p_Workflows  : End Property

Public Function Create(n_Name As String, n_ReturnType As String, n_ReturnFunc As VBGLShaderVariable, n_Arguments As VBGLShaderVariable, n_Workflows As VBGLShaderWorkflow) As VBGLShaderFunction
    Set Create = New VBGLShaderFunction
    With Create
        .Name       = n_Name
        .ReturnType = n_ReturnType
        .ReturnFunc = n_ReturnFunc
        .Arguments  = n_Arguments
        .Workflows  = n_Workflows
    End With
End Function

Public Function CreateAmbient() As VBGLShaderFunction
    Dim n_ReturnType As String: n_ReturnType = "vec3"
    Dim n_Name       As String: n_Name       = "Ambient"
    Dim n_ReturnFunc As VBGLShaderFunction
    n_ReturnFunc.State     = "func"
    n_ReturnFunc.DataType  = n_ReturnType
    n_ReturnFunc.Name      = n_Name

    Dim n_Arguments() As VBGLShaderVariable
    ReDim n_Arguments(1)
    Set n_Arguments(0) = VBGLShaderVariable.Create("var", "vec3" , "Color")
    Set n_Arguments(1) = VBGLShaderVariable.Create("var", "float", "Factor")

    Dim n_Workflows() As VBGLShaderWorkflow
    ReDim n_Workflows(0)
    Set n_Workflows(0) = VBGLShaderWorkflow.Create(VBGLShaderReturn, "VAR0 = VAR1 * VAR2", ReturnFunc, Color, Factor)

    Set CreateAmbient = Create(n_Name, n_ReturnType, n_ReturnFunc, n_Arguments, n_Workflows)
End Function

Public Function CreateDiffuse() As VBGLShaderFunction
    Dim n_ReturnType As String: n_ReturnType = "vec3"
    Dim n_Name       As String: n_Name       = "Diffuse"
    Dim n_ReturnFunc As VBGLShaderFunction
    n_ReturnFunc.State     = "func"
    n_ReturnFunc.DataType  = n_ReturnType
    n_ReturnFunc.Name      = n_Name

    Dim n_Arguments() As VBGLShaderVariable
    ReDim n_Arguments(3)
    Set n_Arguments(0) = VBGLShaderVariable.Create(, "arg", "vec3", "Normal")
    Set n_Arguments(1) = VBGLShaderVariable.Create(, "arg", "vec3", "LightPosition")
    Set n_Arguments(2) = VBGLShaderVariable.Create(, "arg", "vec3", "FragPosition")
    Set n_Arguments(3) = VBGLShaderVariable.Create(, "arg", "vec3", "Color")

    Dim Norm            As VBGLShaderVariable : Set Norm           = VBGLShaderVariable.Create("var", "vec3" , "Norm")
    Dim LightDirection  As VBGLShaderVariable : Set LightDirection = VBGLShaderVariable.Create("var", "vec3" , "LightDirection")
    Dim Diff            As VBGLShaderVariable : Set Diff           = VBGLShaderVariable.Create("var", "float", "Diff")

    Dim n_Workflows() As VBGLShaderWorkflow
    ReDim n_Workflows(3)
    Set n_Workflows(0) = VBGLShaderWorkflow.Create(VBGLShaderAddWithValue, "VAR0 = normalize(VAR1)"           , Norm          , n_Arguments(0))
    Set n_Workflows(1) = VBGLShaderWorkflow.Create(VBGLShaderAddWithValue, "VAR0 = normalize(VAR1 - VAR2)"    , Direction     , n_Arguments(1), n_Arguments(2))
    Set n_Workflows(2) = VBGLShaderWorkflow.Create(VBGLShaderAddWithValue, "VAR0 = max(dot(VAR1, VAR2), 0.0)" , Diff          , Norm          , LightDirection)
    Set n_Workflows(3) = VBGLShaderWorkflow.Create(VBGLShaderReturn      , "VAR0 = VAR1"                      , n_ReturnFunc  , Diff          , n_Arguments(3))
    Set CreateDiffuse = Create(n_Name, n_ReturnType, n_ReturnFunc, n_Arguments, n_Workflows)
End Function

Public Function CreateSpecular() As VBGLShaderFunction
    Dim n_ReturnType As String: n_ReturnType = "vec3"
    Dim n_Name       As String: n_Name       = "Specular"
    Dim n_ReturnFunc As VBGLShaderFunction
    n_ReturnFunc.State     = "func"
    n_ReturnFunc.DataType  = n_ReturnType
    n_ReturnFunc.Name      = n_Name

    Dim n_Arguments() As VBGLShaderVariable
    ReDim n_Arguments(5)
    Set n_Arguments(0) = VBGLShaderVariable.Create("arg", "vec3" , "Normal")
    Set n_Arguments(1) = VBGLShaderVariable.Create("arg", "vec3" , "LightPosition")
    Set n_Arguments(2) = VBGLShaderVariable.Create("arg", "vec3" , "ViewPosition")
    Set n_Arguments(3) = VBGLShaderVariable.Create("arg", "vec3" , "FragPosition")
    Set n_Arguments(4) = VBGLShaderVariable.Create("arg", "vec3" , "Color")
    Set n_Arguments(5) = VBGLShaderVariable.Create("arg", "float", "Strength")

    Dim Norm               As VBGLShaderVariable : Norm               = VBGLShaderVariable.Create("var", "vec3" , "Norm")
    Dim LightDirection     As VBGLShaderVariable : LightDirection     = VBGLShaderVariable.Create("var", "vec3" , "LightDirection")
    Dim Spec               As VBGLShaderVariable : Spec               = VBGLShaderVariable.Create("var", "float", "Spec")
    Dim ViewDirection      As VBGLShaderVariable : ViewDirection      = VBGLShaderVariable.Create("var", "vec3" , "ViewDirection")
    Dim ReflectDirection   As VBGLShaderVariable : ReflectDirection   = VBGLShaderVariable.Create("var", "vec3" , "ReflectDirection")

    Dim n_Workflows() As VBGLShaderWorkflow
    ReDim n_Workflows(5)
    Set n_Workflows(0) = VBGLShaderWorkflow.Create("AddWithValue", "VAR0 = normalize(VAR1)"                    , Norm                   , n_Arguments(0))
    Set n_Workflows(1) = VBGLShaderWorkflow.Create("AddWithValue", "VAR0 = normalize(VAR1 - VAR2)"             , LightDirection         , n_Arguments(1) ,n_Arguments(3))
    Set n_Workflows(2) = VBGLShaderWorkflow.Create("AddWithValue", "VAR0 = normalize(VAR1)"                    , ViewDirection          , n_Arguments(2) , n_Arguments(3))
    Set n_Workflows(3) = VBGLShaderWorkflow.Create("AddWithValue", "VAR0 = reflect(-VAR1, VAR2)"               , ReflectDirection       , LightDirection , Norm)
    Set n_Workflows(4) = VBGLShaderWorkflow.Create("AddWithValue", "VAR0 = pow(max(dot(VAR1, VAR2), 0.0), 32)" , Spec                   , ViewDirection  , ReflectDirection)
    Set n_Workflows(5) = VBGLShaderWorkflow.Create("Return"      , "VAR0 = VAR1 * VAR2 * VAR3"                 , ReturnFunc             , Spec           , n_Arguments(4)   , n_Arguments(5))               
    Set CreateSpecular = Create(n_Name, n_ReturnType, n_ReturnFunc, n_Arguments, n_Workflows)
End Function