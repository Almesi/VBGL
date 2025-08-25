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

'.obj file, "g " keyword until next "g " keyword is one GLGroup


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
        Call .MergeSubGroups()
    End With
    If USize(Create.SubGroups) < 0 Then Set Create = Nothing
End Function

' I FUCKING HATE THIS SUB
' Not working, material gets assigned to smoothing
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
        PrevSearch = ChangeSearch(PrevSearch)
        SearchValue = ChangeSearch(SearchValue)
    End If

    Dim CurrentData As String
    Dim EndPoint    As Long
    If FirstPoint = 0 And SecondPoint = 0 Then
        CurrentData = VBGLMidP(Data, 1, Len(Data))
        EndPoint    = 0
    ElseIf FirstPoint = 0 Then
        CurrentData = VBGLMidP(Data, 1, SecondPoint - 1)
        EndPoint    = InStr(SecondPoint, Data, vbCrLf)
    ElseIf SecondPoint = 0 Then
        CurrentData = VBGLMidP(Data, 1, FirstPoint - 1)
        EndPoint    = InStr(FirstPoint, Data, vbCrLf)
    Else
        EndPoint    = InStr(SecondPoint, Data, vbCrLf)
        CurrentData = VBGLMidP(Data, 1, FirstPoint - 1)
    End If

    Dim Smoothing As String, Material As String
    Call GetSmoothingValue(FirstValue, SecondValue, Material, Smoothing)
    Call Add(Material, Smoothing, CurrentData)

    If FirstPoint = 0 And SecondPoint = 0 Then
        If PrevSearch  = "s " Then FirstValue  = "off" Else FirstValue = Empty
        If SearchValue = "s " Then FirstValue  = "off" Else FirstValue = Empty
    ElseIf FirstPoint = 0 Then
        If PrevSearch  = "s " Then FirstValue  = "off" Else FirstValue = Empty
        SecondValue = GetName(Data, SecondPoint)
    ElseIf SecondPoint = 0 Then
        If SearchValue = "s " Then FirstValue  = "off" Else FirstValue = Empty
        FirstValue  = GetName(Data, FirstPoint)
    Else
        FirstValue  = GetName(Data, FirstPoint)
        SecondValue = GetName(Data, SecondPoint)
    End If
    If EndPoint <> 0 Then Call GetSubGroups(VBGLMidP(Data, EndPoint, Len(Data)), SearchValue, FirstValue, SecondValue)
End Sub

Public Sub MergeSubGroups()
    Dim ReturnArr() As GLSubGroup
    Dim Temp() As GLSubGroup
    Dim i As Long, j As Long
    Temp = SubGroups
    ' Check for missing SubGroup Definition
    Do Until USize(Temp) < i
        If SubGroup(i).Material = Empty And SubGroup(i).Smoothing = Empty Then
            For j = i + 1 To USize(Temp)
                Call AddOntoSubGroup(ReturnArr, Temp, j, i)
            Next j
        End If
        i = i + 1
    Loop

    ' Check for same SubGroup Definition
    i = 0
    j = 1
    Do Until USize(Temp) < i - 1
        Do Until USize(Temp) < j
            If (SubGroup(i).Material = SubGroup(j).Material) And (SubGroup(i).Smoothing = SubGroup(j).Smoothing) Then
                Call AddOntoSubGroup(ReturnArr, Temp, j, i)
            End If
            j = j + 1
        Loop
        i = i + 1
        j = i + 1
    Loop
    SubGroups = ReturnArr
End Sub

Private Sub AddOntoSubGroup(Goal() As GLSubGroup, Arr() As GLSubGroup, First As Long, ToRemove As Long)
    Dim NewSubGroup As GLSubGroup
    Set NewSubGroup = CombineSubGroups(Arr(First), Arr(ToRemove))
    Call AddSubGroup(Goal, NewSubGroup)
    Dim i As Long
    Dim Temp() As GLSubGroup
    ReDim Temp(USize(Arr) - 1)
    Dim Counter As Long
    For i = 0 To USize(Temp)
        If i = ToRemove Then Counter = Counter + 1
        Set Temp(i) = Arr(Counter)
        Counter = Counter + 1
    Next i
    Count = Count -1
    Arr = Temp
End Sub

Private Function CombineSubGroups(Sub1 As GLSubGroup, Sub2 As GLSubGroup) As GLSubGroup
    Set CombineSubGroups = New GLSubGroup
    CombineSubGroups.Material  = Sub1.Material
    CombineSubGroups.Smoothing = Sub1.Smoothing
    CombineSubGroups.Vertices  = CombineVertices(Sub1.Vertices, Sub2.Vertices)
    CombineSubGroups.Textures  = CombineVertices(Sub1.Textures, Sub2.Textures)
    CombineSubGroups.Normals   = CombineVertices(Sub1.Normals , Sub2.Normals)
    CombineSubGroups.Colors    = CombineVertices(Sub1.Colors  , Sub2.Colors)
    CombineSubGroups.Faces     = CombineFaces(Sub1.Faces      , Sub2.Faces)
    CombineSubGroups.Faces.Normalize
    CombineSubGroups.Layout    = CombineLayout(Sub1.Layout    , Sub2.Layout)
End Function

Private Function CombineVertices(V1 As VBGLVertex, V2 As VBGLVertex) As VBGLVertex
    If IsNothing(V1) Then
        Set CombineVertices  = V2
    ElseIf IsNothing(V2) Then
        Set CombineVertices  = V1
    Else
        Set CombineVertices = New VBGLVertex
        CombineVertices.Element  = V1.Element
        CombineVertices.Count    = V1.Count + V2.Count
        Dim Temp As VBGLData
        Set Temp = VBGLData.Create(vbSingle)
        Temp.Data = MergeArray(V1.Data.ByteData, V2.Data.ByteData)
        CombineVertices.Data = Temp
        CombineVertices.Data = MergeArray(V1.Data, V2.Data)
    End If
End Function

Private Function CombineFaces(F1 As VBGLFace, F2 As VBGLFace)
    If IsNothing(F1) Then
        Set CombineFaces  = F2
    ElseIf IsNothing(F2) Then
        Set CombineFaces  = F1
    Else
        Set CombineFaces = New VBGLFace
        CombineFaces.Vertex  = MergeArray(F1.Vertex  , F2.Vertex)
        CombineFaces.Texture = MergeArray(F1.Texture , F2.Texture)
        CombineFaces.Normal  = MergeArray(F1.Normal  , F2.Normal)
        CombineFaces.Color   = MergeArray(F1.Color   , F2.Color)
        CombineFaces.Count   = F1.Count + F2.Count
    End If
End Function

Private Function CombineLayout(L1 As VBGLLayout, L2 As VBGLLayout) As VBGLLayout
    Dim Temp() As VBGLLayoutType
    Dim Size As Long
    If L1.Size > L2.Size Then
        Size = L1.Size
    Else
        Size = L2.Size
    End If
    ReDim Temp(Size)
    Dim i As Long
    Dim L1Element As VBGLElement
    Dim L2Element As VBGLElement
    For i = 0 To Size
        Set L1Element = L1.Element(i)
        Set L2Element = L2.Element(i)
        If (L1Element.GetCategory() = "Position") Then 
            If L1Element.LayoutType = VBGLLayoutType.XYZ And L1Element.LayoutType <> L2Element.LayoutType Then
                Temp(i) = L2Element.LayoutType
            Else
                Temp(i) = L1Element.LayoutType
            End If
        End If 
        If (L1Element.GetCategory() = "Texture")  Then 
            If L1Element.LayoutType = VBGLLayoutType.TxTy And L1Element.LayoutType <> L2Element.LayoutType Then
                Temp(i) = L2Element.LayoutType
            Else
                Temp(i) = L1Element.LayoutType
            End If
        End If 
        If (L1Element.GetCategory() = "Normal")   Then 
            If L1Element.LayoutType = VBGLLayoutType.NxNyNz And L1Element.LayoutType <> L2Element.LayoutType Then
                Temp(i) = L2Element.LayoutType
            Else
                Temp(i) = L1Element.LayoutType
            End If
        End If 
        If (L1Element.GetCategory() = "Color")    Then 
            If L1Element.LayoutType = VBGLLayoutType.RGBB And L1Element.LayoutType <> L2Element.LayoutType Then
                Temp(i) = L2Element.LayoutType
            Else
                Temp(i) = L1Element.LayoutType
            End If
        End If 
    Next i
    Set CombineLayout = VBGLLayout.Create(vbSingle, Temp)
End Function

Private Function MergeArray(Arr1 As Variant, Arr2 As Variant) As Variant
    Dim i As Long
    Dim Counter As Long
    Dim Goal As Variant

    Dim NewSize As Long
    NewSize = (USize(Arr1) + 1) + (USize(Arr2) + 1) - 1
    Goal = Arr1
    ReDim Goal(NewSize)
    For i = 0 To USize(Arr1)
        Call Assign(Goal(Counter), Arr1(i))
        Counter = Counter + 1
    Next i
    For i = 0 To USize(Arr2)
        Call Assign(Goal(Counter), Arr2(i))
        Counter = Counter + 1
    Next i
    Call Assign(MergeArray, Goal)
End Function

Private Function GetName(Data As String, Point As Long) As String
    Dim StartPoint As Long
    Dim EndPoint As Long
    StartPoint = InStr(Point, Data, " ")
    EndPoint   = InStr(Point, Data, vbCrLf)
    GetName    = VBGLMidP(Data, StartPoint + 1, EndPoint - 1)
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
    If IsNothing(NewGroup) Then Exit Sub
    Count = Count + 1
    ReDim Preserve p_SubGroups(Count)
    Set p_SubGroups(Count) = NewGroup
End Sub

Private Sub GetSmoothingValue(Value1 As String, Value2 As String, Material As String, Smoothing As String)
    If Value1 = "off" Or IsNumeric(Value1) Then
        Smoothing = Value1
        Material  = Value2
    Else
        Smoothing = Value2
        Material  = Value1
    End If
End Sub

Private Sub AddSubGroup(Arr() As GLSubGroup, Value As GLSubGroup)
    Dim Size As Long: Size = USize(Arr) + 1
    ReDim Preserve Arr(Size)
    Set Arr(Size) = Value
End Sub

Private Sub Class_Initialize()
    Count = -1
End Sub