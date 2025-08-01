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

Private p_Context As VBGLContext
Private p_Code    As String
Private p_ID      As Long


Public Property Let Context(n_Context As VBGLContext): Set p_Context = n_Context : End Property
Public Property Let Code(n_Code       As String)     : Let p_Code    = n_Code    : End Property
Public Property Let ID(n_Value        As Long)       : Let p_ID      = n_Value   : End Property

Public Property Get Context()         As VBGLContext : Set Context   = p_Context : End Property
Public Property Get Code()            As String      : Let Code      = p_Code    : End Property
Public Property Get ID()              As Long        : Let ID        = p_ID      : End Property


Public Function CreateFromFile(VertexShaderFile As String, FragmentShaderFile As String) As VBGLShader
    Dim VertexShaderSource As String
    Dim FragmentShaderSource As String
    Dim FSO  as Object 
    Dim TSO As Object 

    Set FSO = CreateObject("Scripting.FileSystemObject")

    Set TSO = FSO.OpenTextFile(VertexShaderFile) 
    VertexShaderSource = TSO.ReadAll

    Set TSO = FSO.OpenTextFile(FragmentShaderFile)
    FragmentShaderSource = TSO.ReadAll
    Set CreateFromFile = CreateFromString(VertexShaderSource, FragmentShaderSource)
End Function

Public Function CreateFromText(Text As String) As VBGLShader
    Dim Shaders() As String
    Shaders = Split(Text, "|")
    Set CreateFromText = CreateFromString(Shaders(0), Shaders(1))
End Function

Public Function CreateFromString(VertexShaderSource As String, FragmentShaderSource As String) As VBGLShader
    Dim VertexShader As Long
    Dim FragmentShader As Long
    Set CreateFromString = New VBGLShader
    With CreateFromString
        VertexShader   = glCreateShader(GL_VERTEX_SHADER)
        FragmentShader = glCreateShader(GL_FRAGMENT_SHADER)

        If .CompileShader(VertexShader, VertexShaderSource)     = False Then GoTo Error
        If .CompileShader(FragmentShader, FragmentShaderSource) = False Then GoTo Error
        .ID = glCreateProgram()

        Call glAttachShader(.ID, VertexShader)
        Call glAttachShader(.ID, FragmentShader)

        Call .DeleteShader(VertexShader)
        Call .DeleteShader(FragmentShader)

        Call glLinkProgram(.ID)
        If .LinkStatus(.ID) = False Then GoTo Error
        .Code = VertexShaderSource & "|" & FragmentShaderSource
    End With
    Exit Function

    Error:
    Set CreateFromString = Nothing
End Function

Public Function CompileShader(Shader As Long, SourceCode As String) As Boolean
    Dim SourcePtr(0) As LongPtr
    Dim Length(0) As Long
    Dim Chars() As Byte

    Chars = StrConv(SourceCode, vbFromUnicode)
    SourcePtr(0) = VarPtr(Chars(0))
    If Chars(Ubound(Chars)) = 0 Then
        Call glShaderSource(Shader, 1, VarPtr(SourcePtr(0)), 0)
    Else
        Length(0) = Ubound(Chars) + 1
        Call glShaderSource(Shader, 1, VarPtr(SourcePtr(0)), Length(0))
    End If
    Call glCompileShader(Shader)
    CompileShader = CompileStatus(Shader)
    If CompileShader = False Then DeleteShader(Shader)
End Function

Public Function CompileStatus(Shader As Long) As Boolean
    Dim Compiled As Long
    Call glGetShaderiv(Shader, GL_COMPILE_STATUS, Compiled)
    If Compiled = GL_FALSE Then
        Debug.Print PrintErrorShader(Shader)
    Else
        CompileStatus = True
    End If
End Function

Public Function LinkStatus(Shader As Long) As Boolean
    Dim Linked As Long
    Call glGetProgramiv(Shader, GL_LINK_STATUS, Linked)
    If Linked = GL_FALSE Then
        Debug.Print PrintErrorProgram(Shader)
    Else
        LinkStatus = True
    End If
End Function

Public Sub Bind()
    VBGLContext.CurrentShader = ID
End Sub

Public Sub Unbind()
    VBGLContext.CurrentShader = 0
End Sub

Public Function GetLocation(Name As String) As Long
    Dim i As Long
    Dim ByteArr() As Byte
    ReDim ByteArr(Len(Name))
    For i = 1 To Len(Name)
        ByteArr(i - 1) = Asc(Mid(Name, i, 1))
    Next i
    GetLocation = glGetUniformLocation(ID, VarPtr(ByteArr(0)))
End Function

Private Function PrintErrorShader(Shader As Long) As String
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

Private Function PrintErrorProgram(Program As Long) As String
    Dim Log() As Byte
    Dim InfoLogLength As Long

    Call glGetProgramiv(Program, GL_INFO_LOG_LENGTH, InfoLogLength)
    If InfoLogLength <> 0 Then
        ReDim Log(InfoLogLength)
        Call glGetProgramInfoLog(Program, InfoLogLength, InfoLogLength, VarPtr(Log(0)))
        PrintErrorProgram = PrintErrorProgram & StrConv(Log, vbUnicode)
    End If
End Function

Public Sub DeleteShader(Shader As Long)
    Call glDeleteShader(Shader)
    VBGLContext.CurrentShader = 0
End Sub


Public Function SetAny(Name As String, Data As Variant)
    Dim DataType   As vbVarType: DataType   = GetDataType(Data)
    Dim Dimensions As Long     : Dimensions = GetDimensions(Data)
    Dim Bounds()   As Long
    If Dimensions > 0 Then
        ReDim Bounds(Dimensions - 1)
        Call GetBounds(Data, Bounds)
    End If
    Select Case Dimensions
        Case 0
            Select Case DataType
                Case vbSingle: Call Set1f(Name, CSng(Data))
                Case vbLong  : Call Set1i(Name, CLng(Data))
            End Select
        Case 1
            Select Case DataType
                Case vbSingle: Call SetVectorF(Name, CStr(Bounds(0)), 1, Data)
                Case vbLong  : Call SetVectorI(Name, CStr(Bounds(0)), 1, Data)
            End Select
        Case 2
            Select Case DataType
                Case vbSingle: Call SetMatrix(Name, CStr(Bounds(0) & "x" & Bounds(1)), 1, GL_FALSE, Data)
            End Select
        Case Else
    End Select
End Function


Public Sub Set1f(Name As String, Value As Single)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Call glUniform1f(Location, Value)
End Sub

Public Sub Set2f(Name As String, f0 As Single , f1 As Single)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Call glUniform2f(Location, f0, f1)
End Sub

Public Sub Set3f(Name As String, f0 As Single , f1 As Single, f2 As Single)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Call glUniform3f(Location, f0, f1, f2)
End Sub

Public Sub Set4f(Name As String, f0 As Single , f1 As Single, f2 As Single, f3 As Single)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Call glUniform4f(Location, f0, f1, f2, f3)
End Sub


Public Sub Set1i(Name As String, Value As Long)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Call glUniform1i(Location, Value)
End Sub

Public Sub Set2i(Name As String, f0 As Long , f1 As Long)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Call glUniform2i(Location, f0, f1)
End Sub

Public Sub Set3i(Name As String, f0 As Long , f1 As Long, f2 As Long)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Call glUniform3i(Location, f0, f1, f2)
End Sub

Public Sub Set4i(Name As String, f0 As Long , f1 As Long, f2 As Long, f3 As Long)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Call glUniform4i(Location, f0, f1, f2, f3)
End Sub


Public Sub SetVectorF(Name As String, VectorType As String, Count As Long, Data As Variant)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Dim TempData() As Single
    TempData = Data
    Select Case VectorType
        Case "1": Call glUniform1fv(Location, Count, TempData(0))
        Case "2": Call glUniform2fv(Location, Count, TempData(0))
        Case "3": Call glUniform3fv(Location, Count, TempData(0))
        Case "4": Call glUniform4fv(Location, Count, TempData(0))
    End Select
End Sub

Public Sub SetVectorI(Name As String, VectorType As String, Count As Long, Data As Variant)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Dim TempData() As Long
    TempData = Data
    Select Case VectorType
        Case "1": Call glUniform1iv(Location, Count, TempData(0))
        Case "2": Call glUniform2iv(Location, Count, TempData(0))
        Case "3": Call glUniform3iv(Location, Count, TempData(0))
        Case "4": Call glUniform4iv(Location, Count, TempData(0))
    End Select
End Sub


Public Sub SetMatrix(Name As String, MatrixType As String, Count As Long, Transpose As Long, Data As Variant)
    Dim Location As Long: Location = GetLocation(Name)
    If Location = -1 Then Exit Sub
    Dim TempData() As Single
    TempData = Data
    Select Case MatrixType
        Case "2", "2x2" : Call glUniformMatrix2fv(Location  , Count, Transpose, TempData(0, 0))
        Case "3", "3x3" : Call glUniformMatrix3fv(Location  , Count, Transpose, TempData(0, 0))
        Case "4", "4x4" : Call glUniformMatrix4fv(Location  , Count, Transpose, TempData(0, 0))
        Case "2x3"      : Call glUniformMatrix2x3fv(Location, Count, Transpose, TempData(0, 0))
        Case "3x2"      : Call glUniformMatrix3x2fv(Location, Count, Transpose, TempData(0, 0))
        Case "2x4"      : Call glUniformMatrix2x4fv(Location, Count, Transpose, TempData(0, 0))
        Case "4x2"      : Call glUniformMatrix4x2fv(Location, Count, Transpose, TempData(0, 0))
        Case "3x4"      : Call glUniformMatrix3x4fv(Location, Count, Transpose, TempData(0, 0))
        Case "4x3"      : Call glUniformMatrix4x3fv(Location, Count, Transpose, TempData(0, 0))
    End Select
End Sub


Private Function GetDataType(Data As Variant) As vbVarType
    Dim Dimensions As Long
    Dimensions = GetDimensions(Data)
    Select Case Dimensions
        Case 0: GetDataType = VarType(Data)
        Case 1: GetDataType = VarType(Data(0))
        Case 2: GetDataType = VarType(Data(0, 0))
    End Select
End Function

Private Function GetDimensions(Data As Variant) As Long
    Dim Count As Long: Count = 1
    Dim RandomValue As Long
    On Error GoTo Found
    Do
        RandomValue = UBound(Data, Count)
        GetDimensions = GetDimensions + 1
        Count = Count + 1
    Loop
    Found:
End Function

Private Sub GetBounds(Arr As Variant, Bounds() As Long)
    Dim i As Long
    For i = 0 To Ubound(Bounds)
        Bounds(i) = Ubound(Arr, i + 1) + 1
    Next i
End Sub

Private Sub Class_Initialize()
    Context = VBGLContext
End Sub

Private Sub Class_Terminate()
    Call DeleteShader(p_ID)
End Sub