VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLShaderVariable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Implements VBGLIShaderElement

Private p_State      As String
Private p_ReturnType As String
Private p_Name       As String
Private p_Operator   As String

Public Property Let State(ByVal n_State           As String): p_State      = n_State      : End Property
Public Property Let ReturnType(ByVal n_ReturnType As String): p_ReturnType = n_ReturnType : End Property
Public Property Let Name(ByVal n_Name             As String): p_Name       = n_Name       : End Property
Public Property Let Operator(ByVal n_Operator     As String): p_Operator   = n_Operator   : End Property

Public Property Get State()                       As String : State        = p_State      : End Property
Public Property Get ReturnType()                  As String : ReturnType   = p_ReturnType : End Property
Public Property Get Name()                        As String : Name         = p_Name       : End Property
Public Property Get Operator()                    As String : Operator     = p_Operator   : End Property

Private Function VBGLIShaderElement_GetVariable() As VBGLShaderVariable
    Set VBGLIShaderElement_GetVariable = Me
End Function
Private Function VBGLIShaderElement_GetVariableCall(ByVal WithReturnType As Boolean) As String
    Dim Result As String
    If WithReturnType Then Result = ReturnType & " "
    Result = Result & Name
    VBGLIShaderElement_GetVariableCall = Result
End Function
Private Function VBGLIShaderElement_GetVariableAll() As String
    VBGLIShaderElement_GetVariableAll = VBGLIShaderElement_GetVariableCall(True)
End Function
Private Function VBGLIShaderElement_Element() As Variant
    Set VBGLIShaderElement_Element = Me
End Function

Public Function Create(ByVal n_State As String, ByVal n_ReturnType As String, ByVal n_Name As String, Optional ByVal n_Operator As String = Empty) As VBGLShaderVariable
    Set Create = New VBGLShaderVariable
    With Create
        .State    = n_State
        .ReturnType = n_ReturnType
        .Name     = n_Name
        .Operator = n_Operator
    End With
End Function
Public Function CreateElement(ByVal n_State As String, ByVal n_ReturnType As String, ByVal n_Name As String, Optional ByVal n_Operator As String = Empty) As VBGLIShaderElement
    Set CreateElement = Create(n_State, n_ReturnType, n_Name, n_Operator)
End Function
Public Function Construct(ByVal n_ReturnType As String, ByVal n_Operator As String, ParamArray Values() As Variant) As VBGLShaderVariable
    Dim Temp    As Variant: Temp = Values
    Dim n_State As String : n_State = VBGLShaderStateVariable
    Dim n_Name  As String : n_Name = GetConstructorValue(n_ReturnType, Temp)
    Set Construct = Create(n_State, n_ReturnType, n_Name, n_Operator)
End Function

Public Function Constructint()   As VBGLShaderVariable : Set Constructint   = Construct("int"   , "*", "1")     : End Function
Public Function Constructfloat() As VBGLShaderVariable : Set Constructfloat = Construct("float" , "*", "1.0")   : End Function
Public Function Constructbool()  As VBGLShaderVariable : Set Constructbool  = Construct("bool"  , "*", "false") : End Function
Public Function Constructivec2() As VBGLShaderVariable : Set Constructivec2 = Construct("ivec2" , "*", "0")     : End Function
Public Function Constructivec3() As VBGLShaderVariable : Set Constructivec3 = Construct("ivec3" , "*", "0")     : End Function
Public Function Constructivec4() As VBGLShaderVariable : Set Constructivec4 = Construct("ivec4" , "*", "0")     : End Function
Public Function Constructbvec2() As VBGLShaderVariable : Set Constructbvec2 = Construct("bvec2" , "*", "false") : End Function
Public Function Constructbvec3() As VBGLShaderVariable : Set Constructbvec3 = Construct("bvec3" , "*", "false") : End Function
Public Function Constructbvec4() As VBGLShaderVariable : Set Constructbvec4 = Construct("bvec4" , "*", "false") : End Function
Public Function Constructvec2()  As VBGLShaderVariable : Set Constructvec2  = Construct("vec2"  , "*", "0.0")   : End Function
Public Function Constructvec3()  As VBGLShaderVariable : Set Constructvec3  = Construct("vec3"  , "*", "0.0")   : End Function
Public Function Constructvec4()  As VBGLShaderVariable : Set Constructvec4  = Construct("vec4"  , "*", "0.0")   : End Function
Public Function Constructmat2()  As VBGLShaderVariable : Set Constructmat2  = Construct("mat2"  , "*", "1.0")   : End Function
Public Function Constructmat3()  As VBGLShaderVariable : Set Constructmat3  = Construct("mat3"  , "*", "1.0")   : End Function
Public Function Constructmat4()  As VBGLShaderVariable : Set Constructmat4  = Construct("mat4"  , "*", "1.0")   : End Function


Public Function MakeNewVariable(ByVal Var2 As VBGLShaderVariable, ByVal Index1 As Long , ByVal Index2 As Long, ByVal Text As String, ByVal n_Operator As String) As VBGLShaderVariable
    Dim n_State      As String: n_State    = VBGLShaderStateVariable
    Dim n_ReturnType As String: n_ReturnType = Me.ReturnType
    Dim n_Name       As String
    n_Name = Text
    n_Name = Replace(n_Name, "VAR" & Index1, Me.Name)
    n_Name = Replace(n_Name, "VAR" & Index2, TransformType(Var2))
    Set MakeNewVariable = Create(n_State, n_ReturnType, n_Name, n_Operator)
End Function

Public Function Clone() As VBGLShaderVariable
    Set Clone = Create(State, ReturnType, Name, Operator)
End Function
Public Function CloneElement() As VBGLIShaderElement
    Set CloneElement = CreateElement(State, ReturnType, Name, Operator)
End Function

Public Function Reverse() As VBGLShaderVariable
    Dim Result As New VBGLShaderVariable

    If State Like "*in*" Then
        Result.State = VBGLShaderStateOut
        Result.Name  = Replace(Name, "in", "out")
    Else
        Result.State = "in"
        Result.Name  = Name
    End If
    Result.ReturnType = ReturnType
    Result.Operator = Operator
    Set Reverse = Result
End Function

Public Function TransformType(ByVal Var2 As VBGLShaderVariable) As String
    ' To stop transformation of vec2 Texture into a vec4
    If Var2.Name Like "*Texture*" Then
        TransformType = Var2.Name
        Exit Function
    ElseIf Var2.ReturnType Like "workflow" Then
        TransformType = Var2.Name
        Exit Function
    End If
    Dim VAR1Size   As String            : VAR1Size      = VBGLGetNumericCharacters(Me.ReturnType)
    Dim Var2Size   As String            : Var2Size      = VBGLGetNumericCharacters(Var2.ReturnType)
    Dim Offset     As Long
    If IsNumeric(VAR1Size) And IsNumeric(Var2Size) Then
        Offset = CLng(VAR1Size) - CLng(Var2Size)
    Else
        Offset = 0
    End If
    Dim n_ReturnType As String
    Select Case True 
        Case Me.ReturnType Like "*vec*" And Var2.ReturnType Like "*mat*"
            n_ReturnType = Replace(Me.ReturnType, VAR1Size, "")  & VAR1Size
        Case Me.ReturnType Like "*mat*" And Var2.ReturnType Like "*vec*"
            n_ReturnType = Replace(Var2.ReturnType , Var2Size, "")  & VAR1Size
        Case Else
            n_ReturnType = Replace(Me.ReturnType   , VAR1Size, "")  & VAR1Size
    End Select
    Select Case Offset
        Case +0: TransformType = Var2.Name
        Case +1: TransformType = n_ReturnType & "(" & Var2.Name & ", 1.0)"
        Case +2: TransformType = n_ReturnType & "(" & Var2.Name & ", 0.0, 1.0)"
        Case +3: TransformType = n_ReturnType & "(" & Var2.Name & ", 0.0, 0.0, 1.0)"
        Case -1: TransformType = n_ReturnType & "(" & Var2.Name & ")"
        Case -2: TransformType = n_ReturnType & "(" & Var2.Name & ")"
        Case -3: TransformType = n_ReturnType & "(" & Var2.Name & ")"
    End Select
End Function

Private Function GetConstructorValue(ByVal n_ReturnType As String, ByVal Values As Variant) As String
    Dim ReplaceText As String
    Dim i As Long, j As Long

    Dim Size As String
    Size = VBGLGetNumericCharacters(n_ReturnType)
    Dim Start As String
    Start = n_ReturnType & "(REPLACE)"
    Select Case n_ReturnType
        Case "int"   : ReplaceText = Values(0)
        Case "float" : ReplaceText = Values(0)
        Case "bool"  : ReplaceText = Values(0)
        Case "ivec2", "ivec3", "ivec4", "bvec2", "bvec3", "bvec4", "vec2", "vec3", "vec4"
            For i = 0 To USize(Values)
                ReplaceText = ReplaceText & Values(i) & ", "
            Next i
        Case "mat2", "mat3", "mat4"
            Dim VecValues() As String
            ReDim VecValues(CLng(Size) - 1)
            For i = 0 To USize(VecValues)
                For j = 0 To USize(VecValues)
                    If i = j Then
                        VecValues(i) = Values(0)
                    Else
                        VecValues(j) = "0.0"
                    End If
                Next j
                ReplaceText = ReplaceText & GetConstructorValue("vec" & Size, VecValues) & ", "
            Next i
    End Select
    ReplaceText = Replace(Start, "REPLACE", ReplaceText)
    ReplaceText = Replace(ReplaceText, ", )", ")")
    GetConstructorValue = ReplaceText
End Function