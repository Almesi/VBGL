Attribute VB_Name = "VBGLPreCompiledLayouts"

Option Explicit

' Not REALLY pre-compiled, as the compiling is done when first calling the Function
' Nomenclature:
' 1. VBGLPrCo   = VBGL Pre Compiled
' 2. ObjectType = VBGLLayout|etc.
' 3. Identity   = XYZ|XYZRGB|XYZMVP|etc.

'======================================================================================
'=======================================[Layout]=======================================
'======================================================================================

Public Function VBGLPrCoLayoutXY() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XY)
    Set VBGLPrCoLayoutXY = MyObject
End Function

Public Function VBGLPrCoLayoutXYZ() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ)
    Set VBGLPrCoLayoutXYZ = MyObject
End Function

Public Function VBGLPrCoLayoutXYRGB() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XY, VBGLLayoutType.RGBB)
    Set VBGLPrCoLayoutXYRGB = MyObject
End Function

Public Function VBGLPrCoLayoutXYZRGB() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.RGBB)
    Set VBGLPrCoLayoutXYZRGB = MyObject
End Function

Public Function VBGLPrCoLayoutXYZRGBA() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.RGBA)
    Set VBGLPrCoLayoutXYZRGBA = MyObject
End Function

Public Function VBGLPrCoLayoutXYTxTy() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XY, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutXYTxTy = MyObject
End Function

Public Function VBGLPrCoLayoutXYZTxTy() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutXYZTxTy = MyObject
End Function

Public Function VBGLPrCoLayoutXYZRGBTxTy() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.RGBB, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutXYZRGBTxTy = MyObject
End Function

Public Function VBGLPrCoLayoutXYZRGBATxTy() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.RGBA, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutXYZRGBATxTy = MyObject
End Function

Public Function VBGLPrCoLayoutXYZWRGBA() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZW, VBGLLayoutType.RGBA)
    Set VBGLPrCoLayoutXYZWRGBA = MyObject
End Function

Public Function VBGLPrCoLayoutXYZWRGBATxTy() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZW, VBGLLayoutType.RGBA, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutXYZWRGBA = MyObject
End Function

Public Function VBGLPrCoLayoutXYZTxTyNxNyNz() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.TxTy, VBGLLayoutType.NxNyNz)
    Set VBGLPrCoLayoutXYZTxTyNxNyNz = MyObject
End Function

Public Function VBGLPrCoLayoutText() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.RGBA, VBGLLayoutType.RGBA, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutText = MyObject
End Function