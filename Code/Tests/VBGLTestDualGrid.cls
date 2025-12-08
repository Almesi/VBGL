Attribute VB_Name = "VBGLTestDualGrid"

Option Explicit

Private Window            As VBGLWindow
Private NormalInput       As VBGLIInput
Private CurrentTimer      As VBGLTimer
Private LastChar          As Byte
Private Grid              As VBGLDualGrid
Private ExplainBox        As VBGLTextBox

Private X As Long
Private Y As Long

Private ErrorNum          As Long

Public Function VBGLTestDualGrid1() As Long
    On Error GoTo Error
    Dim Path As String
    Path = ThisWorkbook.Path
    Set Window = CurrentContext.CurrentWindow
    CurrentContext.BlendTest = True 
    CurrentContext.DepthTest = True
    CurrentContext.CullTest = True
    Call CurrentContext.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    Call CurrentContext.CullFace(GL_BACK)

    Set Grid = CreateGrid(Path & "\Res\Tiles")
    Set ExplainBox = CreateExplainBox()

    Set NormalInput = CreateInput()

    Dim VBGLTestDualGridRenderObject As VBGLRenderObject
    Set VBGLTestDualGridRenderObject = VBGLRenderObject.Create(NormalInput, Window.Frame)
    Call VBGLTestDualGridRenderObject.AddDrawable(Grid)
    Call VBGLTestDualGridRenderObject.AddDrawable(ExplainBox)

    With VBGLTestDualGridRenderObject.Callbacks
        Call .SetDisplayFunc(std_Callable.Create(Nothing       , "VBGLTestDualGridLoop"          , vbMethod, -1))
        Call .SetIdleFunc(std_Callable.Create(Nothing          , "VBGLTestDualGridLoop"          , vbMethod, -1))
        Call .SetKeyboardFunc(std_Callable.Create(Nothing      , "VBGLTestDualGridKeyBoard"      , vbMethod, 2))
        Call .SetPassiveMotionFunc(std_Callable.Create(Nothing , "VBGLTestDualGridPassiveMotion" , vbMethod, 1))
        Call .SetMouseWheelFunc(std_Callable.Create(Nothing    , "VBGLTestDualGridMouseWheel"    , vbMethod, 3))
    End With
    Call AddRenderObject(VBGLTestDualGridRenderObject)
    Finish:
    VBGLTestDualGrid1 = ErrorNum
    Exit Function

    Error:
    ErrorNum = 6
    GoTo Finish
End Function




Public Sub VBGLTestDualGridLoop()
    On Error GoTo Error
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0.7, 0, 0.5, 1)
    Call Grid.Draw()
    Call ExplainBox.Draw()
    Call glutSwapBuffers()
    Exit Sub

    Error:
    ErrorNum = 1
End Sub

Public Sub VBGLTestDualGridKeyBoard(ByVal Char As Byte, ByVal x As Long, ByVal y As Long)
    On Error GoTo Error
    LastChar = Char
    Call NormalInput.KeyDown(CLng(Char))
    Exit Sub

    Error:
    ErrorNum = 2
End Sub

Public Sub VBGLTestDualGridMouseWheel(ByVal wheel As Long, ByVal direction As Long, ByVal x As Long, ByVal y As Long)
End Sub

Public Sub VBGLTestDualGridPassiveMotion(ByVal x As Long, ByVal y As Long)
End Sub

Public Sub LetX(ByVal Value As Long)
    X = X + Value
End Sub
Public Sub LetY(ByVal Value As Long)
    Y = Y + Value
End Sub

Public Function GetX() As Long
    GetX = X
End Function
Public Function GetY() As Long
    GetY = Y
End Function

Private Function CreateGrid(ByVal FolderPath As String) As VBGLDualGrid
    Dim Layout As VBGLLayout
    Set Layout = VBGLPrCoLayoutXYZTxTy

    Dim Tiles() As Long
    Tiles = ArrayLong( _
                            ArrayLong(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 2, 2, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 2), _
                            ArrayLong(2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 1, 0, 2), _
                            ArrayLong(2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 2), _
                            ArrayLong(2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2), _
                            ArrayLong(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)  _
                        )
    Set CreateGrid = VBGLDualGrid.CreateFromFolder(FolderPath, False)
    Call CreateGrid.SetUp(Layout, Tiles)

    Dim z() As Single
    Call VBGLArrayCreate(z, 0.5, 15, 15)
    Call CreateGrid.ParseData(0, CreateGrid.GetPositionData(z))
    Call CreateGrid.ParseData(1, CreateGrid.GetSubTextureData())
    Call CreateGrid.Build()
End Function

Private Function CreateInput() As VBGLIInput
    On Error GoTo Error
    Dim Temp As VBGLGeneralInput
    Set Temp = New VBGLGeneralInput

    Dim GetXFunc As std_Callable : Set GetXFunc = std_Callable.Create(Nothing, "GetX", vbMethod, -1)
    Dim GetYFunc As std_Callable : Set GetYFunc = std_Callable.Create(Nothing, "GetY", vbMethod, -1)

    Call Temp.AddKey(Asc("w")    , std_Callable.Create(Nothing, "LetY", vbMethod, 0).Bind(-1).FixArgs(True))
    Call Temp.AddKey(Asc("a")    , std_Callable.Create(Nothing, "LetX", vbMethod, 0).Bind(-1).FixArgs(True))
    Call Temp.AddKey(Asc("s")    , std_Callable.Create(Nothing, "LetY", vbMethod, 0).Bind(+1).FixArgs(True))
    Call Temp.AddKey(Asc("d")    , std_Callable.Create(Nothing, "LetX", vbMethod, 0).Bind(+1).FixArgs(True))

    Call Temp.AddKey(Asc("w")    , std_Callable.Create(Grid, "LookAt", vbMethod, 3).Bind(GetXFunc, GetYFunc, 9, 9).FixArgs(True))
    Call Temp.AddKey(Asc("a")    , std_Callable.Create(Grid, "LookAt", vbMethod, 3).Bind(GetXFunc, GetYFunc, 9, 9).FixArgs(True))
    Call Temp.AddKey(Asc("s")    , std_Callable.Create(Grid, "LookAt", vbMethod, 3).Bind(GetXFunc, GetYFunc, 9, 9).FixArgs(True))
    Call Temp.AddKey(Asc("d")    , std_Callable.Create(Grid, "LookAt", vbMethod, 3).Bind(GetXFunc, GetYFunc, 9, 9).FixArgs(True))

    Call Temp.AddKey(27          , std_Callable.Create(Nothing       , "RemoveRenderObject" ,  vbMethod, -1))



    Set CreateInput = Temp
    Exit Function

    Error:
    ErrorNum = 6
End Function

Private Function CreateExplainBox() As VBGLTextBox
    On Error GoTo Error

    Dim Temp As VBGLProperties
    Set Temp = VBGLTextBox.CreateProperties(2, 3)
    Call Temp.LetValueFamily("TopLeft*"     , -1.0!, +1.0!, +0.0!)
    Call Temp.LetValueFamily("TopRight*"    , +0.0!, +1.0!, +0.0!)
    Call Temp.LetValueFamily("BottomLeft*"  , -1.0!, +0.7!, +0.0!)
    Call Temp.LetValueFamily("BottomRight*" , +0.0!, +0.7!, +0.0!)
    Call Temp.LetValueFamily("Color*"       , +1.0!, +0.0!, +0.0!, +1.0!)

    Dim Text As String
    Text = "wasd to move, esc to go back"

    VBGLTextBox.CharsPerLine   = 128
    VBGLTextBox.LinesPerPage   = 128
    VBGLTextBox.Pages          = 1
    VBGLTextBox.LineOffset     = 0.1!
    Set CreateExplainBox = VBGLTextBox.CreateFromText(Temp, Text, ConsolasFont)
    Exit Function

    Error:
    ErrorNum = 6
End Function