Attribute VB_Name = "ModOpenGL_1_5"
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
'------------------------------- GL_VERSION_1_5 -------------------------------
Public Const GL_BUFFER_SIZE = &H8764&
Public Const GL_BUFFER_USAGE = &H8765&
Public Const GL_QUERY_COUNTER_BITS = &H8864&
Public Const GL_CURRENT_QUERY = &H8865&
Public Const GL_QUERY_RESULT = &H8866&
Public Const GL_QUERY_RESULT_AVAILABLE = &H8867&
Public Const GL_ARRAY_BUFFER = &H8892&
Public Const GL_ELEMENT_ARRAY_BUFFER = &H8893&
Public Const GL_ARRAY_BUFFER_BINDING = &H8894&
Public Const GL_ELEMENT_ARRAY_BUFFER_BINDING = &H8895&
Public Const GL_VERTEX_ARRAY_BUFFER_BINDING = &H8896&
Public Const GL_NORMAL_ARRAY_BUFFER_BINDING = &H8897&
Public Const GL_COLOR_ARRAY_BUFFER_BINDING = &H8898&
Public Const GL_INDEX_ARRAY_BUFFER_BINDING = &H8899&
Public Const GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING = &H889A&
Public Const GL_EDGE_FLAG_ARRAY_BUFFER_BINDING = &H889B&
Public Const GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING = &H889C&
Public Const GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING = &H889D&
Public Const GL_WEIGHT_ARRAY_BUFFER_BINDING = &H889E&
Public Const GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = &H889F&
Public Const GL_READ_ONLY = &H88B8&
Public Const GL_WRITE_ONLY = &H88B9&
Public Const GL_READ_WRITE = &H88BA&
Public Const GL_BUFFER_ACCESS = &H88BB&
Public Const GL_BUFFER_MAPPED = &H88BC&
Public Const GL_BUFFER_MAP_POINTER = &H88BD&
Public Const GL_STREAM_DRAW = &H88E0&
Public Const GL_STREAM_READ = &H88E1&
Public Const GL_STREAM_COPY = &H88E2&
Public Const GL_STATIC_DRAW = &H88E4&
Public Const GL_STATIC_READ = &H88E5&
Public Const GL_STATIC_COPY = &H88E6&
Public Const GL_DYNAMIC_DRAW = &H88E8&
Public Const GL_DYNAMIC_READ = &H88E9&
Public Const GL_DYNAMIC_COPY = &H88EA&
Public Const GL_SAMPLES_PASSED = &H8914&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glBeginQueryPtr, glBindBufferPtr, glBufferDataPtr, glBufferSubDataPtr, glDeleteBuffersPtr, glDeleteQueriesPtr, glEndQueryPtr, glGenBuffersPtr, glGenQueriesPtr, _
glGetBufferParameterivPtr, glGetBufferPointervPtr, glGetBufferSubDataPtr, glGetQueryObjectivPtr, glGetQueryObjectuivPtr, glGetQueryivPtr, glIsBufferPtr, glIsQueryPtr, glMapBufferPtr, glUnmapBufferPtr
'------------------------------- GL_VERSION_1_5 -------------------------------
Public Sub glBeginQuery(ByVal target As Long, ByVal id As Long): Call OpenGLExtCall2(glBeginQueryPtr, vbEmpty, target, id): End Sub
Public Sub glBindBuffer(ByVal target As Long, ByVal buffer As Long): Call OpenGLExtCall2(glBindBufferPtr, vbEmpty, target, buffer): End Sub
Public Sub glBufferData(ByVal target As Long, ByVal size, ByVal data, ByVal usage As Long): Call OpenGLExtCall4(glBufferDataPtr, vbEmpty, target, size, data, usage): End Sub
Public Sub glBufferSubData(ByVal target As Long, ByVal offset, ByVal size, ByVal data): Call OpenGLExtCall4(glBufferSubDataPtr, vbEmpty, target, offset, size, data): End Sub
Public Sub glDeleteBuffers(ByVal n As Long, buffers As Long): Call OpenGLExtCall2(glDeleteBuffersPtr, vbEmpty, n, VarPtr(buffers)): End Sub
Public Sub glDeleteQueries(ByVal n As Long, ids As Long): Call OpenGLExtCall2(glDeleteQueriesPtr, vbEmpty, n, VarPtr(ids)): End Sub
Public Sub glEndQuery(ByVal target As Long): Call OpenGLExtCall1(glEndQueryPtr, vbEmpty, target): End Sub
Public Sub glGenBuffers(ByVal n As Long, buffers As Long): Call OpenGLExtCall2(glGenBuffersPtr, vbEmpty, n, VarPtr(buffers)): End Sub
Public Sub glGenQueries(ByVal n As Long, ids As Long): Call OpenGLExtCall2(glGenQueriesPtr, vbEmpty, n, VarPtr(ids)): End Sub
Public Sub glGetBufferParameteriv(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetBufferParameterivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetBufferPointerv(ByVal target As Long, ByVal pname As Long, ByVal params): Call OpenGLExtCall3(glGetBufferPointervPtr, vbEmpty, target, pname, params): End Sub
Public Sub glGetBufferSubData(ByVal target As Long, ByVal offset, ByVal size, ByVal data): Call OpenGLExtCall4(glGetBufferSubDataPtr, vbEmpty, target, offset, size, data): End Sub
Public Sub glGetQueryObjectiv(ByVal id As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetQueryObjectivPtr, vbEmpty, id, pname, VarPtr(params)): End Sub
Public Sub glGetQueryObjectuiv(ByVal id As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetQueryObjectuivPtr, vbEmpty, id, pname, VarPtr(params)): End Sub
Public Sub glGetQueryiv(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetQueryivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Function glIsBuffer(ByVal buffer As Long) As Integer: glIsBuffer = OpenGLExtCall1(glIsBufferPtr, vbInteger, buffer): End Function
Public Function glIsQuery(ByVal id As Long) As Integer: glIsQuery = OpenGLExtCall1(glIsQueryPtr, vbInteger, id): End Function
Public Function glMapBuffer(ByVal target As Long, ByVal access As Long): glMapBuffer = OpenGLExtCall2(glMapBufferPtr, vbLongPtr, target, access): End Function
Public Function glUnmapBuffer(ByVal target As Long) As Integer: glUnmapBuffer = OpenGLExtCall1(glUnmapBufferPtr, vbInteger, target): End Function
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL1_5()
    If IsDEPEnabled Then
        glUnmapBufferPtr = OpenGLExtProcAddress("glUnmapBuffer")
        glMapBufferPtr = OpenGLExtProcAddress("glMapBuffer")
        glIsQueryPtr = OpenGLExtProcAddress("glIsQuery")
        glIsBufferPtr = OpenGLExtProcAddress("glIsBuffer")
        glGetQueryivPtr = OpenGLExtProcAddress("glGetQueryiv")
        glGetQueryObjectuivPtr = OpenGLExtProcAddress("glGetQueryObjectuiv")
        glGetQueryObjectivPtr = OpenGLExtProcAddress("glGetQueryObjectiv")
        glGetBufferSubDataPtr = OpenGLExtProcAddress("glGetBufferSubData")
        glGetBufferPointervPtr = OpenGLExtProcAddress("glGetBufferPointerv")
        glGetBufferParameterivPtr = OpenGLExtProcAddress("glGetBufferParameteriv")
        glGenQueriesPtr = OpenGLExtProcAddress("glGenQueries")
        glGenBuffersPtr = OpenGLExtProcAddress("glGenBuffers")
        glEndQueryPtr = OpenGLExtProcAddress("glEndQuery")
        glDeleteQueriesPtr = OpenGLExtProcAddress("glDeleteQueries")
        glDeleteBuffersPtr = OpenGLExtProcAddress("glDeleteBuffers")
        glBufferSubDataPtr = OpenGLExtProcAddress("glBufferSubData")
        glBufferDataPtr = OpenGLExtProcAddress("glBufferData")
        glBindBufferPtr = OpenGLExtProcAddress("glBindBuffer")
        glBeginQueryPtr = OpenGLExtProcAddress("glBeginQuery")
    Else
        RemapVBFunctionToGLFunction AddressOf glUnmapBuffer, "glUnmapBuffer"
        RemapVBFunctionToGLFunction AddressOf glMapBuffer, "glMapBuffer"
        RemapVBFunctionToGLFunction AddressOf glIsQuery, "glIsQuery"
        RemapVBFunctionToGLFunction AddressOf glIsBuffer, "glIsBuffer"
        RemapVBFunctionToGLFunction AddressOf glGetQueryiv, "glGetQueryiv"
        RemapVBFunctionToGLFunction AddressOf glGetQueryObjectuiv, "glGetQueryObjectuiv"
        RemapVBFunctionToGLFunction AddressOf glGetQueryObjectiv, "glGetQueryObjectiv"
        RemapVBFunctionToGLFunction AddressOf glGetBufferSubData, "glGetBufferSubData"
        RemapVBFunctionToGLFunction AddressOf glGetBufferPointerv, "glGetBufferPointerv"
        RemapVBFunctionToGLFunction AddressOf glGetBufferParameteriv, "glGetBufferParameteriv"
        RemapVBFunctionToGLFunction AddressOf glGenQueries, "glGenQueries"
        RemapVBFunctionToGLFunction AddressOf glGenBuffers, "glGenBuffers"
        RemapVBFunctionToGLFunction AddressOf glEndQuery, "glEndQuery"
        RemapVBFunctionToGLFunction AddressOf glDeleteQueries, "glDeleteQueries"
        RemapVBFunctionToGLFunction AddressOf glDeleteBuffers, "glDeleteBuffers"
        RemapVBFunctionToGLFunction AddressOf glBufferSubData, "glBufferSubData"
        RemapVBFunctionToGLFunction AddressOf glBufferData, "glBufferData"
        RemapVBFunctionToGLFunction AddressOf glBindBuffer, "glBindBuffer"
        RemapVBFunctionToGLFunction AddressOf glBeginQuery, "glBeginQuery"
    End If
End Function