VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLFrame"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Option Explicit


Private p_ScissorX        As Long
Private p_ScissorY        As Long
Private p_ScissorWidth    As Long
Private p_ScissorHeight   As Long
Private p_ViewportX       As Long
Private p_ViewportY       As Long
Private p_ViewportWidth   As Long
Private p_ViewportHeight  As Long

Private OldScissorTest    As Boolean
Private OldScissorX       As Long
Private OldScissorY       As Long
Private OldScissorWidth   As Long
Private OldScissorHeight  As Long
Private OldViewportX      As Long
Private OldViewportY      As Long
Private OldViewportWidth  As Long
Private OldViewportHeight As Long

Public Property Let ScissorX(n_ScissorX               As Long) : p_ScissorX        = n_ScissorX        : End Property
Public Property Let ScissorY(n_ScissorY               As Long) : p_ScissorY        = n_ScissorY        : End Property
Public Property Let ScissorWidth(n_ScissorWidth       As Long) : p_ScissorWidth    = n_ScissorWidth    : End Property
Public Property Let ScissorHeight(n_ScissorHeight     As Long) : p_ScissorHeight   = n_ScissorHeight   : End Property
Public Property Let ViewportX(n_ViewportX             As Long) : p_ViewportX       = n_ViewportX       : End Property
Public Property Let ViewportY(n_ViewportY             As Long) : p_ViewportY       = n_ViewportY       : End Property
Public Property Let ViewportWidth(n_ViewportWidth     As Long) : p_ViewportWidth   = n_ViewportWidth   : End Property
Public Property Let ViewportHeight(n_ViewportHeight   As Long) : p_ViewportHeight  = n_ViewportHeight  : End Property

Public Property Get ScissorX()                        As Long  : ScissorX          = p_ScissorX        : End Property
Public Property Get ScissorY()                        As Long  : ScissorY          = p_ScissorY        : End Property
Public Property Get ScissorWidth()                    As Long  : ScissorWidth      = p_ScissorWidth    : End Property
Public Property Get ScissorHeight()                   As Long  : ScissorHeight     = p_ScissorHeight   : End Property
Public Property Get ViewportX()                       As Long  : ViewportX         = p_ViewportX       : End Property
Public Property Get ViewportY()                       As Long  : ViewportY         = p_ViewportY       : End Property
Public Property Get ViewportWidth()                   As Long  : ViewportWidth     = p_ViewportWidth   : End Property
Public Property Get ViewportHeight()                  As Long  : ViewportHeight    = p_ViewportHeight  : End Property

Public Function CreateFromWindow(ByVal n_ScissorX As Single, _
                       ByVal n_ScissorY As Single, _
                       ByVal n_ScissorWidth As Single, _
                       ByVal n_ScissorHeight As Single, _
                       ByVal n_ViewportX As Single, _
                       ByVal n_ViewportY As Single, _
                       ByVal n_ViewportWidth As Single, _
                       ByVal n_ViewportHeight As Single, _
                       ByVal n_Window As VBGLWindow) As VBGLFrame
    With n_Window
        Set CreateFromWindow = Create( _
            n_ScissorX       * .Width, _
            n_ScissorY       * .Height, _
            n_ScissorWidth   * .Width, _
            n_ScissorHeight  * .Height, _
            n_ViewportX      * .Width, _
            n_ViewportY      * .Height, _
            n_ViewportWidth  * .Width, _
            n_ViewportHeight * .Height)
    End With
End Function


Public Function Create(ByVal n_ScissorX As Long, _      
                       ByVal n_ScissorY As Long, _      
                       ByVal n_ScissorWidth As Long, _  
                       ByVal n_ScissorHeight As Long, _ 
                       ByVal n_ViewportX As Long, _     
                       ByVal n_ViewportY As Long, _     
                       ByVal n_ViewportWidth As Long, _ 
                       ByVal n_ViewportHeight As Long) As VBGLFrame

    Set Create = New VBGLFrame
    With Create
        .ScissorX       = n_ScissorX
        .ScissorY       = n_ScissorY
        .ScissorWidth   = n_ScissorWidth
        .ScissorHeight  = n_ScissorHeight
        .ViewportX      = n_ViewportX
        .ViewportY      = n_ViewportY
        .ViewportWidth  = n_ViewportWidth
        .ViewportHeight = n_ViewportHeight
    End With
End Function


Public Sub Bind()
    With CurrentContext
        .CurrentFrame     = Me
        OldScissorTest    = .ScissorTest
        OldScissorX       = .GetScissorX
        OldScissorY       = .GetScissorY
        OldScissorWidth   = .GetScissorWidth
        OldScissorHeight  = .GetScissorHeight
        OldViewportX      = .GetViewportX
        OldViewportY      = .GetViewportY
        OldViewportWidth  = .GetViewportWidth
        OldViewportHeight = .GetViewportHeight
        .ScissorTest      = True
        Call .Scissor(ScissorX, ScissorY, ScissorWidth, ScissorHeight)
        Call .Viewport(ViewportX, ViewportY, ViewportWidth, ViewportHeight)
    End With
End Sub

Public Sub Unbind()
    With CurrentContext
        .CurrentFrame     = Nothing
        .ScissorTest = False
        Call .Scissor(OldScissorX, OldScissorY , OldScissorWidth , OldScissorHeight)
        Call .Viewport(OldViewportX  , OldViewportY, OldViewportWidth, OldViewportHeight)
    End With
End Sub

Public Sub ClearColor(Optional ByVal r As Single = 0, Optional ByVal g As Single = 0, Optional ByVal b As Single = 0, Optional ByVal a As Single = 1)
    Call glClearColor(r, g, b, a)
End Sub

Public Sub ClearColorArr(ByRef Arr() As Single)
    Dim Size As Long
    Size = USize(Arr)
    Select Case Size
        Case -1 : Call glClearColor(0     , 0     , 0     , 1)
        Case 0  : Call glClearColor(Arr(0), 0     , 0     , 0)
        Case 1  : Call glClearColor(Arr(0), Arr(1), 0     , 0)
        Case 2  : Call glClearColor(Arr(0), Arr(1), Arr(2), 0)
        Case 3  : Call glClearColor(Arr(0), Arr(1), Arr(2), Arr(3))
    End Select
End Sub