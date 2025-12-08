Attribute VB_Name = "VBGLPreCompiledShaders"

Option Explicit

' Not REALLY pre-compiled, as the compiling is done when first calling the Function
' Nomenclature:
' 1. VBGLPrCo   = VBGL Pre Compiled
' 2. ObjectType = VBGLShader|etc.
' 3. Identity   = XYZ|XYZRGB|XYZMVP|etc.

Public Function VBGLPrCoShaderXY() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXY = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXY)
End Function

Public Function VBGLPrCoShaderXYZ() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYZ = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYZ)
End Function

Public Function VBGLPrCoShaderXYRGB() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYRGB = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYRGB)
End Function

Public Function VBGLPrCoShaderXYZRGB() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYZRGB = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYZRGB)
End Function

Public Function VBGLPrCoShaderXYZRGBA() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYZRGBA = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYZRGBA)
End Function

Public Function VBGLPrCoShaderXYTxTy() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYTxTy = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYTxTy, TextureUniformTemplate)
End Function

Public Function VBGLPrCoShaderXYZTxTy() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYZTxTy = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYZTxTy, TextureUniformTemplate)
End Function
                
Public Function VBGLPrCoShaderXYZRGBTxTy() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYZRGBTxTy = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYZRGBTxTy, TextureUniformTemplate)
End Function

Public Function VBGLPrCoShaderXYZRGBATxTy() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYZRGBATxTy = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYZRGBATxTy, TextureUniformTemplate)
End Function

Public Function VBGLPrCoShaderXYZWRGBA() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYZWRGBA = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYZWRGBA)
End Function

Public Function VBGLPrCoShaderXYZWRGBATxTy() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYZWRGBATxTy = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYZWRGBATxTy, TextureUniformTemplate)
End Function

Public Function VBGLPrCoShaderXYZTxTyNxNyNz() As VBGLShader
    Static MyObject As VBGLShader
    Set VBGLPrCoShaderXYZTxTyNxNyNz = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutXYZTxTyNxNyNz, TextureUniformTemplate)
End Function

Public Function VBGLPrCoShaderText() As VBGLShader
    Static MyObject As VBGLShader
    Dim Uniforms As New VBGLShaderElementCollection
    Call Uniforms.Add(VBGLShaderVariable.Create("inVertexColor0:inFontColor"        , "vec4", "FontColor"      , "*"))
    Call Uniforms.Add(VBGLShaderVariable.Create("inVertexColor1:inBackgroundColor"  , "vec4", "BackgroundColor", "*"))
    Call Uniforms.Add(VBGLShaderVariable.Create("inVertexTexture0:inTextboxPosition", "vec2", "TextboxPosition", "*"))
    Call Uniforms.Add(Nothing)
    Call Uniforms.Add(VBGLShaderVariable.Create(VBGLShaderStateUniformOut       , "sampler2D", "TextboxTexture" , "*"))
    Set VBGLPrCoShaderText = VBGLPrCoShaderTemplate(MyObject, VBGLPrCoLayoutText, Uniforms)
End Function

'======================================================================================
'=======================================[Helper]=======================================
'======================================================================================

Private Function VBGLPrCoShaderTemplate(ByRef MyObject As VBGLShader, ByVal Layout As VBGLLayout, Optional ByVal Uni As VBGLShaderElementCollection = Nothing) As VBGLShader
    If IsNothing(MyObject) Then
        Dim Template As VBGLShaderTemplate
        Set Template = VBGLShaderTemplate.Create("Vertex-Fragment", "460 core")

        If IsNothing(Uni) Then Set Uni = New VBGLShaderElementCollection
        Call Template.SetUp(Layout, Uni)
        Set MyObject = VBGLShader.CreateFromText(Template.GetShader())
    End If
    Set VBGLPrCoShaderTemplate = MyObject
End Function

Private Function TextureUniformTemplate() As VBGLShaderElementCollection
    Set TextureUniformTemplate = New VBGLShaderElementCollection
    Call TextureUniformTemplate.Add(Nothing)
    Call TextureUniformTemplate.Add(VBGLShaderVariable.Create(VBGLShaderStateUniformOut, "sampler2D", "TextureDiffuse0" , "*"))
End Function