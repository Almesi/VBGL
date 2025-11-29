Attribute VB_Name = "VBGLBasicTexture"

Option Explicit

' ======================================================================================
' PURPOSE: Returns arrays of Single representing basic geometric shapes textures (2D / 3D)
'
' Naming Convention:
'   VBGLBaTx<Type><Dimension>
'   Example: VBGLBaTxTriangleXY  →  Triangle, Flat on XY plane
' 
' Coordinate Systems:
'   XY   - 2D coordinates (X,Y)
'   XYZ  - 3D coordinates (X,Y,Z)
'
' All coordinates are normalized to a unit range [0, 1].
' ======================================================================================



'======================================================================================
'=======================================[2D]===========================================
'======================================================================================

Public Function VBGLBaTxTriangleXY() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        ReDim Arr(5)
        Arr(0) = 0  :  Arr(1) = 1
        Arr(2) = 1  :  Arr(3) = 1
        Arr(4) = 0  :  Arr(5) = 0
    End If
    VBGLBaTxTriangleXY = Arr
End Function

Public Function VBGLBaTxTriangleXYZ() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        ReDim Arr(8)
        Arr(0) = 0  :  Arr(1) = 1  :  Arr(1) = 0
        Arr(2) = 1  :  Arr(3) = 1  :  Arr(3) = 0
        Arr(4) = 0  :  Arr(5) = 0  :  Arr(5) = 0
    End If
    VBGLBaTxTriangleXYZ = Arr
End Function

Public Function VBGLBaTxRectangleXY() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        ReDim Arr(11)
        Arr(00) = 0  :  Arr(01) = 1
        Arr(02) = 1  :  Arr(03) = 1
        Arr(04) = 0  :  Arr(05) = 0
        Arr(06) = 1  :  Arr(07) = 1
        Arr(08) = 1  :  Arr(09) = 0
        Arr(10) = 0  :  Arr(11) = 0
    End If
    VBGLBaTxRectangleXY = Arr
End Function

Public Function VBGLBaTxRectangleXYZ() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        ReDim Arr(17)
        Arr(00) = 0  :  Arr(01) = 1  :  Arr(02) = 0
        Arr(03) = 1  :  Arr(04) = 1  :  Arr(05) = 0
        Arr(06) = 0  :  Arr(07) = 0  :  Arr(08) = 0
        Arr(09) = 1  :  Arr(10) = 1  :  Arr(11) = 0
        Arr(12) = 1  :  Arr(13) = 0  :  Arr(14) = 0
        Arr(15) = 0  :  Arr(16) = 0  :  Arr(17) = 0
    End If
    VBGLBaTxRectangleXYZ = Arr
End Function