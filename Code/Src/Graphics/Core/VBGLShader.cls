VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLShader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Context    As VBGLContext
Private p_Code       As String
Private p_ID         As Long
Private p_Uniforms   As VBGLUniforms


Public Property Let Context(ByVal n_Context   As VBGLContext)  : Set p_Context   = n_Context  : End Property
Public Property Let Code(ByVal n_Code         As String)       : Let p_Code      = n_Code     : End Property
Public Property Let ID(ByVal n_Value          As Long)         : Let p_ID        = n_Value    : End Property
Public Property Let Uniforms(ByVal n_Uniforms As VBGLUniforms) : Set p_Uniforms  = n_Uniforms : End Property

Public Property Get Context()                 As VBGLContext   : Set Context     = p_Context  : End Property
Public Property Get Code()                    As String        : Let Code        = p_Code     : End Property
Public Property Get ID()                      As Long          : Let ID          = p_ID       : End Property
Public Property Get Uniforms()                As VBGLUniforms  : Set Uniforms    = p_Uniforms : End Property

' Just creates Program number
Public Function Create() As VBGLShader
    Set Create = New VBGLShader
    Create.ID = glCreateProgram()
End Function

'Creates Compiled, Unlinked Shader
Public Function CreateShader(ByVal Shader As Long, ByVal SourceCode As String) As VBGLShader
    Dim Found As VBGLShader
    Set Found = Find(SourceCode)
    If IsSomething(Found) Then
        Set CreateShader = Found
        Exit Function
    End If

    Dim NewID As Long
    NewID = glCreateShader(Shader)
    Set CreateShader = New VBGLShader
    With CreateShader
        .ID = NewID
        If .CompileShader(SourceCode) = Context.ErrorHandler.IS_ERROR Then
            Set CreateShader = Nothing
            Exit Function
        End If
        .Code = SourceCode
    End With
    Call VBGLAdd(LoadedShaders, CreateShader)
End Function

'Creates all Shaders, compiles them and links them into 1 Program
Public Function CreateShaderProgram(ByVal VertexCode As String, ByVal FragmentCode As String) As VBGLShader
    Dim Found As VBGLShader
    Set Found = Find(VertexCode & "|" & FragmentCode)
    If IsSomething(Found) Then
        Set CreateShaderProgram = Found
        Exit Function
    End If

    Dim VertexShader   As VBGLShader
    Set VertexShader   = CreateShader(GL_VERTEX_SHADER  , VertexCode)
    If IsNothing(VertexShader)   Then Exit Function

    Dim FragmentShader As VBGLShader
    Set FragmentShader = CreateShader(GL_FRAGMENT_SHADER, FragmentCode)
    If IsNothing(FragmentShader) Then Exit Function

    Set CreateShaderProgram = Create()
    With CreateShaderProgram
        If .LinkShader(VertexShader, FragmentShader) = Context.ErrorHandler.IS_ERROR Then
            Set CreateShaderProgram = Nothing
            Exit Function
        End If
        .Code = VertexCode & "|" & FragmentCode
        .Uniforms = VBGLUniforms.Create(CreateShaderProgram)
    End With
    Call VBGLAdd(LoadedShaders, CreateShaderProgram)
End Function

Public Function CreateFromFile(ByVal VertexShaderFile As String, ByVal FragmentShaderFile As String) As VBGLShader
    Dim VertexShaderSource As String
    Dim FragmentShaderSource As String
    Dim FSO  as Object 
    Dim TSO As Object 

    Set FSO = CreateObject("Scripting.FileSystemObject")

    Set TSO = FSO.OpenTextFile(VertexShaderFile) 
    VertexShaderSource = TSO.ReadAll

    Set TSO = FSO.OpenTextFile(FragmentShaderFile)
    FragmentShaderSource = TSO.ReadAll
    Set CreateFromFile = CreateShaderProgram(VertexShaderSource, FragmentShaderSource)
End Function

'Seperator is "|"
Public Function CreateFromText(ByVal Text As String) As VBGLShader
    Dim Shaders() As String
    Shaders = Split(Text, "|")
    Set CreateFromText = CreateShaderProgram(Shaders(0), Shaders(1))
End Function

Public Function CompileShader(ByVal SourceCode As String) As Boolean
    Dim SourcePtr(0) As LongPtr
    Dim Length(0) As Long
    Dim Chars() As Byte

    Chars = StrConv(SourceCode, vbFromUnicode)
    SourcePtr(0) = VarPtr(Chars(0))
    If Chars(Ubound(Chars)) = 0 Then
        Call glShaderSource(ID, 1, VarPtr(SourcePtr(0)), 0)
    Else
        Length(0) = Ubound(Chars) + 1
        Call glShaderSource(ID, 1, VarPtr(SourcePtr(0)), Length(0))
    End If
    Call glCompileShader(ID)
    CompileShader = CompileStatus()
End Function

Public Function LinkShader(ByVal VertexShader As VBGLShader, ByVal FragmentShader As VBGLShader) As Boolean
    Call glAttachShader(Me.ID, VertexShader.ID)
    Call glAttachShader(Me.ID, FragmentShader.ID)
    Call glLinkProgram(Me.ID)
    LinkShader = LinkStatus()
End Function

Public Sub DeleteShader(ByVal Shader As Long)
    Call glDeleteShader(Shader)
    Context.CurrentShader = Nothing
End Sub

Public Sub Bind()
    Context.CurrentShader = Me
End Sub

Public Sub Unbind()
    Context.CurrentShader = Nothing
End Sub

' For Caching
Private Function Find(ByVal n_Code As String) As VBGLShader
    Dim i As Long
    For i = 0 To USize(LoadedShaders)
        If LoadedShaders(i).Code = n_Code Then
            Set Find = LoadedShaders(i)
        End If
    Next i
End Function

Private Function CompileStatus() As Boolean
    Dim Compiled As Long
    Call glGetShaderiv(ID, GL_COMPILE_STATUS, Compiled)
    CompileStatus = Context.ErrorHandler.Handle(Compiled <> GL_TRUE, std_Error.Create("VBGLShader", "Critical", ID, PrintErrorShader(ID), Empty))
End Function

Private Function LinkStatus() As Boolean
    Dim Linked As Long
    Call glGetProgramiv(ID, GL_LINK_STATUS, Linked)
    LinkStatus = Context.ErrorHandler.Handle(Linked <> GL_TRUE, std_Error.Create("VBGLShader", "Critical", ID, PrintErrorProgram(ID), Empty))
End Function

Private Function PrintErrorShader(ByVal Shader As Long) As String
    Dim Log() As Byte
    Dim InfoLogLength As Long

    Call glGetShaderiv(Shader, GL_INFO_LOG_LENGTH, InfoLogLength)
    If InfoLogLength <> 0 Then
        ReDim Log(InfoLogLength)
        Call glGetShaderInfoLog(Shader, InfoLogLength, InfoLogLength, VarPtr(Log(0)))
        PrintErrorShader = PrintErrorShader & StrConv(Log, vbUnicode)
    End If
    Call glGetShaderiv(Shader, GL_SHADER_SOURCE_LENGTH, InfoLogLength)
    If InfoLogLength <> 0 Then
        ReDim Log(InfoLogLength)
        Call glGetShaderInfoLog(Shader, InfoLogLength, InfoLogLength, VarPtr(Log(0)))
        PrintErrorShader = PrintErrorShader & StrConv(Log, vbUnicode)
    End If
End Function

Private Function PrintErrorProgram(ByVal Program As Long) As String
    Dim Log() As Byte
    Dim InfoLogLength As Long

    Call glGetProgramiv(Program, GL_INFO_LOG_LENGTH, InfoLogLength)
    If InfoLogLength <> 0 Then
        ReDim Log(InfoLogLength)
        Call glGetProgramInfoLog(Program, InfoLogLength, InfoLogLength, VarPtr(Log(0)))
        PrintErrorProgram = PrintErrorProgram & StrConv(Log, vbUnicode)
    End If
End Function

Private Sub Class_Initialize()
    Context = CurrentContext
End Sub

Private Sub Class_Terminate()
    Call DeleteShader(p_ID)
End Sub