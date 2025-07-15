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

Private Const UnusableValue As Long = -3545332 ' Some Random Value

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

Public Function CreateFromStringArray(Setup As String, Arr() As String) As GLFace
    Dim ArrV() As Long
    Dim ArrT() As Long
    Dim ArrN() As Long
    Dim ArrC() As Long
    Dim LineBreak As Long
    Dim ArrVOffset As Long
    Dim ArrTOffset As Long
    Dim ArrNOffset As Long
    Dim ArrCOffset As Long 
    
    Select Case True
        Case Setup Like "*#/*#/*#/*#" : LineBreak = 4: ArrVOffset = 1: ArrTOffset = 2: ArrNOffset = 3: ArrCOffset = 4 ' 1234
        Case Setup Like "*#/*#//*#"   : LineBreak = 3: ArrVOffset = 1: ArrTOffset = 2: ArrNOffset = 0: ArrCOffset = 3 ' 124
        Case Setup Like "*#//*#/*#"   : LineBreak = 3: ArrVOffset = 1: ArrTOffset = 0: ArrNOffset = 2: ArrCOffset = 3 ' 134
        Case Setup Like "/*#/*#/*#"   : LineBreak = 3: ArrVOffset = 0: ArrTOffset = 1: ArrNOffset = 2: ArrCOffset = 3 ' 234
        Case Setup Like "*#/*#/*#"    : LineBreak = 3: ArrVOffset = 1: ArrTOffset = 2: ArrNOffset = 3: ArrCOffset = 0 ' 123
        Case Setup Like "//*#/*#"     : LineBreak = 2: ArrVOffset = 0: ArrTOffset = 0: ArrNOffset = 1: ArrCOffset = 2 ' 34
        Case Setup Like "/*#//*#"     : LineBreak = 2: ArrVOffset = 0: ArrTOffset = 1: ArrNOffset = 0: ArrCOffset = 2 ' 24
        Case Setup Like "/*#/*#"      : LineBreak = 2: ArrVOffset = 0: ArrTOffset = 1: ArrNOffset = 2: ArrCOffset = 0 ' 23
        Case Setup Like "*#///*#"     : LineBreak = 2: ArrVOffset = 1: ArrTOffset = 0: ArrNOffset = 0: ArrCOffset = 2 ' 14
        Case Setup Like "*#//*#"      : LineBreak = 2: ArrVOffset = 1: ArrTOffset = 0: ArrNOffset = 3: ArrCOffset = 0 ' 13
        Case Setup Like "*#/*#"       : LineBreak = 2: ArrVOffset = 1: ArrTOffset = 2: ArrNOffset = 0: ArrCOffset = 0 ' 12
        Case Setup Like "///*#"       : LineBreak = 1: ArrVOffset = 0: ArrTOffset = 0: ArrNOffset = 0: ArrCOffset = 1 ' 4
        Case Setup Like "//*#"        : LineBreak = 1: ArrVOffset = 0: ArrTOffset = 0: ArrNOffset = 1: ArrCOffset = 0 ' 3
        Case Setup Like "/*#"         : LineBreak = 1: ArrVOffset = 0: ArrTOffset = 1: ArrNOffset = 0: ArrCOffset = 0 ' 2
        Case Setup Like "*#"          : LineBreak = 1: ArrVOffset = 1: ArrTOffset = 0: ArrNOffset = 0: ArrCOffset = 0 ' 1
    End Select
    If ArrVOffset <> 0 Then ReDim ArrV((Ubound(Arr) + 1) / LineBreak - 1)
    If ArrTOffset <> 0 Then ReDim ArrT((Ubound(Arr) + 1) / LineBreak - 1)
    If ArrNOffset <> 0 Then ReDim ArrN((Ubound(Arr) + 1) / LineBreak - 1)
    If ArrCOffset <> 0 Then ReDim ArrC((Ubound(Arr) + 1) / LineBreak - 1)

    Dim i As Long
    For i = 0 To (UBound(Arr) + 1) / LineBreak - 1
        If ArrVOffset <> 0 Then ArrV(i) = CSng(Arr(i * LineBreak + ArrVOffset - 1))
        If ArrTOffset <> 0 Then ArrT(i) = CSng(Arr(i * LineBreak + ArrTOffset - 1))
        If ArrNOffset <> 0 Then ArrN(i) = CSng(Arr(i * LineBreak + ArrNOffset - 1))
        If ArrCOffset <> 0 Then ArrC(i) = CSng(Arr(i * LineBreak + ArrCOffset - 1))
    Next i
    Set CreateFromStringArray = Create(ArrV, ArrT, ArrN, ArrC)
End Function