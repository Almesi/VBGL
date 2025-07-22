VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "GLFace"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Vertex()  As Long
Private p_Texture() As Long
Private p_Normal()  As Long
Private p_Color()   As Long
Private P_Count     As Long

Public Property Let Vertex(n_Vertex   As Variant)   : Let p_Vertex  = n_Vertex  : End Property
Public Property Let Texture(n_Texture As Variant)   : Let p_Texture = n_Texture : End Property
Public Property Let Normal(n_Normal   As Variant)   : Let p_Normal  = n_Normal  : End Property
Public Property Let Color(n_Color     As Variant)   : Let p_Color   = n_Color   : End Property
Public Property Let Count(n_Count     As Long)      : Let p_Count   = n_Count   : End Property

Public Property Get Vertex()            As Variant  : Let Vertex    = p_Vertex  : End Property
Public Property Get Texture()           As Variant  : Let Texture   = p_Texture : End Property
Public Property Get Normal()            As Variant  : Let Normal    = p_Normal  : End Property
Public Property Get Color()             As Variant  : Let Color     = p_Color   : End Property
Public Property Get Count()             As Long     : Let Count     = p_Count   : End Property

Public Function Create(n_Vertex() As Long, n_Texture() As Long, n_Normal() As Long, n_Color() As Long) As GLFace
    Set Create = New GLFace
    With Create
        .Vertex  = n_Vertex
        .Texture = n_Texture
        .Normal  = n_Normal
        .Color   = n_Color
        .Count   = Ubound(n_Vertex) + 1
    End With
End Function

Public Function CreateFromStringArray(Layout As VBGLLayout, Arr() As String) As GLFace
    Dim ArrV() As Long
    Dim ArrT() As Long
    Dim ArrN() As Long
    Dim ArrC() As Long
    Dim i      As Long
    Dim j      As Long

    For i = 0 To Layout.Size
        Select Case Layout.Element(i).GetCategory
            Case "Position" : ReDim ArrV((Ubound(Arr) + 1) / (Layout.Size + 1) - 1)
            Case "Texture"  : ReDim ArrT((Ubound(Arr) + 1) / (Layout.Size + 1) - 1)
            Case "Normal"   : ReDim ArrN((Ubound(Arr) + 1) / (Layout.Size + 1) - 1)
            Case "Color"    : ReDim ArrC((Ubound(Arr) + 1) / (Layout.Size + 1) - 1)
        End Select
    Next i

    For i = 0 To ((Ubound(Arr) + 1) / (Layout.Size + 1)) - 1
        For j = 0 To Layout.Size
            Select Case Layout.Element(j).GetCategory
                Case "Position" : ArrV(i) = CLng(Arr(i * (Layout.Size + 1) + j))
                Case "Texture"  : ArrT(i) = CLng(Arr(i * (Layout.Size + 1) + j))
                Case "Normal"   : ArrN(i) = CLng(Arr(i * (Layout.Size + 1) + j))
                Case "Color"    : ArrC(i) = CLng(Arr(i * (Layout.Size + 1) + j))
            End Select
        Next j
    Next i
    Set CreateFromStringArray = Create(ArrV, ArrT, ArrN, ArrC)
End Function

Public Sub Normalize()
    Vertex  = NormalizeArray(p_Vertex)
    Texture = NormalizeArray(p_Texture)
    Normal  = NormalizeArray(p_Normal)
    Color   = NormalizeArray(p_Color)
End Sub

Private Function NormalizeArray(Arr() As Long) As Long()
    If USize(Arr) = -1 Then Exit Function

    Dim Uniques() As Long
    Uniques = Unique(Arr)
    Call Sort(Uniques, 0, USize(Uniques))

    Dim Mapping As Object
    Set Mapping = CreateObject("Scripting.Dictionary")

    Dim i As Long
    For i = 0 To USize(Uniques)
        Mapping(Uniques(i)) = i
    Next i

    Dim ReturnArr() As Long
    ReDim ReturnArr(USize(Arr))

    For i = 0 To USize(Arr)
        ReturnArr(i) = Mapping(Arr(i))
    Next i

    NormalizeArray = ReturnArr
End Function

Private Function Unique(Arr() As Long) As Long()
    Dim Dict As Object
    Set Dict = CreateObject("Scripting.Dictionary")

    Dim i As Long
    Dim Val As Long

    If Usize(Arr) = -1 Then Exit Function
    For i = 0 To USize(Arr)
        Val = Arr(i)
        If Not Dict.exists(Val) Then Call Dict.Add(Val, 0)
    Next i

    Dim ReturnArr() As Long
    ReDim ReturnArr(0 To Dict.Count - 1)
    i = 0
    Dim Key As Variant
    For Each Key In Dict.Keys
        ReturnArr(i) = CLng(Key)
        i = i + 1
    Next Key
    Unique = ReturnArr
End Function

Private Sub Sort(Arr() As Long, First As Long, Last As Long)
    Dim Low As Long, High As Long, Mid As Long, Temp As Long
    Low = First
    High = Last
    Mid = Arr((First + Last) \ 2)
    Do While Low <= High
        Do While Arr(Low) < Mid
            Low = Low + 1
        Loop
        Do While Arr(High) > Mid
            High = High - 1
        Loop
        If Low <= High Then
            Temp = Arr(Low)
            Arr(Low) = Arr(High)
            Arr(High) = Temp
            Low = Low + 1
            High = High - 1
        End If
    Loop
    If First < High Then Call Sort(Arr, First, High)
    If Low < Last Then Call Sort(Arr, Low, Last)
End Sub

Private Function USize(Arr As Variant) As Long
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr)
End Function