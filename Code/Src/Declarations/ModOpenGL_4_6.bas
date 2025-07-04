Attribute VB_Name = "ModOpenGL_4_6"
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
'------------------------------- GL_VERSION_4_6 -------------------------------
Public Const GL_CONTEXT_FLAG_NO_ERROR_BIT           = &H8&
Public Const GL_PARAMETER_BUFFER                    = &H80EE&
Public Const GL_PARAMETER_BUFFER_BINDING            = &H80EF&
Public Const GL_TRANSFORM_FEEDBACK_OVERFLOW         = &H82EC&
Public Const GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW  = &H82ED&
Public Const GL_VERTICES_SUBMITTED                  = &H82EE&
Public Const GL_PRIMITIVES_SUBMITTED                = &H82EF&
Public Const GL_VERTEX_SHADER_INVOCATIONS           = &H82F0&
Public Const GL_TESS_CONTROL_SHADER_PATCHES         = &H82F1&
Public Const GL_TESS_EVALUATION_SHADER_INVOCATIONS  = &H82F2&
Public Const GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED  = &H82F3&
Public Const GL_FRAGMENT_SHADER_INVOCATIONS         = &H82F4&
Public Const GL_COMPUTE_SHADER_INVOCATIONS          = &H82F5&
Public Const GL_CLIPPING_INPUT_PRIMITIVES           = &H82F6&
Public Const GL_CLIPPING_OUTPUT_PRIMITIVES          = &H82F7&
Public Const GL_TEXTURE_MAX_ANISOTROPY              = &H84FE&
Public Const GL_MAX_TEXTURE_MAX_ANISOTROPY          = &H84FF&
Public Const GL_POLYGON_OFFSET_CLAMP                = &H8E1B&
Public Const GL_SHADER_BINARY_FORMAT_SPIR_V         = &H9551&
Public Const GL_SPIR_V_BINARY                       = &H9552&
Public Const GL_SPIR_V_EXTENSIONS                   = &H9553&
Public Const GL_NUM_SPIR_V_EXTENSIONS               = &H9554&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glMultiDrawArraysIndirectCountPtr, glMultiDrawElementsIndirectCountPtr, glSpecializeShaderPtr
'------------------------------- GL_VERSION_4_6 -------------------------------
Public Sub glMultiDrawArraysIndirectCount(ByVal mode As Long, ByVal indirect, ByVal drawCount, ByVal maxDrawCount As Long, ByVal stride As Long)                        : Call OpenGLExtCall5(glMultiDrawArraysIndirectCountPtr, vbEmpty, mode, indirect, drawCount, maxDrawCount, stride): End Sub
Public Sub glMultiDrawElementsIndirectCount(ByVal mode As Long, ByVal ptype As Long, ByVal indirect, ByVal drawCount, ByVal maxDrawCount As Long, ByVal stride As Long) : Call OpenGLExtCall6(glMultiDrawElementsIndirectCountPtr, vbEmpty, mode, ptype, indirect, drawCount, maxDrawCount, stride): End Sub
Public Sub glSpecializeShader(ByVal shader As Long, ByVal pEntryPoint, ByVal numSpecializationConstants As Long, pConstantIndex As Long, pConstantValue As Long)        : Call OpenGLExtCall5(glSpecializeShaderPtr, vbEmpty, shader, pEntryPoint, numSpecializationConstants, VarPtr(pConstantIndex), VarPtr(pConstantValue)): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL4_6()
If IsDEPEnabled Then
    glSpecializeShaderPtr = OpenGLExtProcAddress("glSpecializeShader")
    glMultiDrawElementsIndirectCountPtr = OpenGLExtProcAddress("glMultiDrawElementsIndirectCount")
    glMultiDrawArraysIndirectCountPtr = OpenGLExtProcAddress("glMultiDrawArraysIndirectCount")
Else
    RemapVBFunctionToGLFunction AddressOf glSpecializeShader, "glSpecializeShader"
    RemapVBFunctionToGLFunction AddressOf glMultiDrawElementsIndirectCount, "glMultiDrawElementsIndirectCount"
    RemapVBFunctionToGLFunction AddressOf glMultiDrawArraysIndirectCount, "glMultiDrawArraysIndirectCount"
End If
End Function
