Attribute VB_Name = "VBGLArrayFunctions"

Option Explicit

'This is a Collection of Functions is use in different Classes.
'To Avoid redundancy i removed them and added a Public Function here

'Merge 2 Arrays into 1
Public Sub VBGLMerge(ByRef Arr As Variant, ByRef Arr2 As Variant)
    Dim OldSize As Long: OldSize = USize(Arr) + 1
    Dim NewSize As Long: NewSize = OldSize + (USize(Arr2) + 1) - 1
    ReDim Preserve Arr(NewSize)
    Dim i As Long
    For i = 0 To USize(Arr2)
        Call VBGLAssign(Arr(i + OldSize), Arr2(i))
    Next i
End Sub

'VBGLIntertwine 2 Arrays into 1
'Arrays need to be of same size
Public Sub VBGLIntertwine(ByRef NewArr As Variant, ByRef Arr1 As Variant, ByRef Arr2 As Variant)
    Dim OldSize As Long: OldSize = USize(Arr1) + 1
    Dim NewSize As Long: NewSize = OldSize + (USize(Arr2) + 1) - 1
    ReDim NewArr(NewSize)
    Dim i As Long
    For i = 0 To USize(Arr2)
        Call VBGLAssign(NewArr(i * 2 + 0), Arr1(i))
        Call VBGLAssign(NewArr(i * 2 + 1), Arr2(i))
    Next i
End Sub

'VBGLArrayInsert 2 Arrays into 1
'Arrays dont need to be of same size
Public Sub VBGLArrayInsert(ByRef NewArr As Variant, ByRef Arr1 As Variant, ByRef Arr2 As Variant, ByVal Arr1Break As Long, ByVal Arr2Break As Long)
    Dim Size1   As Long: Size1   = USize(Arr1) + 1
    Dim Size2   As Long: Size2   = USize(Arr2) + 1
    Dim Offset  As Long: Offset  = Arr1Break + Arr2Break
    Dim NewSize As Long: NewSize = Size1 + Size2 - 1
    ReDim NewArr(NewSize)

    Dim i As Long
    Dim j As Long
    Dim Index1 As Long
    Dim Index2 As Long

    For i = 0 To NewSize Step +Offset
        For j = 0 To Arr1Break - 1
            Call VBGLAssign(NewArr(i + j), Arr1(Index1 + j))
        Next j
        For j = 0 To Arr2Break - 1
            Call VBGLAssign(NewArr(Arr1Break + i + j), Arr2(Index2 + j))
        Next j
        Index1 = Index1 + Arr1Break
        Index2 = Index2 + Arr2Break
    Next i
End Sub

'Increase 1D Array by 1 and Add Value
Public Function VBGLAdd(ByRef Arr As Variant, ByVal Value As Variant) As Long
    VBGLAdd = USize(Arr) + 1
    ReDim Preserve Arr(VBGLAdd)
    Call VBGLAssign(Arr(VBGLAdd), Value)
End Function

'Find in Array
Public Function VBGLFind(ByRef Arr As Variant, ByVal Value As Variant) As Long
    Dim i As Long
    For i = 0 To USize(Arr)
        If VBGLCompare(Arr(i), Value) Then
            VBGLFind = i
            Exit Function
        End If
    Next i
    VBGLFind = -1
End Function

' Add if not already added
Public Function VBGLAddUnique(ByRef Arr As Variant, ByVal Value As Variant) As Long
    VBGLAddUnique = VBGLFind(Arr, Value)
    If VBGLAddUnique = -1 Then VBGLAddUnique = VBGLAdd(Arr, Value)
End Function

' Remove index from array
Public Function VBGLArrayRemove(ByRef Arr As Variant, ByVal Index As Long) As Variant
    Dim i As Long
    Dim CurrentIndex As Long
    Dim NewArr As Variant
    Dim Size As Long

    Size = USize(Arr)
    If Size = -1 Then Exit Function
    If Size = 0 Then
        Call VBGLAssign(VBGLArrayRemove, Arr(0)) 
        Erase Arr
        Exit Function
    End If

    NewArr = Arr
    Redim NewArr(Size - 1)
    For i = 0 To Index - 1
        Call VBGLAssign(NewArr(i), Arr(i))
        CurrentIndex = CurrentIndex + 1
    Next i

    Call VBGLAssign(VBGLArrayRemove, Arr(Index))

    For i = Index + 1 To Size
        Call VBGLAssign(NewArr(CurrentIndex), Arr(i))
        CurrentIndex = CurrentIndex + 1
    Next i
    Arr = NewArr
End Function

' Reverse Array
Public Function VBGLArrayReverse(ByRef Arr As Variant) As Variant
    Dim i As Long
    Dim Size As Long
    Dim Temp As Variant
    
    Size = USize(Arr)
    Temp = Arr
    For i = 0 To Size
        Call VBGLAssign(Arr(i), Temp(Size - i))
    Next i
End Function

Public Function VBGLArrayPop(ByRef Arr As Variant) As Variant
    Call VBGLArrayRemove(Arr, USize(Arr))
End Function

' Useful if a Variant can be both Object and normal Value
Public Sub VBGLAssign(ByRef Value1 As Variant, ByVal Value2 As Variant)
    If IsObject(Value2) Then
        Set Value1 = Value2
    Else
        Let Value1 = Value2
    End If
End Sub

' Useful if a Variant can be both Object and normal Value
Public Function VBGLCompare(ByVal Value1 As Variant, ByVal Value2 As Variant) As Boolean
    If IsObject(Value2) Then
        VBGLCompare = Value1 Is Value2
    Else
        If Value1 = Value2 Then VBGLCompare = True
    End If
End Function

' Ubound, but is able to return -1 if Array has no Elements
Public Function USize(ByRef Arr As Variant, Optional ByVal Dimension As Long = 1) As Long
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr, Dimension)
End Function