Attribute VB_Name = "OwnTest"

Option Explicit


Public Sub Test()
    Dim Path As String
    Path = ThisWorkbook.Path
    
    Dim Proj As std_VBProject
    Set Proj = std_VBProject.Create(ThisWorkbook.VBProject)

    std_Error.LoggingDestination = Empty
    std_Error.ShowDestination = Empty
    Proj.Handler = std_Error
    If Proj.IncludeFolder(Path & "\Src", NormalReplace, True, False, True) <> Proj.IS_ERROR Then
        Debug.Print Application.Run("RunMain", Path & "\Res")
    End If
End Sub