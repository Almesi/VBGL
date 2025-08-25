VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "IBufferVertex"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Public Property Let ID(n_ID As Long)
Public Property Get ID() As Long
Public Property Let Data(n_Data As VBGLData)
Public Property Get Data() As VBGLData
Public Sub Bind()
Public Sub Unbind()
Public Sub Update(n_Data As VBGLData, Optional NewSize As Variant)