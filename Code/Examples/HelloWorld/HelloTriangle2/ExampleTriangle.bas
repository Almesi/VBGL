Attribute VB_Name = "ExampleTriangle"

Option Explicit

'================================================================================
' Simplest Example of this Library
' Shows how to Create a Context, Window and how to get a simple coloured triangle on screen
'================================================================================

Private Mesh As VBGLMesh

Public Sub TestTriangle(ByVal Path As String)

    ' Create OpenGL Context
    Dim Shower       As IDestination     : Set Shower = Nothing
    Dim Logger       As IDestination     : Set Logger = std_ImmiedeateDestination.Create()
    Set CurrentContext = VBGLContext.Create(Path, GLUT_CORE_PROFILE, GLUT_DEBUG, Logger, Shower)
    If IsNothing(CurrentContext) Then Exit Sub
    CurrentContext.BlendTest = True 
    CurrentContext.DepthTest = True
    CurrentContext.CullTest = True
    Call CurrentContext.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    Call CurrentContext.CullFace(GL_BACK)

    ' Create Window
    Call VBGLWindow.Create(1600, 900, GLUT_RGBA, "OpenGL Test", "4_6", True)

    ' Create Data-Layout
    Dim Layout As VBGLLayout
    Set Layout = VBGLLayout.Create(vbSingle, VBGLLayoutType.XY, VBGLLayoutType.RGBB)

    ' Create Data - Triangle with Position and Color
    Dim Vertices() As Single
    ReDim Vertices(14)
    Vertices = ArraySingle( _
                              -1, 0, 1, 0, 0, _ 
                              +0, 1, 0, 0, 0, _
                              +1, 0, 0, 0, 1  _
                          )

    ' Create ByteData from SingleData
    Dim NewSize    As Long      : NewSize = (USize(Vertices) + 1) * LenB(Vertices(0))
    Dim Temp()     As Byte      : ReDim Temp(NewSize - 1)
    Call CopyMemory(Temp(0), VarPtr(Vertices(0)), NewSize)
    Dim VertexData As IDataByte : Set VertexData = VBGLData.CreateByte(Temp)

    ' Create Shader
    Dim Uniforms As VBGLShaderElementCollection
    Set Uniforms = New VBGLShaderElementCollection
    Dim ShaderTemplate As VBGLShaderTemplate
    Set ShaderTemplate = VBGLShaderTemplate.Create("Vertex-Fragment", "460 core")
    Call ShaderTemplate.SetUp(Layout, Uniforms)
    Dim Shader As VBGLShader
    Set Shader = VBGLShader.CreateFromText(ShaderTemplate.GetShader())

    ' Create a Drawable-Mesh Object
    Set Mesh = VBGLMesh.Create(Shader, Layout, VertexData, Nothing, False)

    ' Assign Freeglut callbacks and call the mainloop
    With CurrentContext
        Call .SetDisplayFunc(AddressOf       LoopSub)
        Call .SetIdleFunc(AddressOf          LoopSub)
        Call .MainLoop()
    End With
End Sub

Private Sub LoopSub()
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0.5, 0.5, 0.5, 1)
    Call Mesh.Draw()
    Call glutSwapBuffers()
End Sub