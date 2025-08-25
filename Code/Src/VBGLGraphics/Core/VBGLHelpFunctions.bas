Attribute VB_Name = "VBGLHelpFunctions"

Option Explicit

'This is a Collection of Functions is use in different Classes.
'To Avoid redundancy i removed them and added a Public Function here



'Merge 2 Arrays into 1
Public Sub VBGLMerge(Arr As Variant, Arr2 As Variant)
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
Public Function VBGLIntertwine(NewArr As Variant, Arr1 As Variant, Arr2 As Variant) As Variant
    Dim OldSize As Long: OldSize = USize(Arr1) + 1
    Dim NewSize As Long: NewSize = OldSize + (USize(Arr2) + 1) - 1
    ReDim NewArr(NewSize)
    Dim i As Long
    For i = 0 To USize(Arr2)
        Call VBGLAssign(NewArr(i * 2 + 0), Arr1(i))
        Call VBGLAssign(NewArr(i * 2 + 1), Arr2(i))
    Next i
End Function

'Increase 1D Array by 1 and Add Value
Public Function VBGLAdd(Arr As Variant, Value As Variant) As Long
    VBGLAdd = USize(Arr) + 1
    ReDim Preserve Arr(VBGLAdd)
    Call VBGLAssign(Arr(VBGLAdd), Value)
End Function

'Find in Array
Public Function VBGLFind(Arr As Variant, Value As Variant) As Long
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
Public Function VBGLAddUnique(Arr As Variant, Value As Variant) As Long
    VBGLAddUnique = VBGLFind(Arr, Value)
    If VBGLAddUnique = -1 Then VBGLAddUnique = VBGLAdd(Arr, Value)
End Function

' Useful if a Variant can be both Object and normal Value
Public Sub VBGLAssign(Value1 As Variant, Value2 As Variant)
    If IsObject(Value2) Then
        Set Value1 = Value2
    Else
        Let Value1 = Value2
    End If
End Sub

' Useful if a Variant can be both Object and normal Value
Public Function VBGLCompare(Value1 As Variant, Value2 As Variant) As Boolean
    If IsObject(Value2) Then
        VBGLCompare = Value1 Is Value2
    Else
        If Value1 = Value2 Then VBGLCompare = True
    End If
End Function

'Same As Mid, but doesnt take length but instead Ending Point
Public Function VBGLMidP(Text As String, StartPoint As Long, EndPoint As Long) As String
    VBGLMidP = Mid(Text, StartPoint, (EndPoint - StartPoint) + 1)
End Function

' Ubound, but is able to return -1 if Array has no Elements
Public Function USize(Arr As Variant, Optional Dimension As Long = 1) As Long
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr, Dimension)
End Function

Public Function VBGLGetNumericCharacters(Text As String) As String
    Dim i As Integer
    Dim ch As String

    For i = 1 To Len(Text)
        ch = Mid(Text, i, 1)
        If ch Like "#" Then
            VBGLGetNumericCharacters = VBGLGetNumericCharacters & ch
        End If
    Next i
End Function

'Purely for readability
Public Function IsNothing(Value As Variant) As Boolean
    IsNothing = Value Is Nothing
End Function

'Purely for readability
Public Function IsSomething(Value As Variant) As Boolean
    IsSomething = IsNothing(Value) Xor True
End Function

Public Function PointerToString(Pointer As LongPtr, Optional Length As Long = 0) As String
    Dim Bytes() As Byte
    Dim Char As Byte
    Dim i As LongPtr
    
    If Length <= 0 Then
        i = Pointer
        Do
            Call CopyMemory(Char, i, 1)
            If Char = 0 Then Exit Do
            i = i + 1
        Loop
        Length = CLng(i - Pointer)
    End If

    If Length <= 0 Then Exit Function
    ReDim Bytes(Length - 1)
    Call CopyMemory(Bytes(0), Pointer, Length)
    PointerToString = StrConv(Bytes, vbUnicode)
End Function