Attribute VB_Name = "VBGLTestTextBox"


Option Explicit

Private TextBox As VBGLTextBox

Private ErrorNum As Long

Public Function VBGLTestTextBox1() As Long
    On Error GoTo Error
    Dim Path As String
    Path = ThisWorkbook.Path
    Set TextBox = CreateTextBox(Path & "\Res", Path & "\Res\Fonts")

    Dim VBGLTestTextBox1RenderObject As VBGLRenderObject
    Set VBGLTestTextBox1RenderObject = VBGLRenderObject.Create(Nothing, Window.Frame)

    With VBGLTestTextBox1RenderObject.Callbacks
        Call .SetDisplayFunc(std_Callable.Create(Nothing       , "VBGLTestTextBoxLoop"          , vbMethod, -1))
        Call .SetIdleFunc(std_Callable.Create(Nothing          , "VBGLTestTextBoxLoop"          , vbMethod, -1))
        Call .SetKeyboardFunc(std_Callable.Create(Nothing      , "VBGLTestTextBoxKeyBoard"      , vbMethod, 2))
        Call .SetPassiveMotionFunc(std_Callable.Create(Nothing , "VBGLTestTextBoxPassiveMotion" , vbMethod, 1))
        Call .SetMouseWheelFunc(std_Callable.Create(Nothing    , "VBGLTestTextBoxMouseWheel"    , vbMethod, 3))
    End With
    Call AddRenderObject(VBGLTestTextBox1RenderObject)
    Finish:
    VBGLTestTextBox1 = ErrorNum
    Exit Function

    Error:
    ErrorNum = 1
    GoTo Finish
End Function

Private Function CreateTextBox(ByVal LoadFilePath As String, ByVal FilePath As String) As VBGLTextBox
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
    Set Fonts(0) = VBGLFont.Create("Press ESC to leave test, otherwise type to add to this Textbox", ConsolasFont)

    VBGLTextBox.CharsPerLine   = 32
    VBGLTextBox.LinesPerPage   = 16
    VBGLTextBox.Pages          = 1
    VBGLTextBox.LineOffset     = 0.1!
    Set CreateTextBox = VBGLTextBox.Create(Temp, Fonts)
    Exit Function

    Error:
    ErrorNum = 2
End Function


Public Sub VBGLTestTextBoxLoop()
    On Error GoTo Error
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0.5, 0.5, 0.5, 1)
    Call TextBox.Draw()
    Call glutSwapBuffers
    Exit Sub

    Error:
    ErrorNum = 3
End Sub

Public Sub VBGLTestTextBoxKeyBoard(ByVal Char As Byte, ByVal x As Long, ByVal y As Long)
    On Error GoTo Error
    Static FirstButton As Boolean
    Dim Temp As Long
    Temp = Char
    Select Case Temp
        Case 13: TextBox.Font(0).AddText(vbCrLf)
        Case 27: Call RemoveRenderObject()
        Case 32 To 255, 8
            If FirstButton = False Then
                TextBox.Font(0).Text = Empty
                TextBox.Font(0).AddText(Chr(Char))
                FirstButton = True
            Else
                TextBox.Font(0).AddText(Chr(Char))
            End If
            Call TextBox.UpdateData()
    End Select
    Exit Sub

    Error:
    ErrorNum = 4
End Sub

Public Sub VBGLTestTextBoxMouseWheel(ByVal wheel As Long, ByVal direction As Long, ByVal x As Long, ByVal y As Long)
    ' Nothing, to not have residues of other tests
End Sub

Public Sub VBGLTestTextBoxPassiveMotion(ByVal x As Long, ByVal y As Long)
    ' Nothing, to not have residues of other tests
End Sub