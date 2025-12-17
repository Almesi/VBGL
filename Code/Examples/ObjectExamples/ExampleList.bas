Attribute VB_Name = "ExampleList"


Option Explicit

'================================================================================
' Shows how use List Class to create Lists with drawable Objects
'================================================================================

Private List As VBGLList

Public Sub TestList(ByVal Path As String, ByVal FontLoaderDLL As String, ByVal FontPath As String, ByVal ImageFolderPath As String)

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

    ' Create List
    Set List = CreateList(FontLoaderDLL, FontPath, ImageFolderPath)

    ' Assign Callback and do mainloop
    With CurrentContext
        Call .SetDisplayFunc(AddressOf  LoopSub)
        Call .SetIdleFunc(AddressOf  LoopSub)
        Call .MainLoop()
    End With
End Sub

Private Function CreateList(ByVal LoadFilePath As String, ByVal FilePath As String, ByVal ImageFolder As String) As VBGLList
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
        Call .AddRows(1)

        Call .AddElement(0, CreateTextBox("Apple", LoadFilePath, FilePath), WhiteBackground)
        Call .AddElement(0, CreateFruit(ImageFolder & "\Apple.png"), WhiteBackground)

        Call .AddElement(1, CreateTextBox("Banana", LoadFilePath, FilePath), RedBackground)
        Call .AddElement(1, CreateFruit(ImageFolder & "\Banana.png"), RedBackground)
        Call .Build()
    End With
End Function

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

Public Sub LoopSub()
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0, 1, 1, 1)
    Call List.Draw()
    Call glutSwapBuffers()
End Sub