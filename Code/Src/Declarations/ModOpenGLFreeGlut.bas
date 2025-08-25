Attribute VB_Name = "ModOpenGLFreeGlut"
Option Explicit
'***************************************************************************************
'*                              Module openGL pour freeglut
'***************************************************************************************
' v0.1 - 04/11/2009
' v0.2 - 03/01/2019
'***************************************************************************************
' http://arkham46.developpez.com
'***************************************************************************************
' Documentation freeglut :
' http://freeglut.sourceforge.net/docs/api.php
'***************************************************************************************
#If VBA7 Then
DefLngPtr A-Z
Private Const PtrNull As LongPtr = 0
#Else
DefLng A-Z
Private Const PtrNull As Long = 0
#End If
#If VBA7 Then
Public Declare PtrSafe Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpsz1 As String, ByVal lpsz2 As String) As LongPtr
Public Declare PtrSafe Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As LongPtr
#Else
Public Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Public Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Long
#End If
'***************************************************************************************
Public Const GLUT_API_VERSION = 4&
Public Const GLUT_XLIB_IMPLEMENTATION = 13&
' GLUT API macro definitions -- the special key codes:
Public Const GLUT_KEY_F1 = &H1&
Public Const GLUT_KEY_F2 = &H2&
Public Const GLUT_KEY_F3 = &H3&
Public Const GLUT_KEY_F4 = &H4&
Public Const GLUT_KEY_F5 = &H5&
Public Const GLUT_KEY_F6 = &H6&
Public Const GLUT_KEY_F7 = &H7&
Public Const GLUT_KEY_F8 = &H8&
Public Const GLUT_KEY_F9 = &H9&
Public Const GLUT_KEY_F10 = &HA&
Public Const GLUT_KEY_F11 = &HB&
Public Const GLUT_KEY_F12 = &HC&
Public Const GLUT_KEY_LEFT = &H64&
Public Const GLUT_KEY_UP = &H65&
Public Const GLUT_KEY_RIGHT = &H66&
Public Const GLUT_KEY_DOWN = &H67&
Public Const GLUT_KEY_PAGE_UP = &H68&
Public Const GLUT_KEY_PAGE_DOWN = &H69&
Public Const GLUT_KEY_HOME = &H6A&
Public Const GLUT_KEY_END = &H6B&
Public Const GLUT_KEY_INSERT = &H6C&
' GLUT API macro definitions -- mouse state definitions
Public Const GLUT_LEFT_BUTTON = &H0&
Public Const GLUT_MIDDLE_BUTTON = &H1&
Public Const GLUT_RIGHT_BUTTON = &H2&
Public Const GLUT_DOWN = &H0&
Public Const GLUT_UP = &H1&
Public Const GLUT_LEFT = &H0&
Public Const GLUT_ENTERED = &H1&
' GLUT API macro definitions -- the display mode definitions
Public Const GLUT_RGB = &H0&
Public Const GLUT_RGBA = &H0&
Public Const GLUT_INDEX = &H1&
Public Const GLUT_SINGLE = &H0&
Public Const GLUT_DOUBLE = &H2&
Public Const GLUT_ACCUM = &H4&
Public Const GLUT_ALPHA = &H8&
Public Const GLUT_DEPTH = &H10&
Public Const GLUT_STENCIL = &H20&
Public Const GLUT_MULTISAMPLE = &H80&
Public Const GLUT_STEREO = &H100&
Public Const GLUT_LUMINANCE = &H200&
' GLUT API macro definitions -- windows and menu related definitions
Public Const GLUT_MENU_NOT_IN_USE = &H0&
Public Const GLUT_MENU_IN_USE = &H1&
Public Const GLUT_NOT_VISIBLE = &H0&
Public Const GLUT_VISIBLE = &H1&
Public Const GLUT_HIDDEN = &H0&
Public Const GLUT_FULLY_RETAINED = &H1&
Public Const GLUT_PARTIALLY_RETAINED = &H2&
Public Const GLUT_FULLY_COVERED = &H3&
' GLUT API macro definitions -- fonts definitions
Public Const GLUT_STROKE_ROMAN = 0
Public Const GLUT_STROKE_MONO_ROMAN = 1
Public Const GLUT_BITMAP_9_BY_15 = 2
Public Const GLUT_BITMAP_8_BY_13 = 3
Public Const GLUT_BITMAP_TIMES_ROMAN_10 = 4
Public Const GLUT_BITMAP_TIMES_ROMAN_24 = 5
Public Const GLUT_BITMAP_HELVETICA_10 = 6
Public Const GLUT_BITMAP_HELVETICA_12 = 7
Public Const GLUT_BITMAP_HELVETICA_18 = 8
' GLUT API macro definitions -- the glutGet parameters
Public Const GLUT_WINDOW_X = &H64&
Public Const GLUT_WINDOW_Y = &H65&
Public Const GLUT_WINDOW_WIDTH = &H66&
Public Const GLUT_WINDOW_HEIGHT = &H67&
Public Const GLUT_WINDOW_BUFFER_SIZE = &H68&
Public Const GLUT_WINDOW_STENCIL_SIZE = &H69&
Public Const GLUT_WINDOW_DEPTH_SIZE = &H6A&
Public Const GLUT_WINDOW_RED_SIZE = &H6B&
Public Const GLUT_WINDOW_GREEN_SIZE = &H6C&
Public Const GLUT_WINDOW_BLUE_SIZE = &H6D&
Public Const GLUT_WINDOW_ALPHA_SIZE = &H6E&
Public Const GLUT_WINDOW_ACCUM_RED_SIZE = &H6F&
Public Const GLUT_WINDOW_ACCUM_GREEN_SIZE = &H70&
Public Const GLUT_WINDOW_ACCUM_BLUE_SIZE = &H71&
Public Const GLUT_WINDOW_ACCUM_ALPHA_SIZE = &H72&
Public Const GLUT_WINDOW_DOUBLEBUFFER = &H73&
Public Const GLUT_WINDOW_RGBA = &H74&
Public Const GLUT_WINDOW_PARENT = &H75&
Public Const GLUT_WINDOW_NUM_CHILDREN = &H76&
Public Const GLUT_WINDOW_COLORMAP_SIZE = &H77&
Public Const GLUT_WINDOW_NUM_SAMPLES = &H78&
Public Const GLUT_WINDOW_STEREO = &H79&
Public Const GLUT_WINDOW_CURSOR = &H7A&
Public Const GLUT_SCREEN_WIDTH = &HC8&
Public Const GLUT_SCREEN_HEIGHT = &HC9&
Public Const GLUT_SCREEN_WIDTH_MM = &HCA&
Public Const GLUT_SCREEN_HEIGHT_MM = &HCB&
Public Const GLUT_MENU_NUM_ITEMS = &H12C&
Public Const GLUT_DISPLAY_MODE_POSSIBLE = &H190&
Public Const GLUT_INIT_WINDOW_X = &H1F4&
Public Const GLUT_INIT_WINDOW_Y = &H1F5&
Public Const GLUT_INIT_WINDOW_WIDTH = &H1F6&
Public Const GLUT_INIT_WINDOW_HEIGHT = &H1F7&
Public Const GLUT_INIT_DISPLAY_MODE = &H1F8&
Public Const GLUT_ELAPSED_TIME = &H2BC&
Public Const GLUT_WINDOW_FORMAT_ID = &H7B&
' GLUT API macro definitions -- the glutDeviceGet parameters
Public Const GLUT_HAS_KEYBOARD = &H258&
Public Const GLUT_HAS_MOUSE = &H259&
Public Const GLUT_HAS_SPACEBALL = &H25A&
Public Const GLUT_HAS_DIAL_AND_BUTTON_BOX = &H25B&
Public Const GLUT_HAS_TABLET = &H25C&
Public Const GLUT_NUM_MOUSE_BUTTONS = &H25D&
Public Const GLUT_NUM_SPACEBALL_BUTTONS = &H25E&
Public Const GLUT_NUM_BUTTON_BOX_BUTTONS = &H25F&
Public Const GLUT_NUM_DIALS = &H260&
Public Const GLUT_NUM_TABLET_BUTTONS = &H261&
Public Const GLUT_DEVICE_IGNORE_KEY_REPEAT = &H262&
Public Const GLUT_DEVICE_KEY_REPEAT = &H263&
Public Const GLUT_HAS_JOYSTICK = &H264&
Public Const GLUT_OWNS_JOYSTICK = &H265&
Public Const GLUT_JOYSTICK_BUTTONS = &H266&
Public Const GLUT_JOYSTICK_AXES = &H267&
Public Const GLUT_JOYSTICK_POLL_RATE = &H268&
' GLUT API macro definitions -- the glutLayerGet parameters
Public Const GLUT_OVERLAY_POSSIBLE = &H320&
Public Const GLUT_LAYER_IN_USE = &H321&
Public Const GLUT_HAS_OVERLAY = &H322&
Public Const GLUT_TRANSPARENT_INDEX = &H323&
Public Const GLUT_NORMAL_DAMAGED = &H324&
Public Const GLUT_OVERLAY_DAMAGED = &H325&
' GLUT API macro definitions -- the glutVideoResizeGet parameters
Public Const GLUT_VIDEO_RESIZE_POSSIBLE = &H384&
Public Const GLUT_VIDEO_RESIZE_IN_USE = &H385&
Public Const GLUT_VIDEO_RESIZE_X_DELTA = &H386&
Public Const GLUT_VIDEO_RESIZE_Y_DELTA = &H387&
Public Const GLUT_VIDEO_RESIZE_WIDTH_DELTA = &H388&
Public Const GLUT_VIDEO_RESIZE_HEIGHT_DELTA = &H389&
Public Const GLUT_VIDEO_RESIZE_X = &H38A&
Public Const GLUT_VIDEO_RESIZE_Y = &H38B&
Public Const GLUT_VIDEO_RESIZE_WIDTH = &H38C&
Public Const GLUT_VIDEO_RESIZE_HEIGHT = &H38D&
' GLUT API macro definitions -- the glutUseLayer parameters
Public Const GLUT_NORMAL = &H0&
Public Const GLUT_OVERLAY = &H1&
' GLUT API macro definitions -- the glutGetModifiers parameters
Public Const GLUT_ACTIVE_SHIFT = &H1&
Public Const GLUT_ACTIVE_CTRL = &H2&
Public Const GLUT_ACTIVE_ALT = &H4&
' GLUT API macro definitions -- the glutSetCursor parameters
Public Const GLUT_CURSOR_RIGHT_ARROW = &H0&
Public Const GLUT_CURSOR_LEFT_ARROW = &H1&
Public Const GLUT_CURSOR_INFO = &H2&
Public Const GLUT_CURSOR_DESTROY = &H3&
Public Const GLUT_CURSOR_HELP = &H4&
Public Const GLUT_CURSOR_CYCLE = &H5&
Public Const GLUT_CURSOR_SPRAY = &H6&
Public Const GLUT_CURSOR_WAIT = &H7&
Public Const GLUT_CURSOR_TEXT = &H8&
Public Const GLUT_CURSOR_CROSSHAIR = &H9&
Public Const GLUT_CURSOR_UP_DOWN = &HA&
Public Const GLUT_CURSOR_LEFT_RIGHT = &HB&
Public Const GLUT_CURSOR_TOP_SIDE = &HC&
Public Const GLUT_CURSOR_BOTTOM_SIDE = &HD&
Public Const GLUT_CURSOR_LEFT_SIDE = &HE&
Public Const GLUT_CURSOR_RIGHT_SIDE = &HF&
Public Const GLUT_CURSOR_TOP_LEFT_CORNER = &H10&
Public Const GLUT_CURSOR_TOP_RIGHT_CORNER = &H11&
Public Const GLUT_CURSOR_BOTTOM_RIGHT_CORNER = &H12&
Public Const GLUT_CURSOR_BOTTOM_LEFT_CORNER = &H13&
Public Const GLUT_CURSOR_INHERIT = &H64&
Public Const GLUT_CURSOR_NONE = &H65&
Public Const GLUT_CURSOR_FULL_CROSSHAIR = &H66&
' GLUT API macro definitions -- RGB color component specification definitions
Public Const GLUT_RED = &H0&
Public Const GLUT_GREEN = &H1&
Public Const GLUT_BLUE = &H2&
' GLUT API macro definitions -- additional keyboard and joystick definitions
Public Const GLUT_KEY_REPEAT_OFF = &H0&
Public Const GLUT_KEY_REPEAT_ON = &H1&
Public Const GLUT_KEY_REPEAT_DEFAULT = &H2&
Public Const GLUT_JOYSTICK_BUTTON_A = &H1&
Public Const GLUT_JOYSTICK_BUTTON_B = &H2&
Public Const GLUT_JOYSTICK_BUTTON_C = &H4&
Public Const GLUT_JOYSTICK_BUTTON_D = &H8&
' GLUT API macro definitions -- game mode definitions
Public Const GLUT_GAME_MODE_ACTIVE = &H0&
Public Const GLUT_GAME_MODE_POSSIBLE = &H1&
Public Const GLUT_GAME_MODE_WIDTH = &H2&
Public Const GLUT_GAME_MODE_HEIGHT = &H3&
Public Const GLUT_GAME_MODE_PIXEL_DEPTH = &H4&
Public Const GLUT_GAME_MODE_REFRESH_RATE = &H5&
Public Const GLUT_GAME_MODE_DISPLAY_CHANGED = &H6&
' Additional GLUT Key definitions for the Special key function
Public Const GLUT_KEY_NUM_LOCK = &H6D&
Public Const GLUT_KEY_BEGIN = &H6E&
Public Const GLUT_KEY_DELETE = &H6F&
Public Const GLUT_KEY_SHIFT_L = &H70&
Public Const GLUT_KEY_SHIFT_R = &H71&
Public Const GLUT_KEY_CTRL_L = &H72&
Public Const GLUT_KEY_CTRL_R = &H73&
Public Const GLUT_KEY_ALT_L = &H74&
Public Const GLUT_KEY_ALT_R = &H75&
' GLUT API Extension macro definitions -- behaviour when the user clicks on an "x" to close a window
Public Const GLUT_ACTION_EXIT = 0&
Public Const GLUT_ACTION_GLUTMAINLOOP_RETURNS = 1&
Public Const GLUT_ACTION_CONTINUE_EXECUTION = 2&
' Create a new rendering context when the user opens a new window?
Public Const GLUT_CREATE_NEW_CONTEXT = 0&
Public Const GLUT_USE_CURRENT_CONTEXT = 1&
' Direct/Indirect rendering context options (has meaning only in Unix/X11)
Public Const GLUT_FORCE_INDIRECT_CONTEXT = 0&
Public Const GLUT_ALLOW_DIRECT_CONTEXT = 1&
Public Const GLUT_TRY_DIRECT_CONTEXT = 2&
Public Const GLUT_FORCE_DIRECT_CONTEXT = 3&
' GLUT API Extension macro definitions -- the glutGet parameters
Public Const GLUT_INIT_STATE = &H7C&
Public Const GLUT_ACTION_ON_WINDOW_CLOSE = &H1F9&
Public Const GLUT_WINDOW_BORDER_WIDTH = &H1FA&
Public Const GLUT_WINDOW_BORDER_HEIGHT = &H1FB&
Public Const GLUT_WINDOW_HEADER_HEIGHT = &H1FB&
Public Const GLUT_VERSION = &H1FC&
Public Const GLUT_RENDERING_CONTEXT = &H1FD&
Public Const GLUT_DIRECT_RENDERING = &H1FE&
Public Const GLUT_FULL_SCREEN = &H1FF&
Public Const GLUT_SKIP_STALE_MOTION_EVENTS = &H204&
Public Const GLUT_GEOMETRY_VISUALIZE_NORMALS = &H205&
Public Const GLUT_STROKE_FONT_DRAW_JOIN_DOTS = &H206&
Public Const GLUT_ALLOW_NEGATIVE_WINDOW_POSITION = &H207&
Public Const GLUT_WINDOW_SRGB = &H7D&
' New tokens for glutInitDisplayMode.
' Only one GLUT_AUXn bit may be used at a time.
' Value 0x0400 is defined in OpenGLUT.
Public Const GLUT_AUX = &H1000&
Public Const GLUT_AUX1 = &H1000&
Public Const GLUT_AUX2 = &H2000&
Public Const GLUT_AUX3 = &H4000&
Public Const GLUT_AUX4 = &H8000&
' Context-related flags, see freeglut_state.c
Public Const GLUT_INIT_MAJOR_VERSION = &H200&
Public Const GLUT_INIT_MINOR_VERSION = &H201&
Public Const GLUT_INIT_FLAGS = &H202&
Public Const GLUT_INIT_PROFILE = &H203&
' Flags for glutInitContextFlags, see freeglut_init.c
Public Const GLUT_DEBUG = &H1&
Public Const GLUT_FORWARD_COMPATIBLE = &H2&
' Flags for glutInitContextProfile, see freeglut_init.c
Public Const GLUT_CORE_PROFILE = &H1&
Public Const GLUT_COMPATIBILITY_PROFILE = &H2&
' GLUT API Extension macro definitions -- Spaceball button definitions
Public Const GLUT_SPACEBALL_BUTTON_A = &H1&
Public Const GLUT_SPACEBALL_BUTTON_B = &H2&
Public Const GLUT_SPACEBALL_BUTTON_C = &H4&
Public Const GLUT_SPACEBALL_BUTTON_D = &H8&
Public Const GLUT_SPACEBALL_BUTTON_E = &H10&
' Multi-touch/multi-pointer extensions
Public Const GLUT_HAS_MULTI = 1&
' state flags that can be passed to callback set by glutAppStatusFunc */
Public Const GLUT_APPSTATUS_PAUSE = 1&
Public Const GLUT_APPSTATUS_RESUME = 2&
' GLUT API macro definitions -- the display mode definitions
Public Const GLUT_CAPTIONLESS = &H400&
Public Const GLUT_BORDERLESS = &H800&
Public Const GLUT_SRGB = &H1000&
#If Win64 Then
    ' Initialization functions, see fglut_init.c
    Public Declare PtrSafe Sub glutInit Lib "freeglut64" (pargc As LongPtr, argv As String)
    Public Declare PtrSafe Sub glutInitWindowPosition Lib "freeglut64" (ByVal X As Long, ByVal y As Long)
    Public Declare PtrSafe Sub glutInitWindowSize Lib "freeglut64" (ByVal Width As Long, ByVal Height As Long)
    Public Declare PtrSafe Sub glutInitDisplayMode Lib "freeglut64" (ByVal displayMode As Long)
    Public Declare PtrSafe Sub glutInitDisplayString Lib "freeglut64" (ByVal displayMode As String)
    ' Process loop function, see freeglut_main.c
    Public Declare PtrSafe Sub glutMainLoop Lib "freeglut64" ()
    ' Window management functions, see freeglut_window.c
    Public Declare PtrSafe Function glutCreateWindow Lib "freeglut64" Alias "glutCreateWindow" (ByVal title As String) As Long
    Public Declare PtrSafe Function glutCreateSubWindow Lib "freeglut64" (ByVal window As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long) As Long
    Public Declare PtrSafe Sub glutDestroyWindow Lib "freeglut64" Alias "glutDestroyWindow" (ByVal window As Long)
    Public Declare PtrSafe Sub glutSetWindow Lib "freeglut64" (ByVal window As Long)
    Public Declare PtrSafe Function glutGetWindow Lib "freeglut64" () As Long
    Public Declare PtrSafe Sub glutSetWindowTitle Lib "freeglut64" (ByVal title As String)
    Public Declare PtrSafe Sub glutSetIconTitle Lib "freeglut64" (ByVal title As String)
    Public Declare PtrSafe Sub glutReshapeWindow Lib "freeglut64" (ByVal Width As Long, ByVal Height As Long)
    Public Declare PtrSafe Sub glutPositionWindow Lib "freeglut64" (ByVal X As Long, ByVal y As Long)
    Public Declare PtrSafe Sub glutShowWindow Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutHideWindow Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutIconifyWindow Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutPushWindow Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutPopWindow Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutFullScreen Lib "freeglut64" ()
    ' Display-connected functions, see freeglut_display.c
    Public Declare PtrSafe Sub glutPostWindowRedisplay Lib "freeglut64" (ByVal window As Long)
    Public Declare PtrSafe Sub glutPostRedisplay Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutSwapBuffers Lib "freeglut64" ()
    ' Mouse cursor functions, see freeglut_cursor.c
    Public Declare PtrSafe Sub glutWarpPointer Lib "freeglut64" (ByVal X As Long, ByVal y As Long)
    Public Declare PtrSafe Sub glutSetCursor Lib "freeglut64" (ByVal cursor As Long)
    ' Overlay stuff, see freeglut_overlay.c
    Public Declare PtrSafe Sub glutEstablishOverlay Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutRemoveOverlay Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutUseLayer Lib "freeglut64" (ByVal layer As Long)
    Public Declare PtrSafe Sub glutPostOverlayRedisplay Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutPostWindowOverlayRedisplay Lib "freeglut64" (ByVal window As Long)
    Public Declare PtrSafe Sub glutShowOverlay Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutHideOverlay Lib "freeglut64" ()
    ' Menu stuff, see freeglut_menu.c
    Public Declare PtrSafe Function glutCreateMenu Lib "freeglut64" (ByVal fnPtr As LongPtr) As Long
    Public Declare PtrSafe Sub glutDestroyMenu Lib "freeglut64" (ByVal menu As Long)
    Public Declare PtrSafe Function glutGetMenu Lib "freeglut64" () As Long
    Public Declare PtrSafe Sub glutSetMenu Lib "freeglut64" (ByVal menu As Long)
    Public Declare PtrSafe Sub glutAddMenuEntry Lib "freeglut64" (ByVal label As String, ByVal value As Long)
    Public Declare PtrSafe Sub glutAddSubMenu Lib "freeglut64" (ByVal label As String, ByVal subMenu As Long)
    Public Declare PtrSafe Sub glutChangeToMenuEntry Lib "freeglut64" (ByVal item As Long, ByVal label As String, ByVal value As Long)
    Public Declare PtrSafe Sub glutChangeToSubMenu Lib "freeglut64" (ByVal item As Long, ByVal label As String, ByVal value As Long)
    Public Declare PtrSafe Sub glutRemoveMenuItem Lib "freeglut64" (ByVal item As Long)
    Public Declare PtrSafe Sub glutAttachMenu Lib "freeglut64" (ByVal button As Long)
    Public Declare PtrSafe Sub glutDetachMenu Lib "freeglut64" (ByVal button As Long)
    ' Global callback functions, see freeglut_callbacks.c
    Public Declare PtrSafe Sub glutTimerFunc Lib "freeglut64" (ByVal time As Long, ByVal fnPtr As LongPtr, ByVal value As Long)
    Public Declare PtrSafe Sub glutIdleFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    ' Window-specific callback functions, see freeglut_callbacks.c
    Public Declare PtrSafe Sub glutKeyboardFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutSpecialFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutReshapeFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutVisibilityFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutDisplayFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMouseFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMotionFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutPassiveMotionFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutEntryFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutKeyboardUpFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutSpecialUpFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutJoystickFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMenuStateFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMenuStatusFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutOverlayDisplayFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutWindowStatusFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutSpaceballMotionFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutSpaceballRotateFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutSpaceballButtonFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutButtonBoxFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutDialsFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutTabletMotionFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutTabletButtonFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    ' State setting and retrieval functions, see freeglut_state.c
    Public Declare PtrSafe Function glutGet Lib "freeglut64" (ByVal query As Long) As Long
    Public Declare PtrSafe Function glutDeviceGet Lib "freeglut64" (ByVal query As Long) As Long
    Public Declare PtrSafe Function glutGetModifiers Lib "freeglut64" () As Long
    Public Declare PtrSafe Function glutLayerGet Lib "freeglut64" (ByVal query As Long) As Long
    ' Font stuff, see freeglut_font.c
    Public Declare PtrSafe Sub glutBitmapCharacter Lib "freeglut64" (ByVal font As LongPtr, ByVal character As Long)
    Public Declare PtrSafe Function glutBitmapWidth Lib "freeglut64" (ByVal font As LongPtr, ByVal character As Long) As Long
    Public Declare PtrSafe Sub glutStrokeCharacter Lib "freeglut64" (ByVal font As LongPtr, ByVal character As Long)
    Public Declare PtrSafe Function glutStrokeWidth Lib "freeglut64" (ByVal font As LongPtr, ByVal character As Long) As Long
    Public Declare PtrSafe Function glutBitmapLength Lib "freeglut64" (ByVal font As LongPtr, ByVal pstring As String) As Long
    Public Declare PtrSafe Function glutStrokeLength Lib "freeglut64" (ByVal font As LongPtr, ByVal pstring As String) As Long
    ' Geometry functions, see freeglut_geometry.c
    Public Declare PtrSafe Sub glutWireCube Lib "freeglut64" (ByVal size As Double)
    Public Declare PtrSafe Sub glutSolidCube Lib "freeglut64" (ByVal size As Double)
    Public Declare PtrSafe Sub glutWireSphere Lib "freeglut64" (ByVal radius As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub glutSolidSphere Lib "freeglut64" (ByVal radius As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub glutWireCone Lib "freeglut64" (ByVal base As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub glutSolidCone Lib "freeglut64" (ByVal base As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub glutWireTorus Lib "freeglut64" (ByVal innerRadius As Double, ByVal outerRadius As Double, ByVal sides As Long, ByVal rings As Long)
    Public Declare PtrSafe Sub glutSolidTorus Lib "freeglut64" (ByVal innerRadius As Double, ByVal outerRadius As Double, ByVal sides As Long, ByVal rings As Long)
    Public Declare PtrSafe Sub glutWireDodecahedron Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutSolidDodecahedron Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutWireOctahedron Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutSolidOctahedron Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutWireTetrahedron Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutSolidTetrahedron Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutWireIcosahedron Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutSolidIcosahedron Lib "freeglut64" ()
    ' Teapot rendering functions, found in freeglut_teapot.c
    ' NB: front facing polygons have clockwise winding, not counter clockwise
    Public Declare PtrSafe Sub glutWireTeapot Lib "freeglut64" (ByVal size As Double)
    Public Declare PtrSafe Sub glutSolidTeapot Lib "freeglut64" (ByVal size As Double)
    ' Game mode functions, see freeglut_gamemode.c
    Public Declare PtrSafe Sub glutGameModeString Lib "freeglut64" (ByVal pstring As String)
    Public Declare PtrSafe Function glutEnterGameMode Lib "freeglut64" () As Long
    Public Declare PtrSafe Sub glutLeaveGameMode Lib "freeglut64" ()
    Public Declare PtrSafe Function glutGameModeGet Lib "freeglut64" (ByVal query As Long) As Long
    ' Video resize functions, see freeglut_videoresize.c
    Public Declare PtrSafe Function glutVideoResizeGet Lib "freeglut64" (ByVal query As Long) As Long
    Public Declare PtrSafe Sub glutSetupVideoResizing Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutStopVideoResizing Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutVideoResize Lib "freeglut64" (ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)
    Public Declare PtrSafe Sub glutVideoPan Lib "freeglut64" (ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)
    ' Colormap functions, see freeglut_misc.c
    Public Declare PtrSafe Sub glutSetColor Lib "freeglut64" (ByVal color As Long, ByVal red As Single, ByVal green As Single, ByVal blue As Single)
    Public Declare PtrSafe Function glutGetColor Lib "freeglut64" (ByVal color As Long, ByVal component As Long) As Single
    Public Declare PtrSafe Sub glutCopyColormap Lib "freeglut64" (ByVal window As Long)
    ' Misc keyboard and joystick functions, see freeglut_misc.c
    Public Declare PtrSafe Sub glutIgnoreKeyRepeat Lib "freeglut64" (ByVal ignore As Long)
    Public Declare PtrSafe Sub glutSetKeyRepeat Lib "freeglut64" (ByVal repeatMode As Long)
    Public Declare PtrSafe Sub glutForceJoystickFunc Lib "freeglut64" ()
    ' Misc functions, see freeglut_misc.c
    Public Declare PtrSafe Function glutExtensionSupported Lib "freeglut64" (ByVal extension As String) As Long
    Public Declare PtrSafe Sub glutReportErrors Lib "freeglut64" ()
    ' Process loop function, see freeglut_main.c
    Public Declare PtrSafe Sub glutMainLoopEvent Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutLeaveMainLoop Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutExit Lib "freeglut64" ()
    ' Window management functions, see freeglut_window.c
    Public Declare PtrSafe Sub glutFullScreenToggle Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutLeaveFullScreen Lib "freeglut64" ()
    ' Menu functions
    Public Declare PtrSafe Sub glutSetMenuFont Lib "freeglut64" (ByVal menuID As Long, ByVal font As LongPtr)
    ' Window-specific callback functions, see freeglut_callbacks.c
    Public Declare PtrSafe Sub glutMouseWheelFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutPositionFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutCloseFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutWMCloseFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMenuDestroyFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    ' State setting and retrieval functions, see freeglut_state.c
    Public Declare PtrSafe Sub glutSetOption Lib "freeglut64" (ByVal option_flag As Long, ByVal value As Long)
    Public Declare PtrSafe Function glutGetModeValues Lib "freeglut64" (ByVal mode As Long, size As LongPtr) As LongPtr
    Public Declare PtrSafe Function glutGetWindowData Lib "freeglut64" () As LongPtr
    Public Declare PtrSafe Sub glutSetWindowData Lib "freeglut64" (ByVal data As LongPtr)
    Public Declare PtrSafe Function glutGetMenuData Lib "freeglut64" () As LongPtr
    Public Declare PtrSafe Sub glutSetMenuData Lib "freeglut64" (ByVal data As LongPtr)
    ' Font stuff, see freeglut_font.c
    Public Declare PtrSafe Function glutBitmapHeight Lib "freeglut64" (ByVal font As LongPtr) As Long
    Public Declare PtrSafe Function glutStrokeHeight Lib "freeglut64" (ByVal font As LongPtr) As Single
    Public Declare PtrSafe Sub glutBitmapString Lib "freeglut64" (ByVal font As LongPtr, ByVal pstring As String)
    Public Declare PtrSafe Sub glutStrokeString Lib "freeglut64" (ByVal font As LongPtr, ByVal pstring As String)
    ' Geometry functions, see freeglut_geometry.c
    Public Declare PtrSafe Sub glutWireRhombicDodecahedron Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutSolidRhombicDodecahedron Lib "freeglut64" ()
    Public Declare PtrSafe Sub glutWireSierpinskiSponge Lib "freeglut64" (ByVal num_levels As Long, offset As Double, ByVal pscale As Double)
    Public Declare PtrSafe Sub glutSolidSierpinskiSponge Lib "freeglut64" (ByVal num_levels As Long, offset As Double, ByVal pscale As Double)
    Public Declare PtrSafe Sub glutWireCylinder Lib "freeglut64" (ByVal radius As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub glutSolidCylinder Lib "freeglut64" (ByVal radius As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    ' Rest of functions for rendering Newell's teaset, found in fg_teapot.c
    ' NB: front facing polygons have clockwise winding, not counter clockwise
    Public Declare PtrSafe Sub glutWireTeacup Lib "freeglut64" (ByVal size As Double)
    Public Declare PtrSafe Sub glutSolidTeacup Lib "freeglut64" (ByVal size As Double)
    Public Declare PtrSafe Sub glutWireTeaspoon Lib "freeglut64" (ByVal size As Double)
    Public Declare PtrSafe Sub glutSolidTeaspoon Lib "freeglut64" (ByVal size As Double)
    ' Extension functions, see fg_ext.c
    Public Declare PtrSafe Function glutGetProcAddress Lib "freeglut64" (ByVal procName As String) As LongPtr
    ' Multi-touch/multi-pointer extensions
    Public Declare PtrSafe Sub glutMultiEntryFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMultiButtonFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMultiMotionFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMultiPassiveFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    ' Initialization functions, see freeglut_init.c
    Public Declare PtrSafe Sub glutInitContextVersion Lib "freeglut64" (ByVal majorVersion As Long, ByVal minorVersion As Long)
    Public Declare PtrSafe Sub glutInitContextFlags Lib "freeglut64" (ByVal flags As Long)
    Public Declare PtrSafe Sub glutInitContextProfile Lib "freeglut64" (ByVal profile As Long)
    Public Declare PtrSafe Sub glutInitErrorFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutInitWarningFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    ' OpenGL >= 2.0 support
    Public Declare PtrSafe Sub glutSetVertexAttribCoord3 Lib "freeglut64" (ByVal attrib As Long)
    Public Declare PtrSafe Sub glutSetVertexAttribNormal Lib "freeglut64" (ByVal attrib As Long)
    Public Declare PtrSafe Sub glutSetVertexAttribTexCoord2 Lib "freeglut64" (ByVal attrib As Long)
    ' Mobile platforms lifecycle
    Public Declare PtrSafe Sub glutInitContextFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutAppStatusFunc Lib "freeglut64" (ByVal fnPtr As LongPtr)
#ElseIf VBA7 Then
    ' Initialization functions, see fglut_init.c
    Public Declare PtrSafe Sub glutInit Lib "freeglut" (pargc As LongPtr, argv As String)
    Public Declare PtrSafe Sub glutInitWindowPosition Lib "freeglut" (ByVal X As Long, ByVal y As Long)
    Public Declare PtrSafe Sub glutInitWindowSize Lib "freeglut" (ByVal Width As Long, ByVal Height As Long)
    Public Declare PtrSafe Sub glutInitDisplayMode Lib "freeglut" (ByVal displayMode As Long)
    Public Declare PtrSafe Sub glutInitDisplayString Lib "freeglut" (ByVal displayMode As String)
    ' Process loop function, see freeglut_main.c
    Public Declare PtrSafe Sub glutMainLoop Lib "freeglut" ()
    ' Window management functions, see freeglut_window.c
    Public Declare PtrSafe Function glutCreateWindow Lib "freeglut" Alias "glutCreateWindow" (ByVal title As String) As Long
    Public Declare PtrSafe Function glutCreateSubWindow Lib "freeglut" (ByVal window As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long) As Long
    Public Declare PtrSafe Sub glutDestroyWindow Lib "freeglut" Alias "glutDestroyWindow" (ByVal window As Long)
    Public Declare PtrSafe Sub glutSetWindow Lib "freeglut" (ByVal window As Long)
    Public Declare PtrSafe Function glutGetWindow Lib "freeglut" () As Long
    Public Declare PtrSafe Sub glutSetWindowTitle Lib "freeglut" (ByVal title As String)
    Public Declare PtrSafe Sub glutSetIconTitle Lib "freeglut" (ByVal title As String)
    Public Declare PtrSafe Sub glutReshapeWindow Lib "freeglut" (ByVal Width As Long, ByVal Height As Long)
    Public Declare PtrSafe Sub glutPositionWindow Lib "freeglut" (ByVal X As Long, ByVal y As Long)
    Public Declare PtrSafe Sub glutShowWindow Lib "freeglut" ()
    Public Declare PtrSafe Sub glutHideWindow Lib "freeglut" ()
    Public Declare PtrSafe Sub glutIconifyWindow Lib "freeglut" ()
    Public Declare PtrSafe Sub glutPushWindow Lib "freeglut" ()
    Public Declare PtrSafe Sub glutPopWindow Lib "freeglut" ()
    Public Declare PtrSafe Sub glutFullScreen Lib "freeglut" ()
    ' Display-connected functions, see freeglut_display.c
    Public Declare PtrSafe Sub glutPostWindowRedisplay Lib "freeglut" (ByVal window As Long)
    Public Declare PtrSafe Sub glutPostRedisplay Lib "freeglut" ()
    Public Declare PtrSafe Sub glutSwapBuffers Lib "freeglut" ()
    ' Mouse cursor functions, see freeglut_cursor.c
    Public Declare PtrSafe Sub glutWarpPointer Lib "freeglut" (ByVal X As Long, ByVal y As Long)
    Public Declare PtrSafe Sub glutSetCursor Lib "freeglut" (ByVal cursor As Long)
    ' Overlay stuff, see freeglut_overlay.c
    Public Declare PtrSafe Sub glutEstablishOverlay Lib "freeglut" ()
    Public Declare PtrSafe Sub glutRemoveOverlay Lib "freeglut" ()
    Public Declare PtrSafe Sub glutUseLayer Lib "freeglut" (ByVal layer As Long)
    Public Declare PtrSafe Sub glutPostOverlayRedisplay Lib "freeglut" ()
    Public Declare PtrSafe Sub glutPostWindowOverlayRedisplay Lib "freeglut" (ByVal window As Long)
    Public Declare PtrSafe Sub glutShowOverlay Lib "freeglut" ()
    Public Declare PtrSafe Sub glutHideOverlay Lib "freeglut" ()
    ' Menu stuff, see freeglut_menu.c
    Public Declare PtrSafe Function glutCreateMenu Lib "freeglut" (ByVal fnPtr As LongPtr) As Long
    Public Declare PtrSafe Sub glutDestroyMenu Lib "freeglut" (ByVal menu As Long)
    Public Declare PtrSafe Function glutGetMenu Lib "freeglut" () As Long
    Public Declare PtrSafe Sub glutSetMenu Lib "freeglut" (ByVal menu As Long)
    Public Declare PtrSafe Sub glutAddMenuEntry Lib "freeglut" (ByVal label As String, ByVal value As Long)
    Public Declare PtrSafe Sub glutAddSubMenu Lib "freeglut" (ByVal label As String, ByVal subMenu As Long)
    Public Declare PtrSafe Sub glutChangeToMenuEntry Lib "freeglut" (ByVal item As Long, ByVal label As String, ByVal value As Long)
    Public Declare PtrSafe Sub glutChangeToSubMenu Lib "freeglut" (ByVal item As Long, ByVal label As String, ByVal value As Long)
    Public Declare PtrSafe Sub glutRemoveMenuItem Lib "freeglut" (ByVal item As Long)
    Public Declare PtrSafe Sub glutAttachMenu Lib "freeglut" (ByVal button As Long)
    Public Declare PtrSafe Sub glutDetachMenu Lib "freeglut" (ByVal button As Long)
    ' Global callback functions, see freeglut_callbacks.c
    Public Declare PtrSafe Sub glutTimerFunc Lib "freeglut" (ByVal time As Long, ByVal fnPtr As LongPtr, ByVal value As Long)
    Public Declare PtrSafe Sub glutIdleFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    ' Window-specific callback functions, see freeglut_callbacks.c
    Public Declare PtrSafe Sub glutKeyboardFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutSpecialFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutReshapeFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutVisibilityFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutDisplayFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMouseFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMotionFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutPassiveMotionFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutEntryFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutKeyboardUpFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutSpecialUpFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutJoystickFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMenuStateFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMenuStatusFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutOverlayDisplayFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutWindowStatusFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutSpaceballMotionFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutSpaceballRotateFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutSpaceballButtonFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutButtonBoxFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutDialsFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutTabletMotionFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutTabletButtonFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    ' State setting and retrieval functions, see freeglut_state.c
    Public Declare PtrSafe Function glutGet Lib "freeglut" (ByVal query As Long) As Long
    Public Declare PtrSafe Function glutDeviceGet Lib "freeglut" (ByVal query As Long) As Long
    Public Declare PtrSafe Function glutGetModifiers Lib "freeglut" () As Long
    Public Declare PtrSafe Function glutLayerGet Lib "freeglut" (ByVal query As Long) As Long
    ' Font stuff, see freeglut_font.c
    Public Declare PtrSafe Sub glutBitmapCharacter Lib "freeglut" (ByVal font As LongPtr, ByVal character As Long)
    Public Declare PtrSafe Function glutBitmapWidth Lib "freeglut" (ByVal font As LongPtr, ByVal character As Long) As Long
    Public Declare PtrSafe Sub glutStrokeCharacter Lib "freeglut" (ByVal font As LongPtr, ByVal character As Long)
    Public Declare PtrSafe Function glutStrokeWidth Lib "freeglut" (ByVal font As LongPtr, ByVal character As Long) As Long
    Public Declare PtrSafe Function glutBitmapLength Lib "freeglut" (ByVal font As LongPtr, ByVal pstring As String) As Long
    Public Declare PtrSafe Function glutStrokeLength Lib "freeglut" (ByVal font As LongPtr, ByVal pstring As String) As Long
    ' Geometry functions, see freeglut_geometry.c
    Public Declare PtrSafe Sub glutWireCube Lib "freeglut" (ByVal size As Double)
    Public Declare PtrSafe Sub glutSolidCube Lib "freeglut" (ByVal size As Double)
    Public Declare PtrSafe Sub glutWireSphere Lib "freeglut" (ByVal radius As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub glutSolidSphere Lib "freeglut" (ByVal radius As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub glutWireCone Lib "freeglut" (ByVal base As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub glutSolidCone Lib "freeglut" (ByVal base As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub glutWireTorus Lib "freeglut" (ByVal innerRadius As Double, ByVal outerRadius As Double, ByVal sides As Long, ByVal rings As Long)
    Public Declare PtrSafe Sub glutSolidTorus Lib "freeglut" (ByVal innerRadius As Double, ByVal outerRadius As Double, ByVal sides As Long, ByVal rings As Long)
    Public Declare PtrSafe Sub glutWireDodecahedron Lib "freeglut" ()
    Public Declare PtrSafe Sub glutSolidDodecahedron Lib "freeglut" ()
    Public Declare PtrSafe Sub glutWireOctahedron Lib "freeglut" ()
    Public Declare PtrSafe Sub glutSolidOctahedron Lib "freeglut" ()
    Public Declare PtrSafe Sub glutWireTetrahedron Lib "freeglut" ()
    Public Declare PtrSafe Sub glutSolidTetrahedron Lib "freeglut" ()
    Public Declare PtrSafe Sub glutWireIcosahedron Lib "freeglut" ()
    Public Declare PtrSafe Sub glutSolidIcosahedron Lib "freeglut" ()
    ' Teapot rendering functions, found in freeglut_teapot.c
    ' NB: front facing polygons have clockwise winding, not counter clockwise
    Public Declare PtrSafe Sub glutWireTeapot Lib "freeglut" (ByVal size As Double)
    Public Declare PtrSafe Sub glutSolidTeapot Lib "freeglut" (ByVal size As Double)
    ' Game mode functions, see freeglut_gamemode.c
    Public Declare PtrSafe Sub glutGameModeString Lib "freeglut" (ByVal pstring As String)
    Public Declare PtrSafe Function glutEnterGameMode Lib "freeglut" () As Long
    Public Declare PtrSafe Sub glutLeaveGameMode Lib "freeglut" ()
    Public Declare PtrSafe Function glutGameModeGet Lib "freeglut" (ByVal query As Long) As Long
    ' Video resize functions, see freeglut_videoresize.c
    Public Declare PtrSafe Function glutVideoResizeGet Lib "freeglut" (ByVal query As Long) As Long
    Public Declare PtrSafe Sub glutSetupVideoResizing Lib "freeglut" ()
    Public Declare PtrSafe Sub glutStopVideoResizing Lib "freeglut" ()
    Public Declare PtrSafe Sub glutVideoResize Lib "freeglut" (ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)
    Public Declare PtrSafe Sub glutVideoPan Lib "freeglut" (ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)
    ' Colormap functions, see freeglut_misc.c
    Public Declare PtrSafe Sub glutSetColor Lib "freeglut" (ByVal color As Long, ByVal red As Single, ByVal green As Single, ByVal blue As Single)
    Public Declare PtrSafe Function glutGetColor Lib "freeglut" (ByVal color As Long, ByVal component As Long) As Single
    Public Declare PtrSafe Sub glutCopyColormap Lib "freeglut" (ByVal window As Long)
    ' Misc keyboard and joystick functions, see freeglut_misc.c
    Public Declare PtrSafe Sub glutIgnoreKeyRepeat Lib "freeglut" (ByVal ignore As Long)
    Public Declare PtrSafe Sub glutSetKeyRepeat Lib "freeglut" (ByVal repeatMode As Long)
    Public Declare PtrSafe Sub glutForceJoystickFunc Lib "freeglut" ()
    ' Misc functions, see freeglut_misc.c
    Public Declare PtrSafe Function glutExtensionSupported Lib "freeglut" (ByVal extension As String) As Long
    Public Declare PtrSafe Sub glutReportErrors Lib "freeglut" ()
    ' Process loop function, see freeglut_main.c
    Public Declare PtrSafe Sub glutMainLoopEvent Lib "freeglut" ()
    Public Declare PtrSafe Sub glutLeaveMainLoop Lib "freeglut" ()
    Public Declare PtrSafe Sub glutExit Lib "freeglut" ()
    ' Window management functions, see freeglut_window.c
    Public Declare PtrSafe Sub glutFullScreenToggle Lib "freeglut" ()
    Public Declare PtrSafe Sub glutLeaveFullScreen Lib "freeglut" ()
    ' Menu functions
    Public Declare PtrSafe Sub glutSetMenuFont Lib "freeglut" (ByVal menuID As Long, ByVal font As LongPtr)
    ' Window-specific callback functions, see freeglut_callbacks.c
    Public Declare PtrSafe Sub glutMouseWheelFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutPositionFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutCloseFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutWMCloseFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMenuDestroyFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    ' State setting and retrieval functions, see freeglut_state.c
    Public Declare PtrSafe Sub glutSetOption Lib "freeglut" (ByVal option_flag As Long, ByVal value As Long)
    Public Declare PtrSafe Function glutGetModeValues Lib "freeglut" (ByVal mode As Long, size As LongPtr) As LongPtr
    Public Declare PtrSafe Function glutGetWindowData Lib "freeglut" () As LongPtr
    Public Declare PtrSafe Sub glutSetWindowData Lib "freeglut" (ByVal data As LongPtr)
    Public Declare PtrSafe Function glutGetMenuData Lib "freeglut" () As LongPtr
    Public Declare PtrSafe Sub glutSetMenuData Lib "freeglut" (ByVal data As LongPtr)
    ' Font stuff, see freeglut_font.c
    Public Declare PtrSafe Function glutBitmapHeight Lib "freeglut" (ByVal font As LongPtr) As Long
    Public Declare PtrSafe Function glutStrokeHeight Lib "freeglut" (ByVal font As LongPtr) As Single
    Public Declare PtrSafe Sub glutBitmapString Lib "freeglut" (ByVal font As LongPtr, ByVal pstring As String)
    Public Declare PtrSafe Sub glutStrokeString Lib "freeglut" (ByVal font As LongPtr, ByVal pstring As String)
    ' Geometry functions, see freeglut_geometry.c
    Public Declare PtrSafe Sub glutWireRhombicDodecahedron Lib "freeglut" ()
    Public Declare PtrSafe Sub glutSolidRhombicDodecahedron Lib "freeglut" ()
    Public Declare PtrSafe Sub glutWireSierpinskiSponge Lib "freeglut" (ByVal num_levels As Long, offset As Double, ByVal pscale As Double)
    Public Declare PtrSafe Sub glutSolidSierpinskiSponge Lib "freeglut" (ByVal num_levels As Long, offset As Double, ByVal pscale As Double)
    Public Declare PtrSafe Sub glutWireCylinder Lib "freeglut" (ByVal radius As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare PtrSafe Sub glutSolidCylinder Lib "freeglut" (ByVal radius As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    ' Rest of functions for rendering Newell's teaset, found in fg_teapot.c
    ' NB: front facing polygons have clockwise winding, not counter clockwise
    Public Declare PtrSafe Sub glutWireTeacup Lib "freeglut" (ByVal size As Double)
    Public Declare PtrSafe Sub glutSolidTeacup Lib "freeglut" (ByVal size As Double)
    Public Declare PtrSafe Sub glutWireTeaspoon Lib "freeglut" (ByVal size As Double)
    Public Declare PtrSafe Sub glutSolidTeaspoon Lib "freeglut" (ByVal size As Double)
    ' Extension functions, see fg_ext.c
    Public Declare PtrSafe Function glutGetProcAddress Lib "freeglut" (ByVal procName As String) As LongPtr
    ' Multi-touch/multi-pointer extensions
    Public Declare PtrSafe Sub glutMultiEntryFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMultiButtonFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMultiMotionFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutMultiPassiveFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    ' Initialization functions, see freeglut_init.c
    Public Declare PtrSafe Sub glutInitContextVersion Lib "freeglut" (ByVal majorVersion As Long, ByVal minorVersion As Long)
    Public Declare PtrSafe Sub glutInitContextFlags Lib "freeglut" (ByVal flags As Long)
    Public Declare PtrSafe Sub glutInitContextProfile Lib "freeglut" (ByVal profile As Long)
    Public Declare PtrSafe Sub glutInitErrorFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutInitWarningFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    ' OpenGL >= 2.0 support
    Public Declare PtrSafe Sub glutSetVertexAttribCoord3 Lib "freeglut" (ByVal attrib As Long)
    Public Declare PtrSafe Sub glutSetVertexAttribNormal Lib "freeglut" (ByVal attrib As Long)
    Public Declare PtrSafe Sub glutSetVertexAttribTexCoord2 Lib "freeglut" (ByVal attrib As Long)
    ' Mobile platforms lifecycle
    Public Declare PtrSafe Sub glutInitContextFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
    Public Declare PtrSafe Sub glutAppStatusFunc Lib "freeglut" (ByVal fnPtr As LongPtr)
#Else
    ' Initialization functions, see fglut_init.c
    Public Declare Sub glutInit Lib "freeglut" (pargc As Long, argv As String)
    Public Declare Sub glutInitWindowPosition Lib "freeglut" (ByVal X As Long, ByVal y As Long)
    Public Declare Sub glutInitWindowSize Lib "freeglut" (ByVal Width As Long, ByVal Height As Long)
    Public Declare Sub glutInitDisplayMode Lib "freeglut" (ByVal displayMode As Long)
    Public Declare Sub glutInitDisplayString Lib "freeglut" (ByVal displayMode As String)
    ' Process loop function, see freeglut_main.c
    Public Declare Sub glutMainLoop Lib "freeglut" ()
    ' Window management functions, see freeglut_window.c
    Public Declare Function glutCreateWindow Lib "freeglut" Alias "glutCreateWindow" (ByVal title As String) As Long
    Public Declare Function glutCreateSubWindow Lib "freeglut" (ByVal window As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long) As Long
    Public Declare Sub glutDestroyWindow Lib "freeglut" Alias "glutDestroyWindow" (ByVal window As Long)
    Public Declare Sub glutSetWindow Lib "freeglut" (ByVal window As Long)
    Public Declare Function glutGetWindow Lib "freeglut" () As Long
    Public Declare Sub glutSetWindowTitle Lib "freeglut" (ByVal title As String)
    Public Declare Sub glutSetIconTitle Lib "freeglut" (ByVal title As String)
    Public Declare Sub glutReshapeWindow Lib "freeglut" (ByVal Width As Long, ByVal Height As Long)
    Public Declare Sub glutPositionWindow Lib "freeglut" (ByVal X As Long, ByVal y As Long)
    Public Declare Sub glutShowWindow Lib "freeglut" ()
    Public Declare Sub glutHideWindow Lib "freeglut" ()
    Public Declare Sub glutIconifyWindow Lib "freeglut" ()
    Public Declare Sub glutPushWindow Lib "freeglut" ()
    Public Declare Sub glutPopWindow Lib "freeglut" ()
    Public Declare Sub glutFullScreen Lib "freeglut" ()
    ' Display-connected functions, see freeglut_display.c
    Public Declare Sub glutPostWindowRedisplay Lib "freeglut" (ByVal window As Long)
    Public Declare Sub glutPostRedisplay Lib "freeglut" ()
    Public Declare Sub glutSwapBuffers Lib "freeglut" ()
    ' Mouse cursor functions, see freeglut_cursor.c
    Public Declare Sub glutWarpPointer Lib "freeglut" (ByVal X As Long, ByVal y As Long)
    Public Declare Sub glutSetCursor Lib "freeglut" (ByVal cursor As Long)
    ' Overlay stuff, see freeglut_overlay.c
    Public Declare Sub glutEstablishOverlay Lib "freeglut" ()
    Public Declare Sub glutRemoveOverlay Lib "freeglut" ()
    Public Declare Sub glutUseLayer Lib "freeglut" (ByVal layer As Long)
    Public Declare Sub glutPostOverlayRedisplay Lib "freeglut" ()
    Public Declare Sub glutPostWindowOverlayRedisplay Lib "freeglut" (ByVal window As Long)
    Public Declare Sub glutShowOverlay Lib "freeglut" ()
    Public Declare Sub glutHideOverlay Lib "freeglut" ()
    ' Menu stuff, see freeglut_menu.c
    Public Declare Function glutCreateMenu Lib "freeglut" (ByVal fnPtr As Long) As Long
    Public Declare Sub glutDestroyMenu Lib "freeglut" (ByVal menu As Long)
    Public Declare Function glutGetMenu Lib "freeglut" () As Long
    Public Declare Sub glutSetMenu Lib "freeglut" (ByVal menu As Long)
    Public Declare Sub glutAddMenuEntry Lib "freeglut" (ByVal label As String, ByVal value As Long)
    Public Declare Sub glutAddSubMenu Lib "freeglut" (ByVal label As String, ByVal subMenu As Long)
    Public Declare Sub glutChangeToMenuEntry Lib "freeglut" (ByVal item As Long, ByVal label As String, ByVal value As Long)
    Public Declare Sub glutChangeToSubMenu Lib "freeglut" (ByVal item As Long, ByVal label As String, ByVal value As Long)
    Public Declare Sub glutRemoveMenuItem Lib "freeglut" (ByVal item As Long)
    Public Declare Sub glutAttachMenu Lib "freeglut" (ByVal button As Long)
    Public Declare Sub glutDetachMenu Lib "freeglut" (ByVal button As Long)
    ' Global callback functions, see freeglut_callbacks.c
    Public Declare Sub glutTimerFunc Lib "freeglut" (ByVal time As Long, ByVal fnPtr As Long, ByVal value As Long)
    Public Declare Sub glutIdleFunc Lib "freeglut" (ByVal fnPtr As Long)
    ' Window-specific callback functions, see freeglut_callbacks.c
    Public Declare Sub glutKeyboardFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutSpecialFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutReshapeFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutVisibilityFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutDisplayFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutMouseFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutMotionFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutPassiveMotionFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutEntryFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutKeyboardUpFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutSpecialUpFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutJoystickFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutMenuStateFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutMenuStatusFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutOverlayDisplayFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutWindowStatusFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutSpaceballMotionFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutSpaceballRotateFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutSpaceballButtonFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutButtonBoxFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutDialsFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutTabletMotionFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutTabletButtonFunc Lib "freeglut" (ByVal fnPtr As Long)
    ' State setting and retrieval functions, see freeglut_state.c
    Public Declare Function glutGet Lib "freeglut" (ByVal query As Long) As Long
    Public Declare Function glutDeviceGet Lib "freeglut" (ByVal query As Long) As Long
    Public Declare Function glutGetModifiers Lib "freeglut" () As Long
    Public Declare Function glutLayerGet Lib "freeglut" (ByVal query As Long) As Long
    ' Font stuff, see freeglut_font.c
    Public Declare Sub glutBitmapCharacter Lib "freeglut" (ByVal font As Long, ByVal character As Long)
    Public Declare Function glutBitmapWidth Lib "freeglut" (ByVal font As Long, ByVal character As Long) As Long
    Public Declare Sub glutStrokeCharacter Lib "freeglut" (ByVal font As Long, ByVal character As Long)
    Public Declare Function glutStrokeWidth Lib "freeglut" (ByVal font As Long, ByVal character As Long) As Long
    Public Declare Function glutBitmapLength Lib "freeglut" (ByVal font As Long, ByVal pstring As String) As Long
    Public Declare Function glutStrokeLength Lib "freeglut" (ByVal font As Long, ByVal pstring As String) As Long
    ' Geometry functions, see freeglut_geometry.c
    Public Declare Sub glutWireCube Lib "freeglut" (ByVal size As Double)
    Public Declare Sub glutSolidCube Lib "freeglut" (ByVal size As Double)
    Public Declare Sub glutWireSphere Lib "freeglut" (ByVal radius As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare Sub glutSolidSphere Lib "freeglut" (ByVal radius As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare Sub glutWireCone Lib "freeglut" (ByVal base As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare Sub glutSolidCone Lib "freeglut" (ByVal base As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare Sub glutWireTorus Lib "freeglut" (ByVal innerRadius As Double, ByVal outerRadius As Double, ByVal sides As Long, ByVal rings As Long)
    Public Declare Sub glutSolidTorus Lib "freeglut" (ByVal innerRadius As Double, ByVal outerRadius As Double, ByVal sides As Long, ByVal rings As Long)
    Public Declare Sub glutWireDodecahedron Lib "freeglut" ()
    Public Declare Sub glutSolidDodecahedron Lib "freeglut" ()
    Public Declare Sub glutWireOctahedron Lib "freeglut" ()
    Public Declare Sub glutSolidOctahedron Lib "freeglut" ()
    Public Declare Sub glutWireTetrahedron Lib "freeglut" ()
    Public Declare Sub glutSolidTetrahedron Lib "freeglut" ()
    Public Declare Sub glutWireIcosahedron Lib "freeglut" ()
    Public Declare Sub glutSolidIcosahedron Lib "freeglut" ()
    ' Teapot rendering functions, found in freeglut_teapot.c
    ' NB: front facing polygons have clockwise winding, not counter clockwise
    Public Declare Sub glutWireTeapot Lib "freeglut" (ByVal size As Double)
    Public Declare Sub glutSolidTeapot Lib "freeglut" (ByVal size As Double)
    ' Game mode functions, see freeglut_gamemode.c
    Public Declare Sub glutGameModeString Lib "freeglut" (ByVal pstring As String)
    Public Declare Function glutEnterGameMode Lib "freeglut" () As Long
    Public Declare Sub glutLeaveGameMode Lib "freeglut" ()
    Public Declare Function glutGameModeGet Lib "freeglut" (ByVal query As Long) As Long
    ' Video resize functions, see freeglut_videoresize.c
    Public Declare Function glutVideoResizeGet Lib "freeglut" (ByVal query As Long) As Long
    Public Declare Sub glutSetupVideoResizing Lib "freeglut" ()
    Public Declare Sub glutStopVideoResizing Lib "freeglut" ()
    Public Declare Sub glutVideoResize Lib "freeglut" (ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)
    Public Declare Sub glutVideoPan Lib "freeglut" (ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)
    ' Colormap functions, see freeglut_misc.c
    Public Declare Sub glutSetColor Lib "freeglut" (ByVal color As Long, ByVal red As Single, ByVal green As Single, ByVal blue As Single)
    Public Declare Function glutGetColor Lib "freeglut" (ByVal color As Long, ByVal component As Long) As Single
    Public Declare Sub glutCopyColormap Lib "freeglut" (ByVal window As Long)
    ' Misc keyboard and joystick functions, see freeglut_misc.c
    Public Declare Sub glutIgnoreKeyRepeat Lib "freeglut" (ByVal ignore As Long)
    Public Declare Sub glutSetKeyRepeat Lib "freeglut" (ByVal repeatMode As Long)
    Public Declare Sub glutForceJoystickFunc Lib "freeglut" ()
    ' Misc functions, see freeglut_misc.c
    Public Declare Function glutExtensionSupported Lib "freeglut" (ByVal extension As String) As Long
    Public Declare Sub glutReportErrors Lib "freeglut" ()
    ' Process loop function, see freeglut_main.c
    Public Declare Sub glutMainLoopEvent Lib "freeglut" ()
    Public Declare Sub glutLeaveMainLoop Lib "freeglut" ()
    Public Declare Sub glutExit Lib "freeglut" ()
    ' Window management functions, see freeglut_window.c
    Public Declare Sub glutFullScreenToggle Lib "freeglut" ()
    Public Declare Sub glutLeaveFullScreen Lib "freeglut" ()
    ' Menu functions
    Public Declare Sub glutSetMenuFont Lib "freeglut64" (ByVal menuID As Long, ByVal font As Long)
    ' Window-specific callback functions, see freeglut_callbacks.c
    Public Declare Sub glutMouseWheelFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutPositionFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutCloseFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutWMCloseFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutMenuDestroyFunc Lib "freeglut" (ByVal fnPtr As Long)
    ' State setting and retrieval functions, see freeglut_state.c
    Public Declare Sub glutSetOption Lib "freeglut" (ByVal option_flag As Long, ByVal value As Long)
    Public Declare Function glutGetModeValues Lib "freeglut" (ByVal mode As Long, size As Long) As Long
    Public Declare Function glutGetWindowData Lib "freeglut" () As Long
    Public Declare Sub glutSetWindowData Lib "freeglut" (ByVal data As Long)
    Public Declare Function glutGetMenuData Lib "freeglut" () As Long
    Public Declare Sub glutSetMenuData Lib "freeglut" (ByVal data As Long)
    ' Font stuff, see freeglut_font.c
    Public Declare Function glutBitmapHeight Lib "freeglut" (ByVal font As Long) As Long
    Public Declare Function glutStrokeHeight Lib "freeglut" (ByVal font As Long) As Single
    Public Declare Sub glutBitmapString Lib "freeglut" (ByVal font As Long, ByVal pstring As String)
    Public Declare Sub glutStrokeString Lib "freeglut" (ByVal font As Long, ByVal pstring As String)
    ' Geometry functions, see freeglut_geometry.c
    Public Declare Sub glutWireRhombicDodecahedron Lib "freeglut" ()
    Public Declare Sub glutSolidRhombicDodecahedron Lib "freeglut" ()
    Public Declare Sub glutWireSierpinskiSponge Lib "freeglut" (ByVal num_levels As Long, offset As Double, ByVal pscale As Double)
    Public Declare Sub glutSolidSierpinskiSponge Lib "freeglut" (ByVal num_levels As Long, offset As Double, ByVal pscale As Double)
    Public Declare Sub glutWireCylinder Lib "freeglut" (ByVal radius As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    Public Declare Sub glutSolidCylinder Lib "freeglut" (ByVal radius As Double, ByVal Height As Double, ByVal slices As Long, ByVal stacks As Long)
    ' Rest of functions for rendering Newell's teaset, found in fg_teapot.c
    'NB: front facing polygons have clockwise winding, not counter clockwise
    Public Declare Sub glutWireTeacup Lib "freeglut" (ByVal size As Double)
    Public Declare Sub glutSolidTeacup Lib "freeglut" (ByVal size As Double)
    Public Declare Sub glutWireTeaspoon Lib "freeglut" (ByVal size As Double)
    Public Declare Sub glutSolidTeaspoon Lib "freeglut" (ByVal size As Double)
    ' Extension functions, see fg_ext.c
    Public Declare Function glutGetProcAddress Lib "freeglut" (ByVal procName As String) As Long
    ' Multi-touch/multi-pointer extensions
    Public Declare Sub glutMultiEntryFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutMultiButtonFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutMultiMotionFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutMultiPassiveFunc Lib "freeglut" (ByVal fnPtr As Long)
    ' Initialization functions, see freeglut_init.c
    Public Declare Sub glutInitContextVersion Lib "freeglut" (ByVal majorVersion As Long, ByVal minorVersion As Long)
    Public Declare Sub glutInitContextFlags Lib "freeglut" (ByVal flags As Long)
    Public Declare Sub glutInitContextProfile Lib "freeglut" (ByVal profile As Long)
    Public Declare Sub glutInitErrorFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutInitWarningFunc Lib "freeglut" (ByVal fnPtr As Long)
    ' OpenGL >= 2.0 support
    Public Declare Sub glutSetVertexAttribCoord3 Lib "freeglut" (ByVal attrib As Long)
    Public Declare Sub glutSetVertexAttribNormal Lib "freeglut" (ByVal attrib As Long)
    Public Declare Sub glutSetVertexAttribTexCoord2 Lib "freeglut" (ByVal attrib As Long)
    ' Mobile platforms lifecycle
    Public Declare Sub glutInitContextFunc Lib "freeglut" (ByVal fnPtr As Long)
    Public Declare Sub glutAppStatusFunc Lib "freeglut" (ByVal fnPtr As Long)
#End If