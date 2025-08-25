VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLContext"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

'Describes one OpenGL Context as an Object

Public Enum VBGLGlutCallback
    VBGLDisplayFunc       = 0
    VBGLIdleFunc          = 1
    VBGLKeyboardFunc      = 2
    VBGLPassiveMotionFunc = 3
    VBGLMouseWheelFunc    = 4
End Enum

Private p_CurrentWindow    As VBGLWindow
Private p_CurrentShader    As VBGLShader
Private p_CurrentVAO       As VBGLVertexArray
Private p_CurrentVBO       As IBufferVertex
Private p_CurrentEBO       As IBufferIndex
Private p_CurrentTexture2D As VBGLTexture
Private p_ErrorHandler     As std_ErrorHandler

Private p_StencilTest        As Boolean
Private p_DepthTest          As Boolean
Private p_BlendTest          As Boolean
Private p_CullFace           As Boolean
Private p_CullMode           As Long
Private p_FrontFace          As Long
Private p_PolygonMode        As Long

Public Property Let CurrentWindow(Window As VBGLWindow)
    If Window Is CurrentWindow Then Exit Property
    Set p_CurrentWindow = Window
End Property
Public Property Let CurrentShader(Shader As VBGLShader)
    If Shader Is CurrentShader Then Exit Property
     Set p_CurrentShader = Shader
     Call glUseProgram(Shader.ID)
End Property
Public Property Let CurrentVAO(VAO As VBGLVertexArray)
    If VAO Is CurrentVAO Then Exit Property
    Set p_CurrentVAO = VAO
    Call glBindVertexArray(VAO.ID)
End Property
Public Property Let CurrentVBO(VBO As IBufferVertex)
    If VBO Is CurrentVBO Then Exit Property
    Set p_CurrentVBO = VBO
    Call glBindBuffer(GL_ARRAY_BUFFER, VBO.ID)
End Property
Public Property Let CurrentEBO(EBO As IBufferIndex)
    If EBO Is CurrentEBO Then Exit Property
    Set p_CurrentEBO = EBO
    Call glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO.ID)
End Property
Public Property Let CurrentTexture2D(Texture As VBGLTexture)
    If Texture Is CurrentTexture2D Then Exit Property
    Set p_CurrentTexture2D = Texture
    Call glBindTexture(GL_TEXTURE_2D, Texture.ID)
End Property
Public Property Let ErrorHandler(n_ErrorHandler As std_ErrorHandler)
    Set p_ErrorHandler = n_ErrorHandler
End Property

Public Property Get CurrentWindow()            As VBGLWindow       : Set CurrentWindow    = p_CurrentWindow    : End Property
Public Property Get CurrentShader()            As VBGLShader       : Set CurrentShader    = p_CurrentShader    : End Property
Public Property Get CurrentVAO()               As VBGLVertexArray  : Set CurrentVAO       = p_CurrentVAO       : End Property
Public Property Get CurrentVBO()               As IBufferVertex    : Set CurrentVBO       = p_CurrentVBO       : End Property
Public Property Get CurrentEBO()               As IBufferIndex     : Set CurrentEBO       = p_CurrentEBO       : End Property
Public Property Get CurrentTexture2D()         As VBGLTexture      : Set CurrentTexture2D = p_CurrentTexture2D : End Property
Public Property Get ErrorHandler()             As std_ErrorHandler : Set ErrorHandler     = p_ErrorHandler     : End Property


Public Property Let StencilTest(n_StencilTest  As Boolean) : p_StencilTest    = n_StencilTest    : Call RenderSettings(GL_STENCIL_TEST , n_StencilTest) : End Property
Public Property Let DepthTest(n_DepthTest      As Boolean) : p_DepthTest      = n_DepthTest      : Call RenderSettings(GL_DEPTH_TEST   , n_DepthTest)   : End Property
Public Property Let BlendTest(n_BlendTest      As Boolean) : p_BlendTest      = n_BlendTest      : Call RenderSettings(GL_BLEND        , n_BlendTest)   : End Property
Public Property Let CullFace(n_CullFace        As Boolean) : p_CullFace       = n_CullFace       : Call RenderSettings(GL_CULL_FACE    , n_CullFace)    : End Property
Public Property Let StencilMode(n_StencilMode  As Long)    : p_StencilMode    = n_StencilMode    : Call RenderValue(GL_STENCIL_TEST    , n_StencilMode) : End Property
Public Property Let DepthMode(n_DepthMode      As Long)    : p_DepthMode      = n_DepthMode      : Call RenderValue(GL_DEPTH_TEST      , n_DepthMode)   : End Property
Public Property Let BlendMode(n_BlendMode      As Long)    : p_BlendMode      = n_BlendMode      : Call RenderValue(GL_BLEND           , n_BlendMode)   : End Property
Public Property Let CullMode(n_CullMode        As Long)    : p_CullMode       = n_CullMode       : Call RenderValue(GL_CULL_FACE       , n_CullMode)    : End Property
Public Property Let FrontFace(n_FrontFace      As Long)    : p_FrontFace      = n_FrontFace      : Call RenderValue(GL_FRONT_FACE      , n_FrontFace)   : End Property
Public Property Let PolygonMode(n_PolygonMode  As Long)    : p_PolygonMode    = n_PolygonMode    : Call RenderValue(, GL_FRONT_AND_BACK, n_PolygonMode) : End Property

Public Property Get StencilTest()              As Boolean  : StencilTest      = p_StencilTest    : End Property
Public Property Get DepthTest()                As Boolean  : DepthTest        = p_DepthTest      : End Property
Public Property Get BlendTest()                As Boolean  : BlendTest        = p_BlendTest      : End Property
Public Property Get CullFace()                 As Boolean  : CullFace         = p_CullFace       : End Property
Public Property Get CullMode()                 As Long     : CullMode         = p_CullMode       : End Property
Public Property Get FrontFace()                As Long     : FrontFace        = p_FrontFace      : End Property
Public Property Get PolygonMode()              As Long     : PolygonMode      = p_PolygonMode    : End Property



Public Function Create(Optional FilePath As String = Empty, Optional ContextProfile As Long = 0, Optional ContextFlag As Long = 0, Optional Logger As IDestination = Nothing, Optional Shower As IDestination = Nothing) As VBGLContext
    If FilePath = Empty Then FilePath = ThisWorkBook.Path
    If IsNothing(Logger) Then Set Logger = std_ImmiedeateDestination.Create()
    If IsNothing(Shower) Then Set Shower = std_MsgBoxDestination.Create()
    Dim NewErrorHandler As std_ErrorHandler
    Set NewErrorHandler = std_ErrorHandler.Create(Shower, Logger)
    #If VBA7 Then
        If LoadLibrary(FilePath & "\Freeglut64.dll") = False Then
    #Else
        If LoadLibrary(FilePath & "\Freeglut.dll") = False Then
    #End If
        Call NewErrorHandler.Handle(NewErrorHandler.IS_ERROR, std_Error.Create("VBGLContext", "Critical", "", "Couldnt load freeglut", Empty))
        Exit Function
    End If

    Call glutInit(0&, "")
    Call glutInitContextProfile(ContextProfile)
    Call glutInitContextFlags(ContextFlag)
    Set Create = New VBGLContext
    Create.ErrorHandler = NewErrorHandler
End Function

Public Sub RenderSettings(Inputt As Long, Value As Boolean)
    Select Case Inputt
        Case GL_STENCIL_TEST : If Value Then Call glEnable(GL_STENCIL_TEST)  Else Call glDisable(GL_STENCIL_TEST)
        Case GL_DEPTH_TEST   : If Value Then Call glEnable(GL_DEPTH_TEST)    Else Call glDisable(GL_DEPTH_TEST)
        Case GL_BLEND        : If Value Then Call glEnable(GL_BLEND)         Else Call glDisable(GL_BLEND)
        Case GL_CULL_FACE    : If Value Then Call glEnable(GL_CULL_FACE)     Else Call glDisable(GL_CULL_FACE)
    End Select
End Sub

Public Sub RenderValue(Inputt As Long, Value1 As Long, Optional Value2 As Long = 0, Optional Value3 As Long = 0)
    Select Case Inputt
        Case GL_STENCIL_TEST : If StencilTest Then Call glStencilFunc(Value1, Value2, Value3)
        Case GL_DEPTH_TEST   : If DepthTest   Then Call glDepthFunc(Value1)
        Case GL_BLEND        : If BlendTest   Then Call glBlendFunc(Value1, Value2)
        Case GL_CULL_FACE    : If CullFace    Then Call glCullFace(Value1)
        Case GL_FRONT_FACE   : If FrontFace   Then Call glFrontFace(Value1)
        'Case Polygonmode: Call glPolygonMode(Value1, Value2)
    End Select
End Sub

Public Sub SetCallBack(What As VBGLGlutCallback, Pointer As LongPtr)
    Select Case What
        Case VBGLDisplayFunc       : Call glutDisplayFunc(Pointer)
        Case VBGLIdleFunc          : Call glutIdleFunc(Pointer)
        Case VBGLKeyboardFunc      : Call glutKeyboardFunc(Pointer)
        Case VBGLPassiveMotionFunc : Call glutPassiveMotionFunc(Pointer)
        Case VBGLMouseWheelFunc    : Call glutMouseWheelFunc(Pointer)
    End Select
End Sub

Public Sub MainLoop()
    Call glutMainLoop()
End Sub

Public Sub Clear()
    Dim Mask As Long
    If BlendTest   Then Mask = Mask Or GL_COLOR_BUFFER_BIT
    If DepthTest   Then Mask = Mask Or GL_DEPTH_BUFFER_BIT
    If StencilTest Then Mask = Mask Or GL_STENCIL_BUFFER_BIT
    Call glClear(Mask)
End Sub

Public Sub ClearColor(Optional r As Single = 0, Optional g As Single = 0, Optional b As Single = 0, Optional a As Single = 1)
    Call glClearColor(r, g, b, a)
End Sub

Private Sub Class_Initialize()
End Sub