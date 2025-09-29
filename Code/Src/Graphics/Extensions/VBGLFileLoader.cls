VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLFileLoader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private Loaded() As String
Private ToLoad() As String
Private ToLoadIndex As Long
Private LoadedIndex As Long

Public Function AddIf(ByVal Path As String) As Long
    AddIf = Find(Path)
    If AddIf = -1 Then
        AddIf = Add(Path)
    End If
End Function

Public Function Add(ByVal Path As String) As Long
    Add = Find(Path)
    If Add = -1 Then Add = AddArr(ToLoad, ToLoadIndex, Path)
End Function

Public Function Consume(ByVal Path As String) As Long
    Dim Found As Long
    Found = Find(Path)
    If Found <> -1 Then
        Consume = AddArr(Loaded, LoadedIndex, Splice(ToLoad, ToLoadIndex, Found))
    Else
        Consume = -1
    End If
End Function

Public Function ConsumeNext() As String
    If ToLoadIndex = -1 Then
        ConsumeNext = Empty
    Else
        ConsumeNext = ToLoad(0)
        Call AddArr(Loaded, LoadedIndex, Splice(ToLoad, ToLoadIndex, 0))
    End If
End Function

Public Function Find(ByVal Path As String) As Long
    Find = FindArr(ToLoad, ToLoadIndex, Path)
    If Find = -1 Then Find = FindArr(Loaded, LoadedIndex, Path)
End Function

Private Function FindArr(Arr() As String, ByVal Index As Long, ByVal Path As String)
    Dim i As Long
    For i = 0 To Index
        If Arr(i) = Path Then
            FindArr = i
            Exit Function
        End If
    Next i
    FindArr = -1
End Function

Private Function AddArr(Arr() As String, ByRef Index As Long, ByVal Value As String) As Long
    Index = Index + 1
    ReDim Preserve Arr(Index)
    Arr(Index) = Value
    AddArr = Index
End Function

Private Function Splice(Arr() As String, ByRef Size As Long, ByVal Index As Long) As String
    Dim Temp() As String
    Dim i As Long
    Dim Counter As Long

    Size = Size - 1
    If Size = -1 Then
        Splice = Arr(0)
        Arr = Temp
        Exit Function
    End If
    
    ReDim Temp(Size)
    For i = 0 To Size
        If i = Index Then
            Splice = Arr(Counter)
            Counter = Counter + 1
        End If
        Temp(i) = Arr(Counter)
        Counter = Counter + 1
    Next i
    Arr = Temp
End Function

Private Sub Class_Initialize()
    ToLoadIndex = -1
    LoadedIndex = -1
End Sub