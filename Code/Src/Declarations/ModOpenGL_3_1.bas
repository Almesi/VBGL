Attribute VB_Name = "ModOpenGL_3_1"
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
'------------------------------- GL_VERSION_3_1 -------------------------------
Public Const GL_TEXTURE_RECTANGLE                 = &H84F5&
Public Const GL_TEXTURE_BINDING_RECTANGLE         = &H84F6&
Public Const GL_PROXY_TEXTURE_RECTANGLE           = &H84F7&
Public Const GL_MAX_RECTANGLE_TEXTURE_SIZE        = &H84F8&
Public Const GL_SAMPLER_2D_RECT                   = &H8B63&
Public Const GL_SAMPLER_2D_RECT_SHADOW            = &H8B64&
Public Const GL_TEXTURE_BUFFER                    = &H8C2A&
Public Const GL_MAX_TEXTURE_BUFFER_SIZE           = &H8C2B&
Public Const GL_TEXTURE_BINDING_BUFFER            = &H8C2C&
Public Const GL_TEXTURE_BUFFER_DATA_STORE_BINDING = &H8C2D&
Public Const GL_TEXTURE_BUFFER_FORMAT             = &H8C2E&
Public Const GL_SAMPLER_BUFFER                    = &H8DC2&
Public Const GL_INT_SAMPLER_2D_RECT               = &H8DCD&
Public Const GL_INT_SAMPLER_BUFFER                = &H8DD0&
Public Const GL_UNSIGNED_INT_SAMPLER_2D_RECT      = &H8DD5&
Public Const GL_UNSIGNED_INT_SAMPLER_BUFFER       = &H8DD8&
Public Const GL_RED_SNORM                         = &H8F90&
Public Const GL_RG_SNORM                          = &H8F91&
Public Const GL_RGB_SNORM                         = &H8F92&
Public Const GL_RGBA_SNORM                        = &H8F93&
Public Const GL_R8_SNORM                          = &H8F94&
Public Const GL_RG8_SNORM                         = &H8F95&
Public Const GL_RGB8_SNORM                        = &H8F96&
Public Const GL_RGBA8_SNORM                       = &H8F97&
Public Const GL_R16_SNORM                         = &H8F98&
Public Const GL_RG16_SNORM                        = &H8F99&
Public Const GL_RGB16_SNORM                       = &H8F9A&
Public Const GL_RGBA16_SNORM                      = &H8F9B&
Public Const GL_SIGNED_NORMALIZED                 = &H8F9C&
Public Const GL_PRIMITIVE_RESTART                 = &H8F9D&
Public Const GL_PRIMITIVE_RESTART_INDEX           = &H8F9E&
Public Const GL_BUFFER_ACCESS_FLAGS               = &H911F&
Public Const GL_BUFFER_MAP_LENGTH                 = &H9120&
Public Const GL_BUFFER_MAP_OFFSET                 = &H9121&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glDrawArraysInstancedPtr, glDrawElementsInstancedPtr, glPrimitiveRestartIndexPtr, glTexBufferPtr
'------------------------------- GL_VERSION_3_1 -------------------------------
Public Sub glDrawArraysInstanced(ByVal mode As Long, ByVal first As Long, ByVal count As Long, ByVal primcount As Long)                  : Call OpenGLExtCall4(glDrawArraysInstancedPtr, vbEmpty, mode, first, count, primcount): End Sub
Public Sub glDrawElementsInstanced(ByVal mode As Long, ByVal count As Long, ByVal ptype As Long, ByVal indices, ByVal primcount As Long) : Call OpenGLExtCall5(glDrawElementsInstancedPtr, vbEmpty, mode, count, ptype, indices, primcount): End Sub
Public Sub glPrimitiveRestartIndex(ByVal buffer As Long)                                                                                 : Call OpenGLExtCall1(glPrimitiveRestartIndexPtr, vbEmpty, buffer): End Sub
Public Sub glTexBuffer(ByVal target As Long, ByVal internalformat As Long, ByVal buffer As Long)                                         : Call OpenGLExtCall3(glTexBufferPtr, vbEmpty, target, internalformat, buffer): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL3_1()
If IsDEPEnabled Then
    glTexBufferPtr = OpenGLExtProcAddress("glTexBuffer")
    glPrimitiveRestartIndexPtr = OpenGLExtProcAddress("glPrimitiveRestartIndex")
    glDrawElementsInstancedPtr = OpenGLExtProcAddress("glDrawElementsInstanced")
    glDrawArraysInstancedPtr = OpenGLExtProcAddress("glDrawArraysInstanced")
Else
    RemapVBFunctionToGLFunction AddressOf glTexBuffer, "glTexBuffer"
    RemapVBFunctionToGLFunction AddressOf glPrimitiveRestartIndex, "glPrimitiveRestartIndex"
    RemapVBFunctionToGLFunction AddressOf glDrawElementsInstanced, "glDrawElementsInstanced"
    RemapVBFunctionToGLFunction AddressOf glDrawArraysInstanced, "glDrawArraysInstanced"
End If
End Function
