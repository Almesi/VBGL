Attribute VB_Name = "TestIMatrixSingle"

Option Explicit

Public Sub Test()
    Dim i As Long, j As Long
    Dim Caller As IMatrixSingle
    Dim Returner As IMatrixSingle
    Dim Temp2 As IMatrixSingle
    Dim Temp3 As IMatrixSingle
    Set Caller = VBGLMatrix.Create(vbSingle, 0, 0)
    Set Returner = VBGLMatrix.Create(vbSingle, 0, 0)
    For i = 0 To 4
        For j = 0 To 4
            Set Temp2 = GetMatrix1(i, j)
            Set Temp3 = GetMatrix2(i, j)

            Returner.Data = Caller.Add(Temp2.Data, Temp3.Data)                                                                 : Debug.Print " " : Returner.Display: Debug.Print " ____"
            Returner.Data = Caller.Subtract(Temp2.Data, Temp3.Data)                                                            : Debug.Print " " : Returner.Display: Debug.Print " ____"
            Returner.Data = Caller.Multiply(Temp2.Data, Temp3.Data)                                                            : Debug.Print " " : Returner.Display: Debug.Print " ____"
            Returner.Data = Caller.Scaling(Temp2.Data, 10)                                                                     : Debug.Print " " : Returner.Display: Debug.Print " ____"
            Returner.Data = Caller.Translate(Temp2.Data, 10)                                                                   : Debug.Print " " : Returner.Display: Debug.Print " ____"
            Returner.Data = Caller.Divide(Temp2.Data, Temp3.Data)                                                              : Debug.Print " " : Returner.Display: Debug.Print " ____"
            Returner.Data = Caller.Compare(Temp2.Data, Temp3.Data, MatrixOperator.Bigger)                                      : Debug.Print " " : Returner.Display: Debug.Print " ____"
            Returner.Data = Caller.Transpose(Temp2.Data)                                                                       : Debug.Print " " : Returner.Display: Debug.Print " ____"
            Returner.Data = Caller.Inverse(Temp2.Data)                                                                         : Debug.Print " " : Returner.Display: Debug.Print " ____"
            Returner.Data = Caller.Rotate(4, i * 90 / 360, 90 + i * 90 / 360, 180 + i * 90 / 360)
            Returner.Data = Caller.Multiply(Temp2.Data, Returner.Data)                                                         : Debug.Print " " : Returner.Display: Debug.Print " ____"
            Debug.Print "-------------------"
        Next j
        Debug.Print "################Test: " i & " " & j & " finished"
    Next i
End Sub

Public Function GetMatrix1(Row As Long, Column As Long) As IMatrixSingle
    Dim i As Long, j As Long
    Set GetMatrix1 = VBGLMatrix.Create(vbSingle, Row, Column)
    For i = 0 To Row
        For j = 0 To Column
            GetMatrix1.Item(i, j) = i * j
        Next j
    Next i
End Function

Public Function GetMatrix2(Row As Long, Column As Long) As IMatrixSingle
    Dim i As Long, j As Long
    Set GetMatrix2 = VBGLMatrix.Create(vbSingle, Row, Column)
    For i = 0 To Row
        For j = 0 To Column
            GetMatrix2.Item(i, j) = i + j
        Next j
    Next i
End Function