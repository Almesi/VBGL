Attribute VB_Name = "VBGLArrayCreation"

Option Explicit

' Single equivalent to Array()
Public Function ArrayString(ParamArray Values() As Variant) As String()
    Dim Arr() As String
    Dim nValues As Variant
    nValues = Values
    If USize(nValues) = -1 Then Exit Function
    Call ArrayAll(Arr, nValues, "VBGLCStr")
    ArrayString = Arr
End Function
' Single equivalent to Array()
Public Function ArraySingle(ParamArray Values() As Variant) As Single()
    Dim Arr() As Single
    Dim nValues As Variant
    nValues = Values
    If USize(nValues) = -1 Then Exit Function
    Call ArrayAll(Arr, nValues, "VBGLCSng")
    ArraySingle = Arr
End Function
' Long equivalent to Array()
Public Function ArrayLong(ParamArray Values() As Variant) As Long()
    Dim Arr() As Long
    Dim nValues As Variant
    nValues = Values
    If USize(nValues) = -1 Then Exit Function
    Call ArrayAll(Arr, nValues, "VBGLCLng")
    ArrayLong = Arr
End Function
' Byte equivalent to Array()
Public Function ArrayByte(ParamArray Values() As Variant) As Byte()
    Dim Arr() As Byte
    Dim nValues As Variant
    nValues = Values
    If USize(nValues) = -1 Then Exit Function
    Call ArrayAll(Arr, nValues, "VBGLCByte")
    ArrayByte = Arr
End Function

Private Sub ArrayAll(ByRef Goal As Variant, ByRef Values As Variant, ByVal Func As String)
    Dim Flattened()   As Variant  : Flattened  = FlattenArray(Values)
    Dim Dimensions()  As Long     : Dimensions = GetDimensions(Flattened)
    Dim Size          As Long     : Size       = USize(Dimensions)
    Dim CurrentDims() As Long     : ReDim CurrentDims(Size)
    Call VBGLArrayCreateArr(Goal, 0, Dimensions)
    Call ArrayAllRecursive(Goal, Flattened, Dimensions, CurrentDims, Func, 0)
End Sub

Private Sub ArrayAllRecursive(ByRef Goal As Variant, ByRef Source As Variant, ByRef Dimensions() As Long, ByRef CurrentDims() As Long, ByVal Func As String, ByVal Level As Long)
    Dim i As Long
    Dim Size As Long
    Dim Temp As Variant
    Dim Result As Variant

    If Level > USize(Dimensions) Then Exit Sub
    Size = Dimensions(Level)
    For i = 0 To Size
        CurrentDims(Level) = i
        If Level = USize(Dimensions) Then
            Call GetArrayPoint(Temp, Source, CurrentDims)
            Result = Application.Run(Func, Temp)
            Call LetArrayPoint(Goal, Result, CurrentDims)
        Else
            Call ArrayAllRecursive(Goal, Source, Dimensions, CurrentDims, Func, Level + 1)
        End If
    Next i
End Sub


Public Sub VBGLArrayCreate(ByRef Arr As Variant, ByVal Value As Variant, ParamArray Dimensions() As Variant)
    Dim Size As Long
    Size = Ubound(Dimensions)
    Dim nDim() As Long
    ReDim nDim(Size)
    Dim i As Long
    For i = 0 To Size
        nDim(i) = CLng(Dimensions(i))
    Next i
    Call VBGLArrayCreateArr(Arr, Value, nDim)
End Sub

Public Sub VBGLArrayCreateArr(ByRef Arr As Variant, ByVal Value As Variant, ByRef Dimensions() As Long)
    Select Case USize(Dimensions)
        Case -1 : ' Nothing
        Case 0 : ReDim Arr(Dimensions(0))
        Case 1 : ReDim Arr(Dimensions(0), Dimensions(1))
        Case 2 : ReDim Arr(Dimensions(0), Dimensions(1), Dimensions(2))
        Case 3 : ReDim Arr(Dimensions(0), Dimensions(1), Dimensions(2), Dimensions(3))
    End Select
    Call LetArray(Arr, Value, Dimensions)
End Sub



Private Sub LetArray(ByRef Arr As Variant, ByRef Value As Variant, ByRef Dimensions() As Long)
    Select Case USize(Dimensions)
        Case 0 : Call LetDim1(Arr, Value, 0, CLng(Dimensions(0)))
        Case 1 : Call LetDim2(Arr, Value, 0, CLng(Dimensions(0)), 0, CLng(Dimensions(1)))
        Case 2 : Call LetDim3(Arr, Value, 0, CLng(Dimensions(0)), 0, CLng(Dimensions(1)), 0, CLng(Dimensions(2)))
        Case 3 : Call LetDim4(Arr, Value, 0, CLng(Dimensions(0)), 0, CLng(Dimensions(1)), 0, CLng(Dimensions(2)), 0, CLng(Dimensions(3)))
    End Select
End Sub

Private Sub LetArrayArrayPoint(ByRef Arr As Variant, ByRef Values As Variant, ByRef Dimensions() As Long)
    Dim Value As Variant
    Call GetArrayPoint(Value, Values, Dimensions)
    Select Case USize(Dimensions)
        Case 0 : Call LetDim1(Arr, Value, 0, CLng(Dimensions(0)))
        Case 1 : Call LetDim2(Arr, Value, 0, CLng(Dimensions(0)), 0, CLng(Dimensions(1)))
        Case 2 : Call LetDim3(Arr, Value, 0, CLng(Dimensions(0)), 0, CLng(Dimensions(1)), 0, CLng(Dimensions(2)))
        Case 3 : Call LetDim4(Arr, Value, 0, CLng(Dimensions(0)), 0, CLng(Dimensions(1)), 0, CLng(Dimensions(2)), 0, CLng(Dimensions(3)))
    End Select
End Sub

Private Sub LetArrayPoint(ByRef Arr As Variant, ByRef Value As Variant, ByRef Dimensions() As Long)
    Select Case USize(Dimensions)
        Case 0 : Call LetDim1(Arr, Value, CLng(Dimensions(0)), CLng(Dimensions(0)))
        Case 1 : Call LetDim2(Arr, Value, CLng(Dimensions(0)), CLng(Dimensions(0)), CLng(Dimensions(1)), CLng(Dimensions(1)))
        Case 2 : Call LetDim3(Arr, Value, CLng(Dimensions(0)), CLng(Dimensions(0)), CLng(Dimensions(1)), CLng(Dimensions(1)), CLng(Dimensions(2)), CLng(Dimensions(2)))
        Case 3 : Call LetDim4(Arr, Value, CLng(Dimensions(0)), CLng(Dimensions(0)), CLng(Dimensions(1)), CLng(Dimensions(1)), CLng(Dimensions(2)), CLng(Dimensions(2)), CLng(Dimensions(3)), CLng(Dimensions(3)))
    End Select
End Sub

Private Sub GetArrayPoint(ByRef Goal As Variant, ByRef Arr As Variant, ByRef Dimensions() As Long)
    Select Case USize(Dimensions)
        Case 0 : Call GetDim1(Goal, Arr, CLng(Dimensions(0)))
        Case 1 : Call GetDim2(Goal, Arr, CLng(Dimensions(0)), CLng(Dimensions(1)))
        Case 2 : Call GetDim3(Goal, Arr, CLng(Dimensions(0)), CLng(Dimensions(1)), CLng(Dimensions(2)))
        Case 3 : Call GetDim4(Goal, Arr, CLng(Dimensions(0)), CLng(Dimensions(1)), CLng(Dimensions(2)), CLng(Dimensions(3)))
    End Select
End Sub

Private Function FlattenArray(ByVal Arr As Variant) As Variant
    Dim Dimensions() As Long
    Call GetDimensionsParam(Arr, Dimensions)

    Dim CurrentDims() As Long
    ReDim CurrentDims(USize(Dimensions))

    Dim Result() As Variant
    Call VBGLArrayCreateArr(Result, 0, Dimensions)

    Call FlattenWorker(Result, Arr, 0, CurrentDims, Dimensions)

    FlattenArray = Result
End Function

Private Sub FlattenWorker(ByRef Goal As Variant, ByRef Arr As Variant, ByVal CurrentDimension As Long, ByRef CurrentDims() As Long, ByRef Dimensions() As Long)
    Dim i As Long
    For i = 0 To USize(Arr)
        If IsArray(Arr(i)) Then
            Call FlattenWorker(Goal, Arr(i), CurrentDimension + 1, CurrentDims, Dimensions)
            CurrentDims(CurrentDimension) = CurrentDims(CurrentDimension) + 1
        Else
            Dim Value As Variant
            Call VBGLAssign(Value, Arr(i))
            Call LetArrayPoint(Goal, Value, CurrentDims)
            CurrentDims(CurrentDimension) = CurrentDims(CurrentDimension) + 1
        End If
    Next i
    CurrentDims(CurrentDimension) = 0
End Sub

Private Function GetDimensions(ByRef Arr As Variant) As Long()
    Dim i As Long
    Dim Result() As Long
    Dim Size As Long
    i = 1
    Do
        Size = USize(Arr, i)
        If Size <> -1 Then
            Call VBGLAdd(Result, Size)
        Else
            Exit Do
        End If
        i = i + 1
    Loop
    GetDimensions = Result
End Function

Private Sub GetDimensionsParam(ByRef Arr As Variant, ByRef Result() As Long)
    Call GetDimsRecursive(Arr, Result, 0)
End Sub

Private Sub GetDimsRecursive(ByRef Arr As Variant, ByRef Result() As Long, ByVal Level As Long)
    Dim i As Long

    If Not IsArray(Arr) Then Exit Sub
    Dim Size As Long
    Size = USize(Arr)

    If USize(Result) < Level Then
        ReDim Preserve Result(Level)
    End If

    If Result(Level) < Size Then Result(Level) = Size

    For i = 0 To USize(Arr)
        If IsArray(Arr(i)) Then
            Call GetDimsRecursive(Arr(i), Result, Level + 1)
        End If
    Next i
End Sub






Private Sub LetDim1(ByRef Arr As Variant, ByVal Value As Variant, ByVal Start1 As Long, ByVal Limit1 As Long)
    Dim a As Long
    For a = Start1 To Limit1
        Call VBGLAssign(Arr(a), Value)
    Next a
End Sub
Private Sub LetDim2(ByRef Arr As Variant, ByVal Value As Variant, ByVal Start1 As Long, ByVal Limit1 As Long, ByVal Start2 As Long, ByVal Limit2 As Long)
    Dim a As Long, b As Long
    For a = Start1 To Limit1
        For b = Start2 To Limit2
            Call VBGLAssign(Arr(a, b), Value)
        Next b
    Next a
End Sub
Private Sub LetDim3(ByRef Arr As Variant, ByVal Value As Variant, ByVal Start1 As Long, ByVal Limit1 As Long, ByVal Start2 As Long, ByVal Limit2 As Long, ByVal Start3 As Long, ByVal Limit3 As Long)
    Dim a As Long, b As Long, c As Long
    For a = Start1 To Limit1
        For b = Start2 To Limit2
            For c = Start3 To Limit3
                Call VBGLAssign(Arr(a, b, c), Value)
            Next c
        Next b
    Next a
End Sub
Private Sub LetDim4(ByRef Arr As Variant, ByVal Value As Variant, ByVal Start1 As Long, ByVal Limit1 As Long, ByVal Start2 As Long, ByVal Limit2 As Long, ByVal Start3 As Long, ByVal Limit3 As Long, ByVal Start4 As Long, ByVal Limit4 As Long)
    Dim a As Long, b As Long, c As Long, d As Long
    For a = Start1 To Limit1
        For b = Start2 To Limit2
            For c = Start3 To Limit3
                For d = Start4 To Limit4 
                    Call VBGLAssign(Arr(a, b, c, d), Value)
                Next d
            Next c
        Next b
    Next a
End Sub

Private Sub GetDim1(ByRef Result As Variant, ByVal Arr As Variant, ByVal a As Long)
    Call VBGLAssign(Result, Arr(a))
End Sub
Private Sub GetDim2(ByRef Result As Variant, ByVal Arr As Variant, ByVal a As Long, ByVal b As Long)
    Call VBGLAssign(Result, Arr(a, b))
End Sub
Private Sub GetDim3(ByRef Result As Variant, ByVal Arr As Variant, ByVal a As Long, ByVal b As Long, ByVal c As Long)
    Call VBGLAssign(Result, Arr(a, b, c))
End Sub
Private Sub GetDim4(ByRef Result As Variant, ByVal Arr As Variant, ByVal a As Long, ByVal b As Long, ByVal c As Long, ByVal d As Long)
    Call VBGLAssign(Result, Arr(a, b, c, d))
End Sub