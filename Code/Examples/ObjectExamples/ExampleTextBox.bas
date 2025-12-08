Attribute VB_Name = "ExampleTextBox"


Option Explicit

'================================================================================
' Shows how use Textbox class to show text
'================================================================================

Private TextBox As VBGLTextBox

Public Sub TestTextBox(ByVal Path As String, ByVal FontLoaderDLL As String, ByVal FontPath As String)

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
    Dim Window As VBGLWindow
    Set Window = VBGLWindow.Create(1600, 900, GLUT_RGBA, "OpenGL Test", "4_6", True)

    ' Create TextBox
    Set TextBox = CreateTextBox("TEXT", FontLoaderDLL, FontPath)

    ' Assign Callback and do mainloop
    With CurrentContext
        Call .SetDisplayFunc(AddressOf  LoopSub)
        Call .SetIdleFunc(AddressOf  LoopSub)
        Call .MainLoop()
    End With
End Sub

Private Function CreateTextBox(ByVal Text As String, ByVal LoadFilePath As String, ByVal FilePath As String) As VBGLTextBox
    Dim Temp As VBGLProperties
    Set Temp = VBGLTextBox.CreateProperties(2, 3)
    Call Temp.LetValueFamily("TopLeft*"     , -1.0!, +0.0!, +0.0!)
    Call Temp.LetValueFamily("TopRight*"    , +1.0!, +0.0!, +0.0!)
    Call Temp.LetValueFamily("BottomLeft*"  , -1.0!, -1.0!, +0.0!)
    Call Temp.LetValueFamily("BottomRight*" , +1.0!, -1.0!, +0.0!)
    Call Temp.LetValueFamily("Color*"       , +1.0!, +1.0!, +1.0!, +0.0!)

    Dim ConsolasFont As VBGLFontLayout
    Set ConsolasFont = VBGLFontLayout.Create(LoadFilePath, FilePath, 48, "Consolas")
    Dim Fonts() As VBGLFont
    ReDim Fonts(0)
    Set Fonts(0) = VBGLFont.Create(Text, ConsolasFont)
    Fonts(0).Scalee = 10

    VBGLTextBox.CharsPerLine   = 32
    VBGLTextBox.LinesPerPage   = 16
    VBGLTextBox.Pages          = 1
    VBGLTextBox.LineOffset     = 0.1!
    Set CreateTextBox = VBGLTextBox.Create(Temp, Fonts)
End Function

Public Sub LoopSub()
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0, 1, 1, 1)
    Call TextBox.Draw()
    Call glutSwapBuffers()
End Sub