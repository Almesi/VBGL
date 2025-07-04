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

Private Type Variable
    State As String
    Typee As String
    Name As String
End Type

Private VertexVarIn()    As Variable
Private VertexVarOut()   As Variable
Private FragmentVarIn()  As Variable
Private FragmentVarOut() As Variable
Private VertexSize      As Long
Private FragmentSize    As Long

Public Sub SetUp(Shader As String, Layout As VBGLBufferLayout, Uniforms() As String)
    Select Case Shader
        Case "Vertex"
            Call AddVar(VertexVarOut, "outmust", "vec4", "gl_Position")
            Call AddVarToShader(Layout, VertexVarIn, "layout (location = #) in", "IN")
            Call AddVarToShader(Layout, VertexVarOut, "out", "OUT")
            Call AddVertexUniforms(VertexVarIn, Uniforms)
        Case "Fragment"
            Call AddVar(FragmentVarOut, "out", "vec4", "FragColor")
            Dim i As Long
            For i = 0 To USize(VertexVarOut)
                If VertexVarOut(i).State <> "uniform" And VertexVarOut(i).State <> "outmust" Then
                    Call AddVar(FragmentVarIn, "in", VertexVarOut(i).Typee, VertexVarOut(i).Name)
                End If
            Next i
            Call AddVertexUniforms(FragmentVarIn, Uniforms)
    End Select
End Sub

Public Function VertexShader(Version As String) As String
    VertexShader   = "#version " & Version & vbCrLf
    VertexShader   = VertexShader & GetVariables(VertexVarIn, VertexVarOut)
    VertexShader   = VertexShader & AddMain(VertexVarIn, VertexVarOut)
    VertexShader   = Replace(VertexShader, "OUTPUT", "gl_Position")
    VertexShader   = Replace(VertexShader, "CALCULATE", GetUniform(VertexVarIn, VertexVarIn(0), " * ") & VecShell(VertexVarIn(0)))
    VertexShader   = Replace(VertexShader, "?", VertexVarIn(0).Name)
End Function

Public Function FragmentShader(Version As String) As String
    FragmentShader = "#version " & Version & vbCrLf
    FragmentShader = FragmentShader & GetVariables(FragmentVarIn, FragmentVarOut)
    FragmentShader = FragmentShader & AddMain(FragmentVarIn, FragmentVarOut)
    FragmentShader = Replace(FragmentShader, "OUTPUT", "FragColor")
    FragmentShader = Replace(FragmentShader, "CALCULATE", GetUniform(FragmentVarIn, FragmentVarIn(0), " * "))
    FragmentShader = Replace(FragmentShader, "?", FragmentVarIn(0).Name)
    FragmentShader = Replace(FragmentShader, " * ;", ";")
End Function

Private Function GetUniform(InF() As Variable, Var As Variable, Operator As String) As String
    Dim i As Long
    For i = 0 To USize(InF)
        If InF(i).State = "uniform" Then
            GetUniform = GetUniform & VarTypeInterpret(InF(i)) & Operator
        End If
    Next i
End Function


Private Sub AddVarToShader(Layout As VBGLBufferLayout, Shader() As Variable, State As String, IOrR As String)
    Dim i As Long
    Dim PositionIndex As Long
    Dim TextureIndex  As Long
    Dim NormalIndex   As Long
    Dim ColorIndex    As Long
    Dim Index         As Long
    Dim Category      As String
    Dim Size          As Long
    With Layout
        For i = 0 To .Size
            If Not (State = "out" And i = 0) Then
                Category = .Element(i).GetCategory
                Select Case Category
                    Case "Position" : Index = PositionIndex : PositionIndex = PositionIndex + 1
                    Case "Texture"  : Index = TextureIndex  : TextureIndex  = TextureIndex  + 1
                    Case "Normal"   : Index = NormalIndex   : NormalIndex   = NormalIndex   + 1
                    Case "Color"    : Index = ColorIndex    : ColorIndex    = ColorIndex    + 1
                End Select
                Call AddVar(Shader, Replace(State, "#", i), GetVarType(.Element(i)), IOrR & Category & Index)
            End If
        Next i
    End With
End Sub

Private Sub AddVertexUniforms(Shader() As Variable ,Uniforms() As String)
    Dim i As Long
    Dim Text() As String
    For i = 0 To Ubound(Uniforms)
        Text = Split(Uniforms(i), "|")
        Call AddVar(Shader, "uniform", Text(0), Text(1))
    Next i
End Sub

'layout (location = 0) in vec3 IPosition0;
'layout (location = 1) in vec2 ITexture0;
'layout (location = 2) in vec3 IPosition1;
'[out vec3 OPosition0]; NOT this one, as the output is a vec4 of Category Position in form of gl_Position
'out vec2 OTexture0;
'out vec3 OPosition0;
Private Function GetVariables(InF() As Variable, Out() As Variable) As String
    Dim i As Long
    For i = 0 To USize(InF)
        GetVariables = GetVariables & InF(i).State & " " & InF(i).Typee & " " & InF(i).Name & ";" & vbCrLf
    Next i
    For i = 0 To USize(Out)
        If Out(i).State <> "outmust" Then GetVariables = GetVariables & Out(i).State & " " & Out(i).Typee & " " & Out(i).Name & ";" & vbCrLf
    Next i
End Function

'void main()
'{
'    gl_Position = Projection * View * Rotation * vec4(aPos, 1.0);
'    OTexture0   = ITexture0;
'}
Private Function AddMain(InF() As Variable, Out() As Variable) As String
    AddMain = "void main()" & vbCrLf
    AddMain = AddMain &  "{" & vbCrLf
    AddMain = AddMain & "    OUTPUT = CALCULATE;" & vbCrLf
    AddMain = AddMain & GetOutput(InF, Out)
    AddMain = AddMain &  "}" & vbCrLf
End Function

Private Function GetOutput(InF() As Variable, Out() As Variable) As String
    Dim i As Long
    For i = 1 To USize(Out)
        GetOutput = GetOutput & "    " & Out(i).Name & " = " & Replace(InF(i).Name, "O", "I") & ";" & vbCrLf
    Next i
End Function


Private Function VecShell(Var As Variable) As String
    Select Case True
        Case Var.Typee Like "*vec1" : VecShell = "vec4(?, 1.0, 1.0, 1.0)"
        Case Var.Typee Like "*vec2" : VecShell = "vec4(?, 1.0, 1.0)"
        Case Var.Typee Like "*vec3" : VecShell = "vec4(?, 1.0)"
        Case Var.Typee Like "*vec4" : VecShell = "?"
    End Select
End Function

Private Function VarTypeInterpret(Var As Variable) As String
    Select Case Var.Typee
        Case "sampler2D": VarTypeInterpret = "texture(" & Var.Name & ", ?)"
        Case Else       : VarTypeInterpret = Var.Name
    End Select
End Function

Private Sub AddVar(Shader() As Variable, State As String, Typee As String, Name As String)
    Dim Size As Long: Size = USize(Shader) + 1
    ReDim Preserve Shader(Size)
    Shader(Size).State = State
    Shader(Size).Typee = Typee
    Shader(Size).Name  = Name
End Sub

Private Function GetVarType(Element As VBGLBufferElement) As String
    Dim Pre As String
    Dim Typee As String
    Select Case Element.DataType
        Case GL_DOUBLE        : Pre = "d"
        Case GL_FLOAT         : Pre = ""
        Case GL_UNSIGNED_INT  : Pre = "u"
    End Select
    Typee = Element.GetTypeSize
    GetVarType = Pre & "vec" & Typee
End Function

Private Function USize(Arr() As Variable)
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr)
End Function