Attribute VB_Name = "ModOpenGL_4_5"
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
'------------------------------- GL_VERSION_4_5 -------------------------------
Public Const GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT                   = &H4&
Public Const GL_CONTEXT_FLAG_DEBUG_BIT                           = &H2&
Public Const GL_DEBUG_OUTPUT_SYNCHRONOUS                         = &H8242&
Public Const GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH                 = &H8243&
Public Const GL_DEBUG_CALLBACK_FUNCTION                          = &H8244&
Public Const GL_DEBUG_CALLBACK_USER_PARAM                        = &H8245&
Public Const GL_DEBUG_SOURCE_API                                 = &H8246&
Public Const GL_DEBUG_SOURCE_WINDOW_SYSTEM                       = &H8247&
Public Const GL_DEBUG_SOURCE_SHADER_COMPILER                     = &H8248&
Public Const GL_DEBUG_SOURCE_THIRD_PARTY                         = &H8249&
Public Const GL_DEBUG_SOURCE_APPLICATION                         = &H824A&
Public Const GL_DEBUG_SOURCE_OTHER                               = &H824B&
Public Const GL_DEBUG_TYPE_ERROR                                 = &H824C&
Public Const GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR                   = &H824D&
Public Const GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR                    = &H824E&
Public Const GL_DEBUG_TYPE_PORTABILITY                           = &H824F&
Public Const GL_DEBUG_TYPE_PERFORMANCE                           = &H8250&
Public Const GL_DEBUG_TYPE_OTHER                                 = &H8251&
Public Const GL_MAX_DEBUG_MESSAGE_LENGTH                         = &H9143&
Public Const GL_MAX_DEBUG_LOGGED_MESSAGES                        = &H9144&
Public Const GL_DEBUG_LOGGED_MESSAGES                            = &H9145&
Public Const GL_DEBUG_SEVERITY_HIGH                              = &H9146&
Public Const GL_DEBUG_SEVERITY_MEDIUM                            = &H9147&
Public Const GL_DEBUG_SEVERITY_LOW                               = &H9148&


'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glGetGraphicsResetStatusPtr, glGetnCompressedTexImagePtr, glGetnTexImagePtr, glGetnUniformdvPtr, glDebugMessageControlPtr, glDebugMessageCallbackPtr, glGetDebugMessageLogPtr
'------------------------------- GL_VERSION_4_5 -------------------------------
Public Function glGetGraphicsResetStatus() As Long                                                                                                                                                                                            : glGetGraphicsResetStatus = OpenGLExtCall0(glGetGraphicsResetStatusPtr, vbLong): End Function
Public Sub      glGetnCompressedTexImage(ByVal target As Long, ByVal lod As Long, ByVal bufSize As Long, ByVal pixels)                                                                                                                        : Call OpenGLExtCall4(glGetnCompressedTexImagePtr, vbEmpty, target, lod, bufSize, pixels): End Sub
Public Sub      glGetnTexImage(ByVal tex As Long, ByVal level As Long, ByVal format As Long, ByVal ptype As Long, ByVal bufSize As Long, ByVal pixels)                                                                                        : Call OpenGLExtCall6(glGetnTexImagePtr, vbEmpty, tex, level, format, ptype, bufSize, pixels): End Sub
Public Sub      glGetnUniformdv(ByVal program As Long, ByVal location As Long, ByVal bufSize As Long, params As Double)                                                                                                                       : Call OpenGLExtCall4(glGetnUniformdvPtr, vbEmpty, program, location, bufSize, VarPtr(params)): End Sub
Public Sub      glDebugMessageControl(ByVal Source As Long, ByVal Typee As Long, ByVal Severity As Long, ByVal Count As Long, ids As LongPtr, ByVal Enabled As Boolean)                                                                       : Call OpenGLExtCall6(glDebugMessageControlPtr, vbEmpty, Source, Typee, Severity, Count, ids, Enabled): End Sub
Public Sub      glDebugMessageCallback(ByVal CallBack, userParam As LongPtr)                                                                                                                                                                  : Call OpenGLExtCall2(glDebugMessageCallbackPtr, vbEmpty, CallBack, UserParam): End Sub
Public Function glGetDebugMessageLog(ByVal Count As Long, ByVal BufSize As Long, ByVal Sources As LongPtr, ByVal Types As LongPtr, ByVal Ids As LongPtr, ByVal Severities As LongPtr, ByVal Lengths As LongPtr, ByVal MessageLog As LongPtr)  : Call OpenGLExtCall8(glGetDebugMessageLogPtr, vbLong, Count, BufSize, Sources, Types, Ids, Severities, Lengths, MessageLog): End Function
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL4_5()
If IsDEPEnabled Then
    glGetnUniformdvPtr = OpenGLExtProcAddress("glGetnUniformdv")
    glGetnTexImagePtr = OpenGLExtProcAddress("glGetnTexImage")
    glGetnCompressedTexImagePtr = OpenGLExtProcAddress("glGetnCompressedTexImage")
    glGetGraphicsResetStatusPtr = OpenGLExtProcAddress("glGetGraphicsResetStatus")
    glDebugMessageControlPtr = OpenGLExtProcAddress("glDebugMessageControl")
    glDebugMessageCallbackPtr = OpenGLExtProcAddress("glDebugMessageCallback")
    glGetDebugMessageLogPtr = OpenGLExtProcAddress("glGetDebugMessageLog")
Else
    RemapVBFunctionToGLFunction AddressOf glGetnUniformdv, "glGetnUniformdv"
    RemapVBFunctionToGLFunction AddressOf glGetnTexImage, "glGetnTexImage"
    RemapVBFunctionToGLFunction AddressOf glGetnCompressedTexImage, "glGetnCompressedTexImage"
    RemapVBFunctionToGLFunction AddressOf glGetGraphicsResetStatus, "glGetGraphicsResetStatus"
    RemapVBFunctionToGLFunction AddressOf glDebugMessageControl, "glDebugMessageControlPtr"
    RemapVBFunctionToGLFunction AddressOf glDebugMessageCallback, "glDebugMessageCallbackPtr"
    RemapVBFunctionToGLFunction AddressOf glGetDebugMessageLog, "glGetDebugMessageLogPtr"
End If
End Function
