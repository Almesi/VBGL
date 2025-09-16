Attribute VB_Name = "VBGLTestAll"


Option Explicit

Private TestFramework As VBGLTestFramework
Private TextBox       As VBGLTextBox
Private ExplainBox    As VBGLTextBox
Private TestIndex     As Long

Private ErrorNum As Long

Public Function TestAll1(ByVal Path As String, ByVal Logger As IDestination, ByVal Shower As IDestination) As Long
    On Error GoTo Error
    Set CurrentContext = VBGLContext.Create(Path & "\Src\Externals", GLUT_CORE_PROFILE, GLUT_DEBUG, Logger, Shower)
    If IsNothing(CurrentContext) Then GoTo Error
    Call VBGLWindow.Create(1600, 900, GLUT_RGBA, "OpenGL Test", "4_6", True)
    CurrentContext.BlendTest = True 
    CurrentContext.DepthTest = True
    CurrentContext.CullFace = True
    Call CurrentContext.RenderSettings(GL_BLEND, True)
    Call CurrentContext.RenderValue(GL_BLEND, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    Call CurrentContext.RenderValue(GL_CULL_FACE, GL_BACK)
    Call glFrontFace(GL_CCW)

    Set TestFramework = VBGLTestFramework.CreateFromProject(ThisWorkbook.VBProject, "Public Function VBGLTest")
    Set TextBox          = CreateTextBox(Path & "\Src\Externals", Path & "\Res\Fonts")
    Set ExplainBox = CreateExplainBox()

    Application.EnableCancelKey = xlDisabled
    With CurrentContext
        Call .SetDisplayFunc(AddressOf       VBGLDisplayFuncStack)
        Call .SetIdleFunc(AddressOf          VBGLIdleFuncStack)
        Call .SetKeyboardFunc(AddressOf      VBGLKeyboardFuncStack)
        Call .SetPassiveMotionFunc(AddressOf VBGLPassiveMotionFuncStack)
        Call .SetMouseWheelFunc(AddressOf    VBGLMouseWheelFuncStack)
        Call .AddDisplayFunc("TestAllLoop")
        Call .AddIdleFunc("TestAllLoop")
        Call .AddKeyboardFunc("TestAllKeyBoard")
        Call .AddPassiveMotionFunc("TestAllPassiveMotion")
        Call .AddMouseWheelFunc("TestAllMouseWheel")
        Call .MainLoop()
    End With
    Finish:
    TestAll1 = ErrorNum
    Exit Function

    Error:
    ErrorNum = 1
    GoTo Finish
End Function

Public Sub TestAllLoop()
    On Error GoTo Error
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0.0, 0.5, 0.5, 1)
    Call TextBox.Draw()
    Call ExplainBox.Draw()
    Call glutSwapBuffers
    Exit Sub

    Error:
    ErrorNum = 2
End Sub

Public Sub TestAllKeyBoard(ByVal Char As Byte, ByVal x As Long, ByVal y As Long)
    On Error GoTo Error
    Dim Temp As Long
    Temp = Char
    Select Case Temp
        Case Asc("w")
            TestIndex = TestIndex - 1
            If TestIndex < 0 Then TestIndex = 0
        Case Asc("s")
            TestIndex = TestIndex + 1
            If TestIndex > USize(TestFramework.AllTests) Then TestIndex = USize(TestFramework.AllTests)
        Case Asc(" ")
            Call TestFramework.ChangeSelectTest(TestIndex)
        Case Asc("t")
            Call TestFramework.TestAll(0)
        Case 27
            Call glutLeaveMainLoop()
    End Select
    Call UpdateTextBox()
    Exit Sub

    Error:
    ErrorNum = 3
End Sub

Public Sub TestAllMouseWheel(ByVal wheel As Long, ByVal direction As Long, ByVal x As Long, ByVal y As Long)
    ' Nothing
End Sub

Public Sub TestAllPassiveMotion(ByVal x As Long, ByVal y As Long)
    ' Nothing
End Sub

Private Function CreateTextBox(ByVal LoadFilePath As String, ByVal FilePath As String) As VBGLTextBox
    On Error GoTo Error
    Dim TopLeft()     As Single : ReDim TopLeft(2)     : TopLeft(0)     = -1: TopLeft(1)     = +0: TopLeft(2)     = 0
    Dim TopRight()    As Single : ReDim TopRight(2)    : TopRight(0)    = +1: TopRight(1)    = +0: TopRight(2)    = 0
    Dim BottomLeft()  As Single : ReDim BottomLeft(2)  : BottomLeft(0)  = -1: BottomLeft(1)  = -1: BottomLeft(2)  = 0
    Dim BottomRight() As Single : ReDim BottomRight(2) : BottomRight(0) = +1: BottomRight(1) = -1: BottomRight(2) = 0
    Dim Color()       As Single : ReDim Color(3)       : Color(0)       = +1: Color(1)       = +1: Color(2)       = 1:Color(3)       = 0
    Dim FontColor()   As Single : ReDim FontColor(2)   : FontColor(0)   = +0: FontColor(1)   = +0: FontColor(2)   = 0

    Dim FontLayout As VBGLFontLayout
    Set FontLayout = VBGLFontLayout.Create(LoadFilePath, FilePath & "\Consolas.ttf", 48, "Consolas")
    Dim Fonts() As VBGLFont
    ReDim Fonts(USize(TestFramework.AllTests))
    Dim i As Long
    For i = 0 To USize(TestFramework.AllTests)
        Set Fonts(i) = New VBGLFont
        Fonts(i).FontLayout = FontLayout
        Fonts(i).Text = TestFramework.GetTest(i).Name & vbcrLf
        Fonts(i).FontColor = FontColor
    Next i

    VBGLTextBox.TopLeft        = TopLeft
    VBGLTextBox.TopRight       = TopRight
    VBGLTextBox.BottomLeft     = BottomLeft
    VBGLTextBox.BottomRight    = BottomRight
    VBGLTextBox.Color          = Color
    VBGLTextBox.CharsPerLine   = 128
    VBGLTextBox.LinesPerPage   = 128
    VBGLTextBox.Pages          = 1
    VBGLTextBox.LineOffset     = 0.1!
    Set CreateTextBox = VBGLTextBox.Create(Fonts)
    Exit Function

    Error:
    ErrorNum = 4
End Function

Private Function CreateExplainBox() As VBGLTextBox
    On Error GoTo Error
    Dim TopLeft()     As Single : ReDim TopLeft(2)     : TopLeft(0)     = -1: TopLeft(1)     = +1: TopLeft(2)     = 0
    Dim TopRight()    As Single : ReDim TopRight(2)    : TopRight(0)    = +1: TopRight(1)    = +1: TopRight(2)    = 0
    Dim BottomLeft()  As Single : ReDim BottomLeft(2)  : BottomLeft(0)  = -1: BottomLeft(1)  = +0: BottomLeft(2)  = 0
    Dim BottomRight() As Single : ReDim BottomRight(2) : BottomRight(0) = +1: BottomRight(1) = +0: BottomRight(2) = 0
    Dim Color()       As Single : ReDim Color(3)       : Color(0)       = +1: Color(1)       = +1: Color(2)       = 1:Color(3)       = 0
    Dim FontColor()   As Single : ReDim FontColor(2)   : FontColor(0)   = +0: FontColor(1)   = +0: FontColor(2)   = 0

    Dim Fonts() As VBGLFont
    ReDim Fonts(0)
    Set Fonts(0) = New VBGLFont
    Fonts(0).FontLayout = TextBox.Font(0).FontLayout
    Fonts(0).Text = "Black   is not selected and not run"                 & vbcrLf & _
                    "White   is     selected and not run"                 & vbcrLf & _
                    "Green   is not selected and run sucessfully"         & vbcrLf & _
                    "Blue    is     selected and run succesfully"         & vbcrLf & _
                    "Red     is not selected and run failed"              & vbcrLf & _
                    "yellow  is     selected and run failed"              & vbcrLf & _
                    "w=up, s=down, whitespace=select, t=run selected"     & vbcrLf
    Fonts(0).FontColor = FontColor

    VBGLTextBox.TopLeft        = TopLeft
    VBGLTextBox.TopRight       = TopRight
    VBGLTextBox.BottomLeft     = BottomLeft
    VBGLTextBox.BottomRight    = BottomRight
    VBGLTextBox.Color          = Color
    VBGLTextBox.CharsPerLine   = 128
    VBGLTextBox.LinesPerPage   = 128
    VBGLTextBox.Pages          = 1
    VBGLTextBox.LineOffset     = 0.1!
    Set CreateExplainBox = VBGLTextBox.Create(Fonts)
    Exit Function

    Error:
    ErrorNum = 6
End Function

Private Sub UpdateTextBox()
    On Error GoTo Error
    Dim i As Long
    Dim FoundTest As VBGLTest
    Dim FontColor() As Single
    ReDim FontColor(2)
    For i = 0 To USize(TestFramework.AllTests)
        Set FoundTest = TestFramework.GetTest(i)
        If FoundTest.HasRun Then
            If FoundTest.Passed Then
                If TestFramework.IsSelected(i) Then
                    FontColor(0) = 0
                    FontColor(1) = 0
                    FontColor(2) = 1
                Else
                    FontColor(0) = 0
                    FontColor(1) = 1
                    FontColor(2) = 0
                End If
            Else
                If TestFramework.IsSelected(i) Then
                    FontColor(0) = 1
                    FontColor(1) = 1
                    FontColor(2) = 0
                Else
                    FontColor(0) = 1
                    FontColor(1) = 0
                    FontColor(2) = 0
                End If
            End If
        Else
            If TestFramework.IsSelected(i) Then
                FontColor(0) = 1
                FontColor(1) = 1
                FontColor(2) = 1
            Else
                FontColor(0) = 0
                FontColor(1) = 0
                FontColor(2) = 0
            End If
        End If
        TextBox.Font(i).FontColor = FontColor
    Next i
    Call TextBox.UpdateData()
    Exit Sub

    Error:
    ErrorNum = 5
End Sub


' Callback Functions, but stackable
Public Sub VBGLDisplayFuncStack()
    Call Application.Run(CurrentContext.DisplayFunc)
End Sub
Public Sub VBGLIdleFuncStack()
    Call Application.Run(CurrentContext.IdleFunc)
End Sub
Public Sub VBGLKeyboardFuncStack(ByVal Char As Byte, ByVal x As Long, ByVal y As Long)
    Call Application.Run(CurrentContext.KeyboardFunc, Char, x, y)
End Sub
Public Sub VBGLPassiveMotionFuncStack(ByVal x As Long, ByVal y As Long)
    Call Application.Run(CurrentContext.PassiveMotionFunc, x, y)
End Sub
Public Sub VBGLMouseWheelFuncStack(ByVal wheel As Long, ByVal direction As Long, ByVal x As Long, ByVal y As Long)
    Call Application.Run(CurrentContext.MouseWheelFunc, wheel, direction, x, y)
End Sub