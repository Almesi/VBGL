Attribute VB_Name = "VBGLHelpFunctions"

Option Explicit

'This is a Collection of Functions is use in different Classes.
'To Avoid redundancy i removed them and added a Public Function here

Public Declare PtrSafe Sub CopyMemory Lib "kernel32" Alias "RtlCopyMemory" (ByRef Destination As Any, ByVal Source As Any, ByVal Length As Long)

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
Public Function VBGLIntertwine(ByRef NewArr As Variant, ByRef Arr1 As Variant, ByRef Arr2 As Variant) As Variant
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

'Same As Mid, but doesnt take length but instead Ending Point
Public Function VBGLMidP(ByVal Text As String, ByVal StartPoint As Long, ByVal EndPoint As Long) As String
    VBGLMidP = Mid(Text, StartPoint, (EndPoint - StartPoint) + 1)
End Function

' Ubound, but is able to return -1 if Array has no Elements
Public Function USize(ByRef Arr As Variant, Optional ByVal Dimension As Long = 1) As Long
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr, Dimension)
End Function

Public Function VBGLGetNumericCharacters(ByVal Text As String) As String
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
Public Function IsNothing(ByVal Value As Variant) As Boolean
    IsNothing = Value Is Nothing
End Function

'Purely for readability
Public Function IsSomething(ByVal Value As Variant) As Boolean
    IsSomething = IsNothing(Value) Xor True
End Function

Public Function PointerToString(ByVal Pointer As LongPtr, Optional ByVal Length As Long = 0) As String
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

Public Function StringToCharArray(ByVal Text As String) As Byte()
    Dim i As Long
    Dim ByteArr() As Byte
    ReDim ByteArr(Len(Text))
    For i = 1 To Len(Text)
        ByteArr(i - 1) = Asc(Mid(Text, i, 1))
    Next i
    StringToCharArray = ByteArr
End Function

Public Function SplitByLength(ByVal Text As String, ByVal Length As Long) As String()
    Dim i As Long
    Dim Size As Long
    Size = Int(Len(Text) / Length)
    Dim ReturnArr() As String
    ReDim ReturnArr(Size)
    For i = 0 To Size -1
        ReturnArr(i) = VBGLMidP(Text, i * Length + 1, Length)
    Next i
    ReturnArr(i) = VBGLMidP(Text, i * Length + 1, Len(Text))
    SplitByLength = ReturnArr
End Function