Attribute VB_Name = "ExampleRotatingCube"

Option Explicit

'================================================================================
' Shows how use the following:
' 1. Matrix Class
' 2. Model Loader
' 3. Uniform Assignment
'================================================================================

Private CubeShader As VBGLShader
Private Window     As VBGLWindow
Private Camera     As VBGLCamera
Private CubeModel  As VBGLModel

Private LastX As Single
Private LastY As Single


Public Sub TestRotatingCube(ByVal Path As String, ByVal DataPath As String)
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
    Set Window = VBGLWindow.Create(1600, 900, GLUT_RGBA, "OpenGL Test", "4_6", True)


    ' Create Cube
    Dim NewLoader As VBGLFileLoader : Set NewLoader  = New VBGLFileLoader
    Dim MtlLoader As IMtlLoader     : Set MtlLoader  = MtlParser.Create(NewLoader, ",")
    Dim ObjLoader As IObjLoader     : Set ObjLoader  = GLFileObject.Create(NewLoader, ",")
    Set CubeModel  = VBGLModel.Create(NewLoader, DataPath, ObjLoader, MtlLoader)
    Set CubeShader = CubeModel.Mesh(0).Shader

    ' Create Camera (Not movable in this example)
    Set Camera       = VBGLCamera.Create(0, 0, 10,    0, 1, 0,    -90, 0, 0,    0.5, 0.5, 45)

    LastX = 800
    LastY = 450
    Window.FPS = 120

    ' Add Callbacks and call mainloop
    With CurrentContext
        Call .SetDisplayFunc(AddressOf       LoopSub)
        Call .SetIdleFunc(AddressOf          LoopSub)
        Call .MainLoop()
    End With
End Sub

Public Sub LoopSub()
    Dim ThetaF As Single
    Static Count As Single
    Static Direction As Single

    Count = Count + 1
    If Count >= 360 Then Count = 0
    ThetaF = Count * 3.14159265 / 180

    ' Calculate new position and assigning it to the shader
    Dim Translate As IMatrixSingle
    Set Translate = VBGLMatrix.Create(vbSingle, 3, 3)
    Translate.Item(0, 3) = Sin(ThetaF) * 5
    Translate.Item(1, 3) = Sin(ThetaF) * 10
    Translate.Item(2, 3) = Cos(ThetaF) * 5

    Dim CPos As IMatrixSingle
    Set CPos = Camera.GetPosition

    Dim Rotation As IMatrixSingle
    Set Rotation = VBGLMatrix.Create(vbSingle, 3, 3)
    Rotation.Data = Rotation.Rotate(3)

    CubeShader.Uniforms.Data("Model") = Translate.Add(Rotation.Data, Translate.Data)
    CubeShader.Uniforms.Data("View") = Camera.GetView.Data
    CubeShader.Uniforms.Data("Projection") = Camera.GetPerspective(Window.Width, Window.Height, 0.1!, 100!).Data

    CubeShader.Uniforms.Data("ViewPosition") = CPos.DataColumn(0, 2)
    Call CubeShader.Uniforms.DataArr("LightPosition", Translate.Item(0, 3), Translate.Item(1, 3), Translate.Item(2, 3))
    Call CubeShader.Uniforms.DataArr("LightColor", +1.0!, +1.0!, +1.0!)

    ' Clearing drawing and swapping
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0.7, 0, 0.5, 1)

    Call CubeModel.Draw()
    Call glutSwapBuffers()
    Debug.Print "FPS:", CurrentContext.CurrentWindow.LimitFPS
End Sub