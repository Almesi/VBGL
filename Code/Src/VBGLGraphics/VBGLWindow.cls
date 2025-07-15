VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Context As VBGLContext
Private p_ID      As Long
Private p_Height  As Long
Private p_Width   As Long



Public Property Let Context(n_Context As VBGLContext): Set p_Context = n_Context : End Property
Public Property Let ID(n_ID           As Long)       : Let p_ID      = n_ID      : End Property
Public Property Let Height(n_Height   As Long)       : Let p_Height  = n_Height  : End Property
Public Property Let Width(n_Width     As Long)       : Let p_Width   = n_Width   : End Property

Public Property Get Context()         As VBGLContext : Set Context   = p_Context : End Property
Public Property Get ID()              As Long        : Let ID        = p_ID      : End Property
Public Property Get Height()          As Long        : Let Height    = p_Height  : End Property
Public Property Get Width()           As Long        : Let Width     = p_Width   : End Property

Public Function Create(n_Width As Long, n_Height As Long, DisplayMode As Long, Optional Title As String = Empty, Optional Version As String = "4_6", Optional Debugg As Boolean = True) As VBGLWindow
    Call glutInitDisplayMode(DisplayMode)
    Call glutInitWindowSize(n_Width, n_Height)
    Call glutSetOption(GLUT_ACTION_ON_WINDOW_CLOSE, GLUT_ACTION_GLUTMAINLOOP_RETURNS)

    Dim VersionIndex() As String
    Dim Major As Long
    Dim Minor As Long

    VersionIndex = Split(Version, "_")
    If Ubound(VersionIndex) < 0 Then
        Exit Function
    ElseIf Ubound(VersionIndex) = 0 Then
        Major = 4
        Minor = 6
    Else
        Major = CLng(VersionIndex(0))
        Minor = CLng(VersionIndex(1))
    End If

    Call glutInitContextVersion(Major, Minor)
    Set Create = New VBGLWindow
    With Create
        .ID = glutCreateWindow(Title)
        .Height = n_Height
        .Width  = n_Width
    End With
    Call RemapVBToGL(Version)
    If Debugg Then Call GLStartDebug()
End Function

Public Sub Cursor(X As Long, Y As Long)
    Call glutWarpPointer(X, Y)
End Sub

Public Function GetWindowHwnd(Window As Long)
    GetWindowHwnd = glutGetWindowHwnd(Window)
End Function

Public Sub Bind()
    Context.CurrentWindow = ID
End Sub
Public Sub UnBind()
    Context.CurrentWindow = 0
End Sub

Private Sub Class_Initialize()
    Context = VBGLContext
End Sub
Private Sub Class_Terminate()
    Call glutDestroyWindow(p_ID)
    Context.CurrentWindow = 0
End Sub

Private Function RemapVBToGL(Optional ToInclude As String = "ALL") As Boolean
    Repeat:
    Select Case ToInclude
    Case "ALL"  :                                         : ToInclude = "OTHER": GoTo Repeat
    Case "OTHER": Call Application.Run("RemapVBToGLOTHER"): ToInclude = "WGL"  : GoTo Repeat
    Case "WGL"  : Call Application.Run("RemapVBToGLWGL")  : ToInclude = "EXT"  : GoTo Repeat
    Case "EXT"  : Call Application.Run("RemapVBToGLEXT")  : ToInclude = "ARB"  : GoTo Repeat
    Case "ARB"  : Call Application.Run("RemapVBToGLARB")  : ToInclude = "4_6"  : GoTo Repeat
    Case "4_6"  : Call Application.Run("RemapVBToGL4_6")  : ToInclude = "4_5"  : GoTo Repeat
    Case "4_5"  : Call Application.Run("RemapVBToGL4_5")  : ToInclude = "4_4"  : GoTo Repeat
    Case "4_4"  : Call Application.Run("RemapVBToGL4_4")  : ToInclude = "4_3"  : GoTo Repeat
    Case "4_3"  : Call Application.Run("RemapVBToGL4_3")  : ToInclude = "4_2"  : GoTo Repeat
    Case "4_2"  : Call Application.Run("RemapVBToGL4_2")  : ToInclude = "4_1"  : GoTo Repeat
    Case "4_1"  : Call Application.Run("RemapVBToGL4_1")  : ToInclude = "4_0"  : GoTo Repeat
    Case "4_0"  : Call Application.Run("RemapVBToGL4_0")  : ToInclude = "3_3"  : GoTo Repeat
    Case "3_3"  : Call Application.Run("RemapVBToGL3_3")  : ToInclude = "3_2"  : GoTo Repeat
    Case "3_2"  : Call Application.Run("RemapVBToGL3_2")  : ToInclude = "3_1"  : GoTo Repeat
    Case "3_1"  : Call Application.Run("RemapVBToGL3_1")  : ToInclude = "3_0"  : GoTo Repeat
    Case "3_0"  : Call Application.Run("RemapVBToGL3_0")  : ToInclude = "2_1"  : GoTo Repeat
    Case "2_1"  : Call Application.Run("RemapVBToGL2_1")  : ToInclude = "2_0"  : GoTo Repeat
    Case "2_0"  : Call Application.Run("RemapVBToGL2_0")  : ToInclude = "1_5"  : GoTo Repeat
    Case "1_5"  : Call Application.Run("RemapVBToGL1_5")  : ToInclude = "1_4"  : GoTo Repeat
    Case "1_4"  : Call Application.Run("RemapVBToGL1_4")  : ToInclude = "1_3"  : GoTo Repeat
    Case "1_3"  : Call Application.Run("RemapVBToGL1_3")  : ToInclude = "1_2"  : GoTo Repeat
    Case "1_2"  : Call Application.Run("RemapVBToGL1_2")  : ToInclude = "1_1"  : GoTo Repeat
    Case "1_1"  : Call Application.Run("RemapVBToGL1_1")  : RemapVBToGL = True
    Case Else
    End Select
End Function