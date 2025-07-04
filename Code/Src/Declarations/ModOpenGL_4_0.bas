Attribute VB_Name = "ModOpenGL_4_0"
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
'------------------------------- GL_VERSION_4_0 -------------------------------
Public Const GL_SAMPLE_SHADING                         = &H8C36&
Public Const GL_MIN_SAMPLE_SHADING_VALUE               = &H8C37&
Public Const GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET      = &H8E5E&
Public Const GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET      = &H8E5F&
Public Const GL_MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS  = &H8F9F&
Public Const GL_TEXTURE_CUBE_MAP_ARRAY                 = &H9009&
Public Const GL_TEXTURE_BINDING_CUBE_MAP_ARRAY         = &H900A&
Public Const GL_PROXY_TEXTURE_CUBE_MAP_ARRAY           = &H900B&
Public Const GL_SAMPLER_CUBE_MAP_ARRAY                 = &H900C&
Public Const GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW          = &H900D&
Public Const GL_INT_SAMPLER_CUBE_MAP_ARRAY             = &H900E&
Public Const GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY    = &H900F&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glBlendEquationSeparateiPtr, glBlendEquationiPtr, glBlendFuncSeparateiPtr, glBlendFunciPtr, glMinSampleShadingPtr
'------------------------------- GL_VERSION_4_0 -------------------------------
Public Sub glBlendEquationSeparatei(ByVal buf As Long, ByVal modeRGB As Long, ByVal modeAlpha As Long)                                          : Call OpenGLExtCall3(glBlendEquationSeparateiPtr, vbEmpty, buf, modeRGB, modeAlpha): End Sub
Public Sub glBlendEquationi(ByVal buf As Long, ByVal mode As Long)                                                                              : Call OpenGLExtCall2(glBlendEquationiPtr, vbEmpty, buf, mode): End Sub
Public Sub glBlendFuncSeparatei(ByVal buf As Long, ByVal srcRGB As Long, ByVal dstRGB As Long, ByVal srcAlpha As Long, ByVal dstAlpha As Long)  : Call OpenGLExtCall5(glBlendFuncSeparateiPtr, vbEmpty, buf, srcRGB, dstRGB, srcAlpha, dstAlpha): End Sub
Public Sub glBlendFunci(ByVal buf As Long, ByVal src As Long, ByVal dst As Long)                                                                : Call OpenGLExtCall3(glBlendFunciPtr, vbEmpty, buf, src, dst): End Sub
Public Sub glMinSampleShading(ByVal value As Single)                                                                                            : Call OpenGLExtCall1(glMinSampleShadingPtr, vbEmpty, value): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL4_0()
If IsDEPEnabled Then
    glMinSampleShadingPtr = OpenGLExtProcAddress("glMinSampleShading")
    glBlendFunciPtr = OpenGLExtProcAddress("glBlendFunci")
    glBlendFuncSeparateiPtr = OpenGLExtProcAddress("glBlendFuncSeparatei")
    glBlendEquationiPtr = OpenGLExtProcAddress("glBlendEquationi")
    glBlendEquationSeparateiPtr = OpenGLExtProcAddress("glBlendEquationSeparatei")
Else
    RemapVBFunctionToGLFunction AddressOf glMinSampleShading, "glMinSampleShading"
    RemapVBFunctionToGLFunction AddressOf glBlendFunci, "glBlendFunci"
    RemapVBFunctionToGLFunction AddressOf glBlendFuncSeparatei, "glBlendFuncSeparatei"
    RemapVBFunctionToGLFunction AddressOf glBlendEquationi, "glBlendEquationi"
    RemapVBFunctionToGLFunction AddressOf glBlendEquationSeparatei, "glBlendEquationSeparatei"
End If
End Function
