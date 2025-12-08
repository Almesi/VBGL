Attribute VB_Name = "VBGLHelpFunctions"

Option Explicit

'This is a Collection of Functions is use in different Classes.
'To Avoid redundancy i removed them and added a Public Function here

Public Declare PtrSafe Sub CopyMemory Lib "kernel32" Alias "RtlCopyMemory" (ByRef Destination As Any, ByVal Source As Any, ByVal Length As Long)

'Same As Mid, but doesnt take length but instead Ending Point
Public Function VBGLMidP(ByVal Text As String, ByVal StartPoint As Long, ByVal EndPoint As Long) As String
    VBGLMidP = Mid(Text, StartPoint, (EndPoint - StartPoint) + 1)
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