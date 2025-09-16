Attribute VB_Name = "VBGLPublic"

Public LoadedShaders()  As VBGLShader       ' For Caching
Public LoadedWindows()  As VBGLWindow       ' For Caching
Public LoadedTextures() As VBGLTexture      ' For Caching
Public CurrentContext   As VBGLContext      ' Will be used for all Core Objects that need it