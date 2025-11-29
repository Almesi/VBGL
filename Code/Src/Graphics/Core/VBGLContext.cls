VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLContext"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

'Describes one OpenGL Context as an Object

Private p_CurrentWindow      As VBGLWindow
Private p_CurrentShader      As VBGLShader
Private p_CurrentVAO         As VBGLVertexArray
Private p_CurrentVBO         As IBufferVertex
Private p_CurrentEBO         As IBufferIndex
Private p_CurrentTexture2D   As VBGLTexture
Private p_CurrentFrame       As VBGLFrame
Private p_ErrorHandler       As std_ErrorHandler

Private p_StencilTest        As Boolean
Private p_DepthTest          As Boolean
Private p_BlendTest          As Boolean
Private p_CullTest           As Boolean
Private p_ScissorTest        As Boolean

Private p_StencilFuncFunc    As Long
Private p_StencilFuncRef     As Long
Private p_StencilFuncMask    As Long
Private p_DepthFunc          As Long
Private p_BlendFuncsFactor   As Long
Private p_BlendFuncdFactor   As Long
Private p_CullFace           As Long
Private p_FrontFace          As Long
Private p_ScissorX           As Long
Private p_ScissorY           As Long
Private p_ScissorWidth       As Long
Private p_ScissorHeight      As Long
Private p_ViewportX          As Long
Private p_ViewportY          As Long
Private p_ViewportWidth      As Long
Private p_ViewportHeight     As Long





Public Sub SetDisplayFunc(ByVal          Pointer As LongPtr)      : Call glutDisplayFunc(Pointer)          : End Sub
Public Sub SetOverlayDisplayFunc(ByVal   Pointer As LongPtr)      : Call glutOverlayDisplayFunc(Pointer)   : End Sub
Public Sub SetReshapeFunc(ByVal          Pointer As LongPtr)      : Call glutReshapeFunc(Pointer)          : End Sub
Public Sub SetPositionFunc(ByVal         Pointer As LongPtr)      : Call glutPositionFunc(Pointer)         : End Sub
Public Sub SetCloseFunc(ByVal            Pointer As LongPtr)      : Call glutCloseFunc(Pointer)            : End Sub
Public Sub SetIdleFunc(ByVal             Pointer As LongPtr)      : Call glutIdleFunc(Pointer)             : End Sub
Public Sub SetTimerFunc(ByVal            Pointer As LongPtr)      : Call glutTimerFunc(Pointer)            : End Sub
Public Sub SetKeyboardFunc(ByVal         Pointer As LongPtr)      : Call glutKeyboardFunc(Pointer)         : End Sub
Public Sub SetSpecialFunc(ByVal          Pointer As LongPtr)      : Call glutSpecialFunc(Pointer)          : End Sub
Public Sub SetKeyboardUpFunc(ByVal       Pointer As LongPtr)      : Call glutKeyboardUpFunc(Pointer)       : End Sub
Public Sub SetSpecialUpFunc(ByVal        Pointer As LongPtr)      : Call glutSpecialUpFunc(Pointer)        : End Sub
Public Sub SetMouseFunc(ByVal            Pointer As LongPtr)      : Call glutMouseFunc(Pointer)            : End Sub
Public Sub SetMouseWheelFunc(ByVal       Pointer As LongPtr)      : Call glutMouseWheelFunc(Pointer)       : End Sub
Public Sub SetMotionFunc(ByVal           Pointer As LongPtr)      : Call glutMotionFunc(Pointer)           : End Sub
Public Sub SetPassiveMotionFunc(ByVal    Pointer As LongPtr)      : Call glutPassiveMotionFunc(Pointer)    : End Sub
Public Sub SetEntryFunc(ByVal            Pointer As LongPtr)      : Call glutEntryFunc(Pointer)            : End Sub
Public Sub SetMenuStatusFunc(ByVal       Pointer As LongPtr)      : Call glutMenuStatusFunc(Pointer)       : End Sub
Public Sub SetMenuStateFunc(ByVal        Pointer As LongPtr)      : Call glutMenuStateFunc(Pointer)        : End Sub
Public Sub SetWindowStatusFunc(ByVal     Pointer As LongPtr)      : Call glutWindowStatusFunc(Pointer)     : End Sub
Public Sub SetJoystickFunc(ByVal         Pointer As LongPtr)      : Call glutJoystickFunc(Pointer)         : End Sub
Public Sub SetSpaceballMotionFunc(ByVal  Pointer As LongPtr)      : Call glutSpaceballMotionFunc(Pointer)  : End Sub
Public Sub SetSpaceballRotateFunc(ByVal  Pointer As LongPtr)      : Call glutSpaceballRotateFunc(Pointer)  : End Sub
Public Sub SetSpaceballButtonFunc(ByVal  Pointer As LongPtr)      : Call glutSpaceballButtonFunc(Pointer)  : End Sub
Public Sub SetButtonBoxFunc(ByVal        Pointer As LongPtr)      : Call glutButtonBoxFunc(Pointer)        : End Sub
Public Sub SetDialsFunc(ByVal            Pointer As LongPtr)      : Call glutDialsFunc(Pointer)            : End Sub
Public Sub SetTabletMotionFunc(ByVal     Pointer As LongPtr)      : Call glutTabletMotionFunc(Pointer)     : End Sub
Public Sub SetTabletButtonFunc(ByVal     Pointer As LongPtr)      : Call glutTabletButtonFunc(Pointer)     : End Sub
Public Sub SetVisibilityFunc(ByVal       Pointer As LongPtr)      : Call glutVisibilityFunc(Pointer)       : End Sub



Public Property Let CurrentWindow(ByVal Window As VBGLWindow)
    If Window Is CurrentWindow Then Exit Property
    Set p_CurrentWindow = Window
End Property
Public Property Let CurrentShader(ByVal Shader As VBGLShader)
    If Shader Is CurrentShader Then Exit Property
    Set p_CurrentShader = Shader
    If IsSomething(CurrentShader) Then
        Call glUseProgram(CurrentShader.ID)
    Else
        Call glUseProgram(0)
    End If
End Property
Public Property Let CurrentVAO(ByVal VAO As VBGLVertexArray)
    If VAO Is CurrentVAO Then Exit Property
    Set p_CurrentVAO = VAO
    If IsSomething(CurrentVAO) Then
        Call glBindVertexArray(CurrentVAO.ID)
    Else
        Call glBindVertexArray(0)
    End If
End Property
Public Property Let CurrentVBO(ByVal VBO As IBufferVertex)
    If VBO Is CurrentVBO Then Exit Property
    Set p_CurrentVBO = VBO
    If IsSomething(CurrentVBO) Then
        Call glBindBuffer(GL_ARRAY_BUFFER, CurrentVBO.ID)
    Else
        Call glBindBuffer(GL_ARRAY_BUFFER, 0)
    End If
End Property
Public Property Let CurrentEBO(ByVal EBO As IBufferIndex)
    If EBO Is CurrentEBO Then Exit Property
    Set p_CurrentEBO = EBO
    If IsSomething(CurrentEBO) Then
        Call glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, CurrentEBO.ID)
    Else
        Call glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)
    End If
End Property
Public Property Let CurrentTexture2D(ByVal Texture As VBGLTexture)
    If Texture Is CurrentTexture2D Then Exit Property
    Set p_CurrentTexture2D = Texture
    If IsSomething(CurrentTexture2D) Then
        Call glBindTexture(GL_TEXTURE_2D, Texture.ID)
    Else
        Call glBindTexture(GL_TEXTURE_2D, 0)
    End If
End Property
Public Property Let CurrentFrame(ByVal Frame As VBGLFrame)
    If IsNothing(CurrentFrame) Then
        If Frame Is CurrentFrame Then Exit Property
        Set p_CurrentFrame = Frame
    End If
End Property
Public Property Let ErrorHandler(ByVal n_ErrorHandler As std_ErrorHandler)
    Set p_ErrorHandler = n_ErrorHandler
End Property

Public Property Get CurrentWindow()            As VBGLWindow       : Set CurrentWindow    = p_CurrentWindow    : End Property
Public Property Get CurrentShader()            As VBGLShader       : Set CurrentShader    = p_CurrentShader    : End Property
Public Property Get CurrentVAO()               As VBGLVertexArray  : Set CurrentVAO       = p_CurrentVAO       : End Property
Public Property Get CurrentVBO()               As IBufferVertex    : Set CurrentVBO       = p_CurrentVBO       : End Property
Public Property Get CurrentEBO()               As IBufferIndex     : Set CurrentEBO       = p_CurrentEBO       : End Property
Public Property Get CurrentTexture2D()         As VBGLTexture      : Set CurrentTexture2D = p_CurrentTexture2D : End Property
Public Property Get CurrentFrame()             As VBGLFrame        : Set CurrentFrame     = p_CurrentFrame     : End Property
Public Property Get ErrorHandler()             As std_ErrorHandler : Set ErrorHandler     = p_ErrorHandler     : End Property

Public Function Create(Optional ByVal FilePath As String = Empty, Optional ByVal ContextProfile As Long = 0, Optional ByVal ContextFlag As Long = 0, Optional ByVal Logger As IDestination = Nothing, Optional ByVal Shower As IDestination = Nothing) As VBGLContext
    If FilePath = Empty Then FilePath = ThisWorkBook.Path
    Dim NewErrorHandler As std_ErrorHandler
    Set NewErrorHandler = std_ErrorHandler.Create(Shower, Logger)
    #If VBA7 Then
        If LoadLibrary(FilePath & "\Freeglut64.dll") = False Then
    #Else
        If LoadLibrary(FilePath & "\Freeglut.dll") = False Then
    #End If
        Call NewErrorHandler.Raise(std_Error.Create("VBGLContext", "Critical", "", "Couldnt load freeglut", Empty))
        Exit Function
    End If

    Call glutInit(0&, "")
    Call glutInitContextProfile(ContextProfile)
    Call glutInitContextFlags(ContextFlag)
    Set Create = New VBGLContext
    Create.ErrorHandler = NewErrorHandler
End Function


Public Property Let StencilTest(ByVal n_Value As Boolean)
    If n_Value Then
        Call glEnable(GL_STENCIL_TEST)
    Else
        Call glDisable(GL_STENCIL_TEST)
    End If
    p_StencilTest = n_Value
End Property
Public Property Let DepthTest(ByVal n_Value   As Boolean)
    If n_Value Then
        Call glEnable(GL_DEPTH_TEST)  
    Else
        Call glDisable(GL_DEPTH_TEST)  
    End If
    p_DepthTest = n_Value
End Property
Public Property Let BlendTest(ByVal n_Value   As Boolean)
    If n_Value Then
        Call glEnable(GL_BLEND)       
    Else
        Call glDisable(GL_BLEND)       
    End If
    p_BlendTest = n_Value
End Property
Public Property Let CullTest(ByVal n_Value    As Boolean)
    If n_Value Then
        Call glEnable(GL_CULL_FACE)   
    Else
        Call glDisable(GL_CULL_FACE)   
    End If
    p_CullTest = n_Value
End Property
Public Property Let ScissorTest(ByVal n_Value As Boolean)
    If n_Value Then
        Call glEnable(GL_SCISSOR_TEST)   
    Else
        Call glDisable(GL_SCISSOR_TEST)   
    End If
    p_ScissorTest = n_Value
End Property

Public Property Get StencilTest() As Boolean
    StencilTest = p_StencilTest
End Property
Public Property Get DepthTest() As Boolean
    DepthTest = p_DepthTest
End Property
Public Property Get BlendTest() As Boolean
    BlendTest = p_BlendTest
End Property
Public Property Get CullTest() As Boolean
    CullTest = p_CullTest
End Property
Public Property Get ScissorTest() As Boolean
    ScissorTest = p_ScissorTest
End Property

Public Sub StencilFunc(ByVal Func As Long, ByVal Ref As Long, ByVal Mask As Long)
    p_StencilFuncFunc = Func
    p_StencilFuncRef  = Ref
    p_StencilFuncMask = Mask
    Call glStencilFunc(Func, Ref, Mask)
End Sub
Public Sub DepthFunc(ByVal n_Value As Long)
    p_DepthFunc = n_Value
    Call glDepthFunc(n_Value)
End Sub
Public Sub BlendFunc(ByVal sFactor As Long, ByVal dFactor As Long)
    p_BlendFuncsFactor = sFactor
    p_BlendFuncdFactor = dFactor
    Call glBlendFunc(sFactor, dFactor)
End Sub
Public Sub CullFace(ByVal n_Value As Long)
    p_CullFace = n_Value
    Call glCullFace(n_Value)
End Sub
Public Sub FrontFace(ByVal n_Value As Long)
    p_FrontFace = n_Value
    Call glFrontFace(n_Value)
End Sub
Public Sub Scissor(ByVal x As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)
    p_ScissorX      = x
    p_ScissorY      = y
    p_ScissorWidth  = Width
    p_ScissorHeight = Height
    Call glScissor(x, y, Width, Height)
End Sub
Public Sub Viewport(ByVal x As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)
    p_ViewportX      = x
    p_ViewportY      = y
    p_ViewportWidth  = Width
    p_ViewportHeight = Height
    Call glViewport(x, y, Width, Height)
End Sub

Public Function GetStencilFuncFunc() As Long
    GetStencilFuncFunc = p_StencilFuncFunc
End Function
Public Function GetStencilFuncRef() As Long
    GetStencilFuncRef = p_StencilFuncRef
End Function
Public Function GetStencilFuncMask() As Long
    GetStencilFuncMask = p_StencilFuncMask
End Function
Public Function GetDepthFunc() As Long
    GetDepthFunc = p_DepthFunc
End Function
Public Function GetBlendFuncsFactor() As Long
    GetBlendFuncsFactor = p_BlendFuncsFactor
End Function
Public Function GetBlendFuncdFactor() As Long
    GetBlendFuncdFactor = p_BlendFuncdFactor
End Function
Public Function GetCullFace() As Long
    CullFace = p_CullFace
End Function
Public Function GetFrontFace() As Long
    FrontFace = p_FrontFace
End Function
Public Function GetScissorX() As Long
    GetScissorX = p_ScissorX
End Function
Public Function GetScissorY() As Long
    GetScissorY = p_ScissorY
End Function
Public Function GetScissorWidth() As Long
    GetScissorWidth = p_ScissorWidth
End Function
Public Function GetScissorHeight() As Long
    GetScissorHeight = p_ScissorHeight
End Function
Public Function GetViewportX() As Long
    GetViewportX = p_ViewportX
End Function
Public Function GetViewportY() As Long
    GetViewportY = p_ViewportY
End Function
Public Function GetViewportWidth() As Long
    GetViewportWidth = p_ViewportWidth
End Function
Public Function GetViewportHeight() As Long
    GetViewportHeight = p_ViewportHeight
End Function


Public Sub MainLoop()
    Call glutMainLoop()
End Sub

Public Sub LeaveMainLoop()
    Call glutLeaveMainLoop()
End Sub

Public Sub Clear()
    Dim Mask As Long
    If BlendTest   Then Mask = Mask Or GL_COLOR_BUFFER_BIT
    If DepthTest   Then Mask = Mask Or GL_DEPTH_BUFFER_BIT
    If StencilTest Then Mask = Mask Or GL_STENCIL_BUFFER_BIT
    Call glClear(Mask)
End Sub

Public Sub ClearColor(Optional ByVal r As Single = 0, Optional ByVal g As Single = 0, Optional ByVal b As Single = 0, Optional ByVal a As Single = 1)
    Call glClearColor(r, g, b, a)
End Sub

Public Sub ClearColorArr(ByRef Arr() As Single)
    Dim Size As Long
    Size = USize(Arr)
    Select Case Size
        Case 0 : Call glClearColor(Arr(0))
        Case 1 : Call glClearColor(Arr(0), Arr(1))
        Case 2 : Call glClearColor(Arr(0), Arr(1), Arr(2))
        Case 3 : Call glClearColor(Arr(0), Arr(1), Arr(2), Arr(3))
    End Select
End Sub

Private Sub Class_Initialize()
    p_StencilTest      = False
    p_DepthTest        = False
    p_BlendTest        = False
    p_CullTest         = False
    p_StencilFuncFunc  = GL_ALWAYS
    p_StencilFuncRef   = 0
    p_StencilFuncMask  = -1 'All 32 bits are 1 = (11111111 11111111 11111111 11111111)
    p_DepthFunc        = GL_LESS
    p_BlendFuncsFactor = GL_ONE
    p_BlendFuncdFactor = GL_ZERO
    p_CullFace         = GL_BACK
    p_FrontFace        = GL_CCW
End Sub