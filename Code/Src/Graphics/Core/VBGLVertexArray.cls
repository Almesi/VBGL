VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLVertexArray"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private p_ID      As Long
Private p_Buffer  As IBufferVertex
Private p_Layout  As VBGLLayout

Public Function Create(ByVal n_Layout As VBGLLayout, ByVal n_Data As VBGLData, Optional ByVal Interleaved As Boolean = True) As VBGLVertexArray
    Set Create = New VBGLVertexArray
    With Create
        Dim TempID As Long
        Call glGenVertexArrays(1, TempID)
        .ID = TempID
        .Buffer = VBGLBuffer.CreateVertexBuffer(n_Data)
        .Layout = n_Layout
        .AddBuffer(Interleaved)
    End With
End Function

Public Property Let ID(ByVal n_ID           As Long)            : Let p_ID      = n_ID      : End Property
Public Property Let Buffer(ByVal n_Buffer   As IBufferVertex)   : Set p_Buffer  = n_Buffer  : End Property
Public Property Let Layout(ByVal n_Layout   As VBGLLayout)      : Set p_Layout  = n_Layout  : End Property

Public Property Get ID()                    As Long             : Let ID        = p_ID      : End Property
Public Property Get Buffer()                As IBufferVertex    : Set Buffer    = p_Buffer  : End Property
Public Property Get Layout()                As VBGLLayout       : Set Layout    = p_Layout  : End Property

Public Sub Bind()
    CurrentContext.CurrentVAO = Me
    Buffer.Bind
End Sub

Public Sub Unbind()
    CurrentContext.CurrentVAO = Nothing
    Buffer.Unbind
End Sub

Public Sub AddBuffer(Optional ByVal Interleaved As Boolean = True)
    Dim Offset As Long
    Dim i As Long

    Call Bind()
    Call Buffer.Bind()
    For i = 0 To Ubound(Layout.Elements)
        With Layout.Element(i)
            Call glEnableVertexAttribArray(i)
            If Interleaved Then
                Call glVertexAttribPointer(i, .Size, .DataType, .Normalized, Layout.ByteSize, Offset)
                Offset = Offset + .ByteSize
            Else
                Call glVertexAttribPointer(i, .Size, .DataType, .Normalized, 0, Offset)
                Offset = Offset + (.ByteSize) 'TODO * ElementCount
            End If
        End With
    Next i
End Sub

Private Sub Class_Terminate()
    ' Not implemented yet
    'Call glDeleteVertexArrays(1, p_ID)
    CurrentContext.CurrentVAO = Nothing
End Sub