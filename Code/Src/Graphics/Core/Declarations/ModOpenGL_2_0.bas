Attribute VB_Name = "ModOpenGL_2_0"
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
'------------------------------- GL_VERSION_2_0 -------------------------------
Public Const GL_VERTEX_ATTRIB_ARRAY_ENABLED          = &H8622&
Public Const GL_VERTEX_ATTRIB_ARRAY_SIZE             = &H8623&
Public Const GL_VERTEX_ATTRIB_ARRAY_STRIDE           = &H8624&
Public Const GL_VERTEX_ATTRIB_ARRAY_TYPE             = &H8625&
Public Const GL_CURRENT_VERTEX_ATTRIB                = &H8626&
Public Const GL_VERTEX_PROGRAM_POINT_SIZE            = &H8642&
Public Const GL_VERTEX_PROGRAM_TWO_SIDE              = &H8643&
Public Const GL_VERTEX_ATTRIB_ARRAY_POINTER          = &H8645&
Public Const GL_STENCIL_BACK_FUNC                    = &H8800&
Public Const GL_STENCIL_BACK_FAIL                    = &H8801&
Public Const GL_STENCIL_BACK_PASS_DEPTH_FAIL         = &H8802&
Public Const GL_STENCIL_BACK_PASS_DEPTH_PASS         = &H8803&
Public Const GL_MAX_DRAW_BUFFERS                     = &H8824&
Public Const GL_DRAW_BUFFER0                         = &H8825&
Public Const GL_DRAW_BUFFER1                         = &H8826&
Public Const GL_DRAW_BUFFER2                         = &H8827&
Public Const GL_DRAW_BUFFER3                         = &H8828&
Public Const GL_DRAW_BUFFER4                         = &H8829&
Public Const GL_DRAW_BUFFER5                         = &H882A&
Public Const GL_DRAW_BUFFER6                         = &H882B&
Public Const GL_DRAW_BUFFER7                         = &H882C&
Public Const GL_DRAW_BUFFER8                         = &H882D&
Public Const GL_DRAW_BUFFER9                         = &H882E&
Public Const GL_DRAW_BUFFER10                        = &H882F&
Public Const GL_DRAW_BUFFER11                        = &H8830&
Public Const GL_DRAW_BUFFER12                        = &H8831&
Public Const GL_DRAW_BUFFER13                        = &H8832&
Public Const GL_DRAW_BUFFER14                        = &H8833&
Public Const GL_DRAW_BUFFER15                        = &H8834&
Public Const GL_BLEND_EQUATION_ALPHA                 = &H883D&
Public Const GL_POINT_SPRITE                         = &H8861&
Public Const GL_COORD_REPLACE                        = &H8862&
Public Const GL_MAX_VERTEX_ATTRIBS                   = &H8869&
Public Const GL_VERTEX_ATTRIB_ARRAY_NORMALIZED       = &H886A&
Public Const GL_MAX_TEXTURE_COORDS                   = &H8871&
Public Const GL_MAX_TEXTURE_IMAGE_UNITS              = &H8872&
Public Const GL_FRAGMENT_SHADER                      = &H8B30&
Public Const GL_VERTEX_SHADER                        = &H8B31&
Public Const GL_MAX_FRAGMENT_UNIFORM_COMPONENTS      = &H8B49&
Public Const GL_MAX_VERTEX_UNIFORM_COMPONENTS        = &H8B4A&
Public Const GL_MAX_VARYING_FLOATS                   = &H8B4B&
Public Const GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS       = &H8B4C&
Public Const GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS     = &H8B4D&
Public Const GL_SHADER_TYPE                          = &H8B4F&
Public Const GL_FLOAT_VEC2                           = &H8B50&
Public Const GL_FLOAT_VEC3                           = &H8B51&
Public Const GL_FLOAT_VEC4                           = &H8B52&
Public Const GL_INT_VEC2                             = &H8B53&
Public Const GL_INT_VEC3                             = &H8B54&
Public Const GL_INT_VEC4                             = &H8B55&
Public Const GL_BOOL                                 = &H8B56&
Public Const GL_BOOL_VEC2                            = &H8B57&
Public Const GL_BOOL_VEC3                            = &H8B58&
Public Const GL_BOOL_VEC4                            = &H8B59&
Public Const GL_FLOAT_MAT2                           = &H8B5A&
Public Const GL_FLOAT_MAT3                           = &H8B5B&
Public Const GL_FLOAT_MAT4                           = &H8B5C&
Public Const GL_SAMPLER_1D                           = &H8B5D&
Public Const GL_SAMPLER_2D                           = &H8B5E&
Public Const GL_SAMPLER_3D                           = &H8B5F&
Public Const GL_SAMPLER_CUBE                         = &H8B60&
Public Const GL_SAMPLER_1D_SHADOW                    = &H8B61&
Public Const GL_SAMPLER_2D_SHADOW                    = &H8B62&
Public Const GL_DELETE_STATUS                        = &H8B80&
Public Const GL_COMPILE_STATUS                       = &H8B81&
Public Const GL_LINK_STATUS                          = &H8B82&
Public Const GL_VALIDATE_STATUS                      = &H8B83&
Public Const GL_INFO_LOG_LENGTH                      = &H8B84&
Public Const GL_ATTACHED_SHADERS                     = &H8B85&
Public Const GL_ACTIVE_UNIFORMS                      = &H8B86&
Public Const GL_ACTIVE_UNIFORM_MAX_LENGTH            = &H8B87&
Public Const GL_SHADER_SOURCE_LENGTH                 = &H8B88&
Public Const GL_ACTIVE_ATTRIBUTES                    = &H8B89&
Public Const GL_ACTIVE_ATTRIBUTE_MAX_LENGTH          = &H8B8A&
Public Const GL_FRAGMENT_SHADER_DERIVATIVE_HINT      = &H8B8B&
Public Const GL_SHADING_LANGUAGE_VERSION             = &H8B8C&
Public Const GL_CURRENT_PROGRAM                      = &H8B8D&
Public Const GL_POINT_SPRITE_COORD_ORIGIN            = &H8CA0&
Public Const GL_LOWER_LEFT                           = &H8CA1&
Public Const GL_UPPER_LEFT                           = &H8CA2&
Public Const GL_STENCIL_BACK_REF                     = &H8CA3&
Public Const GL_STENCIL_BACK_VALUE_MASK              = &H8CA4&
Public Const GL_STENCIL_BACK_WRITEMASK               = &H8CA5&
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glAttachShaderPtr, glBindAttribLocationPtr, glBlendEquationSeparatePtr, glCompileShaderPtr, glCreateProgramPtr, glCreateShaderPtr, glDeleteProgramPtr, glDeleteShaderPtr, glDetachShaderPtr, _
glDisableVertexAttribArrayPtr, glDrawBuffersPtr, glEnableVertexAttribArrayPtr, glGetActiveAttribPtr, glGetActiveUniformPtr, glGetAttachedShadersPtr, glGetAttribLocationPtr, glGetProgramInfoLogPtr, glGetProgramivPtr, glGetShaderInfoLogPtr, _
glGetShaderSourcePtr, glGetShaderivPtr, glGetUniformLocationPtr, glGetUniformfvPtr, glGetUniformivPtr, glGetVertexAttribPointervPtr, glGetVertexAttribdvPtr, glGetVertexAttribfvPtr, glGetVertexAttribivPtr, glIsProgramPtr, _
glIsShaderPtr, glLinkProgramPtr, glShaderSourcePtr, glStencilFuncSeparatePtr, glStencilMaskSeparatePtr, glStencilOpSeparatePtr, glUniform1fPtr, glUniform1fvPtr, glUniform1iPtr, glUniform1ivPtr, _
glUniform2fPtr, glUniform2fvPtr, glUniform2iPtr, glUniform2ivPtr, glUniform3fPtr, glUniform3fvPtr, glUniform3iPtr, glUniform3ivPtr, glUniform4fPtr, glUniform4fvPtr, _
glUniform4iPtr, glUniform4ivPtr, glUniformMatrix2fvPtr, glUniformMatrix3fvPtr, glUniformMatrix4fvPtr, glUseProgramPtr, glValidateProgramPtr, glVertexAttrib1dPtr, glVertexAttrib1dvPtr, glVertexAttrib1fPtr, _
glVertexAttrib1fvPtr, glVertexAttrib1sPtr, glVertexAttrib1svPtr, glVertexAttrib2dPtr, glVertexAttrib2dvPtr, glVertexAttrib2fPtr, glVertexAttrib2fvPtr, glVertexAttrib2sPtr, glVertexAttrib2svPtr, glVertexAttrib3dPtr, _
glVertexAttrib3dvPtr, glVertexAttrib3fPtr, glVertexAttrib3fvPtr, glVertexAttrib3sPtr, glVertexAttrib3svPtr, glVertexAttrib4NbvPtr, glVertexAttrib4NivPtr, glVertexAttrib4NsvPtr, glVertexAttrib4NubPtr, glVertexAttrib4NubvPtr, _
glVertexAttrib4NuivPtr, glVertexAttrib4NusvPtr, glVertexAttrib4bvPtr, glVertexAttrib4dPtr, glVertexAttrib4dvPtr, glVertexAttrib4fPtr, glVertexAttrib4fvPtr, glVertexAttrib4ivPtr, glVertexAttrib4sPtr, glVertexAttrib4svPtr, _
glVertexAttrib4ubvPtr, glVertexAttrib4uivPtr, glVertexAttrib4usvPtr, glVertexAttribPointerPtr
'------------------------------- GL_VERSION_2_0 -------------------------------
Public Sub glAttachShader(ByVal program As Long, ByVal shader As Long)                                                                                                : Call OpenGLExtCall2(glAttachShaderPtr, vbEmpty, program, shader): End Sub
Public Sub glBindAttribLocation(ByVal program As Long, ByVal index As Long, ByVal name)                                                                               : Call OpenGLExtCall3(glBindAttribLocationPtr, vbEmpty, program, index, name): End Sub
Public Sub glBlendEquationSeparate(ByVal modeRGB As Long, ByVal modeAlpha As Long)                                                                                    : Call OpenGLExtCall2(glBlendEquationSeparatePtr, vbEmpty, modeRGB, modeAlpha): End Sub
Public Sub glCompileShader(ByVal shader As Long)                                                                                                                      : Call OpenGLExtCall1(glCompileShaderPtr, vbEmpty, shader): End Sub
Public Function glCreateProgram() As Long                                                                                                                             : glCreateProgram = OpenGLExtCall0(glCreateProgramPtr, vbLong): End Function
Public Function glCreateShader(ByVal ptype As Long) As Long                                                                                                           : glCreateShader = OpenGLExtCall1(glCreateShaderPtr, vbLong, ptype): End Function
Public Sub glDeleteProgram(ByVal program As Long)                                                                                                                     : Call OpenGLExtCall1(glDeleteProgramPtr, vbEmpty, program): End Sub
Public Sub glDeleteShader(ByVal shader As Long)                                                                                                                       : Call OpenGLExtCall1(glDeleteShaderPtr, vbEmpty, shader): End Sub
Public Sub glDetachShader(ByVal program As Long, ByVal shader As Long)                                                                                                : Call OpenGLExtCall2(glDetachShaderPtr, vbEmpty, program, shader): End Sub
Public Sub glDisableVertexAttribArray(ByVal index As Long)                                                                                                            : Call OpenGLExtCall1(glDisableVertexAttribArrayPtr, vbEmpty, index): End Sub
Public Sub glDrawBuffers(ByVal n As Long, bufs As Long)                                                                                                               : Call OpenGLExtCall2(glDrawBuffersPtr, vbEmpty, n, VarPtr(bufs)): End Sub
Public Sub glEnableVertexAttribArray(ByVal index As Long)                                                                                                             : Call OpenGLExtCall1(glEnableVertexAttribArrayPtr, vbEmpty, index): End Sub
Public Sub glGetActiveAttrib(ByVal program As Long, ByVal index As Long, ByVal maxLength As Long, length As Long, size As Long, ptype As Long, ByVal name)            : Call OpenGLExtCall7(glGetActiveAttribPtr, vbEmpty, program, index, maxLength, VarPtr(length), VarPtr(size), VarPtr(ptype), name): End Sub
Public Sub glGetActiveUniform(ByVal program As Long, ByVal index As Long, ByVal maxLength As Long, length As Long, size As Long, ptype As Long, ByVal name)           : Call OpenGLExtCall7(glGetActiveUniformPtr, vbEmpty, program, index, maxLength, VarPtr(length), VarPtr(size), VarPtr(ptype), name): End Sub
Public Sub glGetAttachedShaders(ByVal program As Long, ByVal maxCount As Long, count As Long, shaders As Long)                                                        : Call OpenGLExtCall4(glGetAttachedShadersPtr, vbEmpty, program, maxCount, VarPtr(count), VarPtr(shaders)): End Sub
Public Function glGetAttribLocation(ByVal program As Long, ByVal name) As Long                                                                                        : glGetAttribLocation = OpenGLExtCall2(glGetAttribLocationPtr, vbLong, program, name): End Function
Public Sub glGetProgramInfoLog(ByVal program As Long, ByVal bufSize As Long, length As Long, ByVal infoLog)                                                           : Call OpenGLExtCall4(glGetProgramInfoLogPtr, vbEmpty, program, bufSize, VarPtr(length), infoLog): End Sub
Public Sub glGetProgramiv(ByVal program As Long, ByVal pname As Long, param As Long)                                                                                  : Call OpenGLExtCall3(glGetProgramivPtr, vbEmpty, program, pname, VarPtr(param)): End Sub
Public Sub glGetShaderInfoLog(ByVal shader As Long, ByVal bufSize As Long, length As Long, ByVal infoLog)                                                             : Call OpenGLExtCall4(glGetShaderInfoLogPtr, vbEmpty, shader, bufSize, VarPtr(length), infoLog): End Sub
Public Sub glGetShaderSource(ByVal obj As Long, ByVal maxLength As Long, length As Long, ByVal source)                                                                : Call OpenGLExtCall4(glGetShaderSourcePtr, vbEmpty, obj, maxLength, VarPtr(length), source): End Sub
Public Sub glGetShaderiv(ByVal shader As Long, ByVal pname As Long, param As Long)                                                                                    : Call OpenGLExtCall3(glGetShaderivPtr, vbEmpty, shader, pname, VarPtr(param)): End Sub
Public Function glGetUniformLocation(ByVal program As Long, ByVal name) As Long                                                                                       : glGetUniformLocation = OpenGLExtCall2(glGetUniformLocationPtr, vbLong, program, name): End Function
Public Sub glGetUniformfv(ByVal program As Long, ByVal location As Long, params As Single)                                                                            : Call OpenGLExtCall3(glGetUniformfvPtr, vbEmpty, program, location, VarPtr(params)): End Sub
Public Sub glGetUniformiv(ByVal program As Long, ByVal location As Long, params As Long)                                                                              : Call OpenGLExtCall3(glGetUniformivPtr, vbEmpty, program, location, VarPtr(params)): End Sub
Public Sub glGetVertexAttribPointerv(ByVal index As Long, ByVal pname As Long, ByVal pointer)                                                                         : Call OpenGLExtCall3(glGetVertexAttribPointervPtr, vbEmpty, index, pname, pointer): End Sub
Public Sub glGetVertexAttribdv(ByVal index As Long, ByVal pname As Long, params As Double)                                                                            : Call OpenGLExtCall3(glGetVertexAttribdvPtr, vbEmpty, index, pname, VarPtr(params)): End Sub
Public Sub glGetVertexAttribfv(ByVal index As Long, ByVal pname As Long, params As Single)                                                                            : Call OpenGLExtCall3(glGetVertexAttribfvPtr, vbEmpty, index, pname, VarPtr(params)): End Sub
Public Sub glGetVertexAttribiv(ByVal index As Long, ByVal pname As Long, params As Long)                                                                              : Call OpenGLExtCall3(glGetVertexAttribivPtr, vbEmpty, index, pname, VarPtr(params)): End Sub
Public Function glIsProgram(ByVal program As Long) As Integer                                                                                                         : glIsProgram = OpenGLExtCall1(glIsProgramPtr, vbInteger, program): End Function
Public Function glIsShader(ByVal shader As Long) As Integer                                                                                                           : glIsShader = OpenGLExtCall1(glIsShaderPtr, vbInteger, shader): End Function
Public Sub glLinkProgram(ByVal program As Long)                                                                                                                       : Call OpenGLExtCall1(glLinkProgramPtr, vbEmpty, program): End Sub
Public Sub glShaderSource(ByVal shader As Long, ByVal count As Long, ByVal pstring, length As Long)                                                                   : Call OpenGLExtCall4(glShaderSourcePtr, vbEmpty, shader, count, pstring, VarPtr(length)): End Sub
Public Sub glStencilFuncSeparate(ByVal frontfunc As Long, ByVal backfunc As Long, ByVal ref As Long, ByVal mask As Long)                                              : Call OpenGLExtCall4(glStencilFuncSeparatePtr, vbEmpty, frontfunc, backfunc, ref, mask): End Sub
Public Sub glStencilMaskSeparate(ByVal face As Long, ByVal mask As Long)                                                                                              : Call OpenGLExtCall2(glStencilMaskSeparatePtr, vbEmpty, face, mask): End Sub
Public Sub glStencilOpSeparate(ByVal face As Long, ByVal sfail As Long, ByVal dpfail As Long, ByVal dppass As Long)                                                   : Call OpenGLExtCall4(glStencilOpSeparatePtr, vbEmpty, face, sfail, dpfail, dppass): End Sub
Public Sub glUniform1f(ByVal location As Long, ByVal v0 As Single)                                                                                                    : Call OpenGLExtCall2(glUniform1fPtr, vbEmpty, location, v0): End Sub
Public Sub glUniform1fv(ByVal location As Long, ByVal count As Long, value As Single)                                                                                 : Call OpenGLExtCall3(glUniform1fvPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform1i(ByVal location As Long, ByVal v0 As Long)                                                                                                      : Call OpenGLExtCall2(glUniform1iPtr, vbEmpty, location, v0): End Sub
Public Sub glUniform1iv(ByVal location As Long, ByVal count As Long, value As Long)                                                                                   : Call OpenGLExtCall3(glUniform1ivPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform2f(ByVal location As Long, ByVal v0 As Single, ByVal v1 As Single)                                                                                : Call OpenGLExtCall3(glUniform2fPtr, vbEmpty, location, v0, v1): End Sub
Public Sub glUniform2fv(ByVal location As Long, ByVal count As Long, value As Single)                                                                                 : Call OpenGLExtCall3(glUniform2fvPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform2i(ByVal location As Long, ByVal v0 As Long, ByVal v1 As Long)                                                                                    : Call OpenGLExtCall3(glUniform2iPtr, vbEmpty, location, v0, v1): End Sub
Public Sub glUniform2iv(ByVal location As Long, ByVal count As Long, value As Long)                                                                                   : Call OpenGLExtCall3(glUniform2ivPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform3f(ByVal location As Long, ByVal v0 As Single, ByVal v1 As Single, ByVal v2 As Single)                                                            : Call OpenGLExtCall4(glUniform3fPtr, vbEmpty, location, v0, v1, v2): End Sub
Public Sub glUniform3fv(ByVal location As Long, ByVal count As Long, value As Single)                                                                                 : Call OpenGLExtCall3(glUniform3fvPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform3i(ByVal location As Long, ByVal v0 As Long, ByVal v1 As Long, ByVal v2 As Long)                                                                  : Call OpenGLExtCall4(glUniform3iPtr, vbEmpty, location, v0, v1, v2): End Sub
Public Sub glUniform3iv(ByVal location As Long, ByVal count As Long, value As Long)                                                                                   : Call OpenGLExtCall3(glUniform3ivPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform4f(ByVal location As Long, ByVal v0 As Single, ByVal v1 As Single, ByVal v2 As Single, ByVal v3 As Single)                                        : Call OpenGLExtCall5(glUniform4fPtr, vbEmpty, location, v0, v1, v2, v3): End Sub
Public Sub glUniform4fv(ByVal location As Long, ByVal count As Long, value As Single)                                                                                 : Call OpenGLExtCall3(glUniform4fvPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform4i(ByVal location As Long, ByVal v0 As Long, ByVal v1 As Long, ByVal v2 As Long, ByVal v3 As Long)                                                : Call OpenGLExtCall5(glUniform4iPtr, vbEmpty, location, v0, v1, v2, v3): End Sub
Public Sub glUniform4iv(ByVal location As Long, ByVal count As Long, value As Long)                                                                                   : Call OpenGLExtCall3(glUniform4ivPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniformMatrix2fv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single)                                               : Call OpenGLExtCall4(glUniformMatrix2fvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix3fv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single)                                               : Call OpenGLExtCall4(glUniformMatrix3fvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix4fv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single)                                               : Call OpenGLExtCall4(glUniformMatrix4fvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUseProgram(ByVal program As Long)                                                                                                                        : Call OpenGLExtCall1(glUseProgramPtr, vbEmpty, program): End Sub
Public Sub glValidateProgram(ByVal program As Long)                                                                                                                   : Call OpenGLExtCall1(glValidateProgramPtr, vbEmpty, program): End Sub
Public Sub glVertexAttrib1d(ByVal index As Long, ByVal X As Double)                                                                                                   : Call OpenGLExtCall2(glVertexAttrib1dPtr, vbEmpty, index, X): End Sub
Public Sub glVertexAttrib1dv(ByVal index As Long, v As Double)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib1dvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib1f(ByVal index As Long, ByVal X As Single)                                                                                                   : Call OpenGLExtCall2(glVertexAttrib1fPtr, vbEmpty, index, X): End Sub
Public Sub glVertexAttrib1fv(ByVal index As Long, v As Single)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib1fvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib1s(ByVal index As Long, ByVal X As Integer)                                                                                                  : Call OpenGLExtCall2(glVertexAttrib1sPtr, vbEmpty, index, X): End Sub
Public Sub glVertexAttrib1sv(ByVal index As Long, v As Integer)                                                                                                       : Call OpenGLExtCall2(glVertexAttrib1svPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib2d(ByVal index As Long, ByVal X As Double, ByVal y As Double)                                                                                : Call OpenGLExtCall3(glVertexAttrib2dPtr, vbEmpty, index, X, y): End Sub
Public Sub glVertexAttrib2dv(ByVal index As Long, v As Double)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib2dvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib2f(ByVal index As Long, ByVal X As Single, ByVal y As Single)                                                                                : Call OpenGLExtCall3(glVertexAttrib2fPtr, vbEmpty, index, X, y): End Sub
Public Sub glVertexAttrib2fv(ByVal index As Long, v As Single)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib2fvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib2s(ByVal index As Long, ByVal X As Integer, ByVal y As Integer)                                                                              : Call OpenGLExtCall3(glVertexAttrib2sPtr, vbEmpty, index, X, y): End Sub
Public Sub glVertexAttrib2sv(ByVal index As Long, v As Integer)                                                                                                       : Call OpenGLExtCall2(glVertexAttrib2svPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib3d(ByVal index As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double)                                                             : Call OpenGLExtCall4(glVertexAttrib3dPtr, vbEmpty, index, X, y, z): End Sub
Public Sub glVertexAttrib3dv(ByVal index As Long, v As Double)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib3dvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib3f(ByVal index As Long, ByVal X As Single, ByVal y As Single, ByVal z As Single)                                                             : Call OpenGLExtCall4(glVertexAttrib3fPtr, vbEmpty, index, X, y, z): End Sub
Public Sub glVertexAttrib3fv(ByVal index As Long, v As Single)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib3fvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib3s(ByVal index As Long, ByVal X As Integer, ByVal y As Integer, ByVal z As Integer)                                                          : Call OpenGLExtCall4(glVertexAttrib3sPtr, vbEmpty, index, X, y, z): End Sub
Public Sub glVertexAttrib3sv(ByVal index As Long, v As Integer)                                                                                                       : Call OpenGLExtCall2(glVertexAttrib3svPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4Nbv(ByVal index As Long, v As Byte)                                                                                                         : Call OpenGLExtCall2(glVertexAttrib4NbvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4Niv(ByVal index As Long, v As Long)                                                                                                         : Call OpenGLExtCall2(glVertexAttrib4NivPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4Nsv(ByVal index As Long, v As Integer)                                                                                                      : Call OpenGLExtCall2(glVertexAttrib4NsvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4Nub(ByVal index As Long, ByVal X As Byte, ByVal y As Byte, ByVal z As Byte, ByVal w As Byte)                                                : Call OpenGLExtCall5(glVertexAttrib4NubPtr, vbEmpty, index, X, y, z, w): End Sub
Public Sub glVertexAttrib4Nubv(ByVal index As Long, v As Byte)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib4NubvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4Nuiv(ByVal index As Long, v As Long)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib4NuivPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4Nusv(ByVal index As Long, v As Long)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib4NusvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4bv(ByVal index As Long, v As Byte)                                                                                                          : Call OpenGLExtCall2(glVertexAttrib4bvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4d(ByVal index As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double, ByVal w As Double)                                          : Call OpenGLExtCall5(glVertexAttrib4dPtr, vbEmpty, index, X, y, z, w): End Sub
Public Sub glVertexAttrib4dv(ByVal index As Long, v As Double)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib4dvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4f(ByVal index As Long, ByVal X As Single, ByVal y As Single, ByVal z As Single, ByVal w As Single)                                          : Call OpenGLExtCall5(glVertexAttrib4fPtr, vbEmpty, index, X, y, z, w): End Sub
Public Sub glVertexAttrib4fv(ByVal index As Long, v As Single)                                                                                                        : Call OpenGLExtCall2(glVertexAttrib4fvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4iv(ByVal index As Long, v As Long)                                                                                                          : Call OpenGLExtCall2(glVertexAttrib4ivPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4s(ByVal index As Long, ByVal X As Integer, ByVal y As Integer, ByVal z As Integer, ByVal w As Integer)                                      : Call OpenGLExtCall5(glVertexAttrib4sPtr, vbEmpty, index, X, y, z, w): End Sub
Public Sub glVertexAttrib4sv(ByVal index As Long, v As Integer)                                                                                                       : Call OpenGLExtCall2(glVertexAttrib4svPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4ubv(ByVal index As Long, v As Byte)                                                                                                         : Call OpenGLExtCall2(glVertexAttrib4ubvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4uiv(ByVal index As Long, v As Long)                                                                                                         : Call OpenGLExtCall2(glVertexAttrib4uivPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4usv(ByVal index As Long, v As Long)                                                                                                         : Call OpenGLExtCall2(glVertexAttrib4usvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttribPointer(ByVal index As Long, ByVal size As Long, ByVal ptype As Long, ByVal normalized As Integer, ByVal stride As Long, ByVal pointer)      : Call OpenGLExtCall6(glVertexAttribPointerPtr, vbEmpty, index, size, ptype, normalized, stride, pointer): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL2_0()
    If IsDEPEnabled Then
        glVertexAttribPointerPtr = OpenGLExtProcAddress("glVertexAttribPointer")
        glVertexAttrib4usvPtr = OpenGLExtProcAddress("glVertexAttrib4usv")
        glVertexAttrib4uivPtr = OpenGLExtProcAddress("glVertexAttrib4uiv")
        glVertexAttrib4ubvPtr = OpenGLExtProcAddress("glVertexAttrib4ubv")
        glVertexAttrib4svPtr = OpenGLExtProcAddress("glVertexAttrib4sv")
        glVertexAttrib4sPtr = OpenGLExtProcAddress("glVertexAttrib4s")
        glVertexAttrib4ivPtr = OpenGLExtProcAddress("glVertexAttrib4iv")
        glVertexAttrib4fvPtr = OpenGLExtProcAddress("glVertexAttrib4fv")
        glVertexAttrib4fPtr = OpenGLExtProcAddress("glVertexAttrib4f")
        glVertexAttrib4dvPtr = OpenGLExtProcAddress("glVertexAttrib4dv")
        glVertexAttrib4dPtr = OpenGLExtProcAddress("glVertexAttrib4d")
        glVertexAttrib4bvPtr = OpenGLExtProcAddress("glVertexAttrib4bv")
        glVertexAttrib4NusvPtr = OpenGLExtProcAddress("glVertexAttrib4Nusv")
        glVertexAttrib4NuivPtr = OpenGLExtProcAddress("glVertexAttrib4Nuiv")
        glVertexAttrib4NubvPtr = OpenGLExtProcAddress("glVertexAttrib4Nubv")
        glVertexAttrib4NubPtr = OpenGLExtProcAddress("glVertexAttrib4Nub")
        glVertexAttrib4NsvPtr = OpenGLExtProcAddress("glVertexAttrib4Nsv")
        glVertexAttrib4NivPtr = OpenGLExtProcAddress("glVertexAttrib4Niv")
        glVertexAttrib4NbvPtr = OpenGLExtProcAddress("glVertexAttrib4Nbv")
        glVertexAttrib3svPtr = OpenGLExtProcAddress("glVertexAttrib3sv")
        glVertexAttrib3sPtr = OpenGLExtProcAddress("glVertexAttrib3s")
        glVertexAttrib3fvPtr = OpenGLExtProcAddress("glVertexAttrib3fv")
        glVertexAttrib3fPtr = OpenGLExtProcAddress("glVertexAttrib3f")
        glVertexAttrib3dvPtr = OpenGLExtProcAddress("glVertexAttrib3dv")
        glVertexAttrib3dPtr = OpenGLExtProcAddress("glVertexAttrib3d")
        glVertexAttrib2svPtr = OpenGLExtProcAddress("glVertexAttrib2sv")
        glVertexAttrib2sPtr = OpenGLExtProcAddress("glVertexAttrib2s")
        glVertexAttrib2fvPtr = OpenGLExtProcAddress("glVertexAttrib2fv")
        glVertexAttrib2fPtr = OpenGLExtProcAddress("glVertexAttrib2f")
        glVertexAttrib2dvPtr = OpenGLExtProcAddress("glVertexAttrib2dv")
        glVertexAttrib2dPtr = OpenGLExtProcAddress("glVertexAttrib2d")
        glVertexAttrib1svPtr = OpenGLExtProcAddress("glVertexAttrib1sv")
        glVertexAttrib1sPtr = OpenGLExtProcAddress("glVertexAttrib1s")
        glVertexAttrib1fvPtr = OpenGLExtProcAddress("glVertexAttrib1fv")
        glVertexAttrib1fPtr = OpenGLExtProcAddress("glVertexAttrib1f")
        glVertexAttrib1dvPtr = OpenGLExtProcAddress("glVertexAttrib1dv")
        glVertexAttrib1dPtr = OpenGLExtProcAddress("glVertexAttrib1d")
        glValidateProgramPtr = OpenGLExtProcAddress("glValidateProgram")
        glUseProgramPtr = OpenGLExtProcAddress("glUseProgram")
        glUniformMatrix4fvPtr = OpenGLExtProcAddress("glUniformMatrix4fv")
        glUniformMatrix3fvPtr = OpenGLExtProcAddress("glUniformMatrix3fv")
        glUniformMatrix2fvPtr = OpenGLExtProcAddress("glUniformMatrix2fv")
        glUniform4ivPtr = OpenGLExtProcAddress("glUniform4iv")
        glUniform4iPtr = OpenGLExtProcAddress("glUniform4i")
        glUniform4fvPtr = OpenGLExtProcAddress("glUniform4fv")
        glUniform4fPtr = OpenGLExtProcAddress("glUniform4f")
        glUniform3ivPtr = OpenGLExtProcAddress("glUniform3iv")
        glUniform3iPtr = OpenGLExtProcAddress("glUniform3i")
        glUniform3fvPtr = OpenGLExtProcAddress("glUniform3fv")
        glUniform3fPtr = OpenGLExtProcAddress("glUniform3f")
        glUniform2ivPtr = OpenGLExtProcAddress("glUniform2iv")
        glUniform2iPtr = OpenGLExtProcAddress("glUniform2i")
        glUniform2fvPtr = OpenGLExtProcAddress("glUniform2fv")
        glUniform2fPtr = OpenGLExtProcAddress("glUniform2f")
        glUniform1ivPtr = OpenGLExtProcAddress("glUniform1iv")
        glUniform1iPtr = OpenGLExtProcAddress("glUniform1i")
        glUniform1fvPtr = OpenGLExtProcAddress("glUniform1fv")
        glUniform1fPtr = OpenGLExtProcAddress("glUniform1f")
        glStencilOpSeparatePtr = OpenGLExtProcAddress("glStencilOpSeparate")
        glStencilMaskSeparatePtr = OpenGLExtProcAddress("glStencilMaskSeparate")
        glStencilFuncSeparatePtr = OpenGLExtProcAddress("glStencilFuncSeparate")
        glShaderSourcePtr = OpenGLExtProcAddress("glShaderSource")
        glLinkProgramPtr = OpenGLExtProcAddress("glLinkProgram")
        glIsShaderPtr = OpenGLExtProcAddress("glIsShader")
        glIsProgramPtr = OpenGLExtProcAddress("glIsProgram")
        glGetVertexAttribivPtr = OpenGLExtProcAddress("glGetVertexAttribiv")
        glGetVertexAttribfvPtr = OpenGLExtProcAddress("glGetVertexAttribfv")
        glGetVertexAttribdvPtr = OpenGLExtProcAddress("glGetVertexAttribdv")
        glGetVertexAttribPointervPtr = OpenGLExtProcAddress("glGetVertexAttribPointerv")
        glGetUniformivPtr = OpenGLExtProcAddress("glGetUniformiv")
        glGetUniformfvPtr = OpenGLExtProcAddress("glGetUniformfv")
        glGetUniformLocationPtr = OpenGLExtProcAddress("glGetUniformLocation")
        glGetShaderivPtr = OpenGLExtProcAddress("glGetShaderiv")
        glGetShaderSourcePtr = OpenGLExtProcAddress("glGetShaderSource")
        glGetShaderInfoLogPtr = OpenGLExtProcAddress("glGetShaderInfoLog")
        glGetProgramivPtr = OpenGLExtProcAddress("glGetProgramiv")
        glGetProgramInfoLogPtr = OpenGLExtProcAddress("glGetProgramInfoLog")
        glGetAttribLocationPtr = OpenGLExtProcAddress("glGetAttribLocation")
        glGetAttachedShadersPtr = OpenGLExtProcAddress("glGetAttachedShaders")
        glGetActiveUniformPtr = OpenGLExtProcAddress("glGetActiveUniform")
        glGetActiveAttribPtr = OpenGLExtProcAddress("glGetActiveAttrib")
        glEnableVertexAttribArrayPtr = OpenGLExtProcAddress("glEnableVertexAttribArray")
        glDrawBuffersPtr = OpenGLExtProcAddress("glDrawBuffers")
        glDisableVertexAttribArrayPtr = OpenGLExtProcAddress("glDisableVertexAttribArray")
        glDetachShaderPtr = OpenGLExtProcAddress("glDetachShader")
        glDeleteShaderPtr = OpenGLExtProcAddress("glDeleteShader")
        glDeleteProgramPtr = OpenGLExtProcAddress("glDeleteProgram")
        glCreateShaderPtr = OpenGLExtProcAddress("glCreateShader")
        glCreateProgramPtr = OpenGLExtProcAddress("glCreateProgram")
        glCompileShaderPtr = OpenGLExtProcAddress("glCompileShader")
        glBlendEquationSeparatePtr = OpenGLExtProcAddress("glBlendEquationSeparate")
        glBindAttribLocationPtr = OpenGLExtProcAddress("glBindAttribLocation")
        glAttachShaderPtr = OpenGLExtProcAddress("glAttachShader")
    Else
        RemapVBFunctionToGLFunction AddressOf glVertexAttribPointer, "glVertexAttribPointer"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4usv, "glVertexAttrib4usv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4uiv, "glVertexAttrib4uiv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4ubv, "glVertexAttrib4ubv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4sv, "glVertexAttrib4sv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4s, "glVertexAttrib4s"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4iv, "glVertexAttrib4iv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4fv, "glVertexAttrib4fv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4f, "glVertexAttrib4f"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4dv, "glVertexAttrib4dv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4d, "glVertexAttrib4d"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4bv, "glVertexAttrib4bv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4Nusv, "glVertexAttrib4Nusv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4Nuiv, "glVertexAttrib4Nuiv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4Nubv, "glVertexAttrib4Nubv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4Nub, "glVertexAttrib4Nub"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4Nsv, "glVertexAttrib4Nsv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4Niv, "glVertexAttrib4Niv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib4Nbv, "glVertexAttrib4Nbv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib3sv, "glVertexAttrib3sv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib3s, "glVertexAttrib3s"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib3fv, "glVertexAttrib3fv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib3f, "glVertexAttrib3f"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib3dv, "glVertexAttrib3dv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib3d, "glVertexAttrib3d"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib2sv, "glVertexAttrib2sv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib2s, "glVertexAttrib2s"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib2fv, "glVertexAttrib2fv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib2f, "glVertexAttrib2f"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib2dv, "glVertexAttrib2dv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib2d, "glVertexAttrib2d"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib1sv, "glVertexAttrib1sv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib1s, "glVertexAttrib1s"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib1fv, "glVertexAttrib1fv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib1f, "glVertexAttrib1f"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib1dv, "glVertexAttrib1dv"
        RemapVBFunctionToGLFunction AddressOf glVertexAttrib1d, "glVertexAttrib1d"
        RemapVBFunctionToGLFunction AddressOf glValidateProgram, "glValidateProgram"
        RemapVBFunctionToGLFunction AddressOf glUseProgram, "glUseProgram"
        RemapVBFunctionToGLFunction AddressOf glUniformMatrix4fv, "glUniformMatrix4fv"
        RemapVBFunctionToGLFunction AddressOf glUniformMatrix3fv, "glUniformMatrix3fv"
        RemapVBFunctionToGLFunction AddressOf glUniformMatrix2fv, "glUniformMatrix2fv"
        RemapVBFunctionToGLFunction AddressOf glUniform4iv, "glUniform4iv"
        RemapVBFunctionToGLFunction AddressOf glUniform4i, "glUniform4i"
        RemapVBFunctionToGLFunction AddressOf glUniform4fv, "glUniform4fv"
        RemapVBFunctionToGLFunction AddressOf glUniform4f, "glUniform4f"
        RemapVBFunctionToGLFunction AddressOf glUniform3iv, "glUniform3iv"
        RemapVBFunctionToGLFunction AddressOf glUniform3i, "glUniform3i"
        RemapVBFunctionToGLFunction AddressOf glUniform3fv, "glUniform3fv"
        RemapVBFunctionToGLFunction AddressOf glUniform3f, "glUniform3f"
        RemapVBFunctionToGLFunction AddressOf glUniform2iv, "glUniform2iv"
        RemapVBFunctionToGLFunction AddressOf glUniform2i, "glUniform2i"
        RemapVBFunctionToGLFunction AddressOf glUniform2fv, "glUniform2fv"
        RemapVBFunctionToGLFunction AddressOf glUniform2f, "glUniform2f"
        RemapVBFunctionToGLFunction AddressOf glUniform1iv, "glUniform1iv"
        RemapVBFunctionToGLFunction AddressOf glUniform1i, "glUniform1i"
        RemapVBFunctionToGLFunction AddressOf glUniform1fv, "glUniform1fv"
        RemapVBFunctionToGLFunction AddressOf glUniform1f, "glUniform1f"
        RemapVBFunctionToGLFunction AddressOf glStencilOpSeparate, "glStencilOpSeparate"
        RemapVBFunctionToGLFunction AddressOf glStencilMaskSeparate, "glStencilMaskSeparate"
        RemapVBFunctionToGLFunction AddressOf glStencilFuncSeparate, "glStencilFuncSeparate"
        RemapVBFunctionToGLFunction AddressOf glShaderSource, "glShaderSource"
        RemapVBFunctionToGLFunction AddressOf glLinkProgram, "glLinkProgram"
        RemapVBFunctionToGLFunction AddressOf glIsShader, "glIsShader"
        RemapVBFunctionToGLFunction AddressOf glIsProgram, "glIsProgram"
        RemapVBFunctionToGLFunction AddressOf glGetVertexAttribiv, "glGetVertexAttribiv"
        RemapVBFunctionToGLFunction AddressOf glGetVertexAttribfv, "glGetVertexAttribfv"
        RemapVBFunctionToGLFunction AddressOf glGetVertexAttribdv, "glGetVertexAttribdv"
        RemapVBFunctionToGLFunction AddressOf glGetVertexAttribPointerv, "glGetVertexAttribPointerv"
        RemapVBFunctionToGLFunction AddressOf glGetUniformiv, "glGetUniformiv"
        RemapVBFunctionToGLFunction AddressOf glGetUniformfv, "glGetUniformfv"
        RemapVBFunctionToGLFunction AddressOf glGetUniformLocation, "glGetUniformLocation"
        RemapVBFunctionToGLFunction AddressOf glGetShaderiv, "glGetShaderiv"
        RemapVBFunctionToGLFunction AddressOf glGetShaderSource, "glGetShaderSource"
        RemapVBFunctionToGLFunction AddressOf glGetShaderInfoLog, "glGetShaderInfoLog"
        RemapVBFunctionToGLFunction AddressOf glGetProgramiv, "glGetProgramiv"
        RemapVBFunctionToGLFunction AddressOf glGetProgramInfoLog, "glGetProgramInfoLog"
        RemapVBFunctionToGLFunction AddressOf glGetAttribLocation, "glGetAttribLocation"
        RemapVBFunctionToGLFunction AddressOf glGetAttachedShaders, "glGetAttachedShaders"
        RemapVBFunctionToGLFunction AddressOf glGetActiveUniform, "glGetActiveUniform"
        RemapVBFunctionToGLFunction AddressOf glGetActiveAttrib, "glGetActiveAttrib"
        RemapVBFunctionToGLFunction AddressOf glEnableVertexAttribArray, "glEnableVertexAttribArray"
        RemapVBFunctionToGLFunction AddressOf glDrawBuffers, "glDrawBuffers"
        RemapVBFunctionToGLFunction AddressOf glDisableVertexAttribArray, "glDisableVertexAttribArray"
        RemapVBFunctionToGLFunction AddressOf glDetachShader, "glDetachShader"
        RemapVBFunctionToGLFunction AddressOf glDeleteShader, "glDeleteShader"
        RemapVBFunctionToGLFunction AddressOf glDeleteProgram, "glDeleteProgram"
        RemapVBFunctionToGLFunction AddressOf glCreateShader, "glCreateShader"
        RemapVBFunctionToGLFunction AddressOf glCreateProgram, "glCreateProgram"
        RemapVBFunctionToGLFunction AddressOf glCompileShader, "glCompileShader"
        RemapVBFunctionToGLFunction AddressOf glBlendEquationSeparate, "glBlendEquationSeparate"
        RemapVBFunctionToGLFunction AddressOf glBindAttribLocation, "glBindAttribLocation"
        RemapVBFunctionToGLFunction AddressOf glAttachShader, "glAttachShader"
    End If
End Function