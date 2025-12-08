Attribute VB_Name = "ExampleTextureManager"

Option Explicit

'================================================================================
' Shows how use the TextureManager Class to merge Images
' When creating TileSets you might be inclined to combine them all into 1 big image
' To manage that will become very messy very quickly
' With TextureManager you can keep the TileSets neatly in their own files and merge them into 1 image at runtime

' Another neat bonus is splitting images into subimages. A TileSet usually has 16 SubImages for every neighbour combination
' They are all in one file.
' TextureManager allows to split the image into those subimages and combine them with other files and their subimages into 1 image
'================================================================================

Private Mesh As VBGLMesh

Public Sub TestTextureManager(ByVal Path As String, ByVal FolderPath As String)

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
    Set Layout = VBGLPrCoLayoutXYTxTy

    ' Create Data Rectangle with Position and Color
    Dim VertexData As IDataByte
    Set VertexData = VBGLData.CreateSingle(VBGLBaFoRectangleXYTxTy)

    ' Create Shader
    Dim Shader As VBGLShader
    Set Shader = VBGLPrCoShaderXYTxTy

    ' Create TextureManager
    Dim TextureManager As VBGLTextureManager
    Set TextureManager = VBGLTextureManager.Create(VBGLTextureMergerGrid.Create(True))
    Call TextureManager.LoadFromFolder(FolderPath, True, 1, 1, VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpRow, "Name")
    TextureManager.Flip = True
    TextureManager.Transpose = True

    ' Create a Drawable-Mesh Object
    Set Mesh = VBGLMesh.Create(Shader, Layout, VertexData, Nothing, False)
    Dim Texture As VBGLTexture
    Set Texture = TextureManager.CreateTexture(VBGLTexture, "TestManager")
    Call Mesh.AddTexture(Texture)

    ' Assign Freeglut callbacks and call the mainloop
    With CurrentContext
        Call .SetDisplayFunc(AddressOf  LoopSub)
        Call .SetIdleFunc(AddressOf     LoopSub)
        Call .MainLoop()
    End With
End Sub

Public Sub LoopSub()
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(0.5, 0.5, 0.5, 1)
    Call Mesh.Draw()
    Call glutSwapBuffers()
End Sub