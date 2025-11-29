VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

#If VBA7 Then
    Private Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#Else
    Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#End If

Private p_ID      As Long
Private p_Title   As String
Private p_Height  As Long
Private p_Width   As Long
Private p_FPS     As Single
Private p_Frame   As VBGLFrame


Public Property Let ID(ByVal n_ID           As Long)       : Let p_ID      = n_ID      : End Property
Public Property Let Title(ByVal n_Title     As String)     : Let p_Title   = n_Title   : End Property
Public Property Let Height(ByVal n_Height   As Long)       : Let p_Height  = n_Height  : End Property
Public Property Let Width(ByVal n_Width     As Long)       : Let p_Width   = n_Width   : End Property
Public Property Let FPS(ByVal n_FPS         As Single)     : Let p_FPS     = n_FPS     : End Property
Public Property Let Frame(ByVal n_Frame     As VBGLFrame)  : Set p_Frame   = n_Frame   : End Property

Public Property Get ID()                    As Long        : Let ID        = p_ID      : End Property
Public Property Get Title()                 As String      : Let Title     = p_Title   : End Property
Public Property Get Height()                As Long        : Let Height    = p_Height  : End Property
Public Property Get Width()                 As Long        : Let Width     = p_Width   : End Property
Public Property Get FPS()                   As Single      : Let FPS       = p_FPS     : End Property
Public Property Get Frame()                 As VBGLFrame   : Set Frame     = p_Frame   : End Property

Public Property Get NormalHeight() As Single
    NormalHeight = 1 / Height
End Property
Public Property Get NormalWidth() As Single
    NormalWidth = 1 / Width
End Property

Public Function Create(ByVal n_Width As Long, ByVal n_Height As Long, ByVal DisplayMode As Long, Optional ByVal n_Title As String = Empty, Optional ByVal Version As String = "4_6", Optional ByVal Debugg As Boolean = True) As VBGLWindow
    Dim Found As VBGLShader
    Set Found = Find(n_Title)
    If IsSomething(Found) Then
        Set Create = Found
        Exit Function
    End If


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
        .Title  = n_Title
        .ID     = CreateWindow()
        .Height = n_Height
        .Width  = n_Width
        .Frame = VBGLFrame.Create(0, 0, n_Width, n_Height, 0, 0, n_Width, n_Height)
    End With
    Call RemapVBToGL(Version)
    If Debugg Then Call GLStartDebug()
    Call VBGLAdd(LoadedWindows, Create)
    Call Create.Bind()

    With CurrentContext
        .CurrentFrame = Create.Frame
        .ScissorTest = True
        Call .Scissor(0, 0, n_Width, n_Height)
        Call .Viewport(0, 0, n_Width, n_Height)
    End With
End Function

Public Sub Cursor(ByVal X As Long, ByVal Y As Long)
    Call glutWarpPointer(X, Y)
End Sub

Public Function GetWindowHwnd(ByVal Window As Long)
    GetWindowHwnd = glutGetWindowHwnd(Window)
End Function

Public Sub Bind()
    CurrentContext.CurrentWindow = Me
End Sub
Public Sub Unbind()
    CurrentContext.CurrentWindow = Nothing
End Sub

Public Function LimitFPS() As Single
    Static LastTime As Single
    Dim CurrentTime As Single
    Dim ElapsedTime As Single
    Dim MillisecondsPerFrame As Single
    Dim WaitTime As Single

    CurrentTime = Timer
    ElapsedTime = (CurrentTime - LastTime) * 1000
    If ElapsedTime < 0 Then ElapsedTime = (86400 + CurrentTime - LastTime) * 1000  ' handle midnight

    If FPS > 0 Then
        MillisecondsPerFrame = 1000 / FPS
        If ElapsedTime < MillisecondsPerFrame Then
            WaitTime = MillisecondsPerFrame - ElapsedTime
            Sleep CLng(WaitTime)
            CurrentTime = Timer
            ElapsedTime = (CurrentTime - LastTime) * 1000
        End If
    End If

    LastTime = CurrentTime
    If ElapsedTime = 0 Then ElapsedTime = 1
    LimitFPS = 1000 / ElapsedTime
End Function


Private Function Find(ByVal n_Title As String) As VBGLWindow
    Dim i As Long
    For i = 0 To USize(LoadedWindows)
        If LoadedWindows(i).Title = n_Title Then
            Set Find = LoadedWindows(i)
        End If
    Next i
End Function

Private Function CreateWindow() As Long
    CreateWindow = glutCreateWindow(Title)
    Call glutSetWindowTitle(Title)
End Function

Private Sub Class_Terminate()
    Call glutDestroyWindow(p_ID)
    CurrentContext.CurrentWindow = Nothing
End Sub

Private Function RemapVBToGL(Optional ByVal ToInclude As String = "ALL") As Boolean
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