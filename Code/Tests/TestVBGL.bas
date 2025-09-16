Attribute VB_Name = "TestVBGL"

Option Explicit

Public NewErrorHandler As std_ErrorHandler


Public Sub Test()
    Dim Path As String
    Path = ThisWorkbook.Path

    Dim FoldersToIgnore As Variant
    FoldersToIgnore = IgnoreFolders()

    Dim Shower As IDestination : Set Shower = Nothing
    Dim Logger As IDestination : Set Logger = std_ImmiedeateDestination.Create()
    
    Set NewErrorHandler = std_ErrorHandler.Create(Shower, Logger)
    
    Dim Proj As std_VBProject
    Set Proj = std_VBProject.Create(ThisWorkbook.VBProject, NewErrorHandler)

    If Proj.IncludeFolderArr(Path & "\Src", NormalReplace, True, False, FoldersToIgnore) <> Proj.Handler.IS_ERROR Then
        If Proj.IncludeFolder(Path & "\Tests", NormalReplace, True, False) <> Proj.Handler.IS_ERROR Then
            Debug.Print Application.Run("TestAll1", Path, Shower, Logger)
        End If
    End If
End Sub

Private Function IgnoreFolders() As Variant
    Dim ReturnArr() As Variant
    ReDim ReturnArr(0)
    ReturnArr(0) = CVar("Errorhandling")
    IgnoreFolders = ReturnArr
End Function