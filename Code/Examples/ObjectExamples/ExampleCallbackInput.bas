Attribute VB_Name = "ExampleCallbackInput"

Option Explicit

'================================================================================
' Shows how use the callback class:
' Shows how you can simplify select-case statements for every possible key combination in any context into an assignable object
'================================================================================

Private CurrentInput As VBGLIInput
Private NormalInput As VBGLIInput
Private ReversedInput As VBGLIInput
Private Mesh As VBGLMesh

Public Sub TestCallbackInput(ByVal Path As String)

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
    Set Layout = VBGLPrCoLayoutXYRGB

    ' Create Data Rectangle with Position and Color
    Dim VertexData As IDataByte
    Set VertexData = VBGLData.CreateSingle(VBGLBaFoRectangleXYRGB)

    ' Create Shader
    Dim Shader As VBGLShader
    Set Shader = VBGLPrCoShaderXYRGB

    ' Create a Drawable-Mesh Object
    Set Mesh = VBGLMesh.Create(Shader, Layout, VertexData, Nothing, False)

    Set NormalInput   = CreateInput()
    Set ReversedInput = CreateInputReverse()

    Set CurrentInput = NormalInput

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
    Call Mesh.Draw()
    Call glutSwapBuffers()
End Sub

Public Sub KeyboardSub(ByVal key As Byte, ByVal x As Long, ByVal y As Long)
    Call CurrentInput.KeyDown(CLng(key))
End Sub

Public Sub AssignCurrentInput(ByVal IInput As Long)
    Set CurrentInput = IInput
End Sub

Public Sub UpdateMesh(ByVal xOffset As Single, ByVal yOffset As Single)
    Dim DataObj As IDataSingle
    Set DataObj = Mesh.VAO.Buffer.Data
    Dim Data() As Single
    Data = DataObj.Data
    Data(00) = Data(00) + xOffset
    Data(05) = Data(05) + xOffset
    Data(10) = Data(10) + xOffset
    Data(15) = Data(15) + xOffset
    Data(20) = Data(20) + xOffset
    Data(25) = Data(25) + xOffset

    Data(01) = Data(01) + yOffset
    Data(06) = Data(06) + yOffset
    Data(11) = Data(11) + yOffset
    Data(16) = Data(16) + yOffset
    Data(21) = Data(21) + yOffset
    Data(26) = Data(26) + yOffset

    Call Mesh.VAO.Buffer.Update(VBGLData.CreateSingle(Data))
End Sub

Private Function CreateInput() As VBGLIInput
    Dim Temp As VBGLGeneralInput
    Set Temp = New VBGLGeneralInput
    Call Temp.AddKey(Asc("w"), std_Callable.Create(Nothing , "UpdateMesh"         ,  vbMethod, 1).Bind(+0.0, -0.1).FixArgs(True))
    Call Temp.AddKey(Asc("s"), std_Callable.Create(Nothing , "UpdateMesh"         ,  vbMethod, 1).Bind(+0.0, +0.1).FixArgs(True))
    Call Temp.AddKey(Asc("a"), std_Callable.Create(Nothing , "UpdateMesh"         ,  vbMethod, 1).Bind(-0.1, +0.0).FixArgs(True))
    Call Temp.AddKey(Asc("d"), std_Callable.Create(Nothing , "UpdateMesh"         ,  vbMethod, 1).Bind(+0.1, +0.0).FixArgs(True))
    Call Temp.AddKey(Asc(" "), std_Callable.Create(Nothing , "AssignCurrentInput" ,  vbMethod, 0).Bind(ReversedInput).FixArgs(True))
    Set CreateInput = Temp
End Function

Private Function CreateInputReverse() As VBGLIInput
    Dim Temp As VBGLGeneralInput
    Set Temp = New VBGLGeneralInput
    Call Temp.AddKey(Asc("w"), std_Callable.Create(Nothing , "UpdateMesh"         ,  vbMethod, 1).Bind(+0.0, +0.1).FixArgs(True))
    Call Temp.AddKey(Asc("s"), std_Callable.Create(Nothing , "UpdateMesh"         ,  vbMethod, 1).Bind(+0.0, -0.1).FixArgs(True))
    Call Temp.AddKey(Asc("a"), std_Callable.Create(Nothing , "UpdateMesh"         ,  vbMethod, 1).Bind(+0.1, +0.0).FixArgs(True))
    Call Temp.AddKey(Asc("d"), std_Callable.Create(Nothing , "UpdateMesh"         ,  vbMethod, 1).Bind(-0.1, +0.0).FixArgs(True))
    Call Temp.AddKey(Asc(" "), std_Callable.Create(Nothing , "AssignCurrentInput" ,  vbMethod, 0).Bind(ReversedInput).FixArgs(True))
    Set CreateInputReverse = Temp
End Function