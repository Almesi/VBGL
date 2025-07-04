VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "GLVertex"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Vertices   As VBGLData
Private p_Element    As VBGLBufferElement
Private p_Count      As Long

Public Property Let Vertices(n_Vertices      As VBGLData)             : Set p_Vertices   = n_Vertices   : End Property
Public Property Let Element(n_Element        As VBGLBufferElement)    : Set p_Element    = n_Element    : End Property
Public Property Let Count(n_Count            As Long)                 : Let p_Count      = n_Count      : End Property

Public Property Get Vertices()               As VBGLData              : Set Vertices     = p_Vertices   : End Property
Public Property Get Element()                As VBGLBufferElement     : Set Element      = p_Element    : End Property
Public Property Get Count()                  As Long                  : Let Count        = p_Count      : End Property

Public Function Create(n_Data As VBGLData, n_Element As VBGLBufferElement, n_Count As Long) As GLVertex
    Set Create = New GLVertex
    With Create
        .Vertices   = n_Data
        .Element = n_Element
        .Count      = n_Count
    End With
End Function

Public Function CreateFromArray(Typee As VBGLBufferLayoutType, Arr() As Single)
    Dim n_Data As IDataSingle
    Set n_Data = VBGLData.Create(vbSingle)
    n_Data.Data = Arr
    Dim n_Element As VBGLBufferElement
    Set n_Element = VBGLBufferElement.Create(Typee, GL_FLOAT, False)
    Set CreateFromArray = Create(n_Data, n_Element, Ubound(Arr) + 1)
End Function

Public Function CreateFromStringArray(Typee As VBGLBufferLayoutType, Arr() As String) As GLVertex
    Dim ArrSingle() As Single
    ReDim ArrSingle(Ubound(Arr))
    Dim i As Long
    For i = 0 To Ubound(Arr)
        ArrSingle(i) = CSng(Arr(i))
    Next i
    Set CreateFromStringArray = CreateFromArray(Typee, ArrSingle)
End Function