VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLSound"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False


Option Explicit

#If Win64 Then
    Private Declare PtrSafe Function SendString    Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrIDurnString As String, ByVal uIDurnLength As Long, ByVal hwndCallback As Long) As Long
    Private Declare PtrSafe Function PlaySound     Lib "winmm.dll" Alias "PlaySoundA"     (ByVal lpszName     As String, ByVal hModule           As Long  , ByVal dwFlags       As Long) As Long
#Else
    Private Declare         Function SendString    Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrIDurnString As String, ByVal uIDurnLength As Long, ByVal hwndCallback As Long) As Long
    Private Declare         Function PlaySound     Lib "winmm.dll" Alias "PlaySoundA"     (ByVal lpszName     As String, ByVal hModule           As Long  , ByVal dwFlags       As Long) As Long
#End If

Private Const SND_ASYNC  = &H1           '  play asynchronously
Private Const SND_MEMORY = &H4           '  lpszSoundName points to a memory file

Private p_ID          As Long
Private p_SoundString As String
Private p_Name        As String
Private p_FilePath    As String

Public Function Create(ByVal FilePath As String, ByVal Name As String) As VBGLSound
    Set Create = New VBGLSound
    With Create
        .Name     = n_Name
        .FilePath = n_FilePath
        Call .LoadSound()
    End With
End Function

Public Sub LoadSound()
    Dim File As Long
    Dim FilePathSpace As String

    ID = SendString("open """ & FilePath & """ Type MPEGVideo Alias " & Name, 0&, 0, 0)

    File = FreeFile
    FilePathSpace = Space(FileLen(FilePath))
    Open FilePath For Binary As #File
    Get #File, , FilePathSpace
    Close #File
End Sub

Public Sub Pause()
    ID = SendString("pause " & Name, 0&, 0, 0)
End Sub

Public Sub Resumee()
    ID = SendString("resume " & Name, 0&, 0, 0)
End Sub

Public Sub Play()
    Call PlaySound(SoundString, 0, SND_ASYNC Or SND_MEMORY)
End Sub

Public Sub PlayRepeat()
    On Error GoTo myErr
    DoEvents
    ID = SendString("play " & Name & " repeat", 0&, 0, 0)
    myErr:
    Dim NewError As std_Error
    Set NewError = std_Error.Create("VBGLSound", "minor", "PlayRepeat", "Could not play sound of VAR0, FilePath: VAR1", Empty, Name, FilePath)
    Call CurrentContext.ErrorHandler(CurrentContext.ErrorHandler.IS_ERROR, NewError)
End Sub

Private Sub Class_Terminate()
    If Name <> Empty Then
        ID = SendString("stop " & Name, 0, 0, 0)
        ID = SendString("close " & Name, 0, 0, 0)
    End If
    ID = 0
End Sub