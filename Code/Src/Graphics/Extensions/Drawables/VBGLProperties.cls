VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLProperties"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private Type Propertyy
    Name As String
    Type As vbVarType
    Value As Variant
End Type

Private Properties() As Propertyy
Private Size As Long

Public Property Let Value(ByVal Name As String, ByVal n_Value As Variant)
    Dim Found As Long
    Found = Find(Name)
    If Found = -1 Then
        Call AddProperty(Name)
        Found = Size
    End If
    Properties(Found).Type  = VarType(n_Value)
    Call VBGLAssign(Properties(Found).Value, n_Value)
End Property

Public Property Get Value(ByVal Name As String) As Variant
    Dim Found As Long
    Found = Find(Name)
    If Found <> -1 Then Call VBGLAssign(Value, Interpret(Found))
End Property

Public Function Create() As VBGLProperties
    Set Create = New VBGLProperties
End Function

Public Function Clone() As VBGLProperties
    Dim i As Long
    Set Clone = Create()
    For i = 0 To Size
        Clone.Value(Properties(i).Name) = GetMissing()
    Next i
End Function

Public Function Copy() As VBGLProperties
    Dim i As Long
    Set Copy = Create()
    For i = 0 To Size
        Copy.Value(Properties(i).Name) = Properties(i).Value
    Next i
End Function

Public Sub AddProperty(ByVal Name As String)
    Dim Found As Long
    Found = Find(Name)
    If Found = -1 Then
        Size = Size + 1
        ReDim Preserve Properties(Size)
        Properties(Size).Name = Name
    End If
End Sub

Public Function GetValueFamily(ByVal FamilyName As String) As Variant
    Dim i As Long
    Dim Found As Long
    Dim Count As Long
    Count = -1
    Dim Arr As Variant
    Arr = InitArray(FamilyName)
    For i = 0 To Size
        Found = FindLike(FamilyName, i)
        If Found <> -1 Then
            Count = Count + 1
            ReDim Preserve Arr(Count)
            Arr(Count) = Value(Properties(Found).Name)
            i = Found
        End If
    Next i
    GetValueFamily = Arr
End Function

Public Sub LetValueFamily(ByVal FamilyName As String, ParamArray Values() As Variant)
    Dim i As Long
    Dim Found As Long
    Dim Count As Long
    Count = -1
    Dim Arr() As Long
    For i = 0 To Size
        Found = FindLike(FamilyName, i)
        If Found <> -1 Then
            Count = Count + 1
            ReDim Preserve Arr(Count)
            Arr(Count) = Found
            i = Found
        End If
    Next i
    For i = 0 To Count
        Value(Properties(Arr(i)).Name) = Values(i)
    Next i
End Sub

Public Sub LetValueFamilyArr(ByVal FamilyName As String, Values() As Variant)
    Dim i As Long
    Dim Found As Long
    Dim Count As Long
    Count = -1
    Dim Arr() As Long
    For i = 0 To Size
        Found = FindLike(FamilyName, i)
        If Found <> -1 Then
            Count = Count + 1
            ReDim Preserve Arr(Count)
            Arr(Count) = Found
            i = Found
        End If
    Next i
    For i = 0 To Count
        Value(Properties(Arr(i)).Name) = Values(i)
    Next i
End Sub

Private Function Find(ByVal Name As String, Optional ByVal Index As Long = 0) As Long
    Dim i As Long
    For i = Index To Size
        If Properties(i).Name = Name Then
            Find = i
            Exit Function
        End If
    Next i
    Find = -1
End Function

Private Function FindLike(ByVal Name As String, Optional ByVal Index As Long = 0) As Long
    Dim i As Long
    For i = Index To Size
        If Properties(i).Name Like Name Then
            FindLike = i
            Exit Function
        End If
    Next i
    FindLike = -1
End Function

Private Function GetMissing(ByVal Optional Value As Variant) As Variant
    GetMissing = Value
End Function

Private Function Interpret(ByVal Index As Long) As Variant
    Select Case Properties(Index).Type
        Case vbSingle: Interpret = CSng(Properties(Index).Value)
        Case vbString: Interpret = CStr(Properties(Index).Value)
    End Select
End Function

Private Function InitArray(ByVal FamilyName As String) As Variant
    Dim Found As Long
    Found = FindLike(FamilyName)
    If Found = -1 Then Exit Function
    Select Case Properties(Found).Type
        Case vbSingle
            Dim TempSingle() As Single
            InitArray = TempSingle
        Case vbString
            Dim TempString() As String
            InitArray = TempString
    End Select
End Function

Private Sub Class_Initialize()
    Size = -1
End Sub