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
        ReDim Arr(5)
        Arr(0) = -1  :  Arr(1) = -1
        Arr(2) = +0  :  Arr(3) = +1
        Arr(4) = +1  :  Arr(5) = -1
    End If
    VBGLBaFoTriangleXY = Arr
End Function

Public Function VBGLBaFoTriangleXYZ() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        ReDim Arr(8)
        Arr(0) = -1  :  Arr(1) = -1  :  Arr(1) = 0
        Arr(2) = +0  :  Arr(3) = +1  :  Arr(3) = 0
        Arr(4) = +1  :  Arr(5) = -1  :  Arr(5) = 0
    End If
    VBGLBaFoTriangleXYZ = Arr
End Function

Public Function VBGLBaFoRectangleXY() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        ReDim Arr(11)
        Arr(00) = -1  :  Arr(01) = +1
        Arr(02) = +1  :  Arr(03) = +1
        Arr(04) = -1  :  Arr(05) = -1
        Arr(06) = +1  :  Arr(07) = +1
        Arr(08) = +1  :  Arr(09) = -1
        Arr(10) = -1  :  Arr(11) = -1
    End If
    VBGLBaFoRectangleXY = Arr
End Function

Public Function VBGLBaFoRectangleXYZ() As Single()
    Static Arr() As Single
    If USize(Arr) = -1 Then
        ReDim Arr(17)
        Arr(00) = -1  :  Arr(01) = +1  :  Arr(02) = 0
        Arr(03) = +1  :  Arr(04) = +1  :  Arr(05) = 0
        Arr(06) = -1  :  Arr(07) = -1  :  Arr(08) = 0
        Arr(09) = +1  :  Arr(10) = +1  :  Arr(11) = 0
        Arr(12) = +1  :  Arr(13) = -1  :  Arr(14) = 0
        Arr(15) = -1  :  Arr(16) = -1  :  Arr(17) = 0
    End If
    VBGLBaFoRectangleXYZ = Arr
End Function

'======================================================================================
'=======================================[3D]===========================================
'======================================================================================


Public Function VBGLBaFoCubeXYZ() As Single()
    Dim v As Variant
    v = Array( _
        ' Front face (z = 1)
        +1, +1, +1,   -1, 1, +1,   +1, -1, +1, _
        -1, +1, +1,   -1, 1, +1,   +1, +1, +1, _
        ' Back face (z = -1)
        -1, +1, -1,   +1, 1, -1,   -1, -1, -1, _
        +1, +1, -1,   +1, 1, -1,   -1, +1, -1, _
        ' Left face (x = -1)
        -1, +1, +1,   -1, 1, -1,   -1, -1, +1, _
        -1, +1, -1,   -1, 1, -1,   -1, +1, +1, _
        ' Right face (x = 1)
        +1, +1, -1,   +1, 1, +1,   +1, -1, -1, _
        +1, +1, +1,   +1, 1, +1,   +1, +1, -1, _
        ' Top face (y = 1)
        +1, +1, -1,   -1, 1, +1,   +1, +1, +1, _
        -1, +1, -1,   -1, 1, +1,   +1, +1, -1, _
        ' Bottom face (y = -1)
        +1, -1, +1,   -1, 1, -1,   +1, -1, -1, _
        -1, -1, +1,   -1, 1, -1,   +1, -1, +1  _
    )
    
    Dim Faces           As Long   : Faces           = 6
    Dim TrianglePerFace As Long   : TrianglePerFace = 2
    Dim Length          As Long   : Length          = 3
    Dim Vertices        As Long   : Vertices        = 3
    Dim Arr()           As Single : ReDim Arr(Faces * TrianglePerFace * Vertices * Length - 1)
    Dim i As Long
    For i = 0 To USize(v)
        Arr(i) = v(i)
    Next i
    VBGLBaFoCubeXYZ = Arr
End Function


' --- Pyramid (square base) ------------------------------------------------------------
Public Function VBGLBaFoPyramidXYZ() As Single()

    ' 4 sides (triangles) + 2 for the base = 6 triangles * 3 vertices * 3 coords
    
    Dim v As Variant
    v = Array( _
        ' Front
        +0, +1, +0,   -1, -1, +1,   +1, -1, +1, _
        ' Right
        +0, +1, +0,   +1, -1, +1,   +1, -1, -1, _
        ' Back
        +0, +1, +0,   +1, -1, -1,   -1, -1, -1, _
        ' Left
        +0, +1, +0,   -1, -1, -1,   -1, -1, +1, _
        ' Base (two triangles)
        -1, -1, +1,   +1, -1, +1,   +1, -1, -1, _
        -1, -1, +1,   +1, -1, -1,   -1, -1, -1  _
    )
    
    Dim Triangles       As Long   : Triangles       = 6
    Dim Length          As Long   : Length          = 3
    Dim Vertices        As Long   : Vertices        = 3
    Dim Arr()           As Single : ReDim Arr(Triangles * Vertices * Length - 1)
    Dim i As Long
    For i = 0 To UBound(v)
        Arr(i) = v(i)
    Next i
    
    VBGLBaFoPyramidXYZ = Arr
End Function