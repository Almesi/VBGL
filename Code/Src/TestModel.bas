Attribute VB_Name = "TestModel"


Option Explicit

Public Shader            As VBGLShader
Public Window            As VBGLWindow
Public Camera            As VBGLCamera
Public TeaModel          As Model

Public LastX As Single
Public LastY As Single

Public Sub TestFunc()
    Debug.Print RunMain(ThisWorkBook.Path & "\Res")
End Sub

Public Function RunMain(Path As String) As Long
    Set VBGLContext = VBGLContext.Create(Path, GLUT_CORE_PROFILE, GLUT_DEBUG)
    Set Window = VBGLWindow.Create(1600, 900, GLUT_RGBA, "OpenGL Test", "4_6", True)
    VBGLContext.BlendTest = True 
    VBGLContext.DepthTest = True
    VBGLContext.CullFace = True
    Call VBGLContext.RenderValue(GL_BLEND, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    Call VBGLContext.RenderValue(GL_CULL_FACE, GL_BACK)
    Call glFrontFace(GL_CCW)


    Dim NewLoader As GLFileLoader: Set NewLoader = New GLFileLoader
    Dim MtlLoader As IMtlLoader  : Set MtlLoader = MtlParser.Create(NewLoader, ",")
    Dim ObjLoader As IObjLoader  : Set ObjLoader = GLFileObject.Create(NewLoader, ",")
    Set TeaModel = Model.Create(NewLoader, Path & "\Capsule", ObjLoader, MtlLoader)
    Set Shader = TeaModel.LoadedShaders()(0)
    If Shader Is Nothing Then Exit Function
    Set Camera = VBGLCamera.Create(0, 0, 10,    0, 1, 0,    -90, 0, 0,    0.5, 0.5, 45)
    
    LastX = 800
    LastY = 450
    Call Window.Cursor(CLng(LastX), CLng(LastY))

    With VBGLContext
        Call .SetCallBack(VBGLGlutCallback.VBGLDisplayFunc       , AddressOf DrawLoop)
        Call .SetCallBack(VBGLGlutCallback.VBGLIdleFunc          , AddressOf DrawLoop)
        Call .SetCallBack(VBGLGlutCallback.VBGLKeyboardFunc      , AddressOf CallBackKeyBoard)
        Call .SetCallBack(VBGLGlutCallback.VBGLPassiveMotionFunc , AddressOf CallBackPassiveMotion)
        Call .SetCallBack(VBGLGlutCallback.VBGLMouseWheelFunc    , AddressOf CallBackMouseWheel)
        Call .MainLoop()
    End With
End Function

Public Sub DrawLoop()
    Call Shader.Bind()
    Call Shader.SetMatrix4fv("View"      , 1, GL_FALSE, Camera.GetView.Data)
    Call Shader.SetMatrix4fv("Projection", 1, GL_FALSE, Camera.GetPerspective(Window.Width, Window.Height, 0.1!, 100!).Data)

    Dim ThetaF As Single
    Static Count As Single
    Static Direction As Single

    ThetaF = Count * 3.14159265 / 180
    Count = Count + 1
    If Count >= 360 Then Direction = -1
    If Count =< 000 Then Direction = +1


    Dim Rotation As IMatrixSingle
    Set Rotation = VBGLMatrix.Create(vbSingle, 3, 3)
    Rotation.Data = Rotation.Rotate(3, ThetaF, ThetaF, ThetaF)
    Call Shader.SetMatrix4fv("Rotation", 1, GL_FALSE, Rotation.Data)

    Call glClear(GL_COLOR_BUFFER_BIT OR GL_DEPTH_BUFFER_BIT)
    Call glClearColor(0.7, 0, 0.5, 1)
    Call TeaModel.Draw()
    Call glutSwapBuffers
End Sub

Public Sub CallBackKeyBoard(ByVal char As Byte, ByVal x As Long, ByVal y As Long)
    Dim Temp As Long
    Temp = char
    Select Case Temp
        Case Asc("w"): Call Camera.Move(VBGLCameraMovement.FORWARD  , DeltaTime())
        Case Asc("s"): Call Camera.Move(VBGLCameraMovement.BACKWARD , DeltaTime())
        Case Asc("a"): Call Camera.Move(VBGLCameraMovement.LEFT     , DeltaTime())
        Case Asc("d"): Call Camera.Move(VBGLCameraMovement.RIGHTT   , DeltaTime())
        Case Asc(" "): Call Camera.Move(VBGLCameraMovement.UPP      , DeltaTime())
        Case Asc("y"): Call Camera.Move(VBGLCameraMovement.DOWN     , DeltaTime())
        Case 27: Call glutLeaveMainLoop()
    End Select
End Sub

Public Sub CallBackMouseWheel(ByVal wheel As Long, ByVal direction As Long, ByVal x As Long, ByVal y As Long)
    Call Camera.Zoom(CSng(Direction))
End Sub

Public Sub CallBackPassiveMotion(ByVal x As Long, ByVal y As Long)
    Call Camera.Look(X - LastX, Y - LastY, True)
    LastX = x
    LastY = y
End Sub

Public Function DeltaTime() As Double
    Static LastTime As Double
    DeltaTime = Timer - LastTime
    LastTime = DeltaTime
    If DeltaTime > 1 Then DeltaTime = 1
End Function