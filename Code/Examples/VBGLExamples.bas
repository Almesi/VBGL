Attribute VB_Name = "VBGLExamples"

Option Explicit

Private Mesh As VBGLMesh

Public Sub VBGLExamples1()
    Dim Path As String
    Path = "Your\Path\To\Freeglut.dll"

    Dim Shower As IDestination : Set Shower = Nothing
    Dim Logger As IDestination : Set Logger = std_ImmiedeateDestination.Create()
    
    Set CurrentContext = VBGLContext.Create(Path, GLUT_CORE_PROFILE, GLUT_DEBUG, Logger, Shower)
    If IsNothing(CurrentContext) Then Exit Sub
    Call VBGLWindow.Create(1600, 900, GLUT_RGBA, "OpenGL Test", "4_6", True)
    CurrentContext.BlendTest = True 
    CurrentContext.DepthTest = True
    CurrentContext.CullTest = True
    Call CurrentContext.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    Call CurrentContext.CullFace(GL_BACK)

    Dim LayoutTypes() As VBGLLayoutType
    ReDim LayoutTypes(1)
    LayoutTypes(0) = VBGLLayoutType.XY
    LayoutTypes(1) = VBGLLayoutType.RGBB
    Dim Layout As VBGLLayout
    Set Layout = VBGLLayout.Create(vbSingle, LayoutTypes)

    Dim Vertices() As Single
    ReDim Vertices(14)
    Vertices(00) = -1: Vertices(01) = 0: Vertices(02) = 1: Vertices(03) = 0: Vertices(04) = 0 
    Vertices(05) = +0: Vertices(06) = 1: Vertices(07) = 0: Vertices(08) = 0: Vertices(09) = 0
    Vertices(10) = +1: Vertices(11) = 0: Vertices(12) = 0: Vertices(13) = 0: Vertices(14) = 1
    Dim Temp() As Byte
    Dim NewSize As Long
    NewSize = (USize(Vertices) + 1) * LenB(Vertices(0))
    ReDim Temp(NewSize - 1)
    Call CopyMemory(Temp(0), VarPtr(Vertices(0)), NewSize)
    Dim VertexData As IDataByte
    Set VertexData = VBGLData.CreateByte(Temp)

    Dim ShaderTemplate As VBGLShaderTemplate
    Dim Uniforms As VBGLShaderElementCollection
    Set Uniforms = New VBGLShaderElementCollection
    Set ShaderTemplate = VBGLShaderTemplate.Create("Vertex-Fragment", "460 core")
    Call ShaderTemplate.SetUp(Layout, Uniforms)
    Dim Shader As VBGLShader
    Set Shader = VBGLShader.CreateFromText(ShaderTemplate.GetShader())

    Set Mesh = VBGLMesh.Create(Shader, Layout, VertexData, Nothing, False)

    With CurrentContext
        Call .SetDisplayFunc(AddressOf       VBGLExamples1Loop)
        Call .SetIdleFunc(AddressOf          VBGLExamples1Loop)
        Call .MainLoop()
    End With
End Sub

Private Sub VBGLExamples1Loop()
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0.5, 0.5, 0.5, 1)
    Call Mesh.Draw()
    Call glutSwapBuffers
End Sub