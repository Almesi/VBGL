VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLRenderObject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Option Explicit

Implements VBGLDrawable

Private Drawables()   As VBGLDrawable
Private p_UserInput   As VBGLIInput
Private p_Frame       As VBGLFrame
Private p_Callbacks   As VBGLCallback
Private p_R           As Single
Private p_G           As Single
Private p_B           As Single
Private p_A           As Single


Public Property Let UserInput(ByVal n_Value As VBGLIInput)   : Set p_UserInput = n_Value            : End Property
Public Property Let Frame(ByVal     n_Value As VBGLFrame)    : Set p_Frame     = n_Value            : End Property
Public Property Let Callbacks(ByVal n_Value As VBGLCallback) : Set p_Callbacks = n_Value            : End Property

Public Property Get Drawable(Index As Long) As VBGLDrawable  : Set Drawable    = Drawables(Index)   : End Property
Public Property Get UserInput()             As VBGLIInput    : Set UserInput   = p_UserInput        : End Property
Public Property Get Frame()                 As VBGLFrame     : Set Frame       = p_Frame            : End Property
Public Property Get Callbacks()             As VBGLCallback  : Set Callbacks   = p_Callbacks        : End Property
Public Property Get R()                     As Single        : Let R           = p_R                : End Property
Public Property Get G()                     As Single        : Let G           = p_G                : End Property
Public Property Get B()                     As Single        : Let B           = p_B                : End Property
Public Property Get A()                     As Single        : Let A           = p_A                : End Property

Private Sub VBGLDrawable_Draw()
    Call Draw()
End Sub

Public Function Create(ByVal n_UserInput As VBGLIInput, ByVal n_Frame As VBGLFrame, Optional ByVal n_Callbacks As VBGLCallback = Nothing) As VBGLRenderObject
    Set Create = New VBGLRenderObject
    With Create
        .UserInput = n_UserInput
        .Frame     = n_Frame
        .Callbacks = Iif(IsNothing(n_Callbacks), CreateCallbacks(Create), n_Callbacks)
    End With
End Function

Public Sub AddDrawable(ByVal n_Drawable As VBGLDrawable)
    Call VBGLAdd(Drawables, n_Drawable)
End Sub

Public Sub RemoveDrawable()
    Call VBGLArrayPop(Drawables)
End Sub

Public Function CreateCallbacks(ByVal Obj As VBGLRenderObject) As VBGLCallback
    Set CreateCallbacks = VBGLCallback.Create()
    With CreateCallbacks
        Call .SetDisplayFunc(std_Callable.Create(Obj      , "Loopp"      , vbMethod , -1))
        Call .SetIdleFunc(std_Callable.Create(Obj         , "Loopp"      , vbMethod , -1))
        Call .SetKeyboardFunc(std_Callable.Create(Obj     , "KeyBoard"   , vbMethod , 2))
        Call .SetKeyboardUpFunc(std_Callable.Create(Obj   , "KeyBoardUp" , vbMethod , 2))
        Call .SetPassiveMotionFunc(std_Callable.Create(Obj, "MouseMove"  , vbMethod , 1))
        Call .SetMouseWheelFunc(std_Callable.Create(Obj   , "MouseWheel" , vbMethod , 3))
    End With
End Function

Public Sub AssignColor(ByVal n_R As Single, ByVal n_G As Single, ByVal n_B As Single, ByVal n_A As Single)
    p_R = n_R
    p_G = n_G
    p_B = n_B
    p_A = n_A
End Sub

Public Sub Draw()
    Dim i As Long
    Call Frame.Bind()
    For i = 0 To USize(Drawables)
        Call Drawable(i).Draw()
    Next i
    Call Frame.Unbind()
End Sub

Public Sub Loopp()
    Call CurrentContext.Clear()
    Call CurrentContext.ClearColor(R, G, B, A)
    Call Draw()
    Call glutSwapBuffers()
End Sub

Public Sub KeyBoard(ByVal Char As Byte, ByVal x As Long, ByVal y As Long)
    Call UserInput.KeyDown(Char, x, y)
End Sub

Public Sub KeyBoardUp(ByVal Char As Byte, ByVal x As Long, ByVal y As Long)
    Call UserInput.KeyUp(Char, x, y)
End Sub

Public Sub MouseMove(ByVal x As Long, ByVal y As Long)
    Call UserInput.KeyDown(0, x, y)
End Sub

Public Sub MouseWheel(ByVal wheel As Long, ByVal direction As Long, ByVal x As Long, ByVal y As Long)
    Call UserInput.MouseWheel(wheel, direction, x, y)
End Sub

Private Sub Class_Initialize()
    Call AssignColor(1, 1, 1, 1)
End Sub