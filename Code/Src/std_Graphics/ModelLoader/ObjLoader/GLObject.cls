VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "GLObject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Name          As String
Private p_Groups()      As GLGroup
Private p_Count         As Long

Public Property Let Name(n_Name                   As String)     : Let p_Name           = n_Name          : End Property
Public Property Let Groups(n_Groups()             As GLGroup)    : Let p_Groups         = n_Groups        : End Property
Public Property Let Count(n_Count                 As Long)       : Let p_Count          = n_Count         : End Property

Public Property Get Name()                        As String      : Let Name           = p_Name          : End Property
Public Property Get Groups()                      As GLGroup()   : Let Groups         = p_Groups        : End Property
Public Property Get Count()                       As Long        : Let Count          = p_Count         : End Property

Public Property Let Group(Index As Long, n_Group As GLGroup)
    Set p_Groups(Index) = n_Group
End Property
Public Property Get Group(Index As Long) As GLGroup
    Set Group = p_Groups(Index)
End Property

Public Function Create(n_Name As String, ObjData As String) As GLObject
    Set Create = New GLObject
    Dim Data As String
    With Create
        .Name = n_Name
        Data = .GetGroupData(ObjData)
        If Data <> Empty Then Call .Add(Empty, Data)
    End With
    If USize(Create.Groups) < 0 Then Set Create = Nothing
End Function

Public Function GetGroupData(ByVal Text As String) As String
    Dim Name As String
    Dim Data As String
    Dim EndName As Long

    Dim ObjIndex As Long: ObjIndex = InStr(1, Text, "g ")
    If ObjIndex > 0 Then
        GetGroupData = MidP(Text, 1, ObjIndex - 1)
        EndName = InStr(ObjIndex, Text, vbCrLf)
        If EndName = 0 Then EndName = Len(Text)
        Name = MidP(Text, ObjIndex + Len("g "), EndName - 1)
        Data = GetGroupData(MidP(Text, EndName + 2, Len(Text)))
        Call Add(Name, Data)
    Else
        GetGroupData = Text
    End If
End Function

Public Sub Add(Name As String, Data As String)
    Dim NewGroup As GLGroup
    Set NewGroup = GLGroup.Create(Name, Data)
    If NewGroup Is Nothing Then Exit Sub
    Count = Count + 1
    ReDim Preserve p_Groups(Count)
    Set p_Groups(Count) = NewGroup
End Sub

Private Function MidP(Text As String, StartPoint As Long, EndPoint As Long) As String
    MidP = Mid(Text, StartPoint, (EndPoint - StartPoint) + 1)
End Function

Private Function USize(Arr As Variant, Optional Dimension As Long = 1)
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr, Dimension)
End Function

Private Sub Class_Initialize()
    Count = -1
End Sub