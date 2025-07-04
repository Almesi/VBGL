Attribute VB_Name = "VBGLGraphicsDebug"

Option Explicit

#Const COMPDEBUG = 1

Private Declare PtrSafe Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (ByRef Destination As Any, ByVal Source As Any, ByVal Length As Long)

Public Const NullPtr As LongPtr = 0

#If COMPDEBUG = 1 Then
    Public Sub GLDebugOutput(ByVal Source As Long, ByVal Typee As Long, ByVal ID As Long, ByVal Severity As Long, ByVal Length As Long, ByVal Message As LongPtr, ByVal UserParam As LongPtr)
        Dim PrintMessage As String
        Debug.Print "Message: " ID & " --> " & PointerToString(Message, Length)
        PrintMessage = "Message source: " 
        Select Case Source
            Case GL_DEBUG_SOURCE_API_ARB                 : PrintMessage = PrintMessage & "API"
            Case GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB       : PrintMessage = PrintMessage & "Window System"
            Case GL_DEBUG_SOURCE_SHADER_COMPILER_ARB     : PrintMessage = PrintMessage & "Shader Compiler"
            Case GL_DEBUG_SOURCE_THIRD_PARTY_ARB         : PrintMessage = PrintMessage & "Third Party"
            Case GL_DEBUG_SOURCE_APPLICATION_ARB         : PrintMessage = PrintMessage & "Application"
            Case GL_DEBUG_SOURCE_OTHER_ARB               : PrintMessage = PrintMessage & "Other"
        End Select
        Debug.Print PrintMessage
        PrintMessage = "Error Type: "
        Select Case Typee
            Case GL_DEBUG_TYPE_ERROR_ARB                 : PrintMessage = PrintMessage & "Error"
            Case GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB   : PrintMessage = PrintMessage & "Deprecated Behaviour"
            Case GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB    : PrintMessage = PrintMessage & "Undefined Behaviour"
            Case GL_DEBUG_TYPE_PORTABILITY_ARB           : PrintMessage = PrintMessage & "Portability"
            Case GL_DEBUG_TYPE_PERFORMANCE_ARB           : PrintMessage = PrintMessage & "Performance"
            ' Case GL_DEBUG_TYPE_MARKER_ARB                : Debug.Print "Marker"
            ' Case GL_DEBUG_TYPE_PUSH_ARB                  : Debug.Print "Push"
            ' Case GL_DEBUG_TYPE_POP_ARB                   : Debug.Print "Pop"
            ' Case GL_DEBUG_TYPE_OTHER_ARB                 : Debug.Print "Other"
        End Select
        Debug.Print PrintMessage
        PrintMessage = "Severity: "
        Select Case Severity
            Case GL_DEBUG_SEVERITY_HIGH_ARB              : PrintMessage = PrintMessage & "High"
            Case GL_DEBUG_SEVERITY_MEDIUM_ARB            : PrintMessage = PrintMessage & "Medium"
            Case GL_DEBUG_SEVERITY_LOW_ARB               : PrintMessage = PrintMessage & "Low"
            ' Case GL_DEBUG_SEVERITY_NOTIFICATION_ARB      : Debug.Print "Notification"
        End Select
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

Public Function PointerToString(Pointer As LongPtr, Optional Length As Long = 0) As String
    Dim Bytes() As Byte
    Dim Char As Byte
    Dim i As LongPtr
    
    If Length <= 0 Then
        i = Pointer
        Do
            Call CopyMemory(Char, i, 1)
            If Char = 0 Then Exit Do
            i = i + 1
        Loop
        Length = CLng(i - Pointer)
    End If

    If Length <= 0 Then Exit Function
    ReDim Bytes(Length - 1)
    Call CopyMemory(Bytes(0), Pointer, Length)
    PointerToString = StrConv(Bytes, vbUnicode)
End Function