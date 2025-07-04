Attribute VB_Name = "ModOpenGL_1_4"
Option Explicit
'***************************************************************************************
'*                   Module openGL ModOpenGL_OTHER
'***************************************************************************************
' http://arkham46.developpez.com
'***************************************************************************************
' G�n�r� le 23/05/2018 � partir de glew-2.1.0.h
'***************************************************************************************
#If VBA7 Then
DefLngPtr A-Z
#Else
DefLng A-Z
#End If
#If Win64 Then
Const vbLongPtr As Long = vbLongLong
#Else
Const vbLongPtr As Long = vbLong
#End If
'***************************************************************************************
'*                                    Constantes                                       *
'***************************************************************************************
'------------------------------- GL_VERSION_1_4 -------------------------------
Public Const GL_BLEND_DST_RGB                   = &H80C8&
Public Const GL_BLEND_SRC_RGB                   = &H80C9&
Public Const GL_BLEND_DST_ALPHA                 = &H80CA&
Public Const GL_BLEND_SRC_ALPHA                 = &H80CB&
Public Const GL_POINT_SIZE_MIN                  = &H8126&
Public Const GL_POINT_SIZE_MAX                  = &H8127&
Public Const GL_POINT_FADE_THRESHOLD_SIZE       = &H8128&
Public Const GL_POINT_DISTANCE_ATTENUATION      = &H8129&
Public Const GL_GENERATE_MIPMAP                 = &H8191&
Public Const GL_GENERATE_MIPMAP_HINT            = &H8192&
Public Const GL_DEPTH_COMPONENT16               = &H81A5&
Public Const GL_DEPTH_COMPONENT24               = &H81A6&
Public Const GL_DEPTH_COMPONENT32               = &H81A7&
Public Const GL_MIRRORED_REPEAT                 = &H8370&
Public Const GL_FOG_COORDINATE_SOURCE           = &H8450&
Public Const GL_FOG_COORDINATE                  = &H8451&
Public Const GL_FRAGMENT_DEPTH                  = &H8452&
Public Const GL_CURRENT_FOG_COORDINATE          = &H8453&
Public Const GL_FOG_COORDINATE_ARRAY_TYPE       = &H8454&
Public Const GL_FOG_COORDINATE_ARRAY_STRIDE     = &H8455&
Public Const GL_FOG_COORDINATE_ARRAY_POINTER    = &H8456&
Public Const GL_FOG_COORDINATE_ARRAY            = &H8457&
Public Const GL_COLOR_SUM                       = &H8458&
Public Const GL_CURRENT_SECONDARY_COLOR         = &H8459&
Public Const GL_SECONDARY_COLOR_ARRAY_SIZE      = &H845A&
Public Const GL_SECONDARY_COLOR_ARRAY_TYPE      = &H845B&
Public Const GL_SECONDARY_COLOR_ARRAY_STRIDE    = &H845C&
Public Const GL_SECONDARY_COLOR_ARRAY_POINTER   = &H845D&
Public Const GL_SECONDARY_COLOR_ARRAY           = &H845E&
Public Const GL_MAX_TEXTURE_LOD_BIAS            = &H84FD&
Public Const GL_TEXTURE_FILTER_CONTROL          = &H8500&
Public Const GL_TEXTURE_LOD_BIAS                = &H8501&
Public Const GL_INCR_WRAP                       = &H8507&
Public Const GL_DECR_WRAP                       = &H8508&
Public Const GL_TEXTURE_DEPTH_SIZE              = &H884A&
Public Const GL_DEPTH_TEXTURE_MODE              = &H884B&
Public Const GL_TEXTURE_COMPARE_MODE            = &H884C&
Public Const GL_TEXTURE_COMPARE_FUNC            = &H884D&
Public Const GL_COMPARE_R_TO_TEXTURE            = &H884E&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glBlendColorPtr, glBlendEquationPtr, glBlendFuncSeparatePtr, glFogCoordPointerPtr, glFogCoorddPtr, glFogCoorddvPtr, glFogCoordfPtr, glFogCoordfvPtr, glMultiDrawArraysPtr, _
glMultiDrawElementsPtr, glPointParameterfPtr, glPointParameterfvPtr, glPointParameteriPtr, glPointParameterivPtr, glSecondaryColor3bPtr, glSecondaryColor3bvPtr, glSecondaryColor3dPtr, glSecondaryColor3dvPtr, glSecondaryColor3fPtr, _
glSecondaryColor3fvPtr, glSecondaryColor3iPtr, glSecondaryColor3ivPtr, glSecondaryColor3sPtr, glSecondaryColor3svPtr, glSecondaryColor3ubPtr, glSecondaryColor3ubvPtr, glSecondaryColor3uiPtr, glSecondaryColor3uivPtr, glSecondaryColor3usPtr, _
glSecondaryColor3usvPtr, glSecondaryColorPointerPtr, glWindowPos2dPtr, glWindowPos2dvPtr, glWindowPos2fPtr, glWindowPos2fvPtr, glWindowPos2iPtr, glWindowPos2ivPtr, glWindowPos2sPtr, glWindowPos2svPtr, _
glWindowPos3dPtr, glWindowPos3dvPtr, glWindowPos3fPtr, glWindowPos3fvPtr, glWindowPos3iPtr, glWindowPos3ivPtr, glWindowPos3sPtr, glWindowPos3svPtr
'------------------------------- GL_VERSION_1_4 -------------------------------
Public Sub glBlendColor(ByVal red As Single, ByVal green As Single, ByVal blue As Single, ByVal alpha As Single)                            : Call OpenGLExtCall4(glBlendColorPtr, vbEmpty, red, green, blue, alpha): End Sub
Public Sub glBlendEquation(ByVal mode As Long)                                                                                              : Call OpenGLExtCall1(glBlendEquationPtr, vbEmpty, mode): End Sub
Public Sub glBlendFuncSeparate(ByVal sfactorRGB As Long, ByVal dfactorRGB As Long, ByVal sfactorAlpha As Long, ByVal dfactorAlpha As Long)  : Call OpenGLExtCall4(glBlendFuncSeparatePtr, vbEmpty, sfactorRGB, dfactorRGB, sfactorAlpha, dfactorAlpha): End Sub
Public Sub glFogCoordPointer(ByVal ptype As Long, ByVal stride As Long, ByVal pointer)                                                      : Call OpenGLExtCall3(glFogCoordPointerPtr, vbEmpty, ptype, stride, pointer): End Sub
Public Sub glFogCoordd(ByVal coord As Double)                                                                                               : Call OpenGLExtCall1(glFogCoorddPtr, vbEmpty, coord): End Sub
Public Sub glFogCoorddv(coord As Double)                                                                                                    : Call OpenGLExtCall1(glFogCoorddvPtr, vbEmpty, VarPtr(coord)): End Sub
Public Sub glFogCoordf(ByVal coord As Single)                                                                                               : Call OpenGLExtCall1(glFogCoordfPtr, vbEmpty, coord): End Sub
Public Sub glFogCoordfv(coord As Single)                                                                                                    : Call OpenGLExtCall1(glFogCoordfvPtr, vbEmpty, VarPtr(coord)): End Sub
Public Sub glMultiDrawArrays(ByVal mode As Long, first As Long, count As Long, ByVal drawCount As Long)                                     : Call OpenGLExtCall4(glMultiDrawArraysPtr, vbEmpty, mode, VarPtr(first), VarPtr(count), drawCount): End Sub
Public Sub glMultiDrawElements(ByVal mode As Long, count As Long, ByVal ptype As Long, ByVal indices, ByVal drawCount As Long)              : Call OpenGLExtCall5(glMultiDrawElementsPtr, vbEmpty, mode, VarPtr(count), ptype, indices, drawCount): End Sub
Public Sub glPointParameterf(ByVal pname As Long, ByVal param As Single)                                                                    : Call OpenGLExtCall2(glPointParameterfPtr, vbEmpty, pname, param): End Sub
Public Sub glPointParameterfv(ByVal pname As Long, params As Single)                                                                        : Call OpenGLExtCall2(glPointParameterfvPtr, vbEmpty, pname, VarPtr(params)): End Sub
Public Sub glPointParameteri(ByVal pname As Long, ByVal param As Long)                                                                      : Call OpenGLExtCall2(glPointParameteriPtr, vbEmpty, pname, param): End Sub
Public Sub glPointParameteriv(ByVal pname As Long, params As Long)                                                                          : Call OpenGLExtCall2(glPointParameterivPtr, vbEmpty, pname, VarPtr(params)): End Sub
Public Sub glSecondaryColor3b(ByVal red As Byte, ByVal green As Byte, ByVal blue As Byte)                                                   : Call OpenGLExtCall3(glSecondaryColor3bPtr, vbEmpty, red, green, blue): End Sub
Public Sub glSecondaryColor3bv(v As Byte)                                                                                                   : Call OpenGLExtCall1(glSecondaryColor3bvPtr, vbEmpty, VarPtr(v)): End Sub
Public Sub glSecondaryColor3d(ByVal red As Double, ByVal green As Double, ByVal blue As Double)                                             : Call OpenGLExtCall3(glSecondaryColor3dPtr, vbEmpty, red, green, blue): End Sub
Public Sub glSecondaryColor3dv(v As Double)                                                                                                 : Call OpenGLExtCall1(glSecondaryColor3dvPtr, vbEmpty, VarPtr(v)): End Sub
Public Sub glSecondaryColor3f(ByVal red As Single, ByVal green As Single, ByVal blue As Single)                                             : Call OpenGLExtCall3(glSecondaryColor3fPtr, vbEmpty, red, green, blue): End Sub
Public Sub glSecondaryColor3fv(v As Single)                                                                                                 : Call OpenGLExtCall1(glSecondaryColor3fvPtr, vbEmpty, VarPtr(v)): End Sub
Public Sub glSecondaryColor3i(ByVal red As Long, ByVal green As Long, ByVal blue As Long)                                                   : Call OpenGLExtCall3(glSecondaryColor3iPtr, vbEmpty, red, green, blue): End Sub
Public Sub glSecondaryColor3iv(v As Long)                                                                                                   : Call OpenGLExtCall1(glSecondaryColor3ivPtr, vbEmpty, VarPtr(v)): End Sub
Public Sub glSecondaryColor3s(ByVal red As Integer, ByVal green As Integer, ByVal blue As Integer)                                          : Call OpenGLExtCall3(glSecondaryColor3sPtr, vbEmpty, red, green, blue): End Sub
Public Sub glSecondaryColor3sv(v As Integer)                                                                                                : Call OpenGLExtCall1(glSecondaryColor3svPtr, vbEmpty, VarPtr(v)): End Sub
Public Sub glSecondaryColor3ub(ByVal red As Byte, ByVal green As Byte, ByVal blue As Byte)                                                  : Call OpenGLExtCall3(glSecondaryColor3ubPtr, vbEmpty, red, green, blue): End Sub
Public Sub glSecondaryColor3ubv(v As Byte)                                                                                                  : Call OpenGLExtCall1(glSecondaryColor3ubvPtr, vbEmpty, VarPtr(v)): End Sub
Public Sub glSecondaryColor3ui(ByVal red As Long, ByVal green As Long, ByVal blue As Long)                                                  : Call OpenGLExtCall3(glSecondaryColor3uiPtr, vbEmpty, red, green, blue): End Sub
Public Sub glSecondaryColor3uiv(v As Long)                                                                                                  : Call OpenGLExtCall1(glSecondaryColor3uivPtr, vbEmpty, VarPtr(v)): End Sub
Public Sub glSecondaryColor3us(ByVal red As Long, ByVal green As Long, ByVal blue As Long)                                                  : Call OpenGLExtCall3(glSecondaryColor3usPtr, vbEmpty, red, green, blue): End Sub
Public Sub glSecondaryColor3usv(v As Long)                                                                                                  : Call OpenGLExtCall1(glSecondaryColor3usvPtr, vbEmpty, VarPtr(v)): End Sub
Public Sub glSecondaryColorPointer(ByVal size As Long, ByVal ptype As Long, ByVal stride As Long, ByVal pointer)                            : Call OpenGLExtCall4(glSecondaryColorPointerPtr, vbEmpty, size, ptype, stride, pointer): End Sub
Public Sub glWindowPos2d(ByVal X As Double, ByVal y As Double)                                                                              : Call OpenGLExtCall2(glWindowPos2dPtr, vbEmpty, X, y): End Sub
Public Sub glWindowPos2dv(p As Double)                                                                                                      : Call OpenGLExtCall1(glWindowPos2dvPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos2f(ByVal X As Single, ByVal y As Single)                                                                              : Call OpenGLExtCall2(glWindowPos2fPtr, vbEmpty, X, y): End Sub
Public Sub glWindowPos2fv(p As Single)                                                                                                      : Call OpenGLExtCall1(glWindowPos2fvPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos2i(ByVal X As Long, ByVal y As Long)                                                                                  : Call OpenGLExtCall2(glWindowPos2iPtr, vbEmpty, X, y): End Sub
Public Sub glWindowPos2iv(p As Long)                                                                                                        : Call OpenGLExtCall1(glWindowPos2ivPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos2s(ByVal X As Integer, ByVal y As Integer)                                                                            : Call OpenGLExtCall2(glWindowPos2sPtr, vbEmpty, X, y): End Sub
Public Sub glWindowPos2sv(p As Integer)                                                                                                     : Call OpenGLExtCall1(glWindowPos2svPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos3d(ByVal X As Double, ByVal y As Double, ByVal z As Double)                                                           : Call OpenGLExtCall3(glWindowPos3dPtr, vbEmpty, X, y, z): End Sub
Public Sub glWindowPos3dv(p As Double)                                                                                                      : Call OpenGLExtCall1(glWindowPos3dvPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos3f(ByVal X As Single, ByVal y As Single, ByVal z As Single)                                                           : Call OpenGLExtCall3(glWindowPos3fPtr, vbEmpty, X, y, z): End Sub
Public Sub glWindowPos3fv(p As Single)                                                                                                      : Call OpenGLExtCall1(glWindowPos3fvPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos3i(ByVal X As Long, ByVal y As Long, ByVal z As Long)                                                                 : Call OpenGLExtCall3(glWindowPos3iPtr, vbEmpty, X, y, z): End Sub
Public Sub glWindowPos3iv(p As Long)                                                                                                        : Call OpenGLExtCall1(glWindowPos3ivPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos3s(ByVal X As Integer, ByVal y As Integer, ByVal z As Integer)                                                        : Call OpenGLExtCall3(glWindowPos3sPtr, vbEmpty, X, y, z): End Sub
Public Sub glWindowPos3sv(p As Integer)                                                                                                     : Call OpenGLExtCall1(glWindowPos3svPtr, vbEmpty, VarPtr(p)): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL1_4()
If IsDEPEnabled Then
    glWindowPos3svPtr = OpenGLExtProcAddress("glWindowPos3sv")
    glWindowPos3sPtr = OpenGLExtProcAddress("glWindowPos3s")
    glWindowPos3ivPtr = OpenGLExtProcAddress("glWindowPos3iv")
    glWindowPos3iPtr = OpenGLExtProcAddress("glWindowPos3i")
    glWindowPos3fvPtr = OpenGLExtProcAddress("glWindowPos3fv")
    glWindowPos3fPtr = OpenGLExtProcAddress("glWindowPos3f")
    glWindowPos3dvPtr = OpenGLExtProcAddress("glWindowPos3dv")
    glWindowPos3dPtr = OpenGLExtProcAddress("glWindowPos3d")
    glWindowPos2svPtr = OpenGLExtProcAddress("glWindowPos2sv")
    glWindowPos2sPtr = OpenGLExtProcAddress("glWindowPos2s")
    glWindowPos2ivPtr = OpenGLExtProcAddress("glWindowPos2iv")
    glWindowPos2iPtr = OpenGLExtProcAddress("glWindowPos2i")
    glWindowPos2fvPtr = OpenGLExtProcAddress("glWindowPos2fv")
    glWindowPos2fPtr = OpenGLExtProcAddress("glWindowPos2f")
    glWindowPos2dvPtr = OpenGLExtProcAddress("glWindowPos2dv")
    glWindowPos2dPtr = OpenGLExtProcAddress("glWindowPos2d")
    glSecondaryColorPointerPtr = OpenGLExtProcAddress("glSecondaryColorPointer")
    glSecondaryColor3usvPtr = OpenGLExtProcAddress("glSecondaryColor3usv")
    glSecondaryColor3usPtr = OpenGLExtProcAddress("glSecondaryColor3us")
    glSecondaryColor3uivPtr = OpenGLExtProcAddress("glSecondaryColor3uiv")
    glSecondaryColor3uiPtr = OpenGLExtProcAddress("glSecondaryColor3ui")
    glSecondaryColor3ubvPtr = OpenGLExtProcAddress("glSecondaryColor3ubv")
    glSecondaryColor3ubPtr = OpenGLExtProcAddress("glSecondaryColor3ub")
    glSecondaryColor3svPtr = OpenGLExtProcAddress("glSecondaryColor3sv")
    glSecondaryColor3sPtr = OpenGLExtProcAddress("glSecondaryColor3s")
    glSecondaryColor3ivPtr = OpenGLExtProcAddress("glSecondaryColor3iv")
    glSecondaryColor3iPtr = OpenGLExtProcAddress("glSecondaryColor3i")
    glSecondaryColor3fvPtr = OpenGLExtProcAddress("glSecondaryColor3fv")
    glSecondaryColor3fPtr = OpenGLExtProcAddress("glSecondaryColor3f")
    glSecondaryColor3dvPtr = OpenGLExtProcAddress("glSecondaryColor3dv")
    glSecondaryColor3dPtr = OpenGLExtProcAddress("glSecondaryColor3d")
    glSecondaryColor3bvPtr = OpenGLExtProcAddress("glSecondaryColor3bv")
    glSecondaryColor3bPtr = OpenGLExtProcAddress("glSecondaryColor3b")
    glPointParameterivPtr = OpenGLExtProcAddress("glPointParameteriv")
    glPointParameteriPtr = OpenGLExtProcAddress("glPointParameteri")
    glPointParameterfvPtr = OpenGLExtProcAddress("glPointParameterfv")
    glPointParameterfPtr = OpenGLExtProcAddress("glPointParameterf")
    glMultiDrawElementsPtr = OpenGLExtProcAddress("glMultiDrawElements")
    glMultiDrawArraysPtr = OpenGLExtProcAddress("glMultiDrawArrays")
    glFogCoordfvPtr = OpenGLExtProcAddress("glFogCoordfv")
    glFogCoordfPtr = OpenGLExtProcAddress("glFogCoordf")
    glFogCoorddvPtr = OpenGLExtProcAddress("glFogCoorddv")
    glFogCoorddPtr = OpenGLExtProcAddress("glFogCoordd")
    glFogCoordPointerPtr = OpenGLExtProcAddress("glFogCoordPointer")
    glBlendFuncSeparatePtr = OpenGLExtProcAddress("glBlendFuncSeparate")
    glBlendEquationPtr = OpenGLExtProcAddress("glBlendEquation")
    glBlendColorPtr = OpenGLExtProcAddress("glBlendColor")
Else
    RemapVBFunctionToGLFunction AddressOf glWindowPos3sv, "glWindowPos3sv"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3s, "glWindowPos3s"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3iv, "glWindowPos3iv"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3i, "glWindowPos3i"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3fv, "glWindowPos3fv"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3f, "glWindowPos3f"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3dv, "glWindowPos3dv"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3d, "glWindowPos3d"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2sv, "glWindowPos2sv"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2s, "glWindowPos2s"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2iv, "glWindowPos2iv"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2i, "glWindowPos2i"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2fv, "glWindowPos2fv"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2f, "glWindowPos2f"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2dv, "glWindowPos2dv"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2d, "glWindowPos2d"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColorPointer, "glSecondaryColorPointer"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3usv, "glSecondaryColor3usv"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3us, "glSecondaryColor3us"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3uiv, "glSecondaryColor3uiv"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3ui, "glSecondaryColor3ui"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3ubv, "glSecondaryColor3ubv"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3ub, "glSecondaryColor3ub"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3sv, "glSecondaryColor3sv"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3s, "glSecondaryColor3s"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3iv, "glSecondaryColor3iv"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3i, "glSecondaryColor3i"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3fv, "glSecondaryColor3fv"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3f, "glSecondaryColor3f"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3dv, "glSecondaryColor3dv"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3d, "glSecondaryColor3d"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3bv, "glSecondaryColor3bv"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColor3b, "glSecondaryColor3b"
    RemapVBFunctionToGLFunction AddressOf glPointParameteriv, "glPointParameteriv"
    RemapVBFunctionToGLFunction AddressOf glPointParameteri, "glPointParameteri"
    RemapVBFunctionToGLFunction AddressOf glPointParameterfv, "glPointParameterfv"
    RemapVBFunctionToGLFunction AddressOf glPointParameterf, "glPointParameterf"
    RemapVBFunctionToGLFunction AddressOf glMultiDrawElements, "glMultiDrawElements"
    RemapVBFunctionToGLFunction AddressOf glMultiDrawArrays, "glMultiDrawArrays"
    RemapVBFunctionToGLFunction AddressOf glFogCoordfv, "glFogCoordfv"
    RemapVBFunctionToGLFunction AddressOf glFogCoordf, "glFogCoordf"
    RemapVBFunctionToGLFunction AddressOf glFogCoorddv, "glFogCoorddv"
    RemapVBFunctionToGLFunction AddressOf glFogCoordd, "glFogCoordd"
    RemapVBFunctionToGLFunction AddressOf glFogCoordPointer, "glFogCoordPointer"
    RemapVBFunctionToGLFunction AddressOf glBlendFuncSeparate, "glBlendFuncSeparate"
    RemapVBFunctionToGLFunction AddressOf glBlendEquation, "glBlendEquation"
    RemapVBFunctionToGLFunction AddressOf glBlendColor, "glBlendColor"
End If
End Function
