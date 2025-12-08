Attribute VB_Name = "ExampleRectanglePreCompiled"

Option Explicit


'================================================================================
' Simple Example of this Library, compressed
' Shows how use precompiled layouts, shaders and data for basic use-cases
'================================================================================

Private Mesh As VBGLMesh

Public Sub TestRectanglePreCompiled(ByVal Path As String)

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
    Set Layout = VBGLPrCoLayoutXYRGB

    ' Create Data Rectangle with Position and Color
    Dim VertexData As IDataByte
    Set VertexData = VBGLData.CreateSingle(VBGLBaFoRectangleXYRGB)

    ' Create Shader
    Dim Shader As VBGLShader
    Set Shader = VBGLPrCoShaderXYRGB

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