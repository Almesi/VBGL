Attribute VB_Name = "VBGLGraphicsDebug"

Option Explicit

#Const COMPDEBUG = 1

Private Declare PtrSafe Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (ByRef Destination As Any, ByVal Source As Any, ByVal Length As Long)

#If COMPDEBUG = 1 Then
    ' Standard Callback method of OpenGL Debugging wrapped into custom Errorhandler
    Public Sub GLDebugOutput(ByVal Source As Long, ByVal Typee As Long, ByVal ID As Long, ByVal Severity As Long, ByVal Length As Long, ByVal Message As LongPtr, ByVal UserParam As LongPtr)
        Dim Template As String 
        Template = "Message: " & ID & " --> " & PointerToString(Message, Length)
        Dim Category As String
        Select Case Source
            Case GL_DEBUG_SOURCE_API_ARB                 : Category = "API"
            Case GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB       : Category = "Window System"
            Case GL_DEBUG_SOURCE_SHADER_COMPILER_ARB     : Category = "Shader Compiler"
            Case GL_DEBUG_SOURCE_THIRD_PARTY_ARB         : Category = "Third Party"
            Case GL_DEBUG_SOURCE_APPLICATION_ARB         : Category = "Application"
            Case GL_DEBUG_SOURCE_OTHER_ARB               : Category = "Other"
        End Select
        Dim Identity As String
        Select Case Typee
            Case GL_DEBUG_TYPE_ERROR_ARB                 : Identity = "Error"
            Case GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB   : Identity = "Deprecated Behaviour"
            Case GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB    : Identity = "Undefined Behaviour"
            Case GL_DEBUG_TYPE_PORTABILITY_ARB           : Identity = "Portability"
            Case GL_DEBUG_TYPE_PERFORMANCE_ARB           : Identity = "Performance"
            ' Case GL_DEBUG_TYPE_MARKER_ARB                : Identity "Marker"
            ' Case GL_DEBUG_TYPE_PUSH_ARB                  : Identity "Push"
            ' Case GL_DEBUG_TYPE_POP_ARB                   : Identity "Pop"
            ' Case GL_DEBUG_TYPE_OTHER_ARB                 : Identity "Other"
        End Select
        Dim Severity As String 
        Select Case Severity
            Case GL_DEBUG_SEVERITY_HIGH_ARB              : Severity = "High"
            Case GL_DEBUG_SEVERITY_MEDIUM_ARB            : Severity = "Medium"
            Case GL_DEBUG_SEVERITY_LOW_ARB               : Severity = "Low"
            ' Case GL_DEBUG_SEVERITY_NOTIFICATION_ARB      : Severity "Notification"
        End Select
        Dim NewError As std_Error
        Set NewError = std_Error.Create(Category, Severity, Identity, Template, Empty)
        Call CurrentContext.ErrorHandler.Handle(CurrentContext.ErrorHandler.IS_ERROR, NewError)
    End Sub

    Public Function GLStartDebug() As Boolean
        Call glEnable(GL_DEBUG_OUTPUT)
        Call glEnable(GL_DEBUG_OUTPUT_SYNCHRONOUS)
        Call glDebugMessageCallback(AddressOf GLDebugOutput, 0)
        Call glDebugMessageControl(GL_DONT_CARE, GL_DONT_CARE, GL_DONT_CARE, 0, 0, GL_TRUE)
        GLStartDebug = True
    End Function
#Else
    Public Sub GLDebugOutput(ByVal Source As Long, ByVal Typee As Long, ByVal ID As Long, ByVal Severity As Long, ByVal Length As Long, ByVal Message As LongPtr, ByVal UserParam As LongPtr)
        Exit Sub
    End Sub

    Public Function GLStartDebug() As Boolean
        GLStartDebug = False
    End Function
#End If