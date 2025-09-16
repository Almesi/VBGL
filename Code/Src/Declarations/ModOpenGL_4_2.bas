Attribute VB_Name = "ModOpenGL_4_2"
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
'------------------------------- GL_VERSION_4_2 -------------------------------
Public Const GL_TRANSFORM_FEEDBACK_PAUSED          = &H8E23&
Public Const GL_TRANSFORM_FEEDBACK_ACTIVE          = &H8E24&
Public Const GL_COMPRESSED_RGBA_BPTC_UNORM         = &H8E8C&
Public Const GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM   = &H8E8D&
Public Const GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT   = &H8E8E&
Public Const GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT = &H8E8F&
Public Const GL_COPY_READ_BUFFER_BINDING           = &H8F36&
Public Const GL_COPY_WRITE_BUFFER_BINDING          = &H8F37&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
'------------------------------- GL_VERSION_4_2 -------------------------------
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL4_2()
    If IsDEPEnabled Then
    
    Else
    
    End If
End Function
