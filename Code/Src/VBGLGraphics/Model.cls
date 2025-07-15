VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Model"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Meshes() As Mesh
Private p_LoadedTextures() As VBGLTexture
Private p_LoadedShaders() As VBGLShader
Private p_Materials() As GLMaterial
Private p_Loader As GLFileLoader

Public Property Let Meshes(n_Meshes()                 As Mesh)         : Let p_Meshes         = n_Meshes         : End Property
Public Property Let LoadedTextures(n_LoadedTextures() As VBGLTexture)  : Let p_LoadedTextures = n_LoadedTextures : End Property
Public Property Let LoadedShaders(n_LoadedShaders()   As VBGLShader)   : Let p_LoadedShaders  = n_LoadedShaders  : End Property
Public Property Let Materials(n_Materials()           As GLMaterial)   : Let p_Materials      = n_Materials      : End Property
Public Property Let Loader(n_Loader                   As GLFileLoader) : Set p_Loader         = n_Loader         : End Property

Public Property Get Meshes()                          As Mesh()        : Let Meshes           = p_Meshes         : End Property
Public Property Get LoadedTextures()                  As VBGLTexture() : Let LoadedTextures   = p_LoadedTextures : End Property
Public Property Get LoadedShaders()                   As VBGLShader()  : Let LoadedShaders    = p_LoadedShaders  : End Property
Public Property Get Materials()                       As GLMaterial()  : Let Materials        = p_Materials      : End Property
Public Property Get Loader()                          As GLFileLoader  : Set Loader           = p_Loader         : End Property

Public Function Create(n_Loader As GLFileLoader, FolderPath As String, ObjectLoader As IObjLoader, MaterialLoader As IMtlLoader) As Model
    Set Create = New Model
    With Create
        .Loader = n_Loader
        Call .LoadModel(FolderPath, ObjectLoader, MaterialLoader)
    End With
End Function

Public Sub Draw()
    Dim i As Long
    For i = 0 To Ubound(p_Meshes)
        Call p_Meshes(i).Draw()
    Next i
End Sub

Public Sub LoadModel(FolderPath As String, ObjectLoader As IObjLoader, MaterialLoader As IMtlLoader)
    Dim FSO    As Object: Set FSO = CreateObject("Scripting.FileSystemObject")
    Dim Folder As Object: Set Folder = FSO.GetFolder(FolderPath)
    Dim File   As Object
    For Each File In Folder.Files
        Dim FilePath   As String: FilePath = File.Path
        Dim Points()   As String: Points = Split(FilePath, ".")
        Dim FileFormat As String: FileFormat = Points(Ubound(Points))
        Dim Index      As Long
        Call Loader.Add(FilePath)
        Index = Loader.Consume(FilePath)
        Select Case FileFormat
            Case "bmp", "png", "gif", "jpg", "tiff"
                Call Add(p_LoadedTextures, VBGLTexture.Create(FilePath, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, "Diffuse"))
            Case "obj"
                Call ObjectLoader.Load(FilePath)
                Dim Groups() As GLGroup
                Groups = ObjectLoader.Groups
                Dim i As Long
                For i = 0 To USize(Groups)
                    Call Add(p_Meshes, Mesh.Create(Groups(i), False))
                Next i
            Case "mtl"
                Call MaterialLoader.Load(FilePath)
                Call Merge(p_Materials, MaterialLoader.Materials)
            Case Else
                Debug.Print "Invalid FileFormat: " & FilePath
                Call Loader.Add(FilePath)
        End Select
    Next File
    Call GetMaterialTextures()
    For i = 0 To USize(Groups)
        Call p_Meshes(i).GetTextures(Groups(i), p_Materials, p_LoadedTextures)
        Call p_Meshes(i).GetShader(Groups(i), p_LoadedShaders)
    Next i
    Dim SubFolder As Object
    For Each SubFolder In Folder.SubFolders
        Call LoadModel(SubFolder.Path, ObjectLoader, MaterialLoader)
    Next SubFolder
End Sub

Public Sub GetMaterialTextures()
    Dim i As Long
    For i = 0 To USize(p_Materials)
        If p_Materials(i).MapTexture  <> Empty Then
            If Loader.AddIf(p_Materials(i).MapTexture) = -1 Then
                Call Add(p_LoadedTextures, VBGLTexture.Create(p_Materials(i).MapTexture, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, "Diffuse"))
            End If
        End If
        If p_Materials(i).MapAmbient  <> Empty Then
            If Loader.AddIf(p_Materials(i).MapAmbient) = -1 Then
                Call Add(p_LoadedTextures, VBGLTexture.Create(p_Materials(i).MapAmbient, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, "Diffuse"))
            End If
        End If
        If p_Materials(i).MapDiffuse  <> Empty Then
            If Loader.AddIf(p_Materials(i).MapDiffuse) = -1 Then
                Call Add(p_LoadedTextures, VBGLTexture.Create(p_Materials(i).MapDiffuse, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, "Diffuse"))
            End If
        End If
        If p_Materials(i).MapSpecular <> Empty Then
            If Loader.AddIf(p_Materials(i).MapSpecular) = -1 Then
                Call Add(p_LoadedTextures, VBGLTexture.Create(p_Materials(i).MapSpecular, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, "Diffuse"))
            End If
        End If
    Next i
End Sub

Private Sub Merge(Arr As Variant, Arr2 As Variant)
    Dim OldSize As Long: OldSize = USize(Arr) + 1
    Dim NewSize As Long: NewSize = OldSize + (USize(Arr2) + 1) - 1
    ReDim Preserve Arr(NewSize)
    Dim i As Long
    For i = 0 To USize(Arr2)
        Set Arr(i + OldSize) = Arr2(i)
    Next i
End Sub

Private Sub Add(Arr As Variant, Value As Variant)
    ReDim Preserve Arr(USize(Arr) + 1)
    Call Assign(Arr(USize(Arr)), Value)
End Sub

Private Sub Assign(Value1 As Variant, Value2 As Variant)
    If IsObject(Value2) Then
        Set Value1 = Value2
    Else
        Let Value1 = Value2
    End If
End Sub

Private Function USize(Arr As Variant, Optional Dimension As Long = 1)
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr, Dimension)
End Function