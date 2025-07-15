VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLBuffer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Implements IBufferVertex
Implements IBufferIndex

Private p_Context As VBGLContext
Private p_ID      As Long
Private p_Data    As VBGLData



Public Property Let Context(n_Context As VBGLContext): Set p_Context = n_Context : End Property
Public Property Get Context()         As VBGLContext : Set Context   = p_Context : End Property

Public Function CreateVertexBuffer(n_Data As VBGLData) As IBufferVertex
    Set CreateVertexBuffer = New VBGLBuffer
    With CreateVertexBuffer
        Dim TempID As Long: Call glGenBuffers(1, TempID)
        .ID   = TempID
        Call .Update(n_Data, Ubound(n_Data.ByteData) + 1)
    End With
End Function

Public Function CreateIndexBuffer(n_Data As VBGLData) As IBufferIndex
    Set CreateIndexBuffer = New VBGLBuffer
    With CreateIndexBuffer
        Dim TempID As Long: Call glGenBuffers(1, TempID)
        .ID   = TempID
        Call .Update(n_Data, Ubound(n_Data.ByteData) + 1)
    End With
End Function

Private Sub Class_Initialize()
    Context = VBGLContext
End Sub

Private Sub Class_Terminate()
    If p_ID <> 0 Then
        Call glDeleteBuffers(1, p_ID)
    End If
End Sub

' IBufferVertex
    Private Property Let IBufferVertex_ID(n_ID As Long)
        p_ID = n_ID
    End Property
    Private Property Get IBufferVertex_ID() As Long
        IBufferVertex_ID = p_ID
    End Property

    Private Property Let IBufferVertex_Data(n_Data As VBGLData)
        Set p_Data = n_Data
    End Property
    Private Property Get IBufferVertex_Data() As VBGLData
        Set IBufferVertex_Data = p_Data
    End Property

    Private Sub IBufferVertex_Bind()
        Context.CurrentVBO = IBufferVertex_ID
    End Sub
    Private Sub IBufferVertex_Unbind()
        Context.CurrentVBO = 0
    End Sub

    Private Sub IBufferVertex_Update(n_Data As VBGLData, Optional NewSize As Variant)
        If n_Data Is Nothing Then Exit Sub
        IBufferVertex_Data = n_Data
        Call IBufferVertex_Bind()
        If IsMissing(NewSize) = False Then
            Call glBufferData(GL_ARRAY_BUFFER, NewSize, 0, GL_STATIC_DRAW)
        End If
        Dim TempData() As Byte
        TempData = n_Data.ByteData()
        Call glBufferSubData(GL_ARRAY_BUFFER, 0, Ubound(TempData) + 1, VarPtr(TempData(0)))
    End Sub
'


' IBufferIndex
    Private Property Let IBufferIndex_ID(n_ID As Long)
        p_ID = n_ID
    End Property
    Private Property Get IBufferIndex_ID() As Long
        IBufferIndex_ID = p_ID
    End Property

    Private Property Let IBufferIndex_Data(n_Data As VBGLData)
        Set p_Data = n_Data
    End Property
    Private Property Get IBufferIndex_Data() As VBGLData
        Set IBufferIndex_Data = p_Data
    End Property

    Private Sub IBufferIndex_Bind()
        Context.CurrentEBO = IBufferIndex_ID
    End Sub
    Private Sub IBufferIndex_Unbind()
        Context.CurrentEBO = 0
    End Sub

    Private Sub IBufferIndex_Update(n_Data As VBGLData, Optional NewSize As Variant)
        IBufferIndex_Data = n_Data
        Call IBufferIndex_Bind()
        If IsMissing(NewSize) = False Then
            Call glBufferData(GL_ELEMENT_ARRAY_BUFFER, NewSize, 0, GL_STATIC_DRAW)
        End If
        Dim TempData() As Byte
        TempData = n_Data.ByteData()
        Call glBufferSubData(GL_ELEMENT_ARRAY_BUFFER, 0, Ubound(TempData) + 1, VarPtr(TempData(0)))
    End Sub
'