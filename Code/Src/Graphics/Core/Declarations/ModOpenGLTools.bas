Attribute VB_Name = "ModOpenGLTools"
Option Explicit
'***************************************************************************************
'*           D�clarations pour glu / wgl / gdi32
'*               et autres fonctions utiles
'***************************************************************************************
' v0.2 - 08/11/2009
' v0.3 - 28/07/2014
'***************************************************************************************
'*                                       API                                           *
'***************************************************************************************
#If VBA7 Then
    DefLngPtr A-Z
    Private Const PtrNull As LongPtr = 0
#Else
    DefLng A-Z
    Private Const PtrNull As Long = 0
#End If
#If Win64 = False Then
    Private Declare Function GetProcessDEPPolicy                                                         Lib "kernel32" (ByVal hProcess As Long, ByRef lpFlags As Long, ByRef lpPermanent As Long) As Long
    Private Declare Function GetCurrentProcess                                                           Lib "kernel32" () As Long
    Private Declare Function GetModuleHandle                                                             Lib "kernel32.dll" Alias "GetModuleHandleW" (ByVal lpModuleName As Long) As Long
    Private Declare Function getProcAddress                                                              Lib "kernel32" Alias "GetProcAddress" (ByVal hModule As Long, ByVal lpProcName As String) As Long
#End If
#If VBA7 Then
    ' Extensions
    Private Declare PtrSafe Function DispCallFunc                                                         Lib "oleaut32" (ByVal ppv As LongPtr, ByVal oVft As LongPtr, ByVal CC As LongPtr, ByVal rtTYP As Integer, ByVal paCount As Long, paTypes As Integer, paValues As LongPtr, fuReturn As Variant) As Long
    Private Declare PtrSafe Function GetModuleFileName                                                    Lib "kernel32" Alias "GetModuleFileNameA" (ByVal hModule As LongPtr, ByVal lpFileName As String, ByVal nSize As Long) As Long
    Private Declare PtrSafe Sub CopyMemory                                                                Lib "kernel32" Alias "RtlMoveMemory" (pDest As Any, pSource As Any, ByVal ByteLen As LongPtr)
    Private Declare PtrSafe Function VirtualProtect                                                       Lib "kernel32" (ByVal lpAddress As LongPtr, ByVal dwSize As LongPtr, ByVal flNewProtect As Long, lpflOldProtect As Long) As Long
    ' Glu32
    Private Declare PtrSafe Function gluErrorString                                                       Lib "glu32" (ByVal error As Long) As LongPtr
    Private Declare PtrSafe Function gluGetString                                                         Lib "glu32" (ByVal name As Long) As LongPtr
    Public Declare PtrSafe Sub gluOrtho2D                                                                 Lib "glu32" (ByVal Left As Double, ByVal Right As Double, ByVal Bottom As Double, ByVal Top As Double)
    Public Declare PtrSafe Sub gluPerspective                                                             Lib "glu32" (ByVal fovy As Double, ByVal aspect As Double, ByVal zNear As Double, ByVal zFar As Double)
    Public Declare PtrSafe Sub gluPickMatrix                                                              Lib "glu32" (ByVal X As Double, ByVal y As Double, ByVal Width As Double, ByVal Height As Double, viewport As Long)
    Public Declare PtrSafe Sub gluLookAt                                                                  Lib "glu32" (ByVal eyex As Double, ByVal eyey As Double, ByVal eyez As Double, ByVal centerx As Double, ByVal centery As Double, ByVal centerz As Double, ByVal upx As Double, ByVal upy As Double, ByVal upz As Double)
    Public Declare PtrSafe Function gluProject                                                            Lib "glu32" (ByVal objx As Double, ByVal objy As Double, ByVal objz As Double, modelMatrix As Double, projMatrix As Double, viewport As Long, winx As Double, winy As Double, winz As Double) As Long
    Public Declare PtrSafe Function gluUnProject                                                          Lib "glu32" (ByVal winx As Double, ByVal winy As Double, ByVal winz As Double, modelMatrix As Double, projMatrix As Double, viewport As Long, objx As Double, objy As Double, objz As Double) As Long
    Public Declare PtrSafe Function gluScaleImage                                                         Lib "glu32" (ByVal format As Long, ByVal widthin As Long, ByVal heightin As Long, ByVal typein As Long, datain As Any, ByVal widthout As Long, ByVal heightout As Long, ByVal typeout As Long, dataout As Any) As Long
    Public Declare PtrSafe Function gluBuild1DMipmaps                                                     Lib "glu32" (ByVal target As Long, ByVal components As Long, ByVal Width As Long, ByVal format As Long, ByVal typ As Long, data As Any) As Long
    Public Declare PtrSafe Function gluBuild2DMipmaps                                                     Lib "glu32" (ByVal target As Long, ByVal components As Long, ByVal Width As Long, ByVal Height As Long, ByVal format As Long, ByVal typ As Long, data As Any) As Long
    Public Declare PtrSafe Function gluNewQuadric                                                         Lib "glu32" () As LongPtr
    Public Declare PtrSafe Sub gluDeleteQuadric                                                           Lib "glu32" (ByVal qobj As LongPtr)
    Public Declare PtrSafe Sub gluQuadricNormals                                                          Lib "glu32" (ByVal qobj As LongPtr, ByVal normals As Long)
    Public Declare PtrSafe Sub gluQuadricTexture                                                          Lib "glu32" (ByVal qobj As LongPtr, ByVal textureCoord As Long)
    Public Declare PtrSafe Sub gluQuadricOrientation                                                      Lib "glu32" (ByVal qobj As LongPtr, ByVal orientation As Long)
    Public Declare PtrSafe Sub gluQuadricDrawStyle                                                        Lib "glu32" (ByVal qobj As LongPtr, ByVal drawStyle As Long)
    Public Declare PtrSafe Sub gluCylinder                                                                Lib "glu32" (ByVal qobj As LongPtr, ByVal baseRadius As Double, ByVal topRadius As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub gluDisk                                                                    Lib "glu32" (ByVal qobj As LongPtr, ByVal innerRadius As Double, ByVal outerRadius As Double, ByVal slices As Long, ByVal loops As Long)
    Public Declare PtrSafe Sub gluPartialDisk                                                             Lib "glu32" (ByVal qobj As LongPtr, ByVal innerRadius As Double, ByVal outerRadius As Double, ByVal slices As Long, ByVal loops As Long, ByVal startAngle As Double, ByVal sweepAngle As Double)
    Public Declare PtrSafe Sub gluSphere                                                                  Lib "glu32" (ByVal qobj As LongPtr, ByVal radius As Double, ByVal slices As Integer, ByVal stacks As Integer)
    Public Declare PtrSafe Sub gluQuadricCallback                                                         Lib "glu32" (ByVal qobj As LongPtr, ByVal which As Long, ByVal fn As LongPtr)
    Public Declare PtrSafe Function gluNewTess                                                            Lib "glu32" () As LongPtr
    Public Declare PtrSafe Sub gluDeleteTess                                                              Lib "glu32" (ByVal tess As LongPtr)
    Public Declare PtrSafe Sub gluTessBeginPolygon                                                        Lib "glu32" (ByVal tess As LongPtr, data As Any)
    Public Declare PtrSafe Sub gluTessBeginContour                                                        Lib "glu32" (ByVal tess As LongPtr)
    Public Declare PtrSafe Sub gluTessVertex                                                              Lib "glu32" (ByVal tess As LongPtr, coords As Double, data As Any)
    Public Declare PtrSafe Sub gluTessEndContour                                                          Lib "glu32" (ByVal tess As LongPtr)
    Public Declare PtrSafe Sub gluTessEndPolygon                                                          Lib "glu32" (ByVal tess As LongPtr)
    Public Declare PtrSafe Sub gluTessProperty                                                            Lib "glu32" (ByVal tess As LongPtr, ByVal which As Long, ByVal value As Double)
    Public Declare PtrSafe Sub gluTessNormal                                                              Lib "glu32" (ByVal tess As LongPtr, ByVal X As Double, ByVal y As Double, ByVal z As Double)
    Public Declare PtrSafe Sub gluTessCallback                                                            Lib "glu32" (ByVal tess As LongPtr, ByVal which As Long, ByVal fn As LongPtr)
    Public Declare PtrSafe Sub gluGetTessProperty                                                         Lib "glu32" (ByVal tess As LongPtr, ByVal which As Long, value As Double)
    Public Declare PtrSafe Function gluNewNurbsRenderer                                                   Lib "glu32" () As LongPtr
    Public Declare PtrSafe Sub gluDeleteNurbsRenderer                                                     Lib "glu32" (ByVal nobj As LongPtr)
    Public Declare PtrSafe Sub gluBeginSurface                                                            Lib "glu32" (ByVal nobj As LongPtr)
    Public Declare PtrSafe Sub gluBeginCurve                                                              Lib "glu32" (ByVal nobj As LongPtr)
    Public Declare PtrSafe Sub gluEndCurve                                                                Lib "glu32" (ByVal nobj As LongPtr)
    Public Declare PtrSafe Sub gluEndSurface                                                              Lib "glu32" (ByVal nobj As LongPtr)
    Public Declare PtrSafe Sub gluBeginTrim                                                               Lib "glu32" (ByVal nobj As LongPtr)
    Public Declare PtrSafe Sub gluEndTrim                                                                 Lib "glu32" (ByVal nobj As LongPtr)
    Public Declare PtrSafe Sub gluPwlCurve                                                                Lib "glu32" (ByVal nobj As LongPtr, ByVal count As Long, curvearray As Single, ByVal stride As Long, ByVal typ As Long)
    Public Declare PtrSafe Sub gluNurbsCurve                                                              Lib "glu32" (ByVal nobj As LongPtr, ByVal nknots As Long, knot As Single, ByVal stride As Long, ctlarray As Single, ByVal order As Long, ByVal typ As Long)
    Public Declare PtrSafe Sub gluNurbsSurface                                                            Lib "glu32" (ByVal nobj As LongPtr, ByVal sknot_count As Long, sknot As Single, ByVal tknot_count As Long, tknot As Single, ByVal s_stride As Long, ByVal t_stride As Long, ctlarray As Single, ByVal sorder As Long, ByVal torder As Long, ByVal typ As Long)
    Public Declare PtrSafe Sub gluLoadSamplingMatrices                                                    Lib "glu32" (ByVal nobj As LongPtr, modelMatrix As Single, projMatrix As Single, viewport As Long)
    Public Declare PtrSafe Sub gluNurbsProperty                                                           Lib "glu32" (ByVal nobj As LongPtr, ByVal property As Long, ByVal value As Single)
    Public Declare PtrSafe Sub gluGetNurbsProperty                                                        Lib "glu32" (ByVal nobj As LongPtr, ByVal property As Long, value As Single)
    Public Declare PtrSafe Sub gluNurbsCallback                                                           Lib "glu32" (ByVal nobj As LongPtr, ByVal which As Long, ByVal fn As LongPtr)
    Public Declare PtrSafe Sub gluBeginPolygon                                                            Lib "glu32" (ByVal tess As LongPtr)
    Public Declare PtrSafe Sub gluEndPolygon                                                              Lib "glu32" (ByVal tess As LongPtr)
    Public Declare PtrSafe Sub gluNextContour                                                             Lib "glu32" (ByVal tess As LongPtr, ByVal typ As Long)
    ' Gdi32
    Public Declare PtrSafe Function ChoosePixelFormat                                                     Lib "gdi32" (ByVal hdc As LongPtr, ppfd As PIXELFORMATDESCRIPTOR) As Long
    Public Declare PtrSafe Function SetPixelFormat                                                        Lib "gdi32" (ByVal hdc As LongPtr, ByVal iPixelFormat As Long, ppfd As PIXELFORMATDESCRIPTOR) As Long
    Public Declare PtrSafe Function SwapBuffers                                                           Lib "gdi32" (ByVal hdc As LongPtr) As Long
    ' WGL (windows)
    Public Declare PtrSafe Function wglCopyContext                                                        Lib "opengl32" (ByVal hglrcSrc As LongPtr, ByVal hglrcDst As LongPtr, ByVal mask As Long) As Long
    Public Declare PtrSafe Function wglCreateContext                                                      Lib "opengl32" (ByVal hdc As LongPtr) As LongPtr
    Public Declare PtrSafe Function wglCreateLayerContext                                                 Lib "opengl32" (ByVal hglrc As LongPtr, iLayerPlane As Integer) As LongPtr
    Public Declare PtrSafe Function wglDeleteContext                                                      Lib "opengl32" (ByVal hglrc As LongPtr) As Long
    Public Declare PtrSafe Function wglGetCurrentContext                                                  Lib "opengl32" () As LongPtr
    Public Declare PtrSafe Function wglGetCurrentDC                                                       Lib "opengl32" () As LongPtr
    Public Declare PtrSafe Function wglGetProcAddress                                                     Lib "opengl32.dll" (ByVal lpStr As String) As LongPtr
    Public Declare PtrSafe Function wglMakeCurrent                                                        Lib "opengl32" (ByVal hdc As LongPtr, ByVal hglrc As LongPtr) As Long
    Public Declare PtrSafe Function wglShareLists                                                         Lib "opengl32" (ByVal hglrcSrc As LongPtr, ByVal hglrcDst As LongPtr) As Long
    Public Declare PtrSafe Function wglUseFontBitmaps                                                     Lib "opengl32" Alias "wglUseFontBitmapsA" (ByVal hdc As LongPtr, ByVal first As Long, ByVal count As Long, ByVal listbase As Long) As Long
    Public Declare PtrSafe Function wglUseFontOutlines                                                    Lib "opengl32" Alias "wglUseFontOutlinesA" (ByVal hdc As LongPtr, ByVal first As Long, ByVal count As Long, ByVal listbase As Long, ByVal deviation As Single, ByVal extrusion As Single, ByVal format As Long, ByRef lpgmf As Any) As Long
    ' Kernel32
    Public Declare PtrSafe Sub RtlMoveMemory                                                              Lib "kernel32" (Destination As Any, source As Any, ByVal length As LongPtr)
#Else
    ' Extensions
    Private Declare Function DispCallFunc                                                                 Lib "oleaut32" (ByVal ppv As Long, ByVal oVft As Long, ByVal CC As Long, ByVal rtTYP As Integer, ByVal paCount As Long, paTypes As Integer, paValues As Long, fuReturn As Variant) As Long
    Private Declare Function GetModuleFileName                                                            Lib "kernel32" Alias "GetModuleFileNameA" (ByVal hModule As Long, ByVal lpFileName As String, ByVal nSize As Long) As Long
    Private Declare Sub CopyMemory                                                                        Lib "kernel32" Alias "RtlMoveMemory" (pDest As Any, pSource As Any, ByVal ByteLen As Long)
    Private Declare Function VirtualProtect                                                               Lib "kernel32" (ByVal lpAddress As Long, ByVal dwSize As Long, ByVal flNewProtect As Long, lpflOldProtect As Long) As Long
    ' Glu32
    Private Declare Function gluErrorString                                                               Lib "glu32" (ByVal error As Long) As Long
    Private Declare Function gluGetString                                                                 Lib "glu32" (ByVal name As Long) As Long
    Public Declare Sub gluOrtho2D                                                                         Lib "glu32" (ByVal Left As Double, ByVal Right As Double, ByVal Bottom As Double, ByVal Top As Double)
    Public Declare Sub gluPerspective                                                                     Lib "glu32" (ByVal fovy As Double, ByVal aspect As Double, ByVal zNear As Double, ByVal zFar As Double)
    Public Declare Sub gluPickMatrix                                                                      Lib "glu32" (ByVal X As Double, ByVal y As Double, ByVal Width As Double, ByVal Height As Double, viewport As Long)
    Public Declare Sub gluLookAt                                                                          Lib "glu32" (ByVal eyex As Double, ByVal eyey As Double, ByVal eyez As Double, ByVal centerx As Double, ByVal centery As Double, ByVal centerz As Double, ByVal upx As Double, ByVal upy As Double, ByVal upz As Double)
    Public Declare Function gluProject                                                                    Lib "glu32" (ByVal objx As Double, ByVal objy As Double, ByVal objz As Double, modelMatrix As Double, projMatrix As Double, viewport As Long, winx As Double, winy As Double, winz As Double) As Long
    Public Declare Function gluUnProject                                                                  Lib "glu32" (ByVal winx As Double, ByVal winy As Double, ByVal winz As Double, modelMatrix As Double, projMatrix As Double, viewport As Long, objx As Double, objy As Double, objz As Double) As Long
    Public Declare Function gluScaleImage                                                                 Lib "glu32" (ByVal format As Long, ByVal widthin As Long, ByVal heightin As Long, ByVal typein As Long, datain As Any, ByVal widthout As Long, ByVal heightout As Long, ByVal typeout As Long, dataout As Any) As Long
    Public Declare Function gluBuild1DMipmaps                                                             Lib "glu32" (ByVal target As Long, ByVal components As Long, ByVal Width As Long, ByVal format As Long, ByVal typ As Long, data As Any) As Long
    Public Declare Function gluBuild2DMipmaps                                                             Lib "glu32" (ByVal target As Long, ByVal components As Long, ByVal Width As Long, ByVal Height As Long, ByVal format As Long, ByVal typ As Long, data As Any) As Long
    Public Declare Function gluNewQuadric                                                                 Lib "glu32" () As Long
    Public Declare Sub gluDeleteQuadric                                                                   Lib "glu32" (ByVal qobj As Long)
    Public Declare Sub gluQuadricNormals                                                                  Lib "glu32" (ByVal qobj As Long, ByVal normals As Long)
    Public Declare Sub gluQuadricTexture                                                                  Lib "glu32" (ByVal qobj As Long, ByVal textureCoord As Long)
    Public Declare Sub gluQuadricOrientation                                                              Lib "glu32" (ByVal qobj As Long, ByVal orientation As Long)
    Public Declare Sub gluQuadricDrawStyle                                                                Lib "glu32" (ByVal qobj As Long, ByVal drawStyle As Long)
    Public Declare Sub gluCylinder                                                                        Lib "glu32" (ByVal qobj As Long, ByVal baseRadius As Double, ByVal topRadius As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare Sub gluDisk                                                                            Lib "glu32" (ByVal qobj As Long, ByVal innerRadius As Double, ByVal outerRadius As Double, ByVal slices As Long, ByVal loops As Long)
    Public Declare Sub gluPartialDisk                                                                     Lib "glu32" (ByVal qobj As Long, ByVal innerRadius As Double, ByVal outerRadius As Double, ByVal slices As Long, ByVal loops As Long, ByVal startAngle As Double, ByVal sweepAngle As Double)
    Public Declare Sub gluSphere                                                                          Lib "glu32" (ByVal qobj As Long, ByVal radius As Double, ByVal slices As Integer, ByVal stacks As Integer)
    Public Declare Sub gluQuadricCallback                                                                 Lib "glu32" (ByVal qobj As Long, ByVal which As Long, ByVal fn As Long)
    Public Declare Function gluNewTess                                                                    Lib "glu32" () As Long
    Public Declare Sub gluDeleteTess                                                                      Lib "glu32" (ByVal tess As Long)
    Public Declare Sub gluTessBeginPolygon                                                                Lib "glu32" (ByVal tess As Long, data As Any)
    Public Declare Sub gluTessBeginContour                                                                Lib "glu32" (ByVal tess As Long)
    Public Declare Sub gluTessVertex                                                                      Lib "glu32" (ByVal tess As Long, coords As Double, data As Any)
    Public Declare Sub gluTessEndContour                                                                  Lib "glu32" (ByVal tess As Long)
    Public Declare Sub gluTessEndPolygon                                                                  Lib "glu32" (ByVal tess As Long)
    Public Declare Sub gluTessProperty                                                                    Lib "glu32" (ByVal tess As Long, ByVal which As Long, ByVal value As Double)
    Public Declare Sub gluTessNormal                                                                      Lib "glu32" (ByVal tess As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double)
    Public Declare Sub gluTessCallback                                                                    Lib "glu32" (ByVal tess As Long, ByVal which As Long, ByVal fn As Long)
    Public Declare Sub gluGetTessProperty                                                                 Lib "glu32" (ByVal tess As Long, ByVal which As Long, value As Double)
    Public Declare Function gluNewNurbsRenderer                                                           Lib "glu32" () As Long
    Public Declare Sub gluDeleteNurbsRenderer                                                             Lib "glu32" (ByVal nobj As Long)
    Public Declare Sub gluBeginSurface                                                                    Lib "glu32" (ByVal nobj As Long)
    Public Declare Sub gluBeginCurve                                                                      Lib "glu32" (ByVal nobj As Long)
    Public Declare Sub gluEndCurve                                                                        Lib "glu32" (ByVal nobj As Long)
    Public Declare Sub gluEndSurface                                                                      Lib "glu32" (ByVal nobj As Long)
    Public Declare Sub gluBeginTrim                                                                       Lib "glu32" (ByVal nobj As Long)
    Public Declare Sub gluEndTrim                                                                         Lib "glu32" (ByVal nobj As Long)
    Public Declare Sub gluPwlCurve                                                                        Lib "glu32" (ByVal nobj As Long, ByVal count As Long, curvearray As Single, ByVal stride As Long, ByVal typ As Long)
    Public Declare Sub gluNurbsCurve                                                                      Lib "glu32" (ByVal nobj As Long, ByVal nknots As Long, knot As Single, ByVal stride As Long, ctlarray As Single, ByVal order As Long, ByVal typ As Long)
    Public Declare Sub gluNurbsSurface                                                                    Lib "glu32" (ByVal nobj As Long, ByVal sknot_count As Long, sknot As Single, ByVal tknot_count As Long, tknot As Single, ByVal s_stride As Long, ByVal t_stride As Long, ctlarray As Single, ByVal sorder As Long, ByVal torder As Long, ByVal typ As Long)
    Public Declare Sub gluLoadSamplingMatrices                                                            Lib "glu32" (ByVal nobj As Long, modelMatrix As Single, projMatrix As Single, viewport As Long)
    Public Declare Sub gluNurbsProperty                                                                   Lib "glu32" (ByVal nobj As Long, ByVal property As Long, ByVal value As Single)
    Public Declare Sub gluGetNurbsProperty                                                                Lib "glu32" (ByVal nobj As Long, ByVal property As Long, value As Single)
    Public Declare Sub gluNurbsCallback                                                                   Lib "glu32" (ByVal nobj As Long, ByVal which As Long, ByVal fn As Long)
    Public Declare Sub gluBeginPolygon                                                                    Lib "glu32" (ByVal tess As Long)
    Public Declare Sub gluEndPolygon                                                                      Lib "glu32" (ByVal tess As Long)
    Public Declare Sub gluNextContour                                                                     Lib "glu32" (ByVal tess As Long, ByVal typ As Long)
    ' Gdi32
    Public Declare Function ChoosePixelFormat                                                             Lib "gdi32" (ByVal hdc As Long, ppfd As PIXELFORMATDESCRIPTOR) As Long
    Public Declare Function SetPixelFormat                                                                Lib "gdi32" (ByVal hdc As Long, ByVal iPixelFormat As Long, ppfd As PIXELFORMATDESCRIPTOR) As Long
    Public Declare Function SwapBuffers                                                                   Lib "gdi32" (ByVal hdc As Long) As Long
    ' WGL (windows)
    Public Declare Function wglCopyContext                                                                Lib "opengl32" (ByVal hglrcSrc As Long, ByVal hglrcDst As Long, ByVal mask As Long) As Long
    Public Declare Function wglCreateContext                                                              Lib "opengl32" (ByVal hdc As Long) As Long
    Public Declare Function wglCreateLayerContext                                                         Lib "opengl32" (ByVal hglrc As Long, iLayerPlane As Integer) As Long
    Public Declare Function wglDeleteContext                                                              Lib "opengl32" (ByVal hglrc As Long) As Long
    Public Declare Function wglGetCurrentContext                                                          Lib "opengl32" () As Long
    Public Declare Function wglGetCurrentDC                                                               Lib "opengl32" () As Long
    Public Declare Function wglGetProcAddress                                                             Lib "opengl32.dll" (ByVal lpStr As String) As Long
    Public Declare Function wglMakeCurrent                                                                Lib "opengl32" (ByVal hdc As Long, ByVal hglrc As Long) As Long
    Public Declare Function wglShareLists                                                                 Lib "opengl32" (ByVal hglrcSrc As Long, ByVal hglrcDst As Long) As Long
    Public Declare Function wglUseFontBitmaps                                                             Lib "opengl32" Alias "wglUseFontBitmapsA" (ByVal hdc As Long, ByVal first As Long, ByVal count As Long, ByVal listbase As Long) As Long
    Public Declare Function wglUseFontOutlines                                                            Lib "opengl32" Alias "wglUseFontOutlinesA" (ByVal hdc As Long, ByVal first As Long, ByVal count As Long, ByVal listbase As Long, ByVal deviation As Single, ByVal extrusion As Single, ByVal format As Long, ByRef lpgmf As Any) As Long
    ' Kernel32
    Public Declare Sub RtlMoveMemory                                                                      Lib "kernel32" (Destination As Any, source As Any, ByVal length As Long)
#End If
'***************************************************************************************
'*                                    Constantes                                       *
'***************************************************************************************
' Extensions
Private Const PAGE_EXECUTE_READWRITE = &H40&
' WGL (windows)
Public Const WGL_FONT_LINES = 0
Public Const WGL_FONT_POLYGONS = 1
' Glu32
Public Const GLU_INVALID_ENUM                   = 100900
Public Const GLU_INVALID_VALUE                  = 100901
Public Const GLU_OUT_OF_MEMORY                  = 100902
Public Const GLU_INCOMPATIBLE_GL_VERSION        = 100903
Public Const GLU_VERSION                        = 100800
Public Const GLU_EXTENSIONS                     = 100801
Public Const GLU_TRUE                           = 1
Public Const GLU_FALSE                          = 0
Public Const GLU_SMOOTH                         = 100000
Public Const GLU_FLAT                           = 100001
Public Const GLU_NONE                           = 100002
Public Const GLU_POINT                          = 100010
Public Const GLU_LINE                           = 100011
Public Const GLU_FILL                           = 100012
Public Const GLU_SILHOUETTE                     = 100013
Public Const GLU_OUTSIDE                        = 100020
Public Const GLU_INSIDE                         = 100021
Public Const GLU_ERROR                          = 100103
Public Const GLU_TESS_MAX_COORD                 = 1E+150
Public Const GLU_TESS_WINDING_RULE              = 100140
Public Const GLU_TESS_BOUNDARY_ONLY             = 100141
Public Const GLU_TESS_TOLERANCE                 = 100142
Public Const GLU_TESS_WINDING_ODD               = 100130
Public Const GLU_TESS_WINDING_NONZERO           = 100131
Public Const GLU_TESS_WINDING_POSITIVE          = 100132
Public Const GLU_TESS_WINDING_NEGATIVE          = 100133
Public Const GLU_TESS_WINDING_ABS_GEQ_TWO       = 100134
Public Const GLU_TESS_BEGIN                     = 100100
Public Const GLU_TESS_VERTEX                    = 100101
Public Const GLU_TESS_END                       = 100102
Public Const GLU_TESS_ERROR                     = 100103
Public Const GLU_TESS_EDGE_FLAG                 = 100104
Public Const GLU_TESS_COMBINE                   = 100105
Public Const GLU_TESS_BEGIN_DATA                = 100106
Public Const GLU_TESS_VERTEX_DATA               = 100107
Public Const GLU_TESS_END_DATA                  = 100108
Public Const GLU_TESS_ERROR_DATA                = 100109
Public Const GLU_TESS_EDGE_FLAG_DATA            = 100110
Public Const GLU_TESS_COMBINE_DATA              = 100111
Public Const GLU_TESS_ERROR1                    = 100151
Public Const GLU_TESS_ERROR2                    = 100152
Public Const GLU_TESS_ERROR3                    = 100153
Public Const GLU_TESS_ERROR4                    = 100154
Public Const GLU_TESS_ERROR5                    = 100155
Public Const GLU_TESS_ERROR6                    = 100156
Public Const GLU_TESS_ERROR7                    = 100157
Public Const GLU_TESS_ERROR8                    = 100158
Public Const GLU_TESS_MISSING_BEGIN_POLYGON     = GLU_TESS_ERROR1
Public Const GLU_TESS_MISSING_BEGIN_CONTOUR     = GLU_TESS_ERROR2
Public Const GLU_TESS_MISSING_END_POLYGON       = GLU_TESS_ERROR3
Public Const GLU_TESS_MISSING_END_CONTOUR       = GLU_TESS_ERROR4
Public Const GLU_TESS_COORD_TOO_LARGE           = GLU_TESS_ERROR5
Public Const GLU_TESS_NEED_COMBINE_CALLBACK     = GLU_TESS_ERROR6
Public Const GLU_AUTO_LOAD_MATRIX               = 100200
Public Const GLU_CULLING                        = 100201
Public Const GLU_SAMPLING_TOLERANCE             = 100203
Public Const GLU_DISPLAY_MODE                   = 100204
Public Const GLU_PARAMETRIC_TOLERANCE           = 100202
Public Const GLU_SAMPLING_METHOD                = 100205
Public Const GLU_U_STEP                         = 100206
Public Const GLU_V_STEP                         = 100207
Public Const GLU_PATH_LENGTH                    = 100215
Public Const GLU_PARAMETRIC_ERROR               = 100216
Public Const GLU_DOMAIN_DISTANCE                = 100217
Public Const GLU_MAP1_TRIM_2                    = 100210
Public Const GLU_MAP1_TRIM_3                    = 100211
Public Const GLU_OUTLINE_POLYGON                = 100240
Public Const GLU_OUTLINE_PATCH                  = 100241
Public Const GLU_NURBS_ERROR1                   = 100251
Public Const GLU_NURBS_ERROR2                   = 100252
Public Const GLU_NURBS_ERROR3                   = 100253
Public Const GLU_NURBS_ERROR4                   = 100254
Public Const GLU_NURBS_ERROR5                   = 100255
Public Const GLU_NURBS_ERROR6                   = 100256
Public Const GLU_NURBS_ERROR7                   = 100257
Public Const GLU_NURBS_ERROR8                   = 100258
Public Const GLU_NURBS_ERROR9                   = 100259
Public Const GLU_NURBS_ERROR10                  = 100260
Public Const GLU_NURBS_ERROR11                  = 100261
Public Const GLU_NURBS_ERROR12                  = 100262
Public Const GLU_NURBS_ERROR13                  = 100263
Public Const GLU_NURBS_ERROR14                  = 100264
Public Const GLU_NURBS_ERROR15                  = 100265
Public Const GLU_NURBS_ERROR16                  = 100266
Public Const GLU_NURBS_ERROR17                  = 100267
Public Const GLU_NURBS_ERROR18                  = 100268
Public Const GLU_NURBS_ERROR19                  = 100269
Public Const GLU_NURBS_ERROR20                  = 100270
Public Const GLU_NURBS_ERROR21                  = 100271
Public Const GLU_NURBS_ERROR22                  = 100272
Public Const GLU_NURBS_ERROR23                  = 100273
Public Const GLU_NURBS_ERROR24                  = 100274
Public Const GLU_NURBS_ERROR25                  = 100275
Public Const GLU_NURBS_ERROR26                  = 100276
Public Const GLU_NURBS_ERROR27                  = 100277
Public Const GLU_NURBS_ERROR28                  = 100278
Public Const GLU_NURBS_ERROR29                  = 100279
Public Const GLU_NURBS_ERROR30                  = 100280
Public Const GLU_NURBS_ERROR31                  = 100281
Public Const GLU_NURBS_ERROR32                  = 100282
Public Const GLU_NURBS_ERROR33                  = 100283
Public Const GLU_NURBS_ERROR34                  = 100284
Public Const GLU_NURBS_ERROR35                  = 100285
Public Const GLU_NURBS_ERROR36                  = 100286
Public Const GLU_NURBS_ERROR37                  = 100287
Public Const GLU_CW                             = 100120
Public Const GLU_CCW                            = 100121
Public Const GLU_INTERIOR                       = 100122
Public Const GLU_EXTERIOR                       = 100123
Public Const GLU_UNKNOWN                        = 100124
Public Const GLU_BEGIN                          = GLU_TESS_BEGIN
Public Const GLU_VERTEX                         = GLU_TESS_VERTEX
Public Const GLU_END                            = GLU_TESS_END
Public Const GLU_EDGE_FLAG                      = GLU_TESS_EDGE_FLAG
' Gdi32
Public Const PFD_DRAW_TO_WINDOW         = &H4&
Public Const PFD_DRAW_TO_BITMAP         = &H8&
Public Const PFD_SUPPORT_GDI            = &H10&
Public Const PFD_SUPPORT_OPENGL         = &H20&
Public Const PFD_GENERIC_ACCELERATED    = &H1000&
Public Const PFD_GENERIC_FORMAT         = &H40&
Public Const PFD_NEED_PALETTE           = &H80&
Public Const PFD_NEED_SYSTEM_PALETTE    = &H100&
Public Const PFD_DOUBLEBUFFER           = &H1&
Public Const PFD_STEREO                 = &H2&
Public Const PFD_SWAP_LAYER_BUFFERS     = &H800&
Public Const PFD_DEPTH_DONTCARE         = &H20000000
Public Const PFD_DOUBLEBUFFER_DONTCARE  = &H40000000
Public Const PFD_STEREO_DONTCARE        = &H80000000
Public Const PFD_SWAP_COPY              = &H400
Public Const PFD_SWAP_EXCHANGE          = &H200
Public Const PFD_TYPE_RGBA              = 0
Public Const PFD_TYPE_COLORINDEX        = 1
Public Const PFD_MAIN_PLANE             = 0
Public Const PFD_OVERLAY_PLANE          = 1
Public Const PFD_UNDERLAY_PLANE         = (-1)

'***************************************************************************************
'*                                       Types                                         *
'***************************************************************************************
' Gdi32
Public Type PIXELFORMATDESCRIPTOR
    nSize           As Integer
    nVersion        As Integer
    dwFlags         As Long
    iPixelType      As Byte
    cColorBits      As Byte
    cRedBits        As Byte
    cRedShift       As Byte
    cGreenBits      As Byte
    cGreenShift     As Byte
    cBlueBits       As Byte
    cBlueShift      As Byte
    cAlphaBits      As Byte
    cAlphaShift     As Byte
    cAccumBits      As Byte
    cAccumRedBits   As Byte
    cAccumGreenBits As Byte
    cAccumBlueBits  As Byte
    cAccumAlphaBits As Byte
    cDepthBits      As Byte
    cStencilBits    As Byte
    cAuxBuffers     As Byte
    iLayerType      As Byte
    bReserved       As Byte
    dwLayerMask     As Long
    dwVisibleMask   As Long
    dwDamageMask    As Long
End Type
Public Type POINTFLOAT
    X As Single
    y As Single
End Type
Public Type GLYPHMETRICSFLOAT
    gmfBlackBoxX     As Single
    gmfBlackBoxY     As Single
    gmfptGlyphOrigin As POINTFLOAT
    gmfCellIncX      As Single
    gmfCellIncY      As Single
End Type
' Autre
Public Type TColorub
    ColorRed         As Byte
    ColorGreen       As Byte
    ColorBlue        As Byte
    ColorAlpha       As Byte
End Type
Public Type TColorf
    ColorRed         As Single
    ColorGreen       As Single
    ColorBlue        As Single
    ColorAlpha       As Single
End Type
'***************************************************************************************
'*                            FONCTIONS SUPPLEMENTAIRES VB
'***************************************************************************************
Private Const CC_STDCALL = 4&
Private Const MaxArgs& = 32
Private vType(1 To MaxArgs) As Integer, vPtr(1 To MaxArgs), lReturn As Variant, vValue(1 To MaxArgs) As Variant
Private vValue1 As Variant, vValue2 As Variant

' Conversion de couleur VB en ub (byte)
Function ubColor(pColor As Long, Optional pAlpha As Byte = 255) As TColorub
    Dim lbytes(1 To 4) As Byte
    RtlMoveMemory lbytes(1), pColor, 4
    lbytes(4) = pAlpha
    ubColor.ColorAlpha = lbytes(4)
    ubColor.ColorRed = lbytes(1)
    ubColor.ColorGreen = lbytes(2)
    ubColor.ColorBlue = lbytes(3)
End Function
' Conversion de couleur VB en f (single)
Function ufColor(pColor As Long, Optional pAlpha As Single = 1) As TColorf
    Dim lbytes(1 To 4) As Byte
    RtlMoveMemory lbytes(1), pColor, 4
    lbytes(4) = pAlpha
    ufColor.ColorAlpha = lbytes(4) / 255
    ufColor.ColorRed = lbytes(1) / 255
    ufColor.ColorGreen = lbytes(2) / 255
    ufColor.ColorBlue = lbytes(3) / 255
End Function
' glColor adapt� pour couleur VB
Public Function glColor3VB(pColor As Long)
    Dim lbytes(1 To 3) As Byte
    RtlMoveMemory lbytes(1), pColor, 4
    glColor3ubv lbytes(1)
End Function
Public Function glColor4VB(pColor As Long, pAlpha As Byte)
    Dim lbytes(1 To 4) As Byte
    RtlMoveMemory lbytes(1), pColor, 4
    lbytes(4) = pAlpha
    glColor4ubv lbytes(1)
End Function
' Fonction de remplissage de tableau
Public Function BuildArray(parray As Variant, pValues As Variant)
    Dim lCpt As Long
    Dim lIndice As Long
    lIndice = LBound(parray)
    For lCpt = LBound(pValues) To UBound(pValues)
        parray(lIndice) = pValues(lCpt)
        lIndice = lIndice + 1
    Next
End Function
' Redirige les fonctions vers les extensions OpenGL
' Inspir� de : http://www.activevb.de/tipps/vb6tipps/tipp0715.html
Public Sub RemapVBFunctionToGLFunction(ByVal pVBFuncAddr, ByVal pGLFunction As String)
    Dim lProcAddress
    Dim lVBProcAddress
    Dim lOldProtect
    Dim lret As Long
    Dim lOldProtection As Long
    Dim lAsm(1 To 5)  As Byte
    Dim lJump
    Const ASMSIZE = 5
    
    lProcAddress = wglGetProcAddress(ByVal pGLFunction)
    If lProcAddress = PtrNull Then lProcAddress = wglGetProcAddress(ByVal pGLFunction & "ARB")
    If lProcAddress = PtrNull Then lProcAddress = wglGetProcAddress(ByVal pGLFunction & "EXT")
    If lProcAddress <> PtrNull Then
        If IsRunningInIDE_DirtyTrick Then
            CopyMemory lVBProcAddress, ByVal pVBFuncAddr + 22, LenB(lVBProcAddress)
        Else
            lVBProcAddress = pVBFuncAddr
        End If
        lret = VirtualProtect(ByVal lVBProcAddress, ASMSIZE, PAGE_EXECUTE_READWRITE, lOldProtection)
        lJump = lProcAddress - lVBProcAddress - ASMSIZE
        lAsm(1) = &HE9
        CopyMemory lAsm(2), lJump, ASMSIZE - 1
        CopyMemory ByVal lVBProcAddress, lAsm(1), ASMSIZE
        lret = VirtualProtect(ByVal lVBProcAddress, ASMSIZE, lOldProtection, 0&)
    End If
End Sub
' http://www.activevb.de/tipps/vb6tipps/tipp0347.html
Private Function IsRunningInIDE_DirtyTrick() As Boolean
    On Error GoTo NotCompiled
    Debug.Print 1 / 0
    Exit Function
    NotCompiled:
    IsRunningInIDE_DirtyTrick = True
    Exit Function
End Function

Public Function OpenGLExtCall0(ByRef pFunc, ByRef RetType As VbVarType) As Variant
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 0, vType(1), vPtr(1), OpenGLExtCall0) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall0"
    End If
End Function
Public Function OpenGLExtCall1(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 1, vType(1), vPtr(1), OpenGLExtCall1) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall1"
    End If
End Function
Public Function OpenGLExtCall2(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 2, vType(1), vPtr(1), OpenGLExtCall2) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall2"
    End If
End Function
Public Function OpenGLExtCall3(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 3, vType(1), vPtr(1), OpenGLExtCall3) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall3"
    End If
End Function
Public Function OpenGLExtCall4(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 4, vType(1), vPtr(1), OpenGLExtCall4) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall4"
    End If
End Function
Public Function OpenGLExtCall5(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 5, vType(1), vPtr(1), OpenGLExtCall5) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall5"
    End If
End Function
Public Function OpenGLExtCall6(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant, ByRef pV6 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    vValue(6) = pV6:    vType(6) = VarType(vValue(6)):    vPtr(6) = VarPtr(vValue(6))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 6, vType(1), vPtr(1), OpenGLExtCall6) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall6"
    End If
End Function
Public Function OpenGLExtCall7(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant, ByRef pV6 As Variant, ByRef pV7 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    vValue(6) = pV6:    vType(6) = VarType(vValue(6)):    vPtr(6) = VarPtr(vValue(6))
    vValue(7) = pV7:    vType(7) = VarType(vValue(7)):    vPtr(7) = VarPtr(vValue(7))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 7, vType(1), vPtr(1), OpenGLExtCall7) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall7"
    End If
End Function
Public Function OpenGLExtCall8(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant, ByRef pV6 As Variant, ByRef pV7 As Variant, ByRef pV8 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    vValue(6) = pV6:    vType(6) = VarType(vValue(6)):    vPtr(6) = VarPtr(vValue(6))
    vValue(7) = pV7:    vType(7) = VarType(vValue(7)):    vPtr(7) = VarPtr(vValue(7))
    vValue(8) = pV8:    vType(8) = VarType(vValue(8)):    vPtr(8) = VarPtr(vValue(8))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 8, vType(1), vPtr(1), OpenGLExtCall8) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall8"
    End If
End Function
Public Function OpenGLExtCall9(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant, ByRef pV6 As Variant, ByRef pV7 As Variant, ByRef pV8 As Variant, ByRef pV9 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    vValue(6) = pV6:    vType(6) = VarType(vValue(6)):    vPtr(6) = VarPtr(vValue(6))
    vValue(7) = pV7:    vType(7) = VarType(vValue(7)):    vPtr(7) = VarPtr(vValue(7))
    vValue(8) = pV8:    vType(8) = VarType(vValue(8)):    vPtr(8) = VarPtr(vValue(8))
    vValue(9) = pV9:    vType(9) = VarType(vValue(9)):    vPtr(9) = VarPtr(vValue(9))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 9, vType(1), vPtr(1), OpenGLExtCall9) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall9"
    End If
End Function
Public Function OpenGLExtCall10(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant, ByRef pV6 As Variant, ByRef pV7 As Variant, ByRef pV8 As Variant, ByRef pV9 As Variant, ByRef pV10 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    vValue(6) = pV6:    vType(6) = VarType(vValue(6)):    vPtr(6) = VarPtr(vValue(6))
    vValue(7) = pV7:    vType(7) = VarType(vValue(7)):    vPtr(7) = VarPtr(vValue(7))
    vValue(8) = pV8:    vType(8) = VarType(vValue(8)):    vPtr(8) = VarPtr(vValue(8))
    vValue(9) = pV9:    vType(9) = VarType(vValue(9)):    vPtr(9) = VarPtr(vValue(9))
    vValue(10) = pV10:    vType(10) = VarType(vValue(10)):    vPtr(10) = VarPtr(vValue(10))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 10, vType(1), vPtr(1), OpenGLExtCall10) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall10"
    End If
End Function
Public Function OpenGLExtCall11(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant, ByRef pV6 As Variant, ByRef pV7 As Variant, ByRef pV8 As Variant, ByRef pV9 As Variant, ByRef pV10 As Variant, ByRef pV11 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    vValue(6) = pV6:    vType(6) = VarType(vValue(6)):    vPtr(6) = VarPtr(vValue(6))
    vValue(7) = pV7:    vType(7) = VarType(vValue(7)):    vPtr(7) = VarPtr(vValue(7))
    vValue(8) = pV8:    vType(8) = VarType(vValue(8)):    vPtr(8) = VarPtr(vValue(8))
    vValue(9) = pV9:    vType(9) = VarType(vValue(9)):    vPtr(9) = VarPtr(vValue(9))
    vValue(10) = pV10:    vType(10) = VarType(vValue(10)):    vPtr(10) = VarPtr(vValue(10))
    vValue(11) = pV11:    vType(11) = VarType(vValue(11)):    vPtr(11) = VarPtr(vValue(11))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 11, vType(1), vPtr(1), OpenGLExtCall11) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall11"
    End If
End Function
Public Function OpenGLExtCall12(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant, ByRef pV6 As Variant, ByRef pV7 As Variant, ByRef pV8 As Variant, ByRef pV9 As Variant, ByRef pV10 As Variant, ByRef pV11 As Variant, ByRef pV12 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    vValue(6) = pV6:    vType(6) = VarType(vValue(6)):    vPtr(6) = VarPtr(vValue(6))
    vValue(7) = pV7:    vType(7) = VarType(vValue(7)):    vPtr(7) = VarPtr(vValue(7))
    vValue(8) = pV8:    vType(8) = VarType(vValue(8)):    vPtr(8) = VarPtr(vValue(8))
    vValue(9) = pV9:    vType(9) = VarType(vValue(9)):    vPtr(9) = VarPtr(vValue(9))
    vValue(10) = pV10:    vType(10) = VarType(vValue(10)):    vPtr(10) = VarPtr(vValue(10))
    vValue(11) = pV11:    vType(11) = VarType(vValue(11)):    vPtr(11) = VarPtr(vValue(11))
    vValue(12) = pV12:    vType(12) = VarType(vValue(12)):    vPtr(12) = VarPtr(vValue(12))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 12, vType(1), vPtr(1), OpenGLExtCall12) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall12"
    End If
End Function
Public Function OpenGLExtCall13(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant, ByRef pV6 As Variant, ByRef pV7 As Variant, ByRef pV8 As Variant, ByRef pV9 As Variant, ByRef pV10 As Variant, ByRef pV11 As Variant, _
    ByRef pV12 As Variant, ByRef pV13 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    vValue(6) = pV6:    vType(6) = VarType(vValue(6)):    vPtr(6) = VarPtr(vValue(6))
    vValue(7) = pV7:    vType(7) = VarType(vValue(7)):    vPtr(7) = VarPtr(vValue(7))
    vValue(8) = pV8:    vType(8) = VarType(vValue(8)):    vPtr(8) = VarPtr(vValue(8))
    vValue(9) = pV9:    vType(9) = VarType(vValue(9)):    vPtr(9) = VarPtr(vValue(9))
    vValue(10) = pV10:    vType(10) = VarType(vValue(10)):    vPtr(10) = VarPtr(vValue(10))
    vValue(11) = pV11:    vType(11) = VarType(vValue(11)):    vPtr(11) = VarPtr(vValue(11))
    vValue(123) = pV12:    vType(12) = VarType(vValue(123)):    vPtr(13) = VarPtr(vValue(12))
    vValue(13) = pV13:    vType(13) = VarType(vValue(13)):    vPtr(13) = VarPtr(vValue(13))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 13, vType(1), vPtr(1), OpenGLExtCall13) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall13"
    End If
End Function
Public Function OpenGLExtCall15(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant, ByRef pV6 As Variant, ByRef pV7 As Variant, ByRef pV8 As Variant, ByRef pV9 As Variant, ByRef pV10 As Variant, ByRef pV11 As Variant, _
    ByRef pV12 As Variant, ByRef pV13 As Variant, ByRef pV14 As Variant, ByRef pV15 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    vValue(6) = pV6:    vType(6) = VarType(vValue(6)):    vPtr(6) = VarPtr(vValue(6))
    vValue(7) = pV7:    vType(7) = VarType(vValue(7)):    vPtr(7) = VarPtr(vValue(7))
    vValue(8) = pV8:    vType(8) = VarType(vValue(8)):    vPtr(8) = VarPtr(vValue(8))
    vValue(9) = pV9:    vType(9) = VarType(vValue(9)):    vPtr(9) = VarPtr(vValue(9))
    vValue(10) = pV10:    vType(10) = VarType(vValue(10)):    vPtr(10) = VarPtr(vValue(10))
    vValue(11) = pV11:    vType(11) = VarType(vValue(11)):    vPtr(11) = VarPtr(vValue(11))
    vValue(12) = pV12:    vType(12) = VarType(vValue(12)):    vPtr(12) = VarPtr(vValue(12))
    vValue(13) = pV13:    vType(13) = VarType(vValue(13)):    vPtr(13) = VarPtr(vValue(13))
    vValue(14) = pV14:    vType(14) = VarType(vValue(14)):    vPtr(14) = VarPtr(vValue(14))
    vValue(15) = pV15:    vType(15) = VarType(vValue(15)):    vPtr(15) = VarPtr(vValue(15))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 15, vType(1), vPtr(1), OpenGLExtCall15) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall15"
    End If
End Function
Public Function OpenGLExtCall17(ByRef pFunc, ByRef RetType As VbVarType, ByRef pV1 As Variant, ByRef pV2 As Variant, ByRef pV3 As Variant, ByRef pV4 As Variant, _
    ByRef pV5 As Variant, ByRef pV6 As Variant, ByRef pV7 As Variant, ByRef pV8 As Variant, ByRef pV9 As Variant, ByRef pV10 As Variant, ByRef pV11 As Variant, _
    ByRef pV12 As Variant, ByRef pV13 As Variant, ByRef pV14 As Variant, ByRef pV15 As Variant, ByRef pV16 As Variant, ByRef pV17 As Variant) As Variant
    vValue(1) = pV1:    vType(1) = VarType(vValue(1)):    vPtr(1) = VarPtr(vValue(1))
    vValue(2) = pV2:    vType(2) = VarType(vValue(2)):    vPtr(2) = VarPtr(vValue(2))
    vValue(3) = pV3:    vType(3) = VarType(vValue(3)):    vPtr(3) = VarPtr(vValue(3))
    vValue(4) = pV4:    vType(4) = VarType(vValue(4)):    vPtr(4) = VarPtr(vValue(4))
    vValue(5) = pV5:    vType(5) = VarType(vValue(5)):    vPtr(5) = VarPtr(vValue(5))
    vValue(6) = pV6:    vType(6) = VarType(vValue(6)):    vPtr(6) = VarPtr(vValue(6))
    vValue(7) = pV7:    vType(7) = VarType(vValue(7)):    vPtr(7) = VarPtr(vValue(7))
    vValue(8) = pV8:    vType(8) = VarType(vValue(8)):    vPtr(8) = VarPtr(vValue(8))
    vValue(9) = pV9:    vType(9) = VarType(vValue(9)):    vPtr(9) = VarPtr(vValue(9))
    vValue(10) = pV10:    vType(10) = VarType(vValue(10)):    vPtr(10) = VarPtr(vValue(10))
    vValue(11) = pV11:    vType(11) = VarType(vValue(11)):    vPtr(11) = VarPtr(vValue(11))
    vValue(12) = pV12:    vType(12) = VarType(vValue(12)):    vPtr(12) = VarPtr(vValue(12))
    vValue(13) = pV13:    vType(13) = VarType(vValue(13)):    vPtr(13) = VarPtr(vValue(13))
    vValue(14) = pV14:    vType(14) = VarType(vValue(14)):    vPtr(14) = VarPtr(vValue(14))
    vValue(15) = pV15:    vType(15) = VarType(vValue(15)):    vPtr(15) = VarPtr(vValue(15))
    vValue(16) = pV16:    vType(16) = VarType(vValue(16)):    vPtr(16) = VarPtr(vValue(16))
    vValue(17) = pV17:    vType(17) = VarType(vValue(17)):    vPtr(17) = VarPtr(vValue(17))
    If DispCallFunc(0, pFunc, CC_STDCALL, RetType, 17, vType(1), vPtr(1), OpenGLExtCall17) Then
      Err.Raise vbObjectError, , "Error in OpenGLExtCall17"
    End If
End Function

Public Function OpenGLExtProcAddress(pFunc As String)
    OpenGLExtProcAddress = wglGetProcAddress(ByVal pFunc)
    If OpenGLExtProcAddress = PtrNull Then OpenGLExtProcAddress = wglGetProcAddress(ByVal pFunc & "ARB")
    If OpenGLExtProcAddress = PtrNull Then OpenGLExtProcAddress = wglGetProcAddress(ByVal pFunc & "EXT")
End Function

' Recherche si DEP (Data Execution Prevention) est activ�
' Pour un process 64 bits, on pr�sume qu'il est activ�
' (voir dans une prochaine version si possible de d�tecter en 64 bits car GetProcessDEPPolicy ne fonctionne qu'en 32 bits)
' Si DEP est activ�, on ne peut pas modifier la m�moire ex�cutable ; donc RemapVBFunctionToGLFunction ne fonctionne pas (crash de l'appli)
' On utilise alors une solution de contournement avec DispCallFunc (c'est un peu plus lent)
Public Function IsDEPEnabled() As Boolean
    Dim lFlags As Long, lPermanent As Long, lret As Long
    'IsDEPEnabled = True: Exit Function ' POUR TESTS
    IsDEPEnabled = False
    #If Win64 Then
    ' GetProcessDEPPolicy ne fonctionne pas sur un process 64 bits
    ' On pr�sume que DEP est activ� (ce qui est souvent le cas par d�faut)
    ' Il faudrait �ventuellement aller lire des cl� de registres pour trouver si DEP est activ�
        IsDEPEnabled = True
    #Else
        On Error Resume Next ' si GetProcessDEPPolicy n'existe pas => pas de DEP
        If getProcAddress(GetModuleHandle(StrPtr("kernel32")), "GetProcessDEPPolicy") <> 0 Then
            lret = GetProcessDEPPolicy(GetCurrentProcess, lFlags, lPermanent)
        End If
        On Error GoTo 0
        If lret And lFlags <> 0 Then
            IsDEPEnabled = True
        End If
    #End If
End Function