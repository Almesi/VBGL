VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLFace"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

'used to describe 1 Face/All Faces of a Facegroup
' All ByRef Arr should be ByVal, as they are not used directly.
' But since VBA only allows ByRef Arrays this comment is needed
Private p_Vertex()  As Long
Private p_Texture() As Long
Private p_Normal()  As Long
Private p_Color()   As Long
Private p_Count     As Long

Public Property Let Vertex(ByVal n_Vertex   As Variant)   : Let p_Vertex  = n_Vertex  : End Property
Public Property Let Texture(ByVal n_Texture As Variant)   : Let p_Texture = n_Texture : End Property
Public Property Let Normal(ByVal n_Normal   As Variant)   : Let p_Normal  = n_Normal  : End Property
Public Property Let Color(ByVal n_Color     As Variant)   : Let p_Color   = n_Color   : End Property
Public Property Let Count(ByVal n_Count     As Long)      : Let p_Count   = n_Count   : End Property

Public Property Get Vertex()                As Variant    : Let Vertex    = p_Vertex  : End Property
Public Property Get Texture()               As Variant    : Let Texture   = p_Texture : End Property
Public Property Get Normal()                As Variant    : Let Normal    = p_Normal  : End Property
Public Property Get Color()                 As Variant    : Let Color     = p_Color   : End Property
Public Property Get Count()                 As Long       : Let Count     = p_Count   : End Property

Public Function Create(ByRef n_Vertex() As Long, ByRef n_Texture() As Long, ByRef n_Normal() As Long, ByRef n_Color() As Long) As VBGLFace
    Set Create = New VBGLFace
    With Create
        .Vertex  = n_Vertex
        .Texture = n_Texture
        .Normal  = n_Normal
        .Color   = n_Color
        .Count   = Ubound(n_Vertex) + 1
    End With
End Function

Public Function CreateFromStringArray(ByVal Layout As VBGLLayout, ByRef Arr() As String) As VBGLFace
    Dim ArrV() As Long
    Dim ArrT() As Long
    Dim ArrN() As Long
    Dim ArrC() As Long
    Dim i      As Long
    Dim j      As Long

    For i = 0 To Layout.Size
        Select Case Layout.Element(i).Category
            Case "Position" : ReDim ArrV((Ubound(Arr) + 1) / (Layout.Size + 1) - 1)
            Case "Texture"  : ReDim ArrT((Ubound(Arr) + 1) / (Layout.Size + 1) - 1)
            Case "Normal"   : ReDim ArrN((Ubound(Arr) + 1) / (Layout.Size + 1) - 1)
            Case "Color"    : ReDim ArrC((Ubound(Arr) + 1) / (Layout.Size + 1) - 1)
        End Select
    Next i

    For i = 0 To ((Ubound(Arr) + 1) / (Layout.Size + 1)) - 1
        For j = 0 To Layout.Size
            Select Case Layout.Element(j).Category
                Case "Position" : ArrV(i) = CLng(Arr(i * (Layout.Size + 1) + j))
                Case "Texture"  : ArrT(i) = CLng(Arr(i * (Layout.Size + 1) + j))
                Case "Normal"   : ArrN(i) = CLng(Arr(i * (Layout.Size + 1) + j))
                Case "Color"    : ArrC(i) = CLng(Arr(i * (Layout.Size + 1) + j))
            End Select
        Next j
    Next i
    Set CreateFromStringArray = Create(ArrV, ArrT, ArrN, ArrC)
End Function



'Take this array:
'[1, 103, 105, 323, 103, 1, 3230]
' Transforms into normalized array according to how many values are smaller:
'[0, 1, 2, 3, 1, 0, 4]
Public Sub Normalize()
    Vertex  = NormalizeArray(p_Vertex)
    Texture = NormalizeArray(p_Texture)
    Normal  = NormalizeArray(p_Normal)
    Color   = NormalizeArray(p_Color)
End Sub

Private Function NormalizeArray(ByRef Arr() As Long) As Long()
    If USize(Arr) = -1 Then Exit Function

    Dim Mapping As Object
    Set Mapping = Unique(Arr)

    Dim ReturnArr() As Long
    ReDim ReturnArr(USize(Arr))
    Dim i As Long
    For i = 0 To USize(Arr)
        ReturnArr(i) = Mapping(Arr(i))
    Next i

    NormalizeArray = ReturnArr
End Function

' Scripting.Dictionary
Private Function Unique(ByRef Arr() As Long) As Object
    Dim Mapping As Object
    Set Mapping = CreateObject("Scripting.Dictionary")
    Dim Uniques() As Long

    Dim i As Long, j As Long
    Dim Val As Long

    ReDim Uniques(USize(Arr))
    For i = 0 To USize(Arr)
        Val = Arr(i)
        If Not Mapping.exists(Val) Then
            Call Mapping.Add(Val, 0)
            Uniques(j) = Val
            j = j + 1
        End If
    Next i

    Dim UbUni As Long
    UbUni = j -1
    Call Sort(Uniques, 0, UbUni)

    For i = 0 To UbUni
        Mapping(Uniques(i)) = i
    Next i
    Set Unique = Mapping
End Function

Private Sub Sort(ByRef Arr() As Long, ByVal First As Long, ByVal Last As Long)
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