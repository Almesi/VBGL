Attribute VB_Name = "VBGLPreCompiled"

Option Explicit

' Not REALLY pre-compiled, as the compiling is done when first calling the Function
' Nomenclature:
' 1. VBGLPrCo   = VBGL Pre Compiled
' 2. ObjectType = VBGLShader|VBGLLayout|etc.
' 3. Identity   = XYZ|XYZRGB|XYZMVP|etc.

'======================================================================================
'=======================================[Layout]=======================================
'======================================================================================

Public Function VBGLPrCoLayoutXY() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XY)
    Set VBGLPrCoLayoutXY = MyObject
End Function

Public Function VBGLPrCoLayoutXYZ() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ)
    Set VBGLPrCoLayoutXYZ = MyObject
End Function

Public Function VBGLPrCoLayoutXYRGB() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XY, VBGLLayoutType.RGBB)
    Set VBGLPrCoLayoutXYRGB = MyObject
End Function

Public Function VBGLPrCoLayoutXYZRGB() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.RGBB)
    Set VBGLPrCoLayoutXYZRGB = MyObject
End Function

Public Function VBGLPrCoLayoutXYZRGBA() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.RGBA)
    Set VBGLPrCoLayoutXYZRGBA = MyObject
End Function

Public Function VBGLPrCoLayoutXYTxTy() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XY, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutXYTxTy = MyObject
End Function

Public Function VBGLPrCoLayoutXYZTxTy() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutXYZTxTy = MyObject
End Function

Public Function VBGLPrCoLayoutXYZRGBTxTy() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.RGBB, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutXYZRGBTxTy = MyObject
End Function

Public Function VBGLPrCoLayoutXYZRGBATxTy() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.RGBA, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutXYZRGBATxTy = MyObject
End Function

Public Function VBGLPrCoLayoutXYZWRGBA() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZW, VBGLLayoutType.RGBA)
    Set VBGLPrCoLayoutXYZWRGBA = MyObject
End Function

Public Function VBGLPrCoLayoutXYZWRGBATxTy() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZW, VBGLLayoutType.RGBA, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutXYZWRGBA = MyObject
End Function

Public Function VBGLPrCoLayoutXYZTxTyNxNyNz() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.TxTy, VBGLLayoutType.NxNyNz)
    Set VBGLPrCoLayoutXYZTxTyNxNyNz = MyObject
End Function

Public Function VBGLPrCoLayoutText() As VBGLLayout
    Static MyObject As VBGLLayout
    If IsNothing(MyObject) Then Set MyObject = VBGLLayout.Create(vbSingle, VBGLLayoutType.XYZ, VBGLLayoutType.RGBA, VBGLLayoutType.RGBA, VBGLLayoutType.TxTy)
    Set VBGLPrCoLayoutText = MyObject
End Function

'======================================================================================
'=======================================[Shader]=======================================
'======================================================================================

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