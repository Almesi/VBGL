Attribute VB_Name = "VBGLBasicForms"

Option Explicit

' ======================================================================================
' PURPOSE: Returns arrays of Single representing basic geometric shapes (2D / 3D)
'
' Naming Convention:
'   VBGLBaFo<Type><Dimension>
'   Example: VBGLBaFoTriangleXY  →  Triangle, Flat on XY plane
' 
' Coordinate Systems:
'   XY   - 2D coordinates (X,Y)
'   XYZ  - 3D coordinates (X,Y,Z)
'
' All coordinates are normalized to a unit range [-1, 1].
' ======================================================================================



'======================================================================================
'=======================================[2D]===========================================
'======================================================================================

Public Function VBGLBaFoTriangleXY() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, -1, _
                           +0, +1, _
                           +1, -1  _
                         )
    End If
    VBGLBaFoTriangleXY = Arr
End Function

Public Function VBGLBaFoTriangleXYZ() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, -1, 0, _
                           +0, +1, 0, _
                           +1, -1, 0  _
                         )
    End If
    VBGLBaFoTriangleXYZ = Arr
End Function

Public Function VBGLBaFoRectangleXY() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, +1, _
                           +1, +1, _
                           -1, -1, _
                           +1, +1, _
                           +1, -1, _
                           -1, -1  _
                         )
    End If
    VBGLBaFoRectangleXY = Arr
End Function

Public Function VBGLBaFoRectangleXYZ() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, +1, 0, _
                           +1, +1, 0, _
                           -1, -1, 0, _
                           +1, +1, 0, _
                           +1, -1, 0, _
                           -1, -1, 0  _
                         )
    End If
    VBGLBaFoRectangleXYZ = Arr
End Function

' With Basic Color
Public Function VBGLBaFoTriangleXYRGB() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, -1, 1, 0, 0, _
                           +0, +1, 0, 1, 0, _
                           +1, -1, 0, 0, 1  _
                         )
    End If
    VBGLBaFoTriangleXYRGB = Arr
End Function

Public Function VBGLBaFoTriangleXYZRGB() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, -1, 1, 0, 0, 0, _
                           +0, +1, 0, 1, 0, 0, _
                           +1, -1, 0, 0, 1, 0  _
                         )
    End If
    VBGLBaFoTriangleXYZRGB = Arr
End Function

Public Function VBGLBaFoRectangleXYRGB() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, +1, 1, 0, 0, _
                           +1, +1, 0, 1, 0, _
                           -1, -1, 1, 1, 0, _
                           +1, +1, 0, 1, 0, _
                           +1, -1, 0, 0, 1, _
                           -1, -1, 1, 1, 0 _
                         )
    End If
    VBGLBaFoRectangleXYRGB = Arr
End Function

Public Function VBGLBaFoRectangleXYZRGB() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, +1, 1, 0, 0, 0, _
                           +1, +1, 0, 1, 0, 0, _
                           -1, -1, 1, 1, 0, 0, _
                           +1, +1, 0, 1, 0, 0, _
                           +1, -1, 0, 0, 1, 0, _
                           -1, -1, 1, 1, 0, 0 _
                         )
    End If
    VBGLBaFoRectangleXYZRGB = Arr
End Function

' With Basic Texture Assigning
Public Function VBGLBaFoTriangleXYTxTy() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, -1, 0  , 0, _
                           +0, +1, 0.5, 1, _
                           +1, -1, 1  , 0  _
                         )
    End If
    VBGLBaFoTriangleXYTxTy = Arr
End Function

Public Function VBGLBaFoTriangleXYZTxTy() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, -1, 0, 0  , 0, _
                           +0, +1, 0, 0.5, 1, _
                           +1, -1, 0, 1  , 0  _
                         )
    End If
    VBGLBaFoTriangleXYZTxTy = Arr
End Function

Public Function VBGLBaFoRectangleXYTxTy() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, +1, 0, 1, _
                           +1, +1, 1, 1, _
                           -1, -1, 0, 0, _
                           +1, +1, 1, 1, _
                           +1, -1, 1, 0, _
                           -1, -1, 0, 0  _
                         )
    End If
    VBGLBaFoRectangleXYTxTy = Arr
End Function

Public Function VBGLBaFoRectangleXYZTxTy() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           -1, +1, 0, 0, 1, _
                           +1, +1, 0, 1, 1, _
                           -1, -1, 0, 0, 0, _
                           +1, +1, 0, 1, 1, _
                           +1, -1, 0, 1, 0, _
                           -1, -1, 0, 0, 0  _
                         )
    End If
    VBGLBaFoRectangleXYZTxTy = Arr
End Function

'======================================================================================
'=======================================[3D]===========================================
'======================================================================================


Public Function VBGLBaFoCubeXYZ() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           +1, +1, +1,   -1, 1, +1,   +1, -1, +1, _
                           -1, +1, +1,   -1, 1, +1,   +1, +1, +1, _
                           -1, +1, -1,   +1, 1, -1,   -1, -1, -1, _
                           +1, +1, -1,   +1, 1, -1,   -1, +1, -1, _
                           -1, +1, +1,   -1, 1, -1,   -1, -1, +1, _
                           -1, +1, -1,   -1, 1, -1,   -1, +1, +1, _
                           +1, +1, -1,   +1, 1, +1,   +1, -1, -1, _
                           +1, +1, +1,   +1, 1, +1,   +1, +1, -1, _
                           +1, +1, -1,   -1, 1, +1,   +1, +1, +1, _
                           -1, +1, -1,   -1, 1, +1,   +1, +1, -1, _
                           +1, -1, +1,   -1, 1, -1,   +1, -1, -1, _
                           -1, -1, +1,   -1, 1, -1,   +1, -1, +1  _
                         )
    End If
    VBGLBaFoCubeXYZ = Arr
End Function


Public Function VBGLBaFoPyramidXYZ() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        Arr = ArraySingle( _
                           +0, +1, +0,   -1, -1, +1,   +1, -1, +1, _
                           +0, +1, +0,   +1, -1, +1,   +1, -1, -1, _
                           +0, +1, +0,   +1, -1, -1,   -1, -1, -1, _
                           +0, +1, +0,   -1, -1, -1,   -1, -1, +1, _
                           -1, -1, +1,   +1, -1, +1,   +1, -1, -1, _
                           -1, -1, +1,   +1, -1, -1,   -1, -1, -1  _
                         )
    End If
    VBGLBaFoPyramidXYZ = Arr
End Function