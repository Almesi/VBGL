VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLUniforms"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private Const Count As Long = 1

Private Type Uniform
    Location As Long
    Name     As String
    DataType As String
    Data     As Variant
End Type

Private Uniforms() As Uniform
Private Size       As Long
Private Shader     As VBGLShader

Public Property Let Data(ByVal Name As String, ByVal n_Data As Variant)
    Dim Found As Long
    Found = GetUniform(Name)

    Dim UniformType As String: UniformType = Uniforms(Found).DataType
    Dim DataType    As String: DataType    = TypeName(n_Data)
    If Found <> -1 Then
        Call Shader.Bind()
        If DataType = "Single()" And UniformType Like "mat*"     Then
            Dim mat() As Single
            mat = n_Data
            Call SetMatrix(Name, False, Mat)
            Uniforms(Found).Data = Mat
            Exit Property
        End If
        If DataType = "Single()" And UniformType Like "vec*"   Then
            Dim vec() As Single
            vec = n_Data
            Call SetVecF(Name, vec)
            Uniforms(Found).Data = vec
            Exit Property
        End If
        If DataType = "Long()" And UniformType Like "nvec*"  Then
            Dim vecn() As Long
            vecn = n_Data
            Call SetVecI(Name, vecn)
            Uniforms(Found).Data = vecn
            Exit Property
        End If
        If DataType = "Single" And UniformType Like "float"  Then
            Call Set1f(Name, CSng(n_Data))
            Uniforms(Found).Data = n_Data
            Exit Property
        End If
        If DataType = "Long" And UniformType Like "int" Or UniformType Like "sampler2D" Then
            Call Set1i(Name  , CLng(n_Data))
            Uniforms(Found).Data = n_Data
            Exit Property
        End If
        GoTo Error
    Else
        Error:
        Dim NewError As std_Error
        Set NewError = std_Error.Create("VBGLUniforms", "minor", "Data", "Data cannot be used for Uniform: VAR0", Empty, n_Data)
        Call CurrentContext.ErrorHandler.Raise(NewError)
    End If
End Property
Public Sub DataArr(ByVal Name As String, ParamArray n_Data() As Variant)

    Dim DataSingle() As Single
    Dim DataLong()   As Long
    Dim i As Long

    Dim DataType As vbVarType
    DataType = VarType(n_Data(0))
    
    If DataType = vbSingle Then
        ReDim DataSingle(Ubound(n_Data))
        For i = 0 To Ubound(n_Data)
            DataSingle(i) = CSng(n_Data(i))
        Next i
        Data(Name) = DataSingle
    ElseIf DataType = vbLong Then
        ReDim DataLong(Ubound(n_Data))
        For i = 0 To Ubound(n_Data)
            DataLong(i) = CSng(n_Data(i))
        Next i
        Data(Name) = DataLong
    End If
End Sub

Public Property Get Location(ByVal Name As String) As Long
    Dim Found As Long
    If Found <> -1 Then
        Location = Uniforms(Found).Location
    Else
        Location = -1
    End If
End Function
Public Property Get Data(ByVal Name As String) As Variant
    Dim Found As Long
    If Found <> -1 Then
        Data = Uniforms(Found).Data
    Else
        Data = Empty
    End If
End Function

Public Function Create(ByVal n_Shader As VBGLShader) As VBGLUniforms
    Set Create = New VBGLUniforms
    With Create
        Call .UpdateUniforms(n_Shader)
    End With
End Function

Public Sub UpdateUniforms(ByVal n_Shader As VBGLShader)
    Dim i As Long
    Dim Lines()          As String
    Dim CurrentUniform() As String
    Dim UniformName      As String
    Dim NewUniform       As Uniform
    Dim Reset()          As Uniform

    Set Shader = n_Shader
    Call Shader.Bind()
    Uniforms = Reset

    Lines = Split(Shader.Code, vbCrLf)
    For i = 0 To USize(Lines)
        If Lines(i) Like "uniform * *;" Then
            CurrentUniform = Split(Lines(i), " ")
            NewUniform.Name     = Replace(CurrentUniform(Ubound(CurrentUniform)), ";", "")
            NewUniform.DataType = CurrentUniform(Ubound(CurrentUniform) - 1)
            NewUniform.Location = GetLocation(Shader.ID, NewUniform.Name)

            Size = Size + 1
            ReDim Preserve Uniforms(Size)
            Uniforms(Size) = NewUniform
        End If
    Next i
End Sub

Private Sub Set1f(ByVal Name As String, ByVal Data As Single)                                                           : Call glUniform1f(GetExistingLocation(Name), Data)           : End Sub
Private Sub Set2f(ByVal Name As String, ByVal f0 As Single , ByVal f1 As Single)                                        : Call glUniform2f(GetExistingLocation(Name), f0, f1)         : End Sub
Private Sub Set3f(ByVal Name As String, ByVal f0 As Single , ByVal f1 As Single, ByVal f2 As Single)                    : Call glUniform3f(GetExistingLocation(Name), f0, f1, f2)     : End Sub
Private Sub Set4f(ByVal Name As String, ByVal f0 As Single , ByVal f1 As Single, ByVal f2 As Single, ByVal f3 As Single): Call glUniform4f(GetExistingLocation(Name), f0, f1, f2, f3) : End Sub
Private Sub Set1i(ByVal Name As String, ByVal Data As Long)                                                             : Call glUniform1i(GetExistingLocation(Name), Data)           : End Sub
Private Sub Set2i(ByVal Name As String, ByVal i0 As Long , ByVal i1 As Long)                                            : Call glUniform2i(GetExistingLocation(Name), i0, i1)         : End Sub
Private Sub Set3i(ByVal Name As String, ByVal i0 As Long , ByVal i1 As Long, ByVal i2 As Long)                          : Call glUniform3i(GetExistingLocation(Name), i0, i1, i2)     : End Sub
Private Sub Set4i(ByVal Name As String, ByVal i0 As Long , ByVal i1 As Long, ByVal i2 As Long, ByVal i3 As Long)        : Call glUniform4i(GetExistingLocation(Name), i0, i1, i2, i3) : End Sub

Private Sub SetVecF(ByVal Name As String, ByRef Data() As Single)
    Dim Location As Long
    Dim n_Data() As Single

    Location = GetExistingLocation(Name)
    If Location = -1 Then Exit Sub
    If USize(Data, 2) = -1 Then
        n_Data = Data
    Else
        Call Array2DTo1D(Data, n_Data)
    End If
    Select Case USize(n_Data)
        Case 0: Call glUniform1fv(Location, Count, n_Data(0))
        Case 1: Call glUniform2fv(Location, Count, n_Data(0))
        Case 2: Call glUniform3fv(Location, Count, n_Data(0))
        Case 3: Call glUniform4fv(Location, Count, n_Data(0))
    End Select
End Sub

Private Sub SetVecI(ByVal Name As String, ByRef Data() As Long)
    Dim Location As Long
    Dim n_Data() As Single

    Location = GetExistingLocation(Name)
    If Location = -1 Then Exit Sub
    If USize(Data, 2) = -1 Then
        n_Data = Data
    Else
        Call Array2DTo1D(Data, n_Data)
    End If
    Select Case USize(n_Data)
        Case 0: Call glUniform1iv(Location, Count, n_Data(0))
        Case 1: Call glUniform2iv(Location, Count, n_Data(0))
        Case 2: Call glUniform3iv(Location, Count, n_Data(0))
        Case 3: Call glUniform4iv(Location, Count, n_Data(0))
    End Select
End Sub

Private Sub SetMatrix(ByVal Name As String, ByVal Transpose As Long, ByRef Matrix() As Single)
    Dim Location As Long
    Location = GetExistingLocation(Name)
    If Location = -1 Then Exit Sub

    Dim RowCount    As Long  : RowCount    = USize(Matrix, 1) + 1
    Dim ColumnCount As Long  : ColumnCount = USize(Matrix, 2) + 1

    Select Case (RowCount & "x" & ColumnCount)
        Case "2", "2x2" : Call glUniformMatrix2fv(Location  , Count, Transpose, Matrix(0, 0))
        Case "3", "3x3" : Call glUniformMatrix3fv(Location  , Count, Transpose, Matrix(0, 0))
        Case "4", "4x4" : Call glUniformMatrix4fv(Location  , Count, Transpose, Matrix(0, 0))
        Case "2x3"      : Call glUniformMatrix2x3fv(Location, Count, Transpose, Matrix(0, 0))
        Case "3x2"      : Call glUniformMatrix3x2fv(Location, Count, Transpose, Matrix(0, 0))
        Case "2x4"      : Call glUniformMatrix2x4fv(Location, Count, Transpose, Matrix(0, 0))
        Case "4x2"      : Call glUniformMatrix4x2fv(Location, Count, Transpose, Matrix(0, 0))
        Case "3x4"      : Call glUniformMatrix3x4fv(Location, Count, Transpose, Matrix(0, 0))
        Case "4x3"      : Call glUniformMatrix4x3fv(Location, Count, Transpose, Matrix(0, 0))
    End Select
End Sub

Private Function GetExistingLocation(ByVal Name As String) As Long
    Dim Found As Long
    Found = GetUniform(Name)
    If Found <> -1 Then
        GetExistingLocation = Uniforms(Found).Location
    Else
        GetExistingLocation = Found
    End If
End Function

Private Function GetLocation(ByVal ID As Long, ByVal Name As String) As Long
    Dim ByteArr() As Byte
    ByteArr = StringToCharArray(Name)
    GetLocation = glGetUniformLocation(ID, VarPtr(ByteArr(0)))
End Function

Private Function GetUniform(ByVal Name As String) As Long
    Dim i As Long
    GetUniform = -1
    For i = 0 To Size
        If Uniforms(i).Name = Name Then
            GetUniform = i
            Exit Function
        End If
    Next i
    Dim NewError As std_Error
    Set NewError = std_Error.Create("VBGLUniforms", "minor", "GetUniform", "Cannot find Uniform with Name VAR0", Empty, Name)
    Call CurrentContext.ErrorHandler.Raise(NewError)
End Function

Private Sub Array2DTo1D(ByVal Arr As Variant, ByVal ReturnArr As Variant)
    Dim i As Long, j As Long
    Dim Rows As Long, Columns As Long
    Dim Index As Long
    
    Rows    = USize(Arr, 1) + 1
    Columns = USize(Arr, 2) + 1
    
    ReDim ReturnArr(Rows * Columns - 1)
    
    For i = 0 To Rows - 1
        For j = 0 To Columns - 1
            ReturnArr(Index) = Arr(i, j)
            Index = Index + 1
        Next j
    Next i
End Sub

Private Sub Class_Initialize()
    Size = -1
End Sub