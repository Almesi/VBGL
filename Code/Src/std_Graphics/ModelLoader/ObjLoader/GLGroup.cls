VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "GLGroup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Name        As String
Private p_SubGroups() As GLSubGroup
Private p_Count       As Long

Public Property Let Name(n_Name             As String)      : Let p_Name      = n_Name      : End Property
Public Property Let SubGroups(n_SubGroups() As GLSubGroup)  : Let p_SubGroups = n_SubGroups : End Property
Public Property Let Count(n_Count As Long)                  : Let p_Count     = n_Count     : End Property

Public Property Get Name()                  As String       : Let Name        = p_Name      : End Property
Public Property Get SubGroups()             As GLSubGroup() : Let SubGroups   = p_SubGroups : End Property
Public Property Get Count()                 As Long         : Let Count       = p_Count     : End Property

Public Property Let SubGroup(Index As Long, n_SubGroup As GLSubGroup)
    Set p_SubGroups(Index) = n_SubGroup
End Property
Public Property Get SubGroup(Index As Long) As GLSubGroup
    Set SubGroup = p_SubGroups(Index)
End Property

Public Function Create(n_Name As String, GroupData As String) As GLGroup
    Set Create = New GLGroup
    Dim Data As String
    With Create
        .Name      = n_Name
        Call .GetSubGroups(GroupData, "usemtl ", Empty, Empty)
    End With
    If USize(Create.SubGroups) < 0 Then Set Create = Nothing
End Function

Public Sub GetSubGroups(Data As String, ByVal SearchValue As String, ByVal FirstValue As String, ByVal SecondValue As String)
    Dim PrevSearch  As String
    If Data = Empty Then Exit Sub
    PrevSearch = SearchValue
    SearchValue = ChangeSearch(SearchValue)

    Dim FirstPoint  As Long
    FirstPoint = InStr(1, Data, PrevSearch)

    Dim SecondPoint As Long
    SecondPoint = InStr(1, Data, SearchValue)

    If SecondPoint < FirstPoint Then
    Dim Temp As Long
        Temp        = SecondPoint
        SecondPoint = FirstPoint
        FirstPoint  = Temp
    End If

    Dim CurrentData As String
    Dim EndPoint    As Long
    If FirstPoint = 0 And SecondPoint = 0 Then
        CurrentData = MidP(Data, 1, Len(Data))
        EndPoint    = 0
    ElseIf FirstPoint = 0 Then
        CurrentData = MidP(Data, 1, SecondPoint - 1)
        EndPoint    = InStr(SecondPoint, Data, vbCrLf)
    ElseIf SecondPoint = 0 Then
        CurrentData = MidP(Data, 1, FirstPoint - 1)
        EndPoint    = InStr(FirstPoint, Data, vbCrLf)
    Else
        EndPoint    = InStr(SecondPoint, Data, vbCrLf)
        CurrentData = MidP(Data, 1, FirstPoint - 1)
    End If

    Dim Smoothing As String, Material As String
    Call GetSmoothingValue(FirstValue, SecondValue, Material, Smoothing)
    Call Add(Material, Smoothing, CurrentData)

    If FirstPoint = 0 And SecondPoint = 0 Then
        FirstValue  = Empty
        SecondValue = Empty
    ElseIf FirstPoint = 0 Then
        FirstValue = Empty
        SecondValue = GetName(Data, SecondPoint)
    ElseIf SecondPoint = 0 Then
        SecondValue = Empty
        FirstValue  = GetName(Data, FirstPoint)
    Else
        FirstValue  = GetName(Data, FirstPoint)
        SecondValue = GetName(Data, SecondPoint)
    End If
    If EndPoint <> 0 Then Call GetSubGroups(MidP(Data, EndPoint, Len(Data)), SearchValue, FirstValue, SecondValue)
End Sub

Private Function GetName(Data As String, Point As Long) As String
    Dim StartPoint As Long
    Dim EndPoint As Long
    StartPoint = InStr(Point, Data, " ")
    EndPoint   = InStr(Point, Data, vbCrLf)
    GetName    = MidP(Data, StartPoint + 1, EndPoint - 1)
End Function

Private Function ChangeSearch(Text As String) As String
    If Text = "usemtl " Then
        ChangeSearch = "s "
    Else
        ChangeSearch = "usemtl "
    End If
End Function

Private Sub Add(Material As String, Smoothing As String, Data As String)
    Dim NewGroup As GLSubGroup
    Set NewGroup = GLSubGroup.Create(Material, Smoothing, Data)
    If NewGroup Is Nothing Then Exit Sub
    Count = Count + 1
    ReDim Preserve p_SubGroups(Count)
    Set p_SubGroups(Count) = NewGroup
End Sub

Private Function MidP(Text As String, StartPoint As Long, EndPoint As Long) As String
    MidP = Mid(Text, StartPoint, (EndPoint - StartPoint) + 1)
End Function

Private Function USize(Arr As Variant, Optional Dimension As Long = 1)
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr, Dimension)
End Function

Private Sub GetSmoothingValue(Value1 As String, Value2 As String, Material As String, Smoothing As String)
    If Value1 = "off" Or IsNumeric(Value1) Then
        Smoothing = Value1
        Material  = Value2
    Else
        Smoothing = Value2
        Material  = Value1
    End If
End Sub

Private Sub Class_Initialize()
    Count = -1
End Sub