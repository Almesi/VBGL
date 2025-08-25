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

Private ID As Long
Private SoundString As String
Private AliasName As String

Public Sub LoadMusic(FilePath As String, AliasTitle As String)
    Dim File As Long
    Dim FilePathSpace As String

    AliasName = AliasTitle
    ID = SendString("open """ & FilePath & """ Type MPEGVideo Alias " & AliasName, 0&, 0, 0)

    File = FreeFile
    FilePathSpace = Space(FileLen(FilePath))
    Open FilePath For Binary As #File
    Get #File, , FilePathSpace
    Close #File
    SoundString = Trim(FilePathSpace)
End Sub

Public Sub Pause()
    ID = SendString("pause " & AliasName, 0&, 0, 0)
End Sub

Public Sub Resumee()
    ID = SendString("resume " & AliasName, 0&, 0, 0)
End Sub

Public Sub Play()
    'ID = SendString("play " & AliasName, 0&, 0, 0)
    Call PlaySound(SoundString, 0, SND_ASYNC Or SND_MEMORY)
End Sub

Public Sub PlayRepeat()
    On Error GoTo myErr
    DoEvents
    ID = SendString("play " & AliasName & " repeat", 0&, 0, 0)
    myErr:
    If Err.Number = -2147418105 Then Exit Sub
End Sub

Private Sub Class_Terminate()
    If AliasName <> Empty Then ' If Initialized
        ID = SendString("stop " & AliasName, 0, 0, 0)
        ID = SendString("close " & AliasName, 0, 0, 0)
    End If
    ID = 0
End Sub