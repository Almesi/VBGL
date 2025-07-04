VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLMatrix"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Implements IMatrixSingle

Private p_DataSingle() As Single
Private p_RowsSingle As Long
Private p_ColumnsSingle As Long

Public Enum MatrixOperator
    Equal = 0
    NotEqual = 1
    Bigger = 2
    Smaller = 3
    BiggerEqual = 4
    SmallerEqual = 5
End Enum

Private Sub Class_Initialize()
    ReDim p_DataSingle(0, 0)
End Sub

Public Property Let DataSingle(n_DataSingle As Variant)
    p_DataSingle = n_DataSingle
End Property
Public Property Get DataSingle() As Variant
    DataSingle = p_DataSingle
End Property

Public Function Create(DataType As vbVarType, Optional RowCount As Long = 0, Optional ColumnCount As Long = 0) As VBGLMatrix
    Set Create = New VBGLMatrix
    Select Case DataType
        Case vbSingle
            Dim NewDataSingle() As Single
            ReDim NewDataSingle(RowCount, ColumnCount)
            Create.DataSingle = NewDataSingle
        Case Else
            Set Create = Nothing
    End Select
End Function

Private Function USize(Arr As Variant, Dimension As Long)
    On Error Resume Next
    USize = -1
    USize = UBound(Arr, Dimension)
End Function

' IMatrixSingle
    Private Property Let IMatrixSingle_Item(Row As Long, Column As Long, Value As Single)
        p_DataSingle(Row, Column) = Value
    End Property
    Private Property Get IMatrixSingle_Item(Row As Long, Column As Long) As Single
        IMatrixSingle_Item = p_DataSingle(Row, Column)
    End Property

    Private Property Let IMatrixSingle_Rows(n_RowsSingle As Long)
        p_RowsSingle = n_RowsSingle
    End Property
    Private Property Get IMatrixSingle_Rows() As Long
        IMatrixSingle_Rows = p_RowsSingle
    End Property

    Private Property Let IMatrixSingle_Columns(n_ColumnsSingle As Long)
        p_ColumnsSingle = n_ColumnsSingle
    End Property
    Private Property Get IMatrixSingle_Columns() As Long
        IMatrixSingle_Columns = p_ColumnsSingle
    End Property

    Private Property Let IMatrixSingle_Data(n_DataSingle As Variant)
        p_DataSingle = n_DataSingle
    End Property
    Private Property Get IMatrixSingle_Data() As Variant
        IMatrixSingle_Data = p_DataSingle
    End Property

    Private Sub IMatrixSingle_Diagonals(Value As Single)
        Dim i As Long
        On Error GoTo Finished
        Do
            p_DataSingle(i, i) = Value
            i = i + 1
        Loop
        Finished:
    End Sub

    Private Sub IMatrixSingle_Clear(Value As Single)
        Dim i As Long, j As Long
        For i = 0 To IMatrixSingle_Rows
            For j = 0 To IMatrixSingle_Columns
                p_DataSingle(i, j) = Value
            Next j
        Next i
    End Sub


    Private Function IMatrixSingle_Add(Matrix1 As Variant, Matrix2 As Variant) As Single()
        Dim i As Long, j As Long
        If Usize(Matrix1, 1) <> USize(Matrix2, 1) Then Exit Function
        If Usize(Matrix1, 2) <> USize(Matrix2, 2) Then Exit Function
        Dim ReturnArr() As Single
        ReDim ReturnArr(USize(Matrix1, 1), USize(Matrix1, 2))
        For i = 0 To Usize(Matrix1, 1)
            For j = 0 To Usize(Matrix1, 2)
                ReturnArr(i, j) = Matrix1(i, j) + Matrix2(i, j)
            Next j
        Next i
        IMatrixSingle_Add = ReturnArr
    End Function

    Private Function IMatrixSingle_Subtract(Matrix1 As Variant, Matrix2 As Variant) As Single()
        Dim i As Long, j As Long
        If Usize(Matrix1, 1) <> USize(Matrix2, 1) Then Exit Function
        If Usize(Matrix1, 2) <> USize(Matrix2, 2) Then Exit Function
        Dim ReturnArr() As Single
        ReDim ReturnArr(USize(Matrix1, 1), USize(Matrix1, 2))
        For i = 0 To Usize(Matrix1, 1)
            For j = 0 To Usize(Matrix1, 2)
                ReturnArr(i, j) = Matrix1(i, j) - Matrix2(i, j)
            Next j
        Next i
        IMatrixSingle_Subtract = ReturnArr
    End Function

    Private Function IMatrixSingle_Multiply(Matrix1 As Variant, Matrix2 As Variant) As Single()
        Dim i As Long, j As Long, k As Long
        If USize(Matrix1, 2) <> USize(Matrix2, 1) Then Exit Function
        Dim ReturnArr() As Single
        ReDim ReturnArr(USize(Matrix1, 1), USize(Matrix2, 2))
        For i = 0 To USize(Matrix1, 1)
            For j = 0 To USize(Matrix2, 2)
                For k = 0 To USize(Matrix1, 2)
                    ReturnArr(i, j) = ReturnArr(i, j) + Matrix1(i, k) * Matrix2(k, j)
                Next k
            Next j
        Next i
        IMatrixSingle_Multiply = ReturnArr
    End Function

    Private Function IMatrixSingle_Divide(Matrix1 As Variant, Matrix2 As Variant) As Single()
        IMatrixSingle_Divide = IMatrixSingle_Multiply(Matrix1, IMatrixSingle_Inverse(Matrix2))
    End Function

    Private Function IMatrixSingle_Scalee(Matrix1 As Variant, Value As Single) As Single()
        Dim i As Long, j As Long
        Dim ReturnArr() As Single
        ReDim ReturnArr(USize(Matrix1, 1), USize(Matrix1, 2))
        For i = 0 To USize(Matrix1, 1)
            For j = 0 To USize(Matrix1, 2)
                ReturnArr(i, j) = Matrix1(i, j) * Value
            Next j
        Next i
        IMatrixSingle_Scalee = ReturnArr
    End Function

    Private Function IMatrixSingle_Translate(Matrix1 As Variant, Value As Single) As Single()
        Dim i As Long, j As Long
        Dim ReturnArr() As Single
        ReDim ReturnArr(USize(Matrix1, 1), USize(Matrix1, 2))
        For i = 0 To USize(Matrix1, 1)
            For j = 0 To USize(Matrix1, 2)
                ReturnArr(i, j) = Matrix1(i, j) + Value
            Next j
        Next i
        IMatrixSingle_Translate = ReturnArr
    End Function

    Private Function IMatrixSingle_RotateX(Dimensions As Long, Theta As Single) As Single()

        Dim i As Long
        Dim ReturnArr() As Single
        ReDim ReturnArr(Dimensions, Dimensions)
        For i = 0 To Dimensions
            ReturnArr(i, i) = 1
        Next
        If Dimensions >= 1 Then
            ReturnArr(1, 1) =  Cos(Theta)
        End If
        If Dimensions > 1 Then
            ReturnArr(1, 2) = -Sin(Theta)
            ReturnArr(2, 1) =  Sin(Theta)
            ReturnArr(2, 2) =  Cos(Theta)
        End If
        IMatrixSingle_RotateX = ReturnArr
    End Function

    Private Function IMatrixSingle_RotateY(Dimensions As Long, Theta As Single) As Single()
        Dim i As Long
        Dim ReturnArr() As Single
        ReDim ReturnArr(Dimensions, Dimensions)
        For i = 0 To Dimensions
            ReturnArr(i, i) = 1
        Next
        If Dimensions >= 1 Then
            ReturnArr(0, 0) =  Cos(Theta)
        End If
        If Dimensions > 1 Then
            ReturnArr(0, 2) =  Sin(Theta)
            ReturnArr(2, 0) = -Sin(Theta)
            ReturnArr(2, 2) =  Cos(Theta)
        End If
        IMatrixSingle_RotateY = ReturnArr
    End Function

    Private Function IMatrixSingle_RotateZ(Dimensions As Long, Theta As Single) As Single()
        Dim i As Long
        Dim ReturnArr() As Single
        ReDim ReturnArr(Dimensions, Dimensions)
            For i = 0 To Dimensions
                ReturnArr(i, i) = 1
            Next
            If Dimensions > 1 Then
                ReturnArr(0, 0) =  Cos(Theta)
                ReturnArr(0, 1) = -Sin(Theta)
                ReturnArr(1, 0) =  Sin(Theta)
                ReturnArr(1, 1) =  Cos(Theta)
            End If
            IMatrixSingle_RotateZ = ReturnArr
    End Function

    Private Function IMatrixSingle_Rotate(Dimensions As Long, Optional ThetaX As Single = 3.14156, Optional ThetaY As Single = 3.14156, Optional ThetaZ As Single = 3.14156) As Single()
        Dim Temp1() As Single, Temp2() As Single, Temp3() As Single
        Temp1 = IMatrixSingle_RotateX(Dimensions, ThetaX)
        Temp2 = IMatrixSingle_RotateY(Dimensions, ThetaY)
        Temp3 = IMatrixSingle_RotateZ(Dimensions, ThetaZ)
        IMatrixSingle_Rotate = IMatrixSingle_Multiply(IMatrixSingle_Multiply(Temp1, Temp2), Temp3)
    End Function

    'Operator As MatrixOperation
    Private Function IMatrixSingle_Compare(Matrix1 As Variant, Matrix2 As Variant, Operator As Long) As Single()
        Dim i As Long, j As Long
        If Usize(Matrix1, 1) <> USize(Matrix2, 1) Then Exit Function
        If Usize(Matrix1, 2) <> USize(Matrix2, 2) Then Exit Function
        Dim ReturnArr() As Single
        ReDim ReturnArr(USize(Matrix1, 1), USize(Matrix1, 2))
        For i = 0 To Usize(Matrix1, 1)
            For j = 0 To Usize(Matrix1, 2)
                Select Case Operator
                    Case Equal        : ReturnArr(i, j) = IIf(Matrix1(i, j) = Matrix2(i, j), True, False)
                    Case NotEqual     : ReturnArr(i, j) = Matrix1(i, j) <> Matrix2(i, j)
                    Case Bigger       : ReturnArr(i, j) = Matrix1(i, j) >  Matrix2(i, j)
                    Case Smaller      : ReturnArr(i, j) = Matrix1(i, j) <  Matrix2(i, j)
                    Case BiggerEqual  : ReturnArr(i, j) = Matrix1(i, j) >= Matrix2(i, j)
                    Case SmallerEqual : ReturnArr(i, j) = Matrix1(i, j) =< Matrix2(i, j)
                End Select
            Next j
        Next i
        IMatrixSingle_Compare = ReturnArr
    End Function

    Private Function IMatrixSingle_Transpose(Matrix1 As Variant) As Single()
        Dim i As Long, j As Long
        Dim ReturnArr() As Single
        ReDim ReturnArr(USize(Matrix1, 2), USize(Matrix1, 1))
        For i = 0 To USize(Matrix1, 2)
            For j = 0 To USize(Matrix1, 1)
                ReturnArr(i, j) = Matrix1(j, i)
            Next j
        Next i
        IMatrixSingle_Transpose = ReturnArr
    End Function

    Private Function IMatrixSingle_Inverse(Matrix1 As Variant) As Single()
        Dim i As Long, j As Long
        Dim ReturnArr() As Single
        ReDim ReturnArr(USize(Matrix1, 1), USize(Matrix1, 2))
        For i = 0 To USize(Matrix1, 1)
            For j = 0 To USize(Matrix1, 2)
                If Matrix1(i, j) <> 0 Then ReturnArr(i, j) = 1 / Matrix1(i, j)
            Next j
        Next i
        IMatrixSingle_Inverse = ReturnArr
    End Function

    Private Function IMatrixSingle_Ortho(Dimensions As Long, Left As Single, Right As Single, Bottom As Single, Top As Single, Near As Single, Far As Single) As Single()
        Dim ReturnArr() As Single
        ReDim ReturnArr(Dimensions, Dimensions) As Single
        Dim rl As Single: rl = Right - Left
        Dim tb As Single: tb = Top - Bottom
        Dim fn As Single: fn = Far - Near
        
        ReturnArr(0, 0) = 2 / rl
        ReturnArr(0, 1) = 0
        ReturnArr(0, 2) = 0
        ReturnArr(0, 3) = 0

        ReturnArr(1, 0) = 0
        ReturnArr(1, 1) = 2 / tb
        ReturnArr(1, 2) = 0
        ReturnArr(1, 3) = 0

        ReturnArr(2, 0) = 0
        ReturnArr(2, 1) = 0
        ReturnArr(2, 2) = -2 / fn
        ReturnArr(2, 3) = 0
    
        ReturnArr(3, 0) = -(Right + Left) / rl
        ReturnArr(3, 1) = -(Top + Bottom) / tb
        ReturnArr(3, 2) = -(Far + Near) / fn
        ReturnArr(3, 3) = 1
        IMatrixSingle_Ortho = ReturnArr
    End Function

    Private Function IMatrixSingle_Perspective(Dimensions As Long, Theta As Single, Aspect As Single, zNear As Single, zFar As Single) As Single()
        Dim ReturnArr() As Single
        ReDim ReturnArr(Dimensions, Dimensions) As Single
        Dim tanHalfTheta As Single
        tanHalfTheta = Tan(Theta / 2)
    
        ReturnArr(0, 0) = 1 / (Aspect * tanHalfTheta)
        ReturnArr(1, 1) = 1 / tanHalfTheta
        ReturnArr(2, 2) = -(zFar + zNear) / (zFar - zNear)
        ReturnArr(2, 3) = -1
        ReturnArr(3, 2) = -(2 * zFar * zNear) / (zFar - zNear)
    
        IMatrixSingle_Perspective = ReturnArr
    End Function

    Private Function IMatrixSingle_Normalize(Matrix1 As Variant) As Single()
        Dim i As Long, j As Long
        Dim Sum As Single
        Dim ReturnArr() As Single
        ReDim ReturnArr(USize(Matrix1, 1), USize(Matrix1, 2))

        For i = 0 To USize(Matrix1, 1)
            Sum = 0
            For j = 0 To USize(Matrix1, 2)
                Sum = Sum + Matrix1(i, j) * Matrix1(i, j)
            Next j
            Sum = CSng(Sqr(Sum))

            If Sum <> 0 Then
                For j = 0 To USize(Matrix1, 2)
                    ReturnArr(i, j) = Matrix1(i, j) / Sum
                Next j
            Else
                For j = 0 To USize(Matrix1, 2)
                    ReturnArr(i, j) = 0
                Next j
            End If
        Next i

        IMatrixSingle_Normalize = ReturnArr
    End Function

    Private Function IMatrixSingle_Cross(Matrix1 As Variant, Matrix2 As Variant) As Single()
        Dim i As Long, j As Long
        Dim ReturnArr() As Single
        ReDim ReturnArr(0, 2)

        ReturnArr(0, 0) = Matrix1(0, 1) * Matrix2(0, 2) - Matrix1(0, 2) * Matrix2(0, 1)
        ReturnArr(0, 1) = Matrix1(0, 2) * Matrix2(0, 0) - Matrix1(0, 0) * Matrix2(0, 2)
        ReturnArr(0, 2) = Matrix1(0, 0) * Matrix2(0, 1) - Matrix1(0, 1) * Matrix2(0, 0)
        IMatrixSingle_Cross = ReturnArr
    End Function

    Private Function IMatrixSingle_Dot(Matrix1 As Variant, Matrix2 As Variant) As Single
        IMatrixSingle_Dot = Matrix1(0, 0) * Matrix2(0, 0) + Matrix1(0, 1) * Matrix2(0, 1) + Matrix1(0, 2) * Matrix2(0, 2)
    End Function

    Private Function IMatrixSingle_LookAt(Position As Variant, Direction As Variant, Up As Variant) As Single()
        Dim ReturnArr() As Single
        ReDim ReturnArr(3, 3)

        Dim Z() As Single   : Z = IMatrixSingle_Normalize(IMatrixSingle_Subtract(Direction, Position))
        Dim X() As Single   : X = IMatrixSingle_Normalize(IMatrixSingle_Cross(Z, Up))
        Dim Y() As Single   : Y = IMatrixSingle_Cross(X, Z)

        ReturnArr(0, 0) = +X(0, 0) : ReturnArr(0, 1) = +X(0, 1) : ReturnArr(0, 2) = +X(0, 2) : ReturnArr(0, 3) = -IMatrixSingle_Dot(X, Position)
        ReturnArr(1, 1) = +Y(0, 0) : ReturnArr(1, 1) = +Y(0, 1) : ReturnArr(1, 2) = +Y(0, 2) : ReturnArr(1, 3) = -IMatrixSingle_Dot(Y, Position)
        ReturnArr(2, 2) = -Z(0, 0) : ReturnArr(2, 2) = -Z(0, 1) : ReturnArr(2, 2) = -Z(0, 2) : ReturnArr(2, 3) = +IMatrixSingle_Dot(Z, Position)

        ReturnArr(3, 3) = 1
        IMatrixSingle_LookAt = ReturnArr
    End Function

    Private Sub IMatrixSingle_Display()
        Dim i As Long, j As Long
        Dim Message As String
        For i = 0 To USize(p_DataSingle, 1)
            For j = 0 To USize(p_DataSingle, 2)
                Message = Message & p_DataSingle(i, j) & "|"
            Next j
            Debug.Print Message
            Message = ""
        Next i
    End Sub
'