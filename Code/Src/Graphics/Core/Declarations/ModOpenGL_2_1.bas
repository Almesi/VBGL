Attribute VB_Name = "ModOpenGL_2_1"
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
'------------------------------- GL_VERSION_2_1 -------------------------------
Public Const GL_CURRENT_RASTER_SECONDARY_COLOR  = &H845F&
Public Const GL_PIXEL_PACK_BUFFER               = &H88EB&
Public Const GL_PIXEL_UNPACK_BUFFER             = &H88EC&
Public Const GL_PIXEL_PACK_BUFFER_BINDING       = &H88ED&
Public Const GL_PIXEL_UNPACK_BUFFER_BINDING     = &H88EF&
Public Const GL_FLOAT_MAT2x3                    = &H8B65&
Public Const GL_FLOAT_MAT2x4                    = &H8B66&
Public Const GL_FLOAT_MAT3x2                    = &H8B67&
Public Const GL_FLOAT_MAT3x4                    = &H8B68&
Public Const GL_FLOAT_MAT4x2                    = &H8B69&
Public Const GL_FLOAT_MAT4x3                    = &H8B6A&
Public Const GL_SRGB                            = &H8C40&
Public Const GL_SRGB8                           = &H8C41&
Public Const GL_SRGB_ALPHA                      = &H8C42&
Public Const GL_SRGB8_ALPHA8                    = &H8C43&
Public Const GL_SLUMINANCE_ALPHA                = &H8C44&
Public Const GL_SLUMINANCE8_ALPHA8              = &H8C45&
Public Const GL_SLUMINANCE                      = &H8C46&
Public Const GL_SLUMINANCE8                     = &H8C47&
Public Const GL_COMPRESSED_SRGB                 = &H8C48&
Public Const GL_COMPRESSED_SRGB_ALPHA           = &H8C49&
Public Const GL_COMPRESSED_SLUMINANCE           = &H8C4A&
Public Const GL_COMPRESSED_SLUMINANCE_ALPHA     = &H8C4B&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glUniformMatrix2x3fvPtr, glUniformMatrix2x4fvPtr, glUniformMatrix3x2fvPtr, glUniformMatrix3x4fvPtr, glUniformMatrix4x2fvPtr, glUniformMatrix4x3fvPtr
'------------------------------- GL_VERSION_2_1 -------------------------------
Public Sub glUniformMatrix2x3fv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall4(glUniformMatrix2x3fvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix2x4fv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall4(glUniformMatrix2x4fvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix3x2fv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall4(glUniformMatrix3x2fvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix3x4fv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall4(glUniformMatrix3x4fvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix4x2fv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall4(glUniformMatrix4x2fvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix4x3fv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall4(glUniformMatrix4x3fvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL2_1()
    If IsDEPEnabled Then
        glUniformMatrix4x3fvPtr = OpenGLExtProcAddress("glUniformMatrix4x3fv")
        glUniformMatrix4x2fvPtr = OpenGLExtProcAddress("glUniformMatrix4x2fv")
        glUniformMatrix3x4fvPtr = OpenGLExtProcAddress("glUniformMatrix3x4fv")
        glUniformMatrix3x2fvPtr = OpenGLExtProcAddress("glUniformMatrix3x2fv")
        glUniformMatrix2x4fvPtr = OpenGLExtProcAddress("glUniformMatrix2x4fv")
        glUniformMatrix2x3fvPtr = OpenGLExtProcAddress("glUniformMatrix2x3fv")
    Else
        RemapVBFunctionToGLFunction AddressOf glUniformMatrix4x3fv, "glUniformMatrix4x3fv"
        RemapVBFunctionToGLFunction AddressOf glUniformMatrix4x2fv, "glUniformMatrix4x2fv"
        RemapVBFunctionToGLFunction AddressOf glUniformMatrix3x4fv, "glUniformMatrix3x4fv"
        RemapVBFunctionToGLFunction AddressOf glUniformMatrix3x2fv, "glUniformMatrix3x2fv"
        RemapVBFunctionToGLFunction AddressOf glUniformMatrix2x4fv, "glUniformMatrix2x4fv"
        RemapVBFunctionToGLFunction AddressOf glUniformMatrix2x3fv, "glUniformMatrix2x3fv"
    End If
End Function