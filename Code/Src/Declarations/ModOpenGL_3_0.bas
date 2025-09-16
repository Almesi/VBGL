Attribute VB_Name = "ModOpenGL_3_0"
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
'------------------------------- GL_VERSION_3_0 -------------------------------
Public Const GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT           = &H1&
Public Const GL_MAJOR_VERSION                                 = &H821B&
Public Const GL_MINOR_VERSION                                 = &H821C&
Public Const GL_NUM_EXTENSIONS                                = &H821D&
Public Const GL_CONTEXT_FLAGS                                 = &H821E&
Public Const GL_DEPTH_BUFFER                                  = &H8223&
Public Const GL_STENCIL_BUFFER                                = &H8224&
Public Const GL_RGBA32F                                       = &H8814&
Public Const GL_RGB32F                                        = &H8815&
Public Const GL_RGBA16F                                       = &H881A&
Public Const GL_RGB16F                                        = &H881B&
Public Const GL_VERTEX_ATTRIB_ARRAY_INTEGER                   = &H88FD&
Public Const GL_MAX_ARRAY_TEXTURE_LAYERS                      = &H88FF&
Public Const GL_MIN_PROGRAM_TEXEL_OFFSET                      = &H8904&
Public Const GL_MAX_PROGRAM_TEXEL_OFFSET                      = &H8905&
Public Const GL_CLAMP_VERTEX_COLOR                            = &H891A&
Public Const GL_CLAMP_FRAGMENT_COLOR                          = &H891B&
Public Const GL_CLAMP_READ_COLOR                              = &H891C&
Public Const GL_FIXED_ONLY                                    = &H891D&
Public Const GL_TEXTURE_RED_TYPE                              = &H8C10&
Public Const GL_TEXTURE_GREEN_TYPE                            = &H8C11&
Public Const GL_TEXTURE_BLUE_TYPE                             = &H8C12&
Public Const GL_TEXTURE_ALPHA_TYPE                            = &H8C13&
Public Const GL_TEXTURE_LUMINANCE_TYPE                        = &H8C14&
Public Const GL_TEXTURE_INTENSITY_TYPE                        = &H8C15&
Public Const GL_TEXTURE_DEPTH_TYPE                            = &H8C16&
Public Const GL_TEXTURE_1D_ARRAY                              = &H8C18&
Public Const GL_PROXY_TEXTURE_1D_ARRAY                        = &H8C19&
Public Const GL_TEXTURE_2D_ARRAY                              = &H8C1A&
Public Const GL_PROXY_TEXTURE_2D_ARRAY                        = &H8C1B&
Public Const GL_TEXTURE_BINDING_1D_ARRAY                      = &H8C1C&
Public Const GL_TEXTURE_BINDING_2D_ARRAY                      = &H8C1D&
Public Const GL_R11F_G11F_B10F                                = &H8C3A&
Public Const GL_UNSIGNED_INT_10F_11F_11F_REV                  = &H8C3B&
Public Const GL_RGB9_E5                                       = &H8C3D&
Public Const GL_UNSIGNED_INT_5_9_9_9_REV                      = &H8C3E&
Public Const GL_TEXTURE_SHARED_SIZE                           = &H8C3F&
Public Const GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH         = &H8C76&
Public Const GL_TRANSFORM_FEEDBACK_BUFFER_MODE                = &H8C7F&
Public Const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS    = &H8C80&
Public Const GL_TRANSFORM_FEEDBACK_VARYINGS                   = &H8C83&
Public Const GL_TRANSFORM_FEEDBACK_BUFFER_START               = &H8C84&
Public Const GL_TRANSFORM_FEEDBACK_BUFFER_SIZE                = &H8C85&
Public Const GL_PRIMITIVES_GENERATED                          = &H8C87&
Public Const GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN         = &H8C88&
Public Const GL_RASTERIZER_DISCARD                            = &H8C89&
Public Const GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = &H8C8A&
Public Const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS       = &H8C8B&
Public Const GL_INTERLEAVED_ATTRIBS                           = &H8C8C&
Public Const GL_SEPARATE_ATTRIBS                              = &H8C8D&
Public Const GL_TRANSFORM_FEEDBACK_BUFFER                     = &H8C8E&
Public Const GL_TRANSFORM_FEEDBACK_BUFFER_BINDING             = &H8C8F&
Public Const GL_RGBA32UI                                      = &H8D70&
Public Const GL_RGB32UI                                       = &H8D71&
Public Const GL_RGBA16UI                                      = &H8D76&
Public Const GL_RGB16UI                                       = &H8D77&
Public Const GL_RGBA8UI                                       = &H8D7C&
Public Const GL_RGB8UI                                        = &H8D7D&
Public Const GL_RGBA32I                                       = &H8D82&
Public Const GL_RGB32I                                        = &H8D83&
Public Const GL_RGBA16I                                       = &H8D88&
Public Const GL_RGB16I                                        = &H8D89&
Public Const GL_RGBA8I                                        = &H8D8E&
Public Const GL_RGB8I                                         = &H8D8F&
Public Const GL_RED_INTEGER                                   = &H8D94&
Public Const GL_GREEN_INTEGER                                 = &H8D95&
Public Const GL_BLUE_INTEGER                                  = &H8D96&
Public Const GL_ALPHA_INTEGER                                 = &H8D97&
Public Const GL_RGB_INTEGER                                   = &H8D98&
Public Const GL_RGBA_INTEGER                                  = &H8D99&
Public Const GL_BGR_INTEGER                                   = &H8D9A&
Public Const GL_BGRA_INTEGER                                  = &H8D9B&
Public Const GL_SAMPLER_1D_ARRAY                              = &H8DC0&
Public Const GL_SAMPLER_2D_ARRAY                              = &H8DC1&
Public Const GL_SAMPLER_1D_ARRAY_SHADOW                       = &H8DC3&
Public Const GL_SAMPLER_2D_ARRAY_SHADOW                       = &H8DC4&
Public Const GL_SAMPLER_CUBE_SHADOW                           = &H8DC5&
Public Const GL_UNSIGNED_INT_VEC2                             = &H8DC6&
Public Const GL_UNSIGNED_INT_VEC3                             = &H8DC7&
Public Const GL_UNSIGNED_INT_VEC4                             = &H8DC8&
Public Const GL_INT_SAMPLER_1D                                = &H8DC9&
Public Const GL_INT_SAMPLER_2D                                = &H8DCA&
Public Const GL_INT_SAMPLER_3D                                = &H8DCB&
Public Const GL_INT_SAMPLER_CUBE                              = &H8DCC&
Public Const GL_INT_SAMPLER_1D_ARRAY                          = &H8DCE&
Public Const GL_INT_SAMPLER_2D_ARRAY                          = &H8DCF&
Public Const GL_UNSIGNED_INT_SAMPLER_1D                       = &H8DD1&
Public Const GL_UNSIGNED_INT_SAMPLER_2D                       = &H8DD2&
Public Const GL_UNSIGNED_INT_SAMPLER_3D                       = &H8DD3&
Public Const GL_UNSIGNED_INT_SAMPLER_CUBE                     = &H8DD4&
Public Const GL_UNSIGNED_INT_SAMPLER_1D_ARRAY                 = &H8DD6&
Public Const GL_UNSIGNED_INT_SAMPLER_2D_ARRAY                 = &H8DD7&
Public Const GL_QUERY_WAIT                                    = &H8E13&
Public Const GL_QUERY_NO_WAIT                                 = &H8E14&
Public Const GL_QUERY_BY_REGION_WAIT                          = &H8E15&
Public Const GL_QUERY_BY_REGION_NO_WAIT                       = &H8E16&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glBeginConditionalRenderPtr, glBeginTransformFeedbackPtr, glBindFragDataLocationPtr, glClampColorPtr, glClearBufferfiPtr, glClearBufferfvPtr, glClearBufferivPtr, glClearBufferuivPtr, glColorMaskiPtr, _
glDisableiPtr, glEnableiPtr, glEndConditionalRenderPtr, glEndTransformFeedbackPtr, glGetBooleani_vPtr, glGetFragDataLocationPtr, glGetTexParameterIivPtr, glGetTexParameterIuivPtr, glGetTransformFeedbackVaryingPtr, glGetUniformuivPtr, _
glGetVertexAttribIivPtr, glGetVertexAttribIuivPtr, glIsEnablediPtr, glTexParameterIivPtr, glTexParameterIuivPtr, glTransformFeedbackVaryingsPtr, glUniform1uiPtr, glUniform1uivPtr, glUniform2uiPtr, glUniform2uivPtr, _
glUniform3uiPtr, glUniform3uivPtr, glUniform4uiPtr, glUniform4uivPtr, glVertexAttribI1iPtr, glVertexAttribI1ivPtr, glVertexAttribI1uiPtr, glVertexAttribI1uivPtr, glVertexAttribI2iPtr, glVertexAttribI2ivPtr, _
glVertexAttribI2uiPtr, glVertexAttribI2uivPtr, glVertexAttribI3iPtr, glVertexAttribI3ivPtr, glVertexAttribI3uiPtr, glVertexAttribI3uivPtr, glVertexAttribI4bvPtr, glVertexAttribI4iPtr, glVertexAttribI4ivPtr, glVertexAttribI4svPtr, _
glVertexAttribI4ubvPtr, glVertexAttribI4uiPtr, glVertexAttribI4uivPtr, glVertexAttribI4usvPtr, glVertexAttribIPointerPtr, glGenVertexArraysPtr, glBindVertexArrayPtr
'------------------------------- GL_VERSION_3_0 -------------------------------
Public Sub glBeginConditionalRender(ByVal id As Long, ByVal mode As Long)                                                                                              : Call OpenGLExtCall2(glBeginConditionalRenderPtr, vbEmpty, id, mode): End Sub
Public Sub glBeginTransformFeedback(ByVal primitiveMode As Long)                                                                                                       : Call OpenGLExtCall1(glBeginTransformFeedbackPtr, vbEmpty, primitiveMode): End Sub
Public Sub glBindFragDataLocation(ByVal program As Long, ByVal colorNumber As Long, ByVal name)                                                                        : Call OpenGLExtCall3(glBindFragDataLocationPtr, vbEmpty, program, colorNumber, name): End Sub
Public Sub glClampColor(ByVal target As Long, ByVal clamp As Long)                                                                                                     : Call OpenGLExtCall2(glClampColorPtr, vbEmpty, target, clamp): End Sub
Public Sub glClearBufferfi(ByVal buffer As Long, ByVal drawbuffer As Long, ByVal depth As Single, ByVal stencil As Long)                                               : Call OpenGLExtCall4(glClearBufferfiPtr, vbEmpty, buffer, drawbuffer, depth, stencil): End Sub
Public Sub glClearBufferfv(ByVal buffer As Long, ByVal drawbuffer As Long, value As Single)                                                                            : Call OpenGLExtCall3(glClearBufferfvPtr, vbEmpty, buffer, drawbuffer, VarPtr(value)): End Sub
Public Sub glClearBufferiv(ByVal buffer As Long, ByVal drawbuffer As Long, value As Long)                                                                              : Call OpenGLExtCall3(glClearBufferivPtr, vbEmpty, buffer, drawbuffer, VarPtr(value)): End Sub
Public Sub glClearBufferuiv(ByVal buffer As Long, ByVal drawbuffer As Long, value As Long)                                                                             : Call OpenGLExtCall3(glClearBufferuivPtr, vbEmpty, buffer, drawbuffer, VarPtr(value)): End Sub
Public Sub glColorMaski(ByVal buf As Long, ByVal red As Integer, ByVal green As Integer, ByVal blue As Integer, ByVal alpha As Integer)                                : Call OpenGLExtCall5(glColorMaskiPtr, vbEmpty, buf, red, green, blue, alpha): End Sub
Public Sub glDisablei(ByVal cap As Long, ByVal index As Long)                                                                                                          : Call OpenGLExtCall2(glDisableiPtr, vbEmpty, cap, index): End Sub
Public Sub glEnablei(ByVal cap As Long, ByVal index As Long)                                                                                                           : Call OpenGLExtCall2(glEnableiPtr, vbEmpty, cap, index): End Sub
Public Sub glEndConditionalRender()                                                                                                                                    : Call OpenGLExtCall0(glEndConditionalRenderPtr, vbEmpty): End Sub
Public Sub glEndTransformFeedback()                                                                                                                                    : Call OpenGLExtCall0(glEndTransformFeedbackPtr, vbEmpty): End Sub
Public Sub glGetBooleani_v(ByVal pname As Long, ByVal index As Long, data As Integer)                                                                                  : Call OpenGLExtCall3(glGetBooleani_vPtr, vbEmpty, pname, index, VarPtr(data)): End Sub
Public Function glGetFragDataLocation(ByVal program As Long, ByVal name) As Long                                                                                       : glGetFragDataLocation = OpenGLExtCall2(glGetFragDataLocationPtr, vbLong, program, name): End Function
Public Sub glGetTexParameterIiv(ByVal target As Long, ByVal pname As Long, params As Long)                                                                             : Call OpenGLExtCall3(glGetTexParameterIivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetTexParameterIuiv(ByVal target As Long, ByVal pname As Long, params As Long)                                                                            : Call OpenGLExtCall3(glGetTexParameterIuivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetTransformFeedbackVarying(ByVal program As Long, ByVal index As Long, ByVal bufSize As Long, length As Long, size As Long, ptype As Long, ByVal name)   : Call OpenGLExtCall7(glGetTransformFeedbackVaryingPtr, vbEmpty, program, index, bufSize, VarPtr(length), VarPtr(size), VarPtr(ptype), name): End Sub
Public Sub glGetUniformuiv(ByVal program As Long, ByVal location As Long, params As Long)                                                                              : Call OpenGLExtCall3(glGetUniformuivPtr, vbEmpty, program, location, VarPtr(params)): End Sub
Public Sub glGetVertexAttribIiv(ByVal index As Long, ByVal pname As Long, params As Long)                                                                              : Call OpenGLExtCall3(glGetVertexAttribIivPtr, vbEmpty, index, pname, VarPtr(params)): End Sub
Public Sub glGetVertexAttribIuiv(ByVal index As Long, ByVal pname As Long, params As Long)                                                                             : Call OpenGLExtCall3(glGetVertexAttribIuivPtr, vbEmpty, index, pname, VarPtr(params)): End Sub
Public Function glIsEnabledi(ByVal cap As Long, ByVal index As Long) As Integer                                                                                        : glIsEnabledi = OpenGLExtCall2(glIsEnablediPtr, vbInteger, cap, index): End Function
Public Sub glTexParameterIiv(ByVal target As Long, ByVal pname As Long, params As Long)                                                                                : Call OpenGLExtCall3(glTexParameterIivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glTexParameterIuiv(ByVal target As Long, ByVal pname As Long, params As Long)                                                                               : Call OpenGLExtCall3(glTexParameterIuivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glTransformFeedbackVaryings(ByVal program As Long, ByVal count As Long, ByVal varyings, ByVal bufferMode As Long)                                           : Call OpenGLExtCall4(glTransformFeedbackVaryingsPtr, vbEmpty, program, count, varyings, bufferMode): End Sub
Public Sub glUniform1ui(ByVal location As Long, ByVal v0 As Long)                                                                                                      : Call OpenGLExtCall2(glUniform1uiPtr, vbEmpty, location, v0): End Sub
Public Sub glUniform1uiv(ByVal location As Long, ByVal count As Long, value As Long)                                                                                   : Call OpenGLExtCall3(glUniform1uivPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform2ui(ByVal location As Long, ByVal v0 As Long, ByVal v1 As Long)                                                                                    : Call OpenGLExtCall3(glUniform2uiPtr, vbEmpty, location, v0, v1): End Sub
Public Sub glUniform2uiv(ByVal location As Long, ByVal count As Long, value As Long)                                                                                   : Call OpenGLExtCall3(glUniform2uivPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform3ui(ByVal location As Long, ByVal v0 As Long, ByVal v1 As Long, ByVal v2 As Long)                                                                  : Call OpenGLExtCall4(glUniform3uiPtr, vbEmpty, location, v0, v1, v2): End Sub
Public Sub glUniform3uiv(ByVal location As Long, ByVal count As Long, value As Long)                                                                                   : Call OpenGLExtCall3(glUniform3uivPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform4ui(ByVal location As Long, ByVal v0 As Long, ByVal v1 As Long, ByVal v2 As Long, ByVal v3 As Long)                                                : Call OpenGLExtCall5(glUniform4uiPtr, vbEmpty, location, v0, v1, v2, v3): End Sub
Public Sub glUniform4uiv(ByVal location As Long, ByVal count As Long, value As Long)                                                                                   : Call OpenGLExtCall3(glUniform4uivPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glVertexAttribI1i(ByVal index As Long, ByVal v0 As Long)                                                                                                    : Call OpenGLExtCall2(glVertexAttribI1iPtr, vbEmpty, index, v0): End Sub
Public Sub glVertexAttribI1iv(ByVal index As Long, v0 As Long)                                                                                                         : Call OpenGLExtCall2(glVertexAttribI1ivPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI1ui(ByVal index As Long, ByVal v0 As Long)                                                                                                   : Call OpenGLExtCall2(glVertexAttribI1uiPtr, vbEmpty, index, v0): End Sub
Public Sub glVertexAttribI1uiv(ByVal index As Long, v0 As Long)                                                                                                        : Call OpenGLExtCall2(glVertexAttribI1uivPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI2i(ByVal index As Long, ByVal v0 As Long, ByVal v1 As Long)                                                                                  : Call OpenGLExtCall3(glVertexAttribI2iPtr, vbEmpty, index, v0, v1): End Sub
Public Sub glVertexAttribI2iv(ByVal index As Long, v0 As Long)                                                                                                         : Call OpenGLExtCall2(glVertexAttribI2ivPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI2ui(ByVal index As Long, ByVal v0 As Long, ByVal v1 As Long)                                                                                 : Call OpenGLExtCall3(glVertexAttribI2uiPtr, vbEmpty, index, v0, v1): End Sub
Public Sub glVertexAttribI2uiv(ByVal index As Long, v0 As Long)                                                                                                        : Call OpenGLExtCall2(glVertexAttribI2uivPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI3i(ByVal index As Long, ByVal v0 As Long, ByVal v1 As Long, ByVal v2 As Long)                                                                : Call OpenGLExtCall4(glVertexAttribI3iPtr, vbEmpty, index, v0, v1, v2): End Sub
Public Sub glVertexAttribI3iv(ByVal index As Long, v0 As Long)                                                                                                         : Call OpenGLExtCall2(glVertexAttribI3ivPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI3ui(ByVal index As Long, ByVal v0 As Long, ByVal v1 As Long, ByVal v2 As Long)                                                               : Call OpenGLExtCall4(glVertexAttribI3uiPtr, vbEmpty, index, v0, v1, v2): End Sub
Public Sub glVertexAttribI3uiv(ByVal index As Long, v0 As Long)                                                                                                        : Call OpenGLExtCall2(glVertexAttribI3uivPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI4bv(ByVal index As Long, v0 As Byte)                                                                                                         : Call OpenGLExtCall2(glVertexAttribI4bvPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI4i(ByVal index As Long, ByVal v0 As Long, ByVal v1 As Long, ByVal v2 As Long, ByVal v3 As Long)                                              : Call OpenGLExtCall5(glVertexAttribI4iPtr, vbEmpty, index, v0, v1, v2, v3): End Sub
Public Sub glVertexAttribI4iv(ByVal index As Long, v0 As Long)                                                                                                         : Call OpenGLExtCall2(glVertexAttribI4ivPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI4sv(ByVal index As Long, v0 As Integer)                                                                                                      : Call OpenGLExtCall2(glVertexAttribI4svPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI4ubv(ByVal index As Long, v0 As Byte)                                                                                                        : Call OpenGLExtCall2(glVertexAttribI4ubvPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI4ui(ByVal index As Long, ByVal v0 As Long, ByVal v1 As Long, ByVal v2 As Long, ByVal v3 As Long)                                             : Call OpenGLExtCall5(glVertexAttribI4uiPtr, vbEmpty, index, v0, v1, v2, v3): End Sub
Public Sub glVertexAttribI4uiv(ByVal index As Long, v0 As Long)                                                                                                        : Call OpenGLExtCall2(glVertexAttribI4uivPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribI4usv(ByVal index As Long, v0 As Long)                                                                                                        : Call OpenGLExtCall2(glVertexAttribI4usvPtr, vbEmpty, index, VarPtr(v0)): End Sub
Public Sub glVertexAttribIPointer(ByVal index As Long, ByVal size As Long, ByVal ptype As Long, ByVal stride As Long, ByVal pointer)                                   : Call OpenGLExtCall5(glVertexAttribIPointerPtr, vbEmpty, index, size, ptype, stride, pointer): End Sub
Public Sub glGenVertexArrays(ByVal n As Long, Arrays As Long)                                                                                                          : Call OpenGLExtCall2(glGenVertexArraysPtr, vbEmpty, n, VarPtr(Arrays)): End Sub
Public Sub glBindVertexArray(ByVal Arr As Long)                                                                                                                        : Call OpenGLExtCall1(glBindVertexArrayPtr, vbEmpty, Arr): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL3_0()
    If IsDEPEnabled Then
        glVertexAttribIPointerPtr = OpenGLExtProcAddress("glVertexAttribIPointer")
        glVertexAttribI4usvPtr = OpenGLExtProcAddress("glVertexAttribI4usv")
        glVertexAttribI4uivPtr = OpenGLExtProcAddress("glVertexAttribI4uiv")
        glVertexAttribI4uiPtr = OpenGLExtProcAddress("glVertexAttribI4ui")
        glVertexAttribI4ubvPtr = OpenGLExtProcAddress("glVertexAttribI4ubv")
        glVertexAttribI4svPtr = OpenGLExtProcAddress("glVertexAttribI4sv")
        glVertexAttribI4ivPtr = OpenGLExtProcAddress("glVertexAttribI4iv")
        glVertexAttribI4iPtr = OpenGLExtProcAddress("glVertexAttribI4i")
        glVertexAttribI4bvPtr = OpenGLExtProcAddress("glVertexAttribI4bv")
        glVertexAttribI3uivPtr = OpenGLExtProcAddress("glVertexAttribI3uiv")
        glVertexAttribI3uiPtr = OpenGLExtProcAddress("glVertexAttribI3ui")
        glVertexAttribI3ivPtr = OpenGLExtProcAddress("glVertexAttribI3iv")
        glVertexAttribI3iPtr = OpenGLExtProcAddress("glVertexAttribI3i")
        glVertexAttribI2uivPtr = OpenGLExtProcAddress("glVertexAttribI2uiv")
        glVertexAttribI2uiPtr = OpenGLExtProcAddress("glVertexAttribI2ui")
        glVertexAttribI2ivPtr = OpenGLExtProcAddress("glVertexAttribI2iv")
        glVertexAttribI2iPtr = OpenGLExtProcAddress("glVertexAttribI2i")
        glVertexAttribI1uivPtr = OpenGLExtProcAddress("glVertexAttribI1uiv")
        glVertexAttribI1uiPtr = OpenGLExtProcAddress("glVertexAttribI1ui")
        glVertexAttribI1ivPtr = OpenGLExtProcAddress("glVertexAttribI1iv")
        glVertexAttribI1iPtr = OpenGLExtProcAddress("glVertexAttribI1i")
        glUniform4uivPtr = OpenGLExtProcAddress("glUniform4uiv")
        glUniform4uiPtr = OpenGLExtProcAddress("glUniform4ui")
        glUniform3uivPtr = OpenGLExtProcAddress("glUniform3uiv")
        glUniform3uiPtr = OpenGLExtProcAddress("glUniform3ui")
        glUniform2uivPtr = OpenGLExtProcAddress("glUniform2uiv")
        glUniform2uiPtr = OpenGLExtProcAddress("glUniform2ui")
        glUniform1uivPtr = OpenGLExtProcAddress("glUniform1uiv")
        glUniform1uiPtr = OpenGLExtProcAddress("glUniform1ui")
        glTransformFeedbackVaryingsPtr = OpenGLExtProcAddress("glTransformFeedbackVaryings")
        glTexParameterIuivPtr = OpenGLExtProcAddress("glTexParameterIuiv")
        glTexParameterIivPtr = OpenGLExtProcAddress("glTexParameterIiv")
        glIsEnablediPtr = OpenGLExtProcAddress("glIsEnabledi")
        glGetVertexAttribIuivPtr = OpenGLExtProcAddress("glGetVertexAttribIuiv")
        glGetVertexAttribIivPtr = OpenGLExtProcAddress("glGetVertexAttribIiv")
        glGetUniformuivPtr = OpenGLExtProcAddress("glGetUniformuiv")
        glGetTransformFeedbackVaryingPtr = OpenGLExtProcAddress("glGetTransformFeedbackVarying")
        glGetTexParameterIuivPtr = OpenGLExtProcAddress("glGetTexParameterIuiv")
        glGetTexParameterIivPtr = OpenGLExtProcAddress("glGetTexParameterIiv")
        glGetFragDataLocationPtr = OpenGLExtProcAddress("glGetFragDataLocation")
        glGetBooleani_vPtr = OpenGLExtProcAddress("glGetBooleani_v")
        glEndTransformFeedbackPtr = OpenGLExtProcAddress("glEndTransformFeedback")
        glEndConditionalRenderPtr = OpenGLExtProcAddress("glEndConditionalRender")
        glEnableiPtr = OpenGLExtProcAddress("glEnablei")
        glDisableiPtr = OpenGLExtProcAddress("glDisablei")
        glColorMaskiPtr = OpenGLExtProcAddress("glColorMaski")
        glClearBufferuivPtr = OpenGLExtProcAddress("glClearBufferuiv")
        glClearBufferivPtr = OpenGLExtProcAddress("glClearBufferiv")
        glClearBufferfvPtr = OpenGLExtProcAddress("glClearBufferfv")
        glClearBufferfiPtr = OpenGLExtProcAddress("glClearBufferfi")
        glClampColorPtr = OpenGLExtProcAddress("glClampColor")
        glBindFragDataLocationPtr = OpenGLExtProcAddress("glBindFragDataLocation")
        glBeginTransformFeedbackPtr = OpenGLExtProcAddress("glBeginTransformFeedback")
        glBeginConditionalRenderPtr = OpenGLExtProcAddress("glBeginConditionalRender")
        glGenVertexArraysPtr = OpenGLExtProcAddress("glGenVertexArrays")
        glBindVertexArrayPtr = OpenGLExtProcAddress("glBindVertexArray")
    Else
        RemapVBFunctionToGLFunction AddressOf glVertexAttribIPointer, "glVertexAttribIPointer"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI4usv, "glVertexAttribI4usv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI4uiv, "glVertexAttribI4uiv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI4ui, "glVertexAttribI4ui"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI4ubv, "glVertexAttribI4ubv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI4sv, "glVertexAttribI4sv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI4iv, "glVertexAttribI4iv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI4i, "glVertexAttribI4i"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI4bv, "glVertexAttribI4bv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI3uiv, "glVertexAttribI3uiv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI3ui, "glVertexAttribI3ui"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI3iv, "glVertexAttribI3iv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI3i, "glVertexAttribI3i"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI2uiv, "glVertexAttribI2uiv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI2ui, "glVertexAttribI2ui"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI2iv, "glVertexAttribI2iv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI2i, "glVertexAttribI2i"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI1uiv, "glVertexAttribI1uiv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI1ui, "glVertexAttribI1ui"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI1iv, "glVertexAttribI1iv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttribI1i, "glVertexAttribI1i"
        RemapVBFunctionToGLFunction AddressOf glUniform4uiv, "glUniform4uiv"
        RemapVBFunctionToGLFunction AddressOf glUniform4ui, "glUniform4ui"
        RemapVBFunctionToGLFunction AddressOf glUniform3uiv, "glUniform3uiv"
        RemapVBFunctionToGLFunction AddressOf glUniform3ui, "glUniform3ui"
        RemapVBFunctionToGLFunction AddressOf glUniform2uiv, "glUniform2uiv"
        RemapVBFunctionToGLFunction AddressOf glUniform2ui, "glUniform2ui"
        RemapVBFunctionToGLFunction AddressOf glUniform1uiv, "glUniform1uiv"
        RemapVBFunctionToGLFunction AddressOf glUniform1ui, "glUniform1ui"
        RemapVBFunctionToGLFunction AddressOf glTransformFeedbackVaryings, "glTransformFeedbackVaryings"
        RemapVBFunctionToGLFunction AddressOf glTexParameterIuiv, "glTexParameterIuiv"
        RemapVBFunctionToGLFunction AddressOf glTexParameterIiv, "glTexParameterIiv"
        RemapVBFunctionToGLFunction AddressOf glIsEnabledi, "glIsEnabledi"
        RemapVBFunctionToGLFunction AddressOf glGetVertexAttribIuiv, "glGetVertexAttribIuiv"
        RemapVBFunctionToGLFunction AddressOf glGetVertexAttribIiv, "glGetVertexAttribIiv"
        RemapVBFunctionToGLFunction AddressOf glGetUniformuiv, "glGetUniformuiv"
        RemapVBFunctionToGLFunction AddressOf glGetTransformFeedbackVarying, "glGetTransformFeedbackVarying"
        RemapVBFunctionToGLFunction AddressOf glGetTexParameterIuiv, "glGetTexParameterIuiv"
        RemapVBFunctionToGLFunction AddressOf glGetTexParameterIiv, "glGetTexParameterIiv"
        RemapVBFunctionToGLFunction AddressOf glGetFragDataLocation, "glGetFragDataLocation"
        RemapVBFunctionToGLFunction AddressOf glGetBooleani_v, "glGetBooleani_v"
        RemapVBFunctionToGLFunction AddressOf glEndTransformFeedback, "glEndTransformFeedback"
        RemapVBFunctionToGLFunction AddressOf glEndConditionalRender, "glEndConditionalRender"
        RemapVBFunctionToGLFunction AddressOf glEnablei, "glEnablei"
        RemapVBFunctionToGLFunction AddressOf glDisablei, "glDisablei"
        RemapVBFunctionToGLFunction AddressOf glColorMaski, "glColorMaski"
        RemapVBFunctionToGLFunction AddressOf glClearBufferuiv, "glClearBufferuiv"
        RemapVBFunctionToGLFunction AddressOf glClearBufferiv, "glClearBufferiv"
        RemapVBFunctionToGLFunction AddressOf glClearBufferfv, "glClearBufferfv"
        RemapVBFunctionToGLFunction AddressOf glClearBufferfi, "glClearBufferfi"
        RemapVBFunctionToGLFunction AddressOf glClampColor, "glClampColor"
        RemapVBFunctionToGLFunction AddressOf glBindFragDataLocation, "glBindFragDataLocation"
        RemapVBFunctionToGLFunction AddressOf glBeginTransformFeedback, "glBeginTransformFeedback"
        RemapVBFunctionToGLFunction AddressOf glBeginConditionalRender, "glBeginConditionalRender"
        RemapVBFunctionToGLFunction AddressOf glGenVertexArrays, "glGenVertexArraysPtr"
        RemapVBFunctionToGLFunction AddressOf glBindVertexArray, "glBindVertexArrayPtr"
    End If
End Function