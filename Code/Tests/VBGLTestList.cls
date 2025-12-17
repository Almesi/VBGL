Attribute VB_Name = "VBGLTestList"


Option Explicit

Private List As VBGLList

Private ErrorNum As Long

Public Function VBGLTestList1() As Long
    On Error GoTo Error
    Dim Path As String
    Path = ThisWorkbook.Path
    Set List = CreateList(Path & "\Res", Path & "\Res\Fonts", Path & "\Res\Fruits")

    Dim VBGLTestList1RenderObject As VBGLRenderObject
    Set VBGLTestList1RenderObject = VBGLRenderObject.Create(Nothing, Window.Frame)

    With VBGLTestList1RenderObject.Callbacks
        Call .SetDisplayFunc(std_Callable.Create(Nothing       , "VBGLTestListLoop"          , vbMethod, -1))
        Call .SetIdleFunc(std_Callable.Create(Nothing          , "VBGLTestListLoop"          , vbMethod, -1))
        Call .SetKeyboardFunc(std_Callable.Create(Nothing      , "VBGLTestListKeyBoard"      , vbMethod, 2))
        Call .SetMouseWheelFunc(std_Callable.Create(Nothing    , "VBGLTestListMouseWheel"    , vbMethod, 3))
        Call .SetPassiveMotionFunc(std_Callable.Create(Nothing , "VBGLTestListPassiveMotion" , vbMethod, 1))
    End With
    Call AddRenderObject(VBGLTestList1RenderObject)
    Finish:
    VBGLTestList1 = ErrorNum
    Exit Function

    Error:
    ErrorNum = 1
    GoTo Finish
End Function

Private Function CreateList(ByVal LoadFilePath As String, ByVal FilePath As String, ByVal FruidFolder As String) As VBGLList
    On Error GoTo Error

    Dim Temp As VBGLProperties
    Set Temp = VBGLProperties.Create()
    Temp.Value("X") = -0.1!
    Temp.Value("Y") = 0.1!
    Temp.Value("Z") = 0.0!

    Dim WhiteBackground(3) As Single
    WhiteBackground(0) = 1
    WhiteBackground(1) = 1
    WhiteBackground(2) = 1
    WhiteBackground(3) = 1
    Dim RedBackground(3) As Single
    RedBackground(0) = 1
    RedBackground(3) = 1

    Set CreateList = VBGLList.Create(Temp)
    With CreateList
        Call .AddRows(2)

        Call .AddElement(0, CreateTextBox("Press ESC to leave test", LoadFilePath, FilePath))

        Call .AddElement(1, CreateTextBox("Apple", LoadFilePath, FilePath), WhiteBackground)
        Call .AddElement(1, CreateFruit(FruidFolder & "\Apple.png"), WhiteBackground)

        Call .AddElement(2, CreateTextBox("Banana", LoadFilePath, FilePath), RedBackground)
        Call .AddElement(2, CreateFruit(FruidFolder & "\Banana.png"), RedBackground)
        Call .Build()
    End With

    Exit Function

    Error:
    ErrorNum = 2
End Function

Private Function CreateTextBox(ByVal Text As String, ByVal LoadFilePath As String, ByVal FilePath As String) As VBGLTextBox
    On Error GoTo Error

    Dim Temp As VBGLProperties
    Set Temp = VBGLTextBox.CreateProperties(2, 3)
    Call Temp.LetValueFamily("TopLeft*"     , -1.0!, +0.0!, +0.0!)
    Call Temp.LetValueFamily("TopRight*"    , +1.0!, +0.0!, +0.0!)
    Call Temp.LetValueFamily("BottomLeft*"  , -1.0!, -1.0!, +0.0!)
    Call Temp.LetValueFamily("BottomRight*" , +1.0!, -1.0!, +0.0!)
    Call Temp.LetValueFamily("Color*"       , +1.0!, +1.0!, +1.0!, +0.0!)

    Dim Fonts() As VBGLFont
    ReDim Fonts(0)
    Set Fonts(0) = VBGLFont.Create(Text, ConsolasFont)
    Fonts(0).Scalee = 10

    VBGLTextBox.CharsPerLine   = 32
    VBGLTextBox.LinesPerPage   = 16
    VBGLTextBox.Pages          = 1
    VBGLTextBox.LineOffset     = 0.1!
    Set CreateTextBox = VBGLTextBox.Create(Temp, Fonts)
    Exit Function

    Error:
    ErrorNum = 2
End Function

Private Function CreateFruit(ByVal FilePath As String) As VBGLMesh
    Dim Pos()  As Single     : Pos = VBGLBaFoRectangleXY
    Dim Tex()  As Single     : Tex = VBGLBaTxRectangleXY
    Dim Arr()  As Single     : Call VBGLArrayInsert(Arr, Pos, Tex, 2, 2)
    Dim Shader As VBGLShader : Set Shader = VBGLPrCoShaderXYTxTy
    Dim Layout As VBGLLayout : Set Layout = VBGLPrCoLayoutXYTxTy
    Dim Data   As VBGLData   : Set Data   = VBGLData.CreateSingle(Arr)
    Set CreateFruit = VBGLMesh.Create(Shader, Layout, Data)
    Call CreateFruit.AddTexture(VBGLTexture.Create(FilePath))
End Function

Public Sub VBGLTestListLoop()
    On Error GoTo Error
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0, 1, 1, 1)
    Call List.Draw()
    Call glutSwapBuffers
    Exit Sub

    Error:
    ErrorNum = 3
End Sub

Public Sub VBGLTestListKeyBoard(ByVal Char As Byte, ByVal x As Long, ByVal y As Long)
    On Error GoTo Error
    Static FirstButton As Boolean
    Dim Temp As Long
    Temp = Char
    Select Case Temp
        Case 27: Call RemoveRenderObject()
    End Select

    Error:
    ErrorNum = 4
End Sub

Public Sub VBGLTestListMouseWheel(ByVal wheel As Long, ByVal direction As Long, ByVal x As Long, ByVal y As Long)
    ' Nothing, to not have residues of other tests
End Sub

Public Sub VBGLTestListPassiveMotion(ByVal x As Long, ByVal y As Long)
    ' Nothing, to not have residues of other tests
End Sub