VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLCallback"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Option Explicit


Private p_DisplayFunc         As std_Callable
Private p_OverlayDisplayFunc  As std_Callable
Private p_ReshapeFunc         As std_Callable
Private p_PositionFunc        As std_Callable
Private p_CloseFunc           As std_Callable
Private p_IdleFunc            As std_Callable
Private p_TimerFunc           As std_Callable
Private p_KeyboardFunc        As std_Callable
Private p_SpecialFunc         As std_Callable
Private p_KeyboardUpFunc      As std_Callable
Private p_SpecialUpFunc       As std_Callable
Private p_MouseFunc           As std_Callable
Private p_MouseWheelFunc      As std_Callable
Private p_MotionFunc          As std_Callable
Private p_PassiveMotionFunc   As std_Callable
Private p_EntryFunc           As std_Callable
Private p_MenuStatusFunc      As std_Callable
Private p_MenuStateFunc       As std_Callable
Private p_WindowStatusFunc    As std_Callable
Private p_JoystickFunc        As std_Callable
Private p_SpaceballMotionFunc As std_Callable
Private p_SpaceballRotateFunc As std_Callable
Private p_SpaceballButtonFunc As std_Callable
Private p_ButtonBoxFunc       As std_Callable
Private p_DialsFunc           As std_Callable
Private p_TabletMotionFunc    As std_Callable
Private p_TabletButtonFunc    As std_Callable
Private p_VisibilityFunc      As std_Callable

Public Function Create() As VBGLCallback
    Set Create = New VBGLCallback
End Function

Public Sub SetDisplayFunc(ByVal          n_Callable As std_Callable) : Set p_DisplayFunc         = n_Callable : End Sub
Public Sub SetOverlayDisplayFunc(ByVal   n_Callable As std_Callable) : Set p_OverlayDisplayFunc  = n_Callable : End Sub
Public Sub SetReshapeFunc(ByVal          n_Callable As std_Callable) : Set p_ReshapeFunc         = n_Callable : End Sub
Public Sub SetPositionFunc(ByVal         n_Callable As std_Callable) : Set p_PositionFunc        = n_Callable : End Sub
Public Sub SetCloseFunc(ByVal            n_Callable As std_Callable) : Set p_CloseFunc           = n_Callable : End Sub
Public Sub SetIdleFunc(ByVal             n_Callable As std_Callable) : Set p_IdleFunc            = n_Callable : End Sub
Public Sub SetTimerFunc(ByVal            n_Callable As std_Callable) : Set p_TimerFunc           = n_Callable : End Sub
Public Sub SetKeyboardFunc(ByVal         n_Callable As std_Callable) : Set p_KeyboardFunc        = n_Callable : End Sub
Public Sub SetSpecialFunc(ByVal          n_Callable As std_Callable) : Set p_SpecialFunc         = n_Callable : End Sub
Public Sub SetKeyboardUpFunc(ByVal       n_Callable As std_Callable) : Set p_KeyboardUpFunc      = n_Callable : End Sub
Public Sub SetSpecialUpFunc(ByVal        n_Callable As std_Callable) : Set p_SpecialUpFunc       = n_Callable : End Sub
Public Sub SetMouseFunc(ByVal            n_Callable As std_Callable) : Set p_MouseFunc           = n_Callable : End Sub
Public Sub SetMouseWheelFunc(ByVal       n_Callable As std_Callable) : Set p_MouseWheelFunc      = n_Callable : End Sub
Public Sub SetMotionFunc(ByVal           n_Callable As std_Callable) : Set p_MotionFunc          = n_Callable : End Sub
Public Sub SetPassiveMotionFunc(ByVal    n_Callable As std_Callable) : Set p_PassiveMotionFunc   = n_Callable : End Sub
Public Sub SetEntryFunc(ByVal            n_Callable As std_Callable) : Set p_EntryFunc           = n_Callable : End Sub
Public Sub SetMenuStatusFunc(ByVal       n_Callable As std_Callable) : Set p_MenuStatusFunc      = n_Callable : End Sub
Public Sub SetMenuStateFunc(ByVal        n_Callable As std_Callable) : Set p_MenuStateFunc       = n_Callable : End Sub
Public Sub SetWindowStatusFunc(ByVal     n_Callable As std_Callable) : Set p_WindowStatusFunc    = n_Callable : End Sub
Public Sub SetJoystickFunc(ByVal         n_Callable As std_Callable) : Set p_JoystickFunc        = n_Callable : End Sub
Public Sub SetSpaceballMotionFunc(ByVal  n_Callable As std_Callable) : Set p_SpaceballMotionFunc = n_Callable : End Sub
Public Sub SetSpaceballRotateFunc(ByVal  n_Callable As std_Callable) : Set p_SpaceballRotateFunc = n_Callable : End Sub
Public Sub SetSpaceballButtonFunc(ByVal  n_Callable As std_Callable) : Set p_SpaceballButtonFunc = n_Callable : End Sub
Public Sub SetButtonBoxFunc(ByVal        n_Callable As std_Callable) : Set p_ButtonBoxFunc       = n_Callable : End Sub
Public Sub SetDialsFunc(ByVal            n_Callable As std_Callable) : Set p_DialsFunc           = n_Callable : End Sub
Public Sub SetTabletMotionFunc(ByVal     n_Callable As std_Callable) : Set p_TabletMotionFunc    = n_Callable : End Sub
Public Sub SetTabletButtonFunc(ByVal     n_Callable As std_Callable) : Set p_TabletButtonFunc    = n_Callable : End Sub
Public Sub SetVisibilityFunc(ByVal       n_Callable As std_Callable) : Set p_VisibilityFunc      = n_Callable : End Sub

Public Sub DisplayFunc()                                                                                    : Call Run(p_DisplayFunc)                              : End Sub
Public Sub OverlayDisplayFunc()                                                                             : Call Run(p_OverlayDisplayFunc)                       : End Sub
Public Sub ReshapeFunc(ByVal width As Long, ByVal height As Long)                                           : Call Run(p_ReshapeFunc, width, height)               : End Sub
Public Sub PositionFunc()                                                                                   : Call Run(p_PositionFunc)                             : End Sub
Public Sub CloseFunc()                                                                                      : Call Run(p_CloseFunc)                                : End Sub
Public Sub IdleFunc()                                                                                       : Call Run(p_IdleFunc)                                 : End Sub
Public Sub TimerFunc()                                                                                      : Call Run(p_TimerFunc)                                : End Sub
Public Sub KeyboardFunc(ByVal key As Byte, ByVal x As Long, ByVal y As Long)                                : Call Run(p_KeyboardFunc, key, x, y)                  : End Sub
Public Sub SpecialFunc(ByVal key As Long, ByVal x As Long, ByVal y As Long)                                 : Call Run(p_SpecialFunc, key, x, y)                   : End Sub
Public Sub KeyboardUpFunc(ByVal key As Byte, ByVal x As Long, ByVal y As Long)                              : Call Run(p_KeyboardUpFunc, key, x, y)                : End Sub
Public Sub SpecialUpFunc(ByVal key As Long, ByVal x As Long, ByVal y As Long)                               : Call Run(p_SpecialUpFunc, key, x, y)                 : End Sub
Public Sub MouseFunc(ByVal button As Long, ByVal state As Long, ByVal x As Long, ByVal y As Long)           : Call Run(p_MouseFunc, button, state, x, y)           : End Sub
Public Sub MouseWheelFunc(ByVal wheel As Long, ByVal direction As Long, ByVal x As Long, ByVal y As Long)   : Call Run(p_MouseWheelFunc, wheel, direction, x, y)   : End Sub
Public Sub MotionFunc(ByVal x As Long, ByVal y As Long)                                                     : Call Run(p_MotionFunc, x, y)                         : End Sub
Public Sub PassiveMotionFunc(ByVal x As Long, ByVal y As Long)                                              : Call Run(p_PassiveMotionFunc, x, y)                  : End Sub
Public Sub EntryFunc()                                                                                      : Call Run(p_EntryFunc)                                : End Sub
Public Sub MenuStatusFunc()                                                                                 : Call Run(p_MenuStatusFunc)                           : End Sub
Public Sub MenuStateFunc()                                                                                  : Call Run(p_MenuStateFunc)                            : End Sub
Public Sub WindowStatusFunc()                                                                               : Call Run(p_WindowStatusFunc)                         : End Sub
Public Sub JoystickFunc(ByVal button As Long, ByVal x As Long, ByVal y As Long, ByVal time As Long)         : Call Run(p_JoystickFunc, button, x, y, time)         : End Sub
Public Sub SpaceballMotionFunc(ByVal x As Long, ByVal y As Long, ByVal z As Long)                           : Call Run(p_SpaceballMotionFunc, x, y, z)             : End Sub
Public Sub SpaceballRotateFunc(ByVal x As Long, ByVal y As Long, ByVal z As Long)                           : Call Run(p_SpaceballRotateFunc, x, y, z)             : End Sub
Public Sub SpaceballButtonFunc(ByVal button As Long, ByVal state As Long, ByVal x As Long, ByVal y As Long) : Call Run(p_SpaceballButtonFunc, button, state, x, y) : End Sub
Public Sub ButtonBoxFunc(ByVal button As Long, ByVal state As Long, ByVal x As Long, ByVal y As Long)       : Call Run(p_ButtonBoxFunc, button, state, x, y)       : End Sub
Public Sub DialsFunc(ByVal dial As Long, ByVal value As Long, ByVal x As Long, ByVal y As Long)             : Call Run(p_DialsFunc, dial, value, x, y)             : End Sub
Public Sub TabletMotionFunc(ByVal x As Long, ByVal y As Long)                                               : Call Run(p_TabletMotionFunc, x, y)                   : End Sub
Public Sub TabletButtonFunc(ByVal button As Long, ByVal state As Long, ByVal x As Long, ByVal y As Long)    : Call Run(p_TabletButtonFunc, button, state, x, y)    : End Sub
Public Sub VisibilityFunc()                                                                                 : Call Run(p_VisibilityFunc)                           : End Sub

Private Sub Run(ByVal Callable As std_Callable, ParamArray Args() As Variant)
    Dim ArgsV() As Variant
    ArgsV = Args
    Call RunArr(Callable, ArgsV)
End Sub

Private Sub RunArr(ByVal Callable As std_Callable, ByRef Args() As Variant)
    If IsSomething(Callable) Then
        Call Callable.RunArr(Args)
    End If
End Sub