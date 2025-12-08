VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLITextureMerger"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

' Merging should do:
' Output a 2D array of bytes that can be used to create a VBGLTexture Object
' Use the SubTextures to get the data nessecary for the output
' SubTextures should also be used to update X, Y, EndX and EndY to accomodate for the new positions from output
Public Function Merge(ByRef SubTextures() As VBGLTextureManagerHelper, Optional ByRef OverWriteMaxHeight As Long = 0, Optional ByRef OverWriteMaxWidth As Long = 0, Optional ByRef OverWriteMaxByteHeight As Long = 0, Optional ByRef OverWriteMaxByteWidth As Long = 0) As Byte()
End Function