VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLVertex"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

'VertexData with its designated Element

Private p_Data       As VBGLData
Private p_Element    As VBGLElement
Private p_Count      As Long

Public Property Let Data(n_Data              As VBGLData)             : Set p_Data       = n_Data       : End Property
Public Property Let Element(n_Element        As VBGLElement)          : Set p_Element    = n_Element    : End Property
Public Property Let Count(n_Count            As Long)                 : Let p_Count      = n_Count      : End Property

Public Property Get Data()                   As VBGLData              : Set Data         = p_Data       : End Property
Public Property Get Element()                As VBGLElement           : Set Element      = p_Element    : End Property
Public Property Get Count()                  As Long                  : Let Count        = p_Count      : End Property

Public Function Create(n_Data As VBGLData, n_Element As VBGLElement, n_Count As Long) As VBGLVertex
    Set Create = New VBGLVertex
    With Create
        .Data     = n_Data
        .Element  = n_Element
        .Count    = n_Count
    End With
End Function

Public Function CreateFromArray(Typee As VBGLLayoutType, Arr() As Single)
    Dim n_Data As IDataSingle
    Set n_Data = VBGLData.Create(vbSingle)
    n_Data.Data = Arr
    Dim n_Element As VBGLElement
    Set n_Element = VBGLElement.Create(Typee, GL_FLOAT, False)
    Set CreateFromArray = Create(n_Data, n_Element, Ubound(Arr) + 1)
End Function

Public Function CreateFromStringArray(Typee As VBGLLayoutType, Arr() As String) As VBGLVertex
    Dim ArrSingle() As Single
    ReDim ArrSingle(Ubound(Arr))
    Dim i As Long
    For i = 0 To Ubound(Arr)
        ArrSingle(i) = CSng(Arr(i))
    Next i
    Set CreateFromStringArray = CreateFromArray(Typee, ArrSingle)
End Function