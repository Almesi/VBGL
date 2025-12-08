Attribute VB_Name = "ExampleDualGrid"

Option Explicit

'================================================================================
' Shows how use the DualGrid class for combining TileSets:
'================================================================================

Private Grid As VBGLDualGrid
Private MX As Long
Private MY As Long

Public Sub TestDualGrid(ByVal Path As String, ByVal TilesFolderPath As String)

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
    Call VBGLWindow.Create(1600, 900, GLUT_RGBA, "OpenGL Test", "4_6", True)

    ' Create Data-Layout
    Dim Layout As VBGLLayout
    Set Layout = VBGLPrCoLayoutXYZTxTy

    ' Create Data Rectangle with Position and Color
    Dim VertexData As IDataByte
    Set VertexData = VBGLData.CreateSingle(VBGLBaFoRectangleXYZTxTy)

    ' Create Shader
    Dim Shader As VBGLShader
    Set Shader = VBGLPrCoShaderXYTxTy

    Set Grid = CreateGrid(TilesFolderPath)

    ' Assign Freeglut callbacks and call the mainloop
    With CurrentContext
        Call .SetDisplayFunc(AddressOf  LoopSub)
        Call .SetIdleFunc(AddressOf     LoopSub)
        Call .SetKeyBoardFunc(AddressOf KeyboardSub)
        Call .MainLoop()
    End With
End Sub

Public Sub LoopSub()
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0.5, 0.5, 0.5, 1)
    Call Grid.Draw()
    Call glutSwapBuffers()
End Sub

Public Sub KeyboardSub(ByVal key As Byte, ByVal x As Long, ByVal y As Long)
    Dim Val As Long
    Val = CLng(key)
    Select Case ChrW(Val)
        Case "w"
            MY = MY - 1
            Call Grid.LookAt(MX, MY, 9, 9)
        Case "a"
            MX = MX - 1
            Call Grid.LookAt(MX, MY, 9, 9)
        Case "s"
            MY = MY + 1
            Call Grid.LookAt(MX, MY, 9, 9)
        Case "d"
            MX = MX + 1
            Call Grid.LookAt(MX, MY, 9, 9)
    End Select
End Sub

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