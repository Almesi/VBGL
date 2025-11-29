Attribute VB_Name = "VBGLRenderPublic"

Public CurrentRenderObject As VBGLRenderObject

Option Explicit

'Needed, as callback functions need to be on the same standard module as the calling procedure for setting them up
Public Sub VBGLCallBackFunc(ByVal Name As String)
    Select Case Name
        Case "DisplayFunc"         : Call CurrentContext.SetDisplayFunc(AddressOf VBGLCallbackDisplayFunc)
        Case "OverlayDisplayFunc"  : Call CurrentContext.SetOverlayDisplayFunc(AddressOf VBGLCallbackOverlayDisplayFunc)
        Case "ReshapeFunc"         : Call CurrentContext.SetReshapeFunc(AddressOf VBGLCallbackReshapeFunc)
        Case "PositionFunc"        : Call CurrentContext.SetPositionFunc(AddressOf VBGLCallbackPositionFunc)
        Case "CloseFunc"           : Call CurrentContext.SetCloseFunc(AddressOf VBGLCallbackCloseFunc)
        Case "IdleFunc"            : Call CurrentContext.SetIdleFunc(AddressOf VBGLCallbackIdleFunc)
        Case "TimerFunc"           : Call CurrentContext.SetTimerFunc(AddressOf VBGLCallbackTimerFunc)
        Case "KeyboardFunc"        : Call CurrentContext.SetKeyboardFunc(AddressOf VBGLCallbackKeyboardFunc)
        Case "SpecialFunc"         : Call CurrentContext.SetSpecialFunc(AddressOf VBGLCallbackSpecialFunc)
        Case "KeyboardUpFunc"      : Call CurrentContext.SetKeyboardUpFunc(AddressOf VBGLCallbackKeyboardUpFunc)
        Case "SpecialUpFunc"       : Call CurrentContext.SetSpecialUpFunc(AddressOf VBGLCallbackSpecialUpFunc)
        Case "MouseFunc"           : Call CurrentContext.SetMouseFunc(AddressOf VBGLCallbackMouseFunc)
        Case "MouseWheelFunc"      : Call CurrentContext.SetMouseWheelFunc(AddressOf VBGLCallbackMouseWheelFunc)
        Case "MotionFunc"          : Call CurrentContext.SetMotionFunc(AddressOf VBGLCallbackMotionFunc)
        Case "PassiveMotionFunc"   : Call CurrentContext.SetPassiveMotionFunc(AddressOf VBGLCallbackPassiveMotionFunc)
        Case "EntryFunc"           : Call CurrentContext.SetEntryFunc(AddressOf VBGLCallbackEntryFunc)
        Case "MenuStatusFunc"      : Call CurrentContext.SetMenuStatusFunc(AddressOf VBGLCallbackMenuStatusFunc)
        Case "MenuStateFunc"       : Call CurrentContext.SetMenuStateFunc(AddressOf VBGLCallbackMenuStateFunc)
        Case "WindowStatusFunc"    : Call CurrentContext.SetWindowStatusFunc(AddressOf VBGLCallbackWindowStatusFunc)
        Case "JoystickFunc"        : Call CurrentContext.SetJoystickFunc(AddressOf VBGLCallbackJoystickFunc)
        Case "SpaceballMotionFunc" : Call CurrentContext.SetSpaceballMotionFunc(AddressOf VBGLCallbackSpaceballMotionFunc)
        Case "SpaceballRotateFunc" : Call CurrentContext.SetSpaceballRotateFunc(AddressOf VBGLCallbackSpaceballRotateFunc)
        Case "SpaceballButtonFunc" : Call CurrentContext.SetSpaceballButtonFunc(AddressOf VBGLCallbackSpaceballButtonFunc)
        Case "ButtonBoxFunc"       : Call CurrentContext.SetButtonBoxFunc(AddressOf VBGLCallbackButtonBoxFunc)
        Case "DialsFunc"           : Call CurrentContext.SetDialsFunc(AddressOf VBGLCallbackDialsFunc)
        Case "TabletMotionFunc"    : Call CurrentContext.SetTabletMotionFunc(AddressOf VBGLCallbackTabletMotionFunc)
        Case "TabletButtonFunc"    : Call CurrentContext.SetTabletButtonFunc(AddressOf VBGLCallbackTabletButtonFunc)
        Case "VisibilityFunc"      : Call CurrentContext.SetVisibilityFunc(AddressOf VBGLCallbackVisibilityFunc)
    End Select
End Sub

Public Sub VBGLCallbackDisplayFunc()                                                                                     : Call CurrentRenderObject.Callbacks.DisplayFunc()                            : End Sub
Public Sub VBGLCallbackOverlayDisplayFunc()                                                                              : Call CurrentRenderObject.Callbacks.OverlayDisplayFunc()                     : End Sub
Public Sub VBGLCallbackReshapeFunc(ByVal width As Long, ByVal height As Long)                                            : Call CurrentRenderObject.Callbacks.ReshapeFunc(width, height)               : End Sub
Public Sub VBGLCallbackPositionFunc()                                                                                    : Call CurrentRenderObject.Callbacks.PositionFunc()                           : End Sub
Public Sub VBGLCallbackCloseFunc()                                                                                       : Call CurrentRenderObject.Callbacks.CloseFunc()                              : End Sub
Public Sub VBGLCallbackIdleFunc()                                                                                        : Call CurrentRenderObject.Callbacks.IdleFunc()                               : End Sub
Public Sub VBGLCallbackTimerFunc()                                                                                       : Call CurrentRenderObject.Callbacks.TimerFunc()                              : End Sub
Public Sub VBGLCallbackKeyboardFunc(ByVal key As Byte, ByVal x As Long, ByVal y As Long)                                 : Call CurrentRenderObject.Callbacks.KeyboardFunc(key, x, y)                  : End Sub
Public Sub VBGLCallbackSpecialFunc(ByVal key As Long, ByVal x As Long, ByVal y As Long)                                  : Call CurrentRenderObject.Callbacks.SpecialFunc(key, x, y)                   : End Sub
Public Sub VBGLCallbackKeyboardUpFunc(ByVal key As Byte, ByVal x As Long, ByVal y As Long)                               : Call CurrentRenderObject.Callbacks.KeyboardUpFunc(key, x, y)                : End Sub
Public Sub VBGLCallbackSpecialUpFunc(ByVal key As Long, ByVal x As Long, ByVal y As Long)                                : Call CurrentRenderObject.Callbacks.SpecialUpFunc(key, x, y)                 : End Sub
Public Sub VBGLCallbackMouseFunc(ByVal button As Long, ByVal state As Long, ByVal x As Long, ByVal y As Long)            : Call CurrentRenderObject.Callbacks.MouseFunc(button, state, x, y)           : End Sub
Public Sub VBGLCallbackMouseWheelFunc(ByVal wheel As Long, ByVal direction As Long, ByVal x As Long, ByVal y As Long)    : Call CurrentRenderObject.Callbacks.MouseWheelFunc(wheel, direction, x, y)   : End Sub
Public Sub VBGLCallbackMotionFunc(ByVal x As Long, ByVal y As Long)                                                      : Call CurrentRenderObject.Callbacks.MotionFunc(x, y)                         : End Sub
Public Sub VBGLCallbackPassiveMotionFunc(ByVal x As Long, ByVal y As Long)                                               : Call CurrentRenderObject.Callbacks.PassiveMotionFunc(x, y)                  : End Sub
Public Sub VBGLCallbackEntryFunc()                                                                                       : Call CurrentRenderObject.Callbacks.EntryFunc()                              : End Sub
Public Sub VBGLCallbackMenuStatusFunc()                                                                                  : Call CurrentRenderObject.Callbacks.MenuStatusFunc()                         : End Sub
Public Sub VBGLCallbackMenuStateFunc()                                                                                   : Call CurrentRenderObject.Callbacks.MenuStateFunc()                          : End Sub
Public Sub VBGLCallbackWindowStatusFunc()                                                                                : Call CurrentRenderObject.Callbacks.WindowStatusFunc()                       : End Sub
Public Sub VBGLCallbackJoystickFunc(ByVal button As Long, ByVal x As Long, ByVal y As Long, ByVal time As Long)          : Call CurrentRenderObject.Callbacks.JoystickFunc(button, x, y, time)         : End Sub
Public Sub VBGLCallbackSpaceballMotionFunc(ByVal x As Long, ByVal y As Long, ByVal z As Long)                            : Call CurrentRenderObject.Callbacks.SpaceballMotionFunc(x, y, z)             : End Sub
Public Sub VBGLCallbackSpaceballRotateFunc(ByVal x As Long, ByVal y As Long, ByVal z As Long)                            : Call CurrentRenderObject.Callbacks.SpaceballRotateFunc(x, y, z)             : End Sub
Public Sub VBGLCallbackSpaceballButtonFunc(ByVal button As Long, ByVal state As Long, ByVal x As Long, ByVal y As Long)  : Call CurrentRenderObject.Callbacks.SpaceballButtonFunc(button, state, x, y) : End Sub
Public Sub VBGLCallbackButtonBoxFunc(ByVal button As Long, ByVal state As Long, ByVal x As Long, ByVal y As Long)        : Call CurrentRenderObject.Callbacks.ButtonBoxFunc(button, state, x, y)       : End Sub
Public Sub VBGLCallbackDialsFunc(ByVal dial As Long, ByVal value As Long, ByVal x As Long, ByVal y As Long)              : Call CurrentRenderObject.Callbacks.DialsFunc(dial, value, x, y)             : End Sub
Public Sub VBGLCallbackTabletMotionFunc(ByVal x As Long, ByVal y As Long)                                                : Call CurrentRenderObject.Callbacks.TabletMotionFunc(x, y)                   : End Sub
Public Sub VBGLCallbackTabletButtonFunc(ByVal button As Long, ByVal state As Long, ByVal x As Long, ByVal y As Long)     : Call CurrentRenderObject.Callbacks.TabletButtonFunc(button, state, x, y)    : End Sub
Public Sub VBGLCallbackVisibilityFunc()                                                                                  : Call CurrentRenderObject.Callbacks.VisibilityFunc()                         : End Sub