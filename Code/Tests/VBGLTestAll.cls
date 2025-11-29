Attribute VB_Name = "VBGLTestAll"


Option Explicit

Private RenderStack() As VBGLRenderObject

Private TestFramework As VBGLTestFramework
Private TextBox       As VBGLTextBox
Private ExplainBox    As VBGLTextBox
Private TestIndex     As Long

Public Window As VBGLWindow
Public ConsolasFont As VBGLFontLayout

Private ErrorNum As Long

Public Function TestAll1(ByVal Path As String, ByVal Logger As IDestination, ByVal Shower As IDestination) As Long
    On Error GoTo Error
    Set CurrentContext = VBGLContext.Create(Path & "\Src\Graphics\Core", GLUT_CORE_PROFILE, GLUT_DEBUG, Logger, Shower)
    If IsNothing(CurrentContext) Then GoTo Error
    Set Window = VBGLWindow.Create(1600, 900, GLUT_RGBA, "OpenGL Test", "4_6", True)
    CurrentContext.BlendTest = True 
    CurrentContext.DepthTest = True
    CurrentContext.CullTest = True
    CurrentContext.ScissorTest = True
    Call CurrentContext.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    Call CurrentContext.CullFace(GL_BACK)

    Set ConsolasFont = VBGLFontLayout.Create(Path & "\Src\Graphics\Extensions\Drawables\TextRendering", Path & "\Res\Fonts\Consolas.ttf", 48, "Consolas")
    Set TestFramework = VBGLTestFramework.CreateFromProject(ThisWorkbook.VBProject, "Public Function VBGLTest")

    Set TextBox    = CreateTextBox()
    Set ExplainBox = CreateExplainBox()

    Dim TestAll1RenderObject As VBGLRenderObject
    Set TestAll1RenderObject = VBGLRenderObject.Create(CreateInput(), Window.Frame)


    Application.EnableCancelKey = xlDisabled
    With TestAll1RenderObject
        Call .AddDrawable(TextBox)
        Call .AddDrawable(ExplainBox)
    End With
    Call AddRenderObject(TestAll1RenderObject)
    Debug.Print CurrentContext.CurrentWindow.LimitFPS


    Call VBGLCallbackFunc("DisplayFunc")
    Call VBGLCallbackFunc("IdleFunc")
    Call VBGLCallbackFunc("KeyboardFunc")
    Call VBGLCallbackFunc("PassiveMotionFunc")
    Call VBGLCallbackFunc("MouseWheelFunc")
    Call CurrentContext.MainLoop()

    Finish:
    TestAll1 = ErrorNum
    Exit Function

    Error:
    ErrorNum = 1
    GoTo Finish
End Function

Public Sub AddRenderObject(ByVal Obj As VBGLRenderObject)
    Call VBGLAdd(RenderStack, Obj)
    Set CurrentRenderObject = Obj
End Sub

Public Sub RemoveRenderObject()
    Call VBGLArrayPop(RenderStack)
    Set CurrentRenderObject = RenderStack(USize(RenderStack))
End Sub


Public Function GetTestIndex() As Long
    GetTestIndex = TestIndex
End Function

Public Sub IncrementTestIndex(ByVal Value As Long)
    TestIndex = TestIndex + Value
    If Value > 0 Then
        If TestIndex < 0 Then TestIndex = 0
    Else
        If TestIndex > USize(TestFramework.AllTests) Then TestIndex = USize(TestFramework.AllTests)
    End If
End Sub



Private Function CreateInput() As VBGLIInput
    Dim Inputt As VBGLGeneralInput
    Set Inputt = VBGLGeneralInput.Create()
    Dim Temp As std_Callable
    Set Temp = std_Callable.Create(Nothing, "GetTestIndex", vbMethod, -1)
    With Inputt
        Call .AddKey(Asc("w"), std_Callable.Create(Nothing      , "IncrementTestIndex" , vbMethod, 0).Bind(-1).FixArgs(True))
        Call .AddKey(Asc("s"), std_Callable.Create(Nothing      , "IncrementTestIndex" , vbMethod, 0).Bind(+1).FixArgs(True))
        Call .AddKey(Asc(" "), std_Callable.Create(TestFramework, "ChangeSelectTest"   , vbMethod, 0).Bind(Temp).FixArgs(True))
        Call .AddKey(Asc("t"), std_Callable.Create(TestFramework, "TestAll"            , vbMethod, 0).Bind(0).FixArgs(True))

        Call .AddKey(Asc("w"), std_Callable.Create(Nothing      , "UpdateTestBox"      , vbMethod, -1).FixArgs(True))
        Call .AddKey(Asc("s"), std_Callable.Create(Nothing      , "UpdateTestBox"      , vbMethod, -1).FixArgs(True))
        Call .AddKey(Asc(" "), std_Callable.Create(Nothing      , "UpdateTestBox"      , vbMethod, -1).FixArgs(True))
        Call .AddKey(Asc("t"), std_Callable.Create(Nothing      , "UpdateTestBox"      , vbMethod, -1).FixArgs(True))

        Call .AddKey(27      , std_Callable.Create(Nothing      , "glutLeaveMainLoop"  , vbMethod, -1).FixArgs(True))
    End With
    Set CreateInput = Inputt
End Function

Private Function CreateTextBox() As VBGLTextBox
    On Error GoTo Error

    Dim Temp As VBGLProperties
    Set Temp = VBGLTextBox.CreateProperties(2, 3)
    Call Temp.LetValueFamily("TopLeft*"     , -1.0!, +0.0!, +0.0!)
    Call Temp.LetValueFamily("TopRight*"    , +1.0!, +0.0!, +0.0!)
    Call Temp.LetValueFamily("BottomLeft*"  , -1.0!, -1.0!, +0.0!)
    Call Temp.LetValueFamily("BottomRight*" , +1.0!, -1.0!, +0.0!)
    Call Temp.LetValueFamily("Color*"       , +1.0!, +1.0!, +1.0!, +1.0!)


    Dim Fonts() As VBGLFont
    ReDim Fonts(USize(TestFramework.AllTests))
    Dim i As Long
    For i = 0 To USize(TestFramework.AllTests)
        Set Fonts(i) = VBGLFont.Create(TestFramework.GetTest(i).Name & vbcrLf, ConsolasFont)
        Fonts(i).BackgroundColor = Temp.GetValueFamily("Color*")
    Next i

    VBGLTextBox.CharsPerLine   = 128
    VBGLTextBox.LinesPerPage   = 128
    VBGLTextBox.Pages          = 1
    VBGLTextBox.LineOffset     = 0.1!
    Set CreateTextBox = VBGLTextBox.Create(Temp, Fonts)
    Exit Function

    Error:
    ErrorNum = 4
End Function

Private Function CreateExplainBox() As VBGLTextBox
    On Error GoTo Error

    Dim Temp As VBGLProperties
    Set Temp = VBGLTextBox.CreateProperties(2, 3)
    Call Temp.LetValueFamily("TopLeft*"     , -1.0!, +1.0!, +0.0!)
    Call Temp.LetValueFamily("TopRight*"    , +1.0!, +1.0!, +0.0!)
    Call Temp.LetValueFamily("BottomLeft*"  , -1.0!, +0.0!, +0.0!)
    Call Temp.LetValueFamily("BottomRight*" , +1.0!, +0.0!, +0.0!)
    Call Temp.LetValueFamily("Color*"       , +1.0!, +0.0!, +0.0!, +1.0!)

    Dim Text As String
    Text = "Black   is not selected and not run"                 & vbcrLf & _
           "White   is     selected and not run"                 & vbcrLf & _
           "Green   is not selected and run sucessfully"         & vbcrLf & _
           "Blue    is     selected and run succesfully"         & vbcrLf & _
           "Red     is not selected and run failed"              & vbcrLf & _
           "yellow  is     selected and run failed"              & vbcrLf & _
           "w=up, s=down, whitespace=select, t=run selected"     & vbcrLf

    VBGLTextBox.CharsPerLine   = 128
    VBGLTextBox.LinesPerPage   = 128
    VBGLTextBox.Pages          = 1
    VBGLTextBox.LineOffset     = 0.1!
    Set CreateExplainBox = VBGLTextBox.CreateFromText(Temp, Text, ConsolasFont)
    Exit Function

    Error:
    ErrorNum = 6
End Function

Public Sub UpdateTestBox()
    On Error GoTo Error
    Dim i As Long
    Dim FoundTest As VBGLTest
    Dim BackgroundColor() As Single
    ReDim BackgroundColor(3)
    For i = 0 To USize(TestFramework.AllTests)
        Set FoundTest = TestFramework.GetTest(i)
        If FoundTest.HasRun Then
            If FoundTest.Passed Then
                If TestFramework.IsSelected(i) Then
                    BackgroundColor(0) = 0
                    BackgroundColor(1) = 0
                    BackgroundColor(2) = 1
                    BackgroundColor(3) = 1
                Else
                    BackgroundColor(0) = 0
                    BackgroundColor(1) = 1
                    BackgroundColor(2) = 0
                    BackgroundColor(3) = 1
                End If
            Else
                If TestFramework.IsSelected(i) Then
                    BackgroundColor(0) = 1
                    BackgroundColor(1) = 1
                    BackgroundColor(2) = 0
                    BackgroundColor(3) = 1
                Else
                    BackgroundColor(0) = 1
                    BackgroundColor(1) = 0
                    BackgroundColor(2) = 0
                    BackgroundColor(3) = 1
                End If
            End If
        Else
            If TestFramework.IsSelected(i) Then
                BackgroundColor(0) = 0
                BackgroundColor(1) = 1
                BackgroundColor(2) = 1
                BackgroundColor(3) = 1
            Else
                BackgroundColor = TextBox.Properties.GetValueFamily("Color*")
            End If
        End If
        TextBox.Font(i).BackgroundColor = BackgroundColor
    Next i
    Call TextBox.UpdateData()
    Exit Sub

    Error:
    ErrorNum = 5
End Sub