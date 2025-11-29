Attribute VB_Name = "VBGLTestModels"

Option Explicit

Private CapsuleShader     As VBGLShader
Private CubeShader        As VBGLShader
Private Window            As VBGLWindow
Private Camera            As VBGLCamera
Private CapsuleModel      As VBGLModel
Private CubeModel         As VBGLModel

Private NormalInput       As VBGLIInput

Private CurrentTimer      As VBGLTimer

Private LastChar          As Byte


Private LastX As Single
Private LastY As Single


Private ErrorNum          As Long

Public Function VBGLTestModels1() As Long
    On Error GoTo Error
    Dim Path As String
    Path = ThisWorkbook.Path
    Set Window = CurrentContext.CurrentWindow
    CurrentContext.BlendTest = True 
    CurrentContext.DepthTest = True
    CurrentContext.CullTest = True
    Call CurrentContext.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    Call CurrentContext.CullFace(GL_BACK)

    Dim NewLoader As VBGLFileLoader
    Dim MtlLoader As IMtlLoader
    Dim ObjLoader As IObjLoader

    Set NewLoader = New VBGLFileLoader
    Set MtlLoader = MtlParser.Create(NewLoader, ",")
    Set ObjLoader = GLFileObject.Create(NewLoader, ",")
    Set CapsuleModel = VBGLModel.Create(NewLoader, Path & "\Res\Capsule", ObjLoader, MtlLoader)
    Set CapsuleShader = CapsuleModel.Mesh(0).Shader
    If IsNothing(CapsuleShader) Then Exit Function

    Set NewLoader  = New VBGLFileLoader
    Set MtlLoader  = MtlParser.Create(NewLoader, ",")
    Set ObjLoader  = GLFileObject.Create(NewLoader, ",")
    Set CubeModel  = VBGLModel.Create(NewLoader, Path & "\Res\Cube", ObjLoader, MtlLoader)
    Set CubeShader = CubeModel.Mesh(0).Shader
    If IsNothing(CubeShader) Then Exit Function
    CubeModel.Mesh(0).Orientation = GL_CCW ' Because Orientation not working correctly

    Set Camera = VBGLCamera.Create(0, 0, 10,    0, 1, 0,    -90, 0, 0,    0.5, 0.5, 45)
    Set CurrentTimer = VBGLTimer.Create()
    Set NormalInput = CreateInput()

    Dim VBGLTestModelsRenderObject As VBGLRenderObject
    Set VBGLTestModelsRenderObject = VBGLRenderObject.Create(NormalInput, Window.Frame)

    LastX = 800
    LastY = 450
    Window.FPS = 120

    With VBGLTestModelsRenderObject.Callbacks
        Call .SetDisplayFunc(std_Callable.Create(Nothing       , "VBGLTestModelsLoop"          , vbMethod, -1))
        Call .SetIdleFunc(std_Callable.Create(Nothing          , "VBGLTestModelsLoop"          , vbMethod, -1))
        Call .SetKeyboardFunc(std_Callable.Create(Nothing      , "VBGLTestModelsKeyBoard"      , vbMethod, 2))
        Call .SetPassiveMotionFunc(std_Callable.Create(Nothing , "VBGLTestModelsPassiveMotion" , vbMethod, 1))
        Call .SetMouseWheelFunc(std_Callable.Create(Nothing    , "VBGLTestModelsMouseWheel"    , vbMethod, 3))
    End With
    Call AddRenderObject(VBGLTestModelsRenderObject)
    Finish:
    VBGLTestModels1 = ErrorNum
    Exit Function

    Error:
    ErrorNum = 6
    GoTo Finish
End Function

Public Sub VBGLTestModelsLoop()
    On Error GoTo Error
    Dim ThetaF As Single
    Static Count As Single
    Static Direction As Single
    Dim Rotat As Single

    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0.7, 0, 0.5, 1)


    Count = Count + 1
    If Count >= 360 Then Count = 0
    ThetaF = Count * 3.14159265 / 180

    Dim Translate As IMatrixSingle
    Set Translate = VBGLMatrix.Create(vbSingle, 3, 3)
    Translate.Item(0, 3) = Sin(ThetaF) * 5
    Translate.Item(1, 3) = Sin(ThetaF) * 10
    Translate.Item(2, 3) = Cos(ThetaF) * 5

    Call UpdateShader(CapsuleShader, Translate)


    Dim Rotation As IMatrixSingle
    Set Rotation = VBGLMatrix.Create(vbSingle, 3, 3)
    Rotation.Data = Rotation.Rotate(3)
    CapsuleShader.Uniforms.Data("Model") = Rotation.Data
    Call CapsuleModel.Draw()

    Call UpdateShader(CubeShader, Translate)
    CubeShader.Uniforms.Data("Model") = Translate.Add(Rotation.Data, Translate.Data)


    Call CubeModel.Draw()
    Call glutSwapBuffers
    Call CurrentTimer.Update()
    Debug.Print "FPS:", CurrentContext.CurrentWindow.LimitFPS

    Exit Sub

    Error:
    ErrorNum = 1
End Sub

Public Sub VBGLTestModelsKeyBoard(ByVal Char As Byte, ByVal x As Long, ByVal y As Long)
    On Error GoTo Error
    LastChar = Char
    Call NormalInput.KeyDown(CLng(Char))
    Exit Sub

    Error:
    ErrorNum = 2
End Sub

Public Sub VBGLTestModelsMouseWheel(ByVal wheel As Long, ByVal direction As Long, ByVal x As Long, ByVal y As Long)
    On Error GoTo Error
    Call NormalInput.MouseWheel(Direction, Direction)
    Exit Sub

    Error:
    ErrorNum = 3
End Sub

Public Sub VBGLTestModelsPassiveMotion(ByVal x As Long, ByVal y As Long)
    On Error GoTo Error
    Call NormalInput.MouseMove(0, X - LastX, Y - LastY, True)
    LastX = x
    LastY = y
    Exit Sub

    Error:
    ErrorNum = 4
End Sub

Private Sub UpdateShader(ByVal CurrentShader As VBGLShader, ByVal Translate As IMatrixSingle)
    On Error GoTo Error
    CurrentShader.Uniforms.Data("View") = Camera.GetView.Data
    CurrentShader.Uniforms.Data("Projection") = Camera.GetPerspective(Window.Width, Window.Height, 0.1!, 100!).Data

    Dim CPos As IMatrixSingle
    Set CPos = Camera.GetPosition
    CurrentShader.Uniforms.Data("ViewPosition") = CPos.DataColumn(0, 2)
    Call CurrentShader.Uniforms.DataArr("LightPosition", Translate.Item(0, 3), Translate.Item(1, 3), Translate.Item(2, 3))
    Call CurrentShader.Uniforms.DataArr("LightColor", +1.0!, +1.0!, +1.0!)
    Exit Sub

    Error:
    ErrorNum = 5
End Sub

Private Function CreateInput() As VBGLIInput
    On Error GoTo Error
    Dim Temp As VBGLGeneralInput
    Set Temp = New VBGLGeneralInput
    Dim DeltaTime As std_Callable
    Set DeltaTime = std_Callable.Create(CurrentTimer, "DeltaTime", VbMethod, -1)
    Call Temp.AddKey(Asc("w"), std_Callable.Create(Camera        , "Move"               ,  vbMethod, 1).Bind(VBGLCameraMovement.FORWARD  , 1).FixArgs(True)) 'DeltaTime
    Call Temp.AddKey(Asc("s"), std_Callable.Create(Camera        , "Move"               ,  vbMethod, 1).Bind(VBGLCameraMovement.BACKWARD , 1).FixArgs(True)) 'DeltaTime
    Call Temp.AddKey(Asc("a"), std_Callable.Create(Camera        , "Move"               ,  vbMethod, 1).Bind(VBGLCameraMovement.LEFT     , 1).FixArgs(True)) 'DeltaTime
    Call Temp.AddKey(Asc("d"), std_Callable.Create(Camera        , "Move"               ,  vbMethod, 1).Bind(VBGLCameraMovement.RIGHTT   , 1).FixArgs(True)) 'DeltaTime
    Call Temp.AddKey(Asc(" "), std_Callable.Create(Camera        , "Move"               ,  vbMethod, 1).Bind(VBGLCameraMovement.UPP      , 1).FixArgs(True)) 'DeltaTime
    Call Temp.AddKey(Asc("y"), std_Callable.Create(Camera        , "Move"               ,  vbMethod, 1).Bind(VBGLCameraMovement.DOWN     , 1).FixArgs(True)) 'DeltaTime
    Call Temp.AddKey(27      , std_Callable.Create(Nothing       , "RemoveRenderObject" ,  vbMethod, -1))

    Call Temp.AddWheel(+1, std_Callable.Create(Camera, "Zoom", vbMethod, 0).Bind(+1).FixArgs(True))
    Call Temp.AddWheel(-1, std_Callable.Create(Camera, "Zoom", vbMethod, 0).Bind(-1).FixArgs(True))
    Call Temp.AddMouse(0 , std_Callable.Create(Camera, "Look", vbMethod, 2))

    Set CreateInput = Temp
    Exit Function

    Error:
    ErrorNum = 6
End Function