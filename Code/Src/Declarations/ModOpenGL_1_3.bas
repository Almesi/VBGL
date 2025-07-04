Attribute VB_Name = "ModOpenGL_1_3"
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
'------------------------------- GL_VERSION_1_3 -------------------------------
Public Const GL_MULTISAMPLE                    = &H809D&
Public Const GL_SAMPLE_ALPHA_TO_COVERAGE       = &H809E&
Public Const GL_SAMPLE_ALPHA_TO_ONE            = &H809F&
Public Const GL_SAMPLE_COVERAGE                = &H80A0&
Public Const GL_SAMPLE_BUFFERS                 = &H80A8&
Public Const GL_SAMPLES                        = &H80A9&
Public Const GL_SAMPLE_COVERAGE_VALUE          = &H80AA&
Public Const GL_SAMPLE_COVERAGE_INVERT         = &H80AB&
Public Const GL_CLAMP_TO_BORDER                = &H812D&
Public Const GL_TEXTURE0                       = &H84C0&
Public Const GL_TEXTURE1                       = &H84C1&
Public Const GL_TEXTURE2                       = &H84C2&
Public Const GL_TEXTURE3                       = &H84C3&
Public Const GL_TEXTURE4                       = &H84C4&
Public Const GL_TEXTURE5                       = &H84C5&
Public Const GL_TEXTURE6                       = &H84C6&
Public Const GL_TEXTURE7                       = &H84C7&
Public Const GL_TEXTURE8                       = &H84C8&
Public Const GL_TEXTURE9                       = &H84C9&
Public Const GL_TEXTURE10                      = &H84CA&
Public Const GL_TEXTURE11                      = &H84CB&
Public Const GL_TEXTURE12                      = &H84CC&
Public Const GL_TEXTURE13                      = &H84CD&
Public Const GL_TEXTURE14                      = &H84CE&
Public Const GL_TEXTURE15                      = &H84CF&
Public Const GL_TEXTURE16                      = &H84D0&
Public Const GL_TEXTURE17                      = &H84D1&
Public Const GL_TEXTURE18                      = &H84D2&
Public Const GL_TEXTURE19                      = &H84D3&
Public Const GL_TEXTURE20                      = &H84D4&
Public Const GL_TEXTURE21                      = &H84D5&
Public Const GL_TEXTURE22                      = &H84D6&
Public Const GL_TEXTURE23                      = &H84D7&
Public Const GL_TEXTURE24                      = &H84D8&
Public Const GL_TEXTURE25                      = &H84D9&
Public Const GL_TEXTURE26                      = &H84DA&
Public Const GL_TEXTURE27                      = &H84DB&
Public Const GL_TEXTURE28                      = &H84DC&
Public Const GL_TEXTURE29                      = &H84DD&
Public Const GL_TEXTURE30                      = &H84DE&
Public Const GL_TEXTURE31                      = &H84DF&
Public Const GL_ACTIVE_TEXTURE                 = &H84E0&
Public Const GL_CLIENT_ACTIVE_TEXTURE          = &H84E1&
Public Const GL_MAX_TEXTURE_UNITS              = &H84E2&
Public Const GL_TRANSPOSE_MODELVIEW_MATRIX     = &H84E3&
Public Const GL_TRANSPOSE_PROJECTION_MATRIX    = &H84E4&
Public Const GL_TRANSPOSE_TEXTURE_MATRIX       = &H84E5&
Public Const GL_TRANSPOSE_COLOR_MATRIX         = &H84E6&
Public Const GL_SUBTRACT                       = &H84E7&
Public Const GL_COMPRESSED_ALPHA               = &H84E9&
Public Const GL_COMPRESSED_LUMINANCE           = &H84EA&
Public Const GL_COMPRESSED_LUMINANCE_ALPHA     = &H84EB&
Public Const GL_COMPRESSED_INTENSITY           = &H84EC&
Public Const GL_COMPRESSED_RGB                 = &H84ED&
Public Const GL_COMPRESSED_RGBA                = &H84EE&
Public Const GL_TEXTURE_COMPRESSION_HINT       = &H84EF&
Public Const GL_NORMAL_MAP                     = &H8511&
Public Const GL_REFLECTION_MAP                 = &H8512&
Public Const GL_TEXTURE_CUBE_MAP               = &H8513&
Public Const GL_TEXTURE_BINDING_CUBE_MAP       = &H8514&
Public Const GL_TEXTURE_CUBE_MAP_POSITIVE_X    = &H8515&
Public Const GL_TEXTURE_CUBE_MAP_NEGATIVE_X    = &H8516&
Public Const GL_TEXTURE_CUBE_MAP_POSITIVE_Y    = &H8517&
Public Const GL_TEXTURE_CUBE_MAP_NEGATIVE_Y    = &H8518&
Public Const GL_TEXTURE_CUBE_MAP_POSITIVE_Z    = &H8519&
Public Const GL_TEXTURE_CUBE_MAP_NEGATIVE_Z    = &H851A&
Public Const GL_PROXY_TEXTURE_CUBE_MAP         = &H851B&
Public Const GL_MAX_CUBE_MAP_TEXTURE_SIZE      = &H851C&
Public Const GL_COMBINE                        = &H8570&
Public Const GL_COMBINE_RGB                    = &H8571&
Public Const GL_COMBINE_ALPHA                  = &H8572&
Public Const GL_RGB_SCALE                      = &H8573&
Public Const GL_ADD_SIGNED                     = &H8574&
Public Const GL_INTERPOLATE                    = &H8575&
Public Const GL_CONSTANT                       = &H8576&
Public Const GL_PRIMARY_COLOR                  = &H8577&
Public Const GL_PREVIOUS                       = &H8578&
Public Const GL_SOURCE0_RGB                    = &H8580&
Public Const GL_SOURCE1_RGB                    = &H8581&
Public Const GL_SOURCE2_RGB                    = &H8582&
Public Const GL_SOURCE0_ALPHA                  = &H8588&
Public Const GL_SOURCE1_ALPHA                  = &H8589&
Public Const GL_SOURCE2_ALPHA                  = &H858A&
Public Const GL_OPERAND0_RGB                   = &H8590&
Public Const GL_OPERAND1_RGB                   = &H8591&
Public Const GL_OPERAND2_RGB                   = &H8592&
Public Const GL_OPERAND0_ALPHA                 = &H8598&
Public Const GL_OPERAND1_ALPHA                 = &H8599&
Public Const GL_OPERAND2_ALPHA                 = &H859A&
Public Const GL_TEXTURE_COMPRESSED_IMAGE_SIZE  = &H86A0&
Public Const GL_TEXTURE_COMPRESSED             = &H86A1&
Public Const GL_NUM_COMPRESSED_TEXTURE_FORMATS = &H86A2&
Public Const GL_COMPRESSED_TEXTURE_FORMATS     = &H86A3&
Public Const GL_DOT3_RGB                       = &H86AE&
Public Const GL_DOT3_RGBA                      = &H86AF&
Public Const GL_MULTISAMPLE_BIT                = &H20000000
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glActiveTexturePtr, glClientActiveTexturePtr, glCompressedTexImage1DPtr, glCompressedTexImage2DPtr, glCompressedTexImage3DPtr, glCompressedTexSubImage1DPtr, glCompressedTexSubImage2DPtr, glCompressedTexSubImage3DPtr, glGetCompressedTexImagePtr, _
glLoadTransposeMatrixdPtr, glLoadTransposeMatrixfPtr, glMultTransposeMatrixdPtr, glMultTransposeMatrixfPtr, glMultiTexCoord1dPtr, glMultiTexCoord1dvPtr, glMultiTexCoord1fPtr, glMultiTexCoord1fvPtr, glMultiTexCoord1iPtr, glMultiTexCoord1ivPtr, _
glMultiTexCoord1sPtr, glMultiTexCoord1svPtr, glMultiTexCoord2dPtr, glMultiTexCoord2dvPtr, glMultiTexCoord2fPtr, glMultiTexCoord2fvPtr, glMultiTexCoord2iPtr, glMultiTexCoord2ivPtr, glMultiTexCoord2sPtr, glMultiTexCoord2svPtr, _
glMultiTexCoord3dPtr, glMultiTexCoord3dvPtr, glMultiTexCoord3fPtr, glMultiTexCoord3fvPtr, glMultiTexCoord3iPtr, glMultiTexCoord3ivPtr, glMultiTexCoord3sPtr, glMultiTexCoord3svPtr, glMultiTexCoord4dPtr, glMultiTexCoord4dvPtr, _
glMultiTexCoord4fPtr, glMultiTexCoord4fvPtr, glMultiTexCoord4iPtr, glMultiTexCoord4ivPtr, glMultiTexCoord4sPtr, glMultiTexCoord4svPtr, glSampleCoveragePtr
'------------------------------- GL_VERSION_1_3 -------------------------------
Public Sub glActiveTexture(ByVal texture As Long)                                                                                                                                                                                                                                  : Call OpenGLExtCall1(glActiveTexturePtr, vbEmpty, texture): End Sub
Public Sub glClientActiveTexture(ByVal texture As Long)                                                                                                                                                                                                                            : Call OpenGLExtCall1(glClientActiveTexturePtr, vbEmpty, texture): End Sub
Public Sub glCompressedTexImage1D(ByVal target As Long, ByVal level As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal border As Long, ByVal imageSize As Long, ByVal data)                                                                                         : Call OpenGLExtCall7(glCompressedTexImage1DPtr, vbEmpty, target, level, internalformat, Width, border, imageSize, data): End Sub
Public Sub glCompressedTexImage2D(ByVal target As Long, ByVal level As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal border As Long, ByVal imageSize As Long, ByVal data)                                                                   : Call OpenGLExtCall8(glCompressedTexImage2DPtr, vbEmpty, target, level, internalformat, Width, Height, border, imageSize, data): End Sub
Public Sub glCompressedTexImage3D(ByVal target As Long, ByVal level As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal border As Long, ByVal imageSize As Long, ByVal data)                                              : Call OpenGLExtCall9(glCompressedTexImage3DPtr, vbEmpty, target, level, internalformat, Width, Height, depth, border, imageSize, data): End Sub
Public Sub glCompressedTexSubImage1D(ByVal target As Long, ByVal level As Long, ByVal xoffset As Long, ByVal Width As Long, ByVal format As Long, ByVal imageSize As Long, ByVal data)                                                                                             : Call OpenGLExtCall7(glCompressedTexSubImage1DPtr, vbEmpty, target, level, xoffset, Width, format, imageSize, data): End Sub
Public Sub glCompressedTexSubImage2D(ByVal target As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal format As Long, ByVal imageSize As Long, ByVal data)                                                : Call OpenGLExtCall9(glCompressedTexSubImage2DPtr, vbEmpty, target, level, xoffset, yoffset, Width, Height, format, imageSize, data): End Sub
Public Sub glCompressedTexSubImage3D(ByVal target As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal format As Long, ByVal imageSize As Long, ByVal data)    : Call OpenGLExtCall11(glCompressedTexSubImage3DPtr, vbEmpty, target, level, xoffset, yoffset, zoffset, Width, Height, depth, format, imageSize, data): End Sub
Public Sub glGetCompressedTexImage(ByVal target As Long, ByVal lod As Long, ByVal img)                                                                                                                                                                                             : Call OpenGLExtCall3(glGetCompressedTexImagePtr, vbEmpty, target, lod, img): End Sub
Public Sub glLoadTransposeMatrixd(m As Double)                                                                                                                                                                                                                                     : Call OpenGLExtCall1(glLoadTransposeMatrixdPtr, vbEmpty, VarPtr(m)): End Sub
Public Sub glLoadTransposeMatrixf(m As Single)                                                                                                                                                                                                                                     : Call OpenGLExtCall1(glLoadTransposeMatrixfPtr, vbEmpty, VarPtr(m)): End Sub
Public Sub glMultTransposeMatrixd(m As Double)                                                                                                                                                                                                                                     : Call OpenGLExtCall1(glMultTransposeMatrixdPtr, vbEmpty, VarPtr(m)): End Sub
Public Sub glMultTransposeMatrixf(m As Single)                                                                                                                                                                                                                                     : Call OpenGLExtCall1(glMultTransposeMatrixfPtr, vbEmpty, VarPtr(m)): End Sub
Public Sub glMultiTexCoord1d(ByVal target As Long, ByVal s As Double)                                                                                                                                                                                                              : Call OpenGLExtCall2(glMultiTexCoord1dPtr, vbEmpty, target, s): End Sub
Public Sub glMultiTexCoord1dv(ByVal target As Long, v As Double)                                                                                                                                                                                                                   : Call OpenGLExtCall2(glMultiTexCoord1dvPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord1f(ByVal target As Long, ByVal s As Single)                                                                                                                                                                                                              : Call OpenGLExtCall2(glMultiTexCoord1fPtr, vbEmpty, target, s): End Sub
Public Sub glMultiTexCoord1fv(ByVal target As Long, v As Single)                                                                                                                                                                                                                   : Call OpenGLExtCall2(glMultiTexCoord1fvPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord1i(ByVal target As Long, ByVal s As Long)                                                                                                                                                                                                                : Call OpenGLExtCall2(glMultiTexCoord1iPtr, vbEmpty, target, s): End Sub
Public Sub glMultiTexCoord1iv(ByVal target As Long, v As Long)                                                                                                                                                                                                                     : Call OpenGLExtCall2(glMultiTexCoord1ivPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord1s(ByVal target As Long, ByVal s As Integer)                                                                                                                                                                                                             : Call OpenGLExtCall2(glMultiTexCoord1sPtr, vbEmpty, target, s): End Sub
Public Sub glMultiTexCoord1sv(ByVal target As Long, v As Integer)                                                                                                                                                                                                                  : Call OpenGLExtCall2(glMultiTexCoord1svPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord2d(ByVal target As Long, ByVal s As Double, ByVal t As Double)                                                                                                                                                                                           : Call OpenGLExtCall3(glMultiTexCoord2dPtr, vbEmpty, target, s, t): End Sub
Public Sub glMultiTexCoord2dv(ByVal target As Long, v As Double)                                                                                                                                                                                                                   : Call OpenGLExtCall2(glMultiTexCoord2dvPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord2f(ByVal target As Long, ByVal s As Single, ByVal t As Single)                                                                                                                                                                                           : Call OpenGLExtCall3(glMultiTexCoord2fPtr, vbEmpty, target, s, t): End Sub
Public Sub glMultiTexCoord2fv(ByVal target As Long, v As Single)                                                                                                                                                                                                                   : Call OpenGLExtCall2(glMultiTexCoord2fvPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord2i(ByVal target As Long, ByVal s As Long, ByVal t As Long)                                                                                                                                                                                               : Call OpenGLExtCall3(glMultiTexCoord2iPtr, vbEmpty, target, s, t): End Sub
Public Sub glMultiTexCoord2iv(ByVal target As Long, v As Long)                                                                                                                                                                                                                     : Call OpenGLExtCall2(glMultiTexCoord2ivPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord2s(ByVal target As Long, ByVal s As Integer, ByVal t As Integer)                                                                                                                                                                                         : Call OpenGLExtCall3(glMultiTexCoord2sPtr, vbEmpty, target, s, t): End Sub
Public Sub glMultiTexCoord2sv(ByVal target As Long, v As Integer)                                                                                                                                                                                                                  : Call OpenGLExtCall2(glMultiTexCoord2svPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord3d(ByVal target As Long, ByVal s As Double, ByVal t As Double, ByVal r As Double)                                                                                                                                                                        : Call OpenGLExtCall4(glMultiTexCoord3dPtr, vbEmpty, target, s, t, r): End Sub
Public Sub glMultiTexCoord3dv(ByVal target As Long, v As Double)                                                                                                                                                                                                                   : Call OpenGLExtCall2(glMultiTexCoord3dvPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord3f(ByVal target As Long, ByVal s As Single, ByVal t As Single, ByVal r As Single)                                                                                                                                                                        : Call OpenGLExtCall4(glMultiTexCoord3fPtr, vbEmpty, target, s, t, r): End Sub
Public Sub glMultiTexCoord3fv(ByVal target As Long, v As Single)                                                                                                                                                                                                                   : Call OpenGLExtCall2(glMultiTexCoord3fvPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord3i(ByVal target As Long, ByVal s As Long, ByVal t As Long, ByVal r As Long)                                                                                                                                                                              : Call OpenGLExtCall4(glMultiTexCoord3iPtr, vbEmpty, target, s, t, r): End Sub
Public Sub glMultiTexCoord3iv(ByVal target As Long, v As Long)                                                                                                                                                                                                                     : Call OpenGLExtCall2(glMultiTexCoord3ivPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord3s(ByVal target As Long, ByVal s As Integer, ByVal t As Integer, ByVal r As Integer)                                                                                                                                                                     : Call OpenGLExtCall4(glMultiTexCoord3sPtr, vbEmpty, target, s, t, r): End Sub
Public Sub glMultiTexCoord3sv(ByVal target As Long, v As Integer)                                                                                                                                                                                                                  : Call OpenGLExtCall2(glMultiTexCoord3svPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord4d(ByVal target As Long, ByVal s As Double, ByVal t As Double, ByVal r As Double, ByVal q As Double)                                                                                                                                                     : Call OpenGLExtCall5(glMultiTexCoord4dPtr, vbEmpty, target, s, t, r, q): End Sub
Public Sub glMultiTexCoord4dv(ByVal target As Long, v As Double)                                                                                                                                                                                                                   : Call OpenGLExtCall2(glMultiTexCoord4dvPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord4f(ByVal target As Long, ByVal s As Single, ByVal t As Single, ByVal r As Single, ByVal q As Single)                                                                                                                                                     : Call OpenGLExtCall5(glMultiTexCoord4fPtr, vbEmpty, target, s, t, r, q): End Sub
Public Sub glMultiTexCoord4fv(ByVal target As Long, v As Single)                                                                                                                                                                                                                   : Call OpenGLExtCall2(glMultiTexCoord4fvPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord4i(ByVal target As Long, ByVal s As Long, ByVal t As Long, ByVal r As Long, ByVal q As Long)                                                                                                                                                             : Call OpenGLExtCall5(glMultiTexCoord4iPtr, vbEmpty, target, s, t, r, q): End Sub
Public Sub glMultiTexCoord4iv(ByVal target As Long, v As Long)                                                                                                                                                                                                                     : Call OpenGLExtCall2(glMultiTexCoord4ivPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord4s(ByVal target As Long, ByVal s As Integer, ByVal t As Integer, ByVal r As Integer, ByVal q As Integer)                                                                                                                                                 : Call OpenGLExtCall5(glMultiTexCoord4sPtr, vbEmpty, target, s, t, r, q): End Sub
Public Sub glMultiTexCoord4sv(ByVal target As Long, v As Integer)                                                                                                                                                                                                                  : Call OpenGLExtCall2(glMultiTexCoord4svPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glSampleCoverage(ByVal value As Single, ByVal invert As Integer)                                                                                                                                                                                                        : Call OpenGLExtCall2(glSampleCoveragePtr, vbEmpty, value, invert): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL1_3()
If IsDEPEnabled Then
    glSampleCoveragePtr = OpenGLExtProcAddress("glSampleCoverage")
    glMultiTexCoord4svPtr = OpenGLExtProcAddress("glMultiTexCoord4sv")
    glMultiTexCoord4sPtr = OpenGLExtProcAddress("glMultiTexCoord4s")
    glMultiTexCoord4ivPtr = OpenGLExtProcAddress("glMultiTexCoord4iv")
    glMultiTexCoord4iPtr = OpenGLExtProcAddress("glMultiTexCoord4i")
    glMultiTexCoord4fvPtr = OpenGLExtProcAddress("glMultiTexCoord4fv")
    glMultiTexCoord4fPtr = OpenGLExtProcAddress("glMultiTexCoord4f")
    glMultiTexCoord4dvPtr = OpenGLExtProcAddress("glMultiTexCoord4dv")
    glMultiTexCoord4dPtr = OpenGLExtProcAddress("glMultiTexCoord4d")
    glMultiTexCoord3svPtr = OpenGLExtProcAddress("glMultiTexCoord3sv")
    glMultiTexCoord3sPtr = OpenGLExtProcAddress("glMultiTexCoord3s")
    glMultiTexCoord3ivPtr = OpenGLExtProcAddress("glMultiTexCoord3iv")
    glMultiTexCoord3iPtr = OpenGLExtProcAddress("glMultiTexCoord3i")
    glMultiTexCoord3fvPtr = OpenGLExtProcAddress("glMultiTexCoord3fv")
    glMultiTexCoord3fPtr = OpenGLExtProcAddress("glMultiTexCoord3f")
    glMultiTexCoord3dvPtr = OpenGLExtProcAddress("glMultiTexCoord3dv")
    glMultiTexCoord3dPtr = OpenGLExtProcAddress("glMultiTexCoord3d")
    glMultiTexCoord2svPtr = OpenGLExtProcAddress("glMultiTexCoord2sv")
    glMultiTexCoord2sPtr = OpenGLExtProcAddress("glMultiTexCoord2s")
    glMultiTexCoord2ivPtr = OpenGLExtProcAddress("glMultiTexCoord2iv")
    glMultiTexCoord2iPtr = OpenGLExtProcAddress("glMultiTexCoord2i")
    glMultiTexCoord2fvPtr = OpenGLExtProcAddress("glMultiTexCoord2fv")
    glMultiTexCoord2fPtr = OpenGLExtProcAddress("glMultiTexCoord2f")
    glMultiTexCoord2dvPtr = OpenGLExtProcAddress("glMultiTexCoord2dv")
    glMultiTexCoord2dPtr = OpenGLExtProcAddress("glMultiTexCoord2d")
    glMultiTexCoord1svPtr = OpenGLExtProcAddress("glMultiTexCoord1sv")
    glMultiTexCoord1sPtr = OpenGLExtProcAddress("glMultiTexCoord1s")
    glMultiTexCoord1ivPtr = OpenGLExtProcAddress("glMultiTexCoord1iv")
    glMultiTexCoord1iPtr = OpenGLExtProcAddress("glMultiTexCoord1i")
    glMultiTexCoord1fvPtr = OpenGLExtProcAddress("glMultiTexCoord1fv")
    glMultiTexCoord1fPtr = OpenGLExtProcAddress("glMultiTexCoord1f")
    glMultiTexCoord1dvPtr = OpenGLExtProcAddress("glMultiTexCoord1dv")
    glMultiTexCoord1dPtr = OpenGLExtProcAddress("glMultiTexCoord1d")
    glMultTransposeMatrixfPtr = OpenGLExtProcAddress("glMultTransposeMatrixf")
    glMultTransposeMatrixdPtr = OpenGLExtProcAddress("glMultTransposeMatrixd")
    glLoadTransposeMatrixfPtr = OpenGLExtProcAddress("glLoadTransposeMatrixf")
    glLoadTransposeMatrixdPtr = OpenGLExtProcAddress("glLoadTransposeMatrixd")
    glGetCompressedTexImagePtr = OpenGLExtProcAddress("glGetCompressedTexImage")
    glCompressedTexSubImage3DPtr = OpenGLExtProcAddress("glCompressedTexSubImage3D")
    glCompressedTexSubImage2DPtr = OpenGLExtProcAddress("glCompressedTexSubImage2D")
    glCompressedTexSubImage1DPtr = OpenGLExtProcAddress("glCompressedTexSubImage1D")
    glCompressedTexImage3DPtr = OpenGLExtProcAddress("glCompressedTexImage3D")
    glCompressedTexImage2DPtr = OpenGLExtProcAddress("glCompressedTexImage2D")
    glCompressedTexImage1DPtr = OpenGLExtProcAddress("glCompressedTexImage1D")
    glClientActiveTexturePtr = OpenGLExtProcAddress("glClientActiveTexture")
    glActiveTexturePtr = OpenGLExtProcAddress("glActiveTexture")
Else
    RemapVBFunctionToGLFunction AddressOf glSampleCoverage, "glSampleCoverage"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4sv, "glMultiTexCoord4sv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4s, "glMultiTexCoord4s"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4iv, "glMultiTexCoord4iv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4i, "glMultiTexCoord4i"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4fv, "glMultiTexCoord4fv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4f, "glMultiTexCoord4f"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4dv, "glMultiTexCoord4dv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4d, "glMultiTexCoord4d"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3sv, "glMultiTexCoord3sv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3s, "glMultiTexCoord3s"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3iv, "glMultiTexCoord3iv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3i, "glMultiTexCoord3i"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3fv, "glMultiTexCoord3fv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3f, "glMultiTexCoord3f"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3dv, "glMultiTexCoord3dv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3d, "glMultiTexCoord3d"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2sv, "glMultiTexCoord2sv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2s, "glMultiTexCoord2s"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2iv, "glMultiTexCoord2iv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2i, "glMultiTexCoord2i"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2fv, "glMultiTexCoord2fv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2f, "glMultiTexCoord2f"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2dv, "glMultiTexCoord2dv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2d, "glMultiTexCoord2d"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1sv, "glMultiTexCoord1sv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1s, "glMultiTexCoord1s"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1iv, "glMultiTexCoord1iv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1i, "glMultiTexCoord1i"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1fv, "glMultiTexCoord1fv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1f, "glMultiTexCoord1f"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1dv, "glMultiTexCoord1dv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1d, "glMultiTexCoord1d"
    RemapVBFunctionToGLFunction AddressOf glMultTransposeMatrixf, "glMultTransposeMatrixf"
    RemapVBFunctionToGLFunction AddressOf glMultTransposeMatrixd, "glMultTransposeMatrixd"
    RemapVBFunctionToGLFunction AddressOf glLoadTransposeMatrixf, "glLoadTransposeMatrixf"
    RemapVBFunctionToGLFunction AddressOf glLoadTransposeMatrixd, "glLoadTransposeMatrixd"
    RemapVBFunctionToGLFunction AddressOf glGetCompressedTexImage, "glGetCompressedTexImage"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexSubImage3D, "glCompressedTexSubImage3D"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexSubImage2D, "glCompressedTexSubImage2D"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexSubImage1D, "glCompressedTexSubImage1D"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexImage3D, "glCompressedTexImage3D"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexImage2D, "glCompressedTexImage2D"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexImage1D, "glCompressedTexImage1D"
    RemapVBFunctionToGLFunction AddressOf glClientActiveTexture, "glClientActiveTexture"
    RemapVBFunctionToGLFunction AddressOf glActiveTexture, "glActiveTexture"
End If
End Function
