Attribute VB_Name = "VBGLBasicTexture"

Option Explicit

' ======================================================================================
' PURPOSE: Returns arrays of Single representing basic geometric shapes textures
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
        Arr = ArraySingle( _
                           0, 1, _
                           1, 1, _
                           0, 0  _
                         )
    End If
    VBGLBaTxTriangleXY = Arr
End Function

Public Function VBGLBaTxRectangleXY() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           0, 1, _
                           1, 1, _
                           0, 0, _
                           1, 1, _
                           1, 0, _
                           0, 0  _
                         )
    End If
    VBGLBaTxRectangleXY = Arr
End Function