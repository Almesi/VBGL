Attribute VB_Name = "ModOpenGL_3_3"
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
'------------------------------- GL_VERSION_3_3 -------------------------------
Public Const GL_VERTEX_ATTRIB_ARRAY_DIVISOR = &H88FE&
Public Const GL_RGB10_A2UI                  = &H906F&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glVertexAttribDivisorPtr
'------------------------------- GL_VERSION_3_3 -------------------------------
Public Sub glVertexAttribDivisor(ByVal index As Long, ByVal divisor As Long): Call OpenGLExtCall2(glVertexAttribDivisorPtr, vbEmpty, index, divisor): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL3_3()
If IsDEPEnabled Then
    glVertexAttribDivisorPtr = OpenGLExtProcAddress("glVertexAttribDivisor")
Else
    RemapVBFunctionToGLFunction AddressOf glVertexAttribDivisor, "glVertexAttribDivisor"
End If
End Function
