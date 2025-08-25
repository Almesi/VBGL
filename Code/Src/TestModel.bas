Attribute VB_Name = "TestModel"


Option Explicit

Public CapsuleShader     As VBGLShader
Public CubeShader        As VBGLShader
Public Window            As VBGLWindow
Public Camera            As VBGLCamera
Public CapsuleModel      As VBGLModel
Public CubeModel         As VBGLModel
Public TextBox           As VBGLTextBox



Public LastX As Single
Public LastY As Single

Public Sub TestFunc()
    Debug.Print RunMain(ThisWorkBook.Path & "\Res")
End Sub

Public Function RunMain(Path As String) As Long
    Set CurrentContext = VBGLContext.Create(Path, GLUT_CORE_PROFILE, GLUT_DEBUG)
    Set Window = VBGLWindow.Create(1600, 900, GLUT_RGBA, "OpenGL Test", "4_6", True)
    CurrentContext.BlendTest = True 
    CurrentContext.DepthTest = True
    CurrentContext.CullFace = True
    Call CurrentContext.RenderValue(GL_BLEND, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    Call CurrentContext.RenderValue(GL_CULL_FACE, GL_BACK)
    Call glFrontFace(GL_CCW)


    Dim NewLoader As VBGLFileLoader
    Dim MtlLoader As IMtlLoader
    Dim ObjLoader As IObjLoader

    Set NewLoader = New VBGLFileLoader
    Set MtlLoader = MtlParser.Create(NewLoader, ",")
    Set ObjLoader = GLFileObject.Create(NewLoader, ",")
    Set CapsuleModel = VBGLModel.Create(NewLoader, Path & "\Capsule", ObjLoader, MtlLoader)
    Set CapsuleShader = LoadedShaders(2)
    If IsNothing(CapsuleShader) Then Exit Function

    Set NewLoader  = New VBGLFileLoader
    Set MtlLoader  = MtlParser.Create(NewLoader, ",")
    Set ObjLoader  = GLFileObject.Create(NewLoader, ",")
    Set CubeModel  = VBGLModel.Create(NewLoader, Path & "\Cube", ObjLoader, MtlLoader)
    Set CubeShader = LoadedShaders(2)
    If IsNothing(CubeShader) Then Exit Function

    Set Camera = VBGLCamera.Create(0, 0, 10,    0, 1, 0,    -90, 0, 0,    0.5, 0.5, 45)

    Set TextBox = CreateTextBox(Path & "\Fonts")
    
    LastX = 800
    LastY = 450
    Call Window.Cursor(CLng(LastX), CLng(LastY))

    With CurrentContext
        Call .SetCallBack(VBGLGlutCallback.VBGLDisplayFunc       , AddressOf DrawLoop)
        Call .SetCallBack(VBGLGlutCallback.VBGLIdleFunc          , AddressOf DrawLoop)
        Call .SetCallBack(VBGLGlutCallback.VBGLKeyboardFunc      , AddressOf CallBackKeyBoard)
        Call .SetCallBack(VBGLGlutCallback.VBGLPassiveMotionFunc , AddressOf CallBackPassiveMotion)
        Call .SetCallBack(VBGLGlutCallback.VBGLMouseWheelFunc    , AddressOf CallBackMouseWheel)
        Call .MainLoop()
    End With
End Function

Public Sub DrawLoop()
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
    Call CapsuleShader.SetAny("Model", Rotation.Data)
    Call CapsuleModel.Draw()

    Call UpdateShader(CubeShader, Translate)
    Call CubeShader.SetAny("Model", Translate.Add(Rotation.Data, Translate.Data))


    Call CubeModel.Draw()
    Call TextBox.Draw()
    Call glutSwapBuffers
End Sub

Public Sub UpdateShader(CurrentShader As VBGLShader, Translate As IMatrixSingle)
    Call CurrentShader.Bind()
    Call CurrentShader.SetAny("View", Camera.GetView.Data)
    Call CurrentShader.SetAny("Projection", Camera.GetPerspective(Window.Width, Window.Height, 0.1!, 100!).Data)

    Dim CPos As IMatrixSingle
    Set CPos = Camera.GetPosition
    Dim Foo() As Single
    ReDim Foo(2)
    Foo(0) = CPos.Item(0, 0)
    Foo(1) = CPos.Item(0, 1)
    Foo(2) = CPos.Item(0, 2)
    Call CurrentShader.SetAny("ViewPosition", Foo)
    Call CurrentShader.Set3f("LightPosition"  , Translate.Item(0, 3), Translate.Item(1, 3), Translate.Item(2, 3))
    Call CurrentShader.Set3f("LightColor"     , +1.0, +1.0, +1.0)
End Sub

Public Function CreateTextBox(Path As String) As VBGLTextBox
    Dim TopLeft()     As Single : ReDim TopLeft(2)     : TopLeft(0)     = -1: TopLeft(1)     = +0: TopLeft(2)     = 0
    Dim TopRight()    As Single : ReDim TopRight(2)    : TopRight(0)    = +1: TopRight(1)    = +0: TopRight(2)    = 0
    Dim BottomLeft()  As Single : ReDim BottomLeft(2)  : BottomLeft(0)  = -1: BottomLeft(1)  = -1: BottomLeft(2)  = 0
    Dim BottomRight() As Single : ReDim BottomRight(2) : BottomRight(0) = +1: BottomRight(1) = -1: BottomRight(2) = 0
    Dim Color()       As Single : ReDim Color(3)       : Color(0)       = +1: Color(1)       = +1: Color(2)       = 1:Color(3)       = 0
    Dim FontColor()   As Single : ReDim FontColor(2)   : FontColor(0)   = +1: FontColor(1)   = +0: FontColor(2)   = 0
    Dim CharsPerLine  As Long   : CharsPerLine = 16
    Dim FontLayout As VBGLFontLayout
    Set FontLayout = VBGLFontLayout.Create(Path & "\Consolas.png", 665, 1080, 16, "UTF8", "Consolas")
    Dim Fonts() As VBGLFont
    ReDim Fonts(0)
    Set Fonts(0) = New VBGLFont
    Fonts(0).FontLayout = FontLayout
    Fonts(0).Text = "Test Text"
    Fonts(0).FontColor = FontColor

    Set CreateTextBox = VBGLTextBox.Create(TopLeft, TopRight, BottomLeft, BottomRight, Color, CharsPerLine, Fonts)
    Call CreateTextBox.CreateMesh()
End Function

Public Sub CallBackKeyBoard(ByVal Char As Byte, ByVal x As Long, ByVal y As Long)
    Dim Temp As Long
    Temp = Char
    Select Case Temp
        Case Asc("w"): Call Camera.Move(VBGLCameraMovement.FORWARD  , DeltaTime())
        Case Asc("s"): Call Camera.Move(VBGLCameraMovement.BACKWARD , DeltaTime())
        Case Asc("a"): Call Camera.Move(VBGLCameraMovement.LEFT     , DeltaTime())
        Case Asc("d"): Call Camera.Move(VBGLCameraMovement.RIGHTT   , DeltaTime())
        Case Asc(" "): Call Camera.Move(VBGLCameraMovement.UPP      , DeltaTime())
        Case Asc("y"): Call Camera.Move(VBGLCameraMovement.DOWN     , DeltaTime())
        Case 27: Call glutLeaveMainLoop()
        Case 32 To 255
            TextBox.Font(0).Text = TextBox.Font(0).Text & Chr(Char)
            Call TextBox.UpdateData()
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