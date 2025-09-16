Attribute VB_Name = "ModOpenGL_1_2"
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
'------------------------------- GL_VERSION_1_2 -------------------------------
Public Const GL_SMOOTH_POINT_SIZE_RANGE       = &HB12&
Public Const GL_SMOOTH_POINT_SIZE_GRANULARITY = &HB13&
Public Const GL_SMOOTH_LINE_WIDTH_RANGE       = &HB22&
Public Const GL_SMOOTH_LINE_WIDTH_GRANULARITY = &HB23&
Public Const GL_UNSIGNED_BYTE_3_3_2           = &H8032&
Public Const GL_UNSIGNED_SHORT_4_4_4_4        = &H8033&
Public Const GL_UNSIGNED_SHORT_5_5_5_1        = &H8034&
Public Const GL_UNSIGNED_INT_8_8_8_8          = &H8035&
Public Const GL_UNSIGNED_INT_10_10_10_2       = &H8036&
Public Const GL_RESCALE_NORMAL                = &H803A&
Public Const GL_TEXTURE_BINDING_3D            = &H806A&
Public Const GL_PACK_SKIP_IMAGES              = &H806B&
Public Const GL_PACK_IMAGE_HEIGHT             = &H806C&
Public Const GL_UNPACK_SKIP_IMAGES            = &H806D&
Public Const GL_UNPACK_IMAGE_HEIGHT           = &H806E&
Public Const GL_TEXTURE_3D                    = &H806F&
Public Const GL_PROXY_TEXTURE_3D              = &H8070&
Public Const GL_TEXTURE_DEPTH                 = &H8071&
Public Const GL_TEXTURE_WRAP_R                = &H8072&
Public Const GL_MAX_3D_TEXTURE_SIZE           = &H8073&
Public Const GL_BGR                           = &H80E0&
Public Const GL_BGRA                          = &H80E1&
Public Const GL_MAX_ELEMENTS_VERTICES         = &H80E8&
Public Const GL_MAX_ELEMENTS_INDICES          = &H80E9&
Public Const GL_CLAMP_TO_EDGE                 = &H812F&
Public Const GL_TEXTURE_MIN_LOD               = &H813A&
Public Const GL_TEXTURE_MAX_LOD               = &H813B&
Public Const GL_TEXTURE_BASE_LEVEL            = &H813C&
Public Const GL_TEXTURE_MAX_LEVEL             = &H813D&
Public Const GL_LIGHT_MODEL_COLOR_CONTROL     = &H81F8&
Public Const GL_SINGLE_COLOR                  = &H81F9&
Public Const GL_SEPARATE_SPECULAR_COLOR       = &H81FA&
Public Const GL_UNSIGNED_BYTE_2_3_3_REV       = &H8362&
Public Const GL_UNSIGNED_SHORT_5_6_5          = &H8363&
Public Const GL_UNSIGNED_SHORT_5_6_5_REV      = &H8364&
Public Const GL_UNSIGNED_SHORT_4_4_4_4_REV    = &H8365&
Public Const GL_UNSIGNED_SHORT_1_5_5_5_REV    = &H8366&
Public Const GL_UNSIGNED_INT_8_8_8_8_REV      = &H8367&
Public Const GL_ALIASED_POINT_SIZE_RANGE      = &H846D&
Public Const GL_ALIASED_LINE_WIDTH_RANGE      = &H846E&
'------------------------------- GL_VERSION_1_2_1 -------------------------------
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glCopyTexSubImage3DPtr, glDrawRangeElementsPtr, glTexImage3DPtr, glTexSubImage3DPtr
'------------------------------- GL_VERSION_1_2 -------------------------------
Public Sub glCopyTexSubImage3D(ByVal target As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)                                         : Call OpenGLExtCall9(glCopyTexSubImage3DPtr, vbEmpty, target, level, xoffset, yoffset, zoffset, X, y, Width, Height): End Sub
Public Sub glDrawRangeElements(ByVal mode As Long, ByVal start As Long, ByVal pend As Long, ByVal count As Long, ByVal ptype As Long, ByVal indices)                                                                                                                : Call OpenGLExtCall6(glDrawRangeElementsPtr, vbEmpty, mode, start, pend, count, ptype, indices): End Sub
Public Sub glTexImage3D(ByVal target As Long, ByVal level As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal border As Long, ByVal format As Long, ByVal ptype As Long, ByVal pixels)                     : Call OpenGLExtCall10(glTexImage3DPtr, vbEmpty, target, level, internalformat, Width, Height, depth, border, format, ptype, pixels): End Sub
Public Sub glTexSubImage3D(ByVal target As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal format As Long, ByVal ptype As Long, ByVal pixels) : Call OpenGLExtCall11(glTexSubImage3DPtr, vbEmpty, target, level, xoffset, yoffset, zoffset, Width, Height, depth, format, ptype, pixels): End Sub
'------------------------------- GL_VERSION_1_2_1 -------------------------------
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGL1_2()
    If IsDEPEnabled Then
        glTexSubImage3DPtr = OpenGLExtProcAddress("glTexSubImage3D")
        glTexImage3DPtr = OpenGLExtProcAddress("glTexImage3D")
        glDrawRangeElementsPtr = OpenGLExtProcAddress("glDrawRangeElements")
        glCopyTexSubImage3DPtr = OpenGLExtProcAddress("glCopyTexSubImage3D")
    Else
        RemapVBFunctionToGLFunction AddressOf glTexSubImage3D, "glTexSubImage3D"
        RemapVBFunctionToGLFunction AddressOf glTexImage3D, "glTexImage3D"
        RemapVBFunctionToGLFunction AddressOf glDrawRangeElements, "glDrawRangeElements"
        RemapVBFunctionToGLFunction AddressOf glCopyTexSubImage3D, "glCopyTexSubImage3D"
    End If
End Function