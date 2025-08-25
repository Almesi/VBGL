Attribute VB_Name = "OwnTest"

Option Explicit

Public NewErrorHandler As std_ErrorHandler


Public Sub Test()
    Dim Path As String
    Path = ThisWorkbook.Path
    
    Set NewErrorHandler = std_ErrorHandler.Create(std_MsgBoxDestination.Create(), std_ImmiedeateDestination.Create())
    
    Dim Proj As std_VBProject
    Set Proj = std_VBProject.Create(ThisWorkbook.VBProject, NewErrorHandler)

    If Proj.IncludeFolder(Path & "\Src", NormalReplace, True, False) <> Proj.Handler.IS_ERROR Then
        Debug.Print Application.Run("RunMain", Path & "\Res")
    End If
End Sub