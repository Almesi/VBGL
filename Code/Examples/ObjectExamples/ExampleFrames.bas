Attribute VB_Name = "ExampleFrames"

Option Explicit

'================================================================================
' Shows how use split the Window into smaller Subwindows(frames)
'================================================================================

Private FrameLeft As VBGLFrame
Private FrameRight As VBGLFrame
Private Mesh As VBGLMesh

Public Sub TestFrames(ByVal Path As String)

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
    Dim Window As VBGLWindow
    Set Window = VBGLWindow.Create(1600, 900, GLUT_RGBA, "OpenGL Test", "4_6", True)
    Set FrameLeft  = VBGLFrame.CreateFromWindow(0  , 0, 0.5, 0.5, 0  , 0, 0.5, 0.5, Window)
    Set FrameRight = VBGLFrame.CreateFromWindow(0.5, 0, 0.5, 0.5, 0.5, 0, 0.5, 0.5, Window)

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
        Call .SetDisplayFunc(AddressOf  LoopSub)
        Call .SetIdleFunc(AddressOf     LoopSub)
        Call .MainLoop()
    End With
End Sub

Public Sub LoopSub()
    Call CurrentContext.Clear()

    Call FrameLeft.Bind()
    Call CurrentContext.ClearColor(0, 1, 0, 1)
    Call Mesh.Draw()
    Call FrameRight.Bind()
    Call CurrentContext.ClearColor(1, 0, 0, 1)
    Call Mesh.Draw()
    
    Call glutSwapBuffers()
End Sub