Attribute VB_Name = "ModOpenGL_3_2"
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
'------------------------------- GL_VERSION_3_2 -------------------------------
Public Const GL_CONTEXT_CORE_PROFILE_BIT               = &H1&
Public Const GL_CONTEXT_COMPATIBILITY_PROFILE_BIT      = &H2&
Public Const GL_LINES_ADJACENCY                        = &HA&
Public Const GL_LINE_STRIP_ADJACENCY                   = &HB&
Public Const GL_TRIANGLES_ADJACENCY                    = &HC&
Public Const GL_TRIANGLE_STRIP_ADJACENCY               = &HD&
Public Const GL_PROGRAM_POINT_SIZE                     = &H8642&
Public Const GL_GEOMETRY_VERTICES_OUT                  = &H8916&
Public Const GL_GEOMETRY_INPUT_TYPE                    = &H8917&
Public Const GL_GEOMETRY_OUTPUT_TYPE                   = &H8918&
Public Const GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS       = &H8C29&
Public Const GL_FRAMEBUFFER_ATTACHMENT_LAYERED         = &H8DA7&
Public Const GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS   = &H8DA8&
Public Const GL_GEOMETRY_SHADER                        = &H8DD9&
Public Const GL_MAX_GEOMETRY_UNIFORM_COMPONENTS        = &H8DDF&
Public Const GL_MAX_GEOMETRY_OUTPUT_VERTICES           = &H8DE0&
Public Const GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS   = &H8DE1&
Public Const GL_MAX_VERTEX_OUTPUT_COMPONENTS           = &H9122&
Public Const GL_MAX_GEOMETRY_INPUT_COMPONENTS          = &H9123&
Public Const GL_MAX_GEOMETRY_OUTPUT_COMPONENTS         = &H9124&
Public Const GL_MAX_FRAGMENT_INPUT_COMPONENTS          = &H9125&
Public Const GL_CONTEXT_PROFILE_MASK                   = &H9126&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glFramebufferTexturePtr, glGetBufferParameteri64vPtr, glGetInteger64i_vPtr
'------------------------------- GL_VERSION_3_2 -------------------------------
Public Sub glFramebufferTexture(ByVal target As Long, ByVal pattachment As Long, ByVal texture As Long, ByVal level As Long) : Call OpenGLExtCall4(glFramebufferTexturePtr, vbEmpty, target, pattachment, texture, level): End Sub
Public Sub glGetBufferParameteri64v(ByVal target As Long, ByVal value As Long, data As Currency)                             : Call OpenGLExtCall3(glGetBufferParameteri64vPtr, vbEmpty, target, value, VarPtr(data)): End Sub
Public Sub glGetInteger64i_v(ByVal pname As Long, ByVal index As Long, data As Currency)                                     : Call OpenGLExtCall3(glGetInteger64i_vPtr, vbEmpty, pname, index, VarPtr(data)): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL3_2()
If IsDEPEnabled Then
    glGetInteger64i_vPtr = OpenGLExtProcAddress("glGetInteger64i_v")
    glGetBufferParameteri64vPtr = OpenGLExtProcAddress("glGetBufferParameteri64v")
    glFramebufferTexturePtr = OpenGLExtProcAddress("glFramebufferTexture")
Else
    RemapVBFunctionToGLFunction AddressOf glGetInteger64i_v, "glGetInteger64i_v"
    RemapVBFunctionToGLFunction AddressOf glGetBufferParameteri64v, "glGetBufferParameteri64v"
    RemapVBFunctionToGLFunction AddressOf glFramebufferTexture, "glFramebufferTexture"
End If
End Function
