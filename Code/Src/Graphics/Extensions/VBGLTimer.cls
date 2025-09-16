VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLTimer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit


#If VBA7 Then
    Private Declare PtrSafe Function GetTickCount Lib "kernel32" () As Long
    Private Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#Else
    Private Declare Function GetTickCount Lib "kernel32" () As Long
    Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#End If

Private Running   As Boolean
Private StartTime As Single
Private LastTime  As Single
Private Times()   As Single

Public Function Create() As VBGLTimer
    Set Create = New VBGLTimer
    With Create
         .Start
    End With
End Function

Public Sub Start()
    Running = True
    StartTime = Timer
    LastTime  = StartTime
    Call StopTime
End Sub

Public Sub Pause()
    Running = False
End Sub

Public Sub Resume()
    Running = True
End Sub

Public Sub Reset()
    Dim Temp() As Single
    Times = Temp
    Call Start()
End Sub

Public Sub Wait(ByVal Milliseconds As Long)
    Call Sleep(Milliseconds)
End Sub

Public Function DeltaTime() As Single
    DeltaTime = Timer - LastTime
End Function

Public Function RunTime() As Single
    RunTime = Timer - StartTime
End Function

Public Sub StopTime()
    Call VBGLAdd(Times, Timer)
End Sub

Public Sub Update()
    LastTime = Timer
End Sub