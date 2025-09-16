Attribute VB_Name = "VBGLTestTextBox"


Option Explicit

Private TextBox As VBGLTextBox

Private ErrorNum As Long

Public Function VBGLTestTextBox1() As Long
    On Error GoTo Error
    Dim Path As String
    Path = ThisWorkbook.Path
    Set TextBox = CreateTextBox(Path & "\Res", Path & "\Res\Fonts")

    With CurrentContext
        Call .AddDisplayFunc("VBGLTestTextBoxLoop")
        Call .AddIdleFunc("VBGLTestTextBoxLoop")
        Call .AddKeyboardFunc("VBGLTestTextBoxKeyBoard")
        Call .AddPassiveMotionFunc("VBGLTestTextBoxPassiveMotion")
        Call .AddMouseWheelFunc("VBGLTestTextBoxMouseWheel")
    End With
    Finish:
    VBGLTestTextBox1 = ErrorNum
    Exit Function

    Error:
    ErrorNum = 1
    GoTo Finish
End Function

Private Function CreateTextBox(ByVal LoadFilePath As String, ByVal FilePath As String) As VBGLTextBox
    On Error GoTo Error
    Dim TopLeft()     As Single : ReDim TopLeft(2)     : TopLeft(0)     = -1: TopLeft(1)     = +0: TopLeft(2)     = 0
    Dim TopRight()    As Single : ReDim TopRight(2)    : TopRight(0)    = +1: TopRight(1)    = +0: TopRight(2)    = 0
    Dim BottomLeft()  As Single : ReDim BottomLeft(2)  : BottomLeft(0)  = -1: BottomLeft(1)  = -1: BottomLeft(2)  = 0
    Dim BottomRight() As Single : ReDim BottomRight(2) : BottomRight(0) = +1: BottomRight(1) = -1: BottomRight(2) = 0
    Dim Color()       As Single : ReDim Color(3)       : Color(0)       = +1: Color(1)       = +1: Color(2)       = 1:Color(3)       = 0
    Dim FontColor()   As Single : ReDim FontColor(2)   : FontColor(0)   = +1: FontColor(1)   = +0: FontColor(2)   = 0
    Dim FontLayout As VBGLFontLayout
    Set FontLayout = VBGLFontLayout.Create(LoadFilePath, FilePath & "\Consolas.ttf", 48, "Consolas")
    Dim Fonts() As VBGLFont
    ReDim Fonts(0)
    Set Fonts(0) = New VBGLFont
    Fonts(0).FontLayout = FontLayout
    Fonts(0).Text = "Press ESC to leave test, otherwise type to add to this Textbox"
    Fonts(0).FontColor = FontColor

    VBGLTextBox.TopLeft        = TopLeft
    VBGLTextBox.TopRight       = TopRight
    VBGLTextBox.BottomLeft     = BottomLeft
    VBGLTextBox.BottomRight    = BottomRight
    VBGLTextBox.Color          = Color
    VBGLTextBox.CharsPerLine   = 32
    VBGLTextBox.LinesPerPage   = 16
    VBGLTextBox.Pages          = 1
    VBGLTextBox.LineOffset     = 0.1!
    Set CreateTextBox = VBGLTextBox.Create(Fonts)
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
        Case 27: Call CurrentContext.PopStack
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