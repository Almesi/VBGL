VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLModel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Meshes()         As VBGLMesh
Private p_LoadedTextures() As VBGLTexture
Private p_LoadedShaders()  As VBGLShader
Private p_Materials()      As GLMaterial
Private p_Loader           As VBGLFileLoader

Public Property Let Meshes(n_Meshes()                 As VBGLMesh)     : Let p_Meshes         = n_Meshes         : End Property
Public Property Let LoadedTextures(n_LoadedTextures() As VBGLTexture)  : Let p_LoadedTextures = n_LoadedTextures : End Property
Public Property Let LoadedShaders(n_LoadedShaders()   As VBGLShader)   : Let p_LoadedShaders  = n_LoadedShaders  : End Property
Public Property Let Materials(n_Materials()           As GLMaterial)   : Let p_Materials      = n_Materials      : End Property
Public Property Let Loader(n_Loader                   As VBGLFileLoader) : Set p_Loader         = n_Loader         : End Property

Public Property Get Meshes()                          As VBGLMesh()    : Let Meshes           = p_Meshes         : End Property
Public Property Get LoadedTextures()                  As VBGLTexture() : Let LoadedTextures   = p_LoadedTextures : End Property
Public Property Get LoadedShaders()                   As VBGLShader()  : Let LoadedShaders    = p_LoadedShaders  : End Property
Public Property Get Materials()                       As GLMaterial()  : Let Materials        = p_Materials      : End Property
Public Property Get Loader()                          As VBGLFileLoader  : Set Loader           = p_Loader         : End Property

Public Function Create(n_Loader As VBGLFileLoader, FolderPath As String, ObjectLoader As IObjLoader, MaterialLoader As IMtlLoader) As VBGLModel
    Set Create = New VBGLModel
    With Create
        .Loader = n_Loader
        Call .LoadModel(FolderPath, ObjectLoader, MaterialLoader)
    End With
End Function

Public Sub Draw()
    Dim i As Long
    For i = 0 To USize(p_Meshes)
        Call p_Meshes(i).Draw()
    Next i
End Sub

Public Sub LoadModel(FolderPath As String, ObjectLoader As IObjLoader, MaterialLoader As IMtlLoader)
    Dim i As Long, j As Long

    Call LoadFolder(FolderPath)
    Call ProcessLoader(ObjectLoader, MaterialLoader)

    Dim Groups() As GLGroup
    Groups = ObjectLoader.Groups
    For i = 0 To USize(Groups)
        Call GetMaterials(Groups(i))
    Next i
    Call GetTexturesFromMaterial()

    Dim SubGroups() As GLSubGroup
    Dim CurrentShader As VBGLShader
    For i = 0 To USize(Groups)
        SubGroups = Groups(i).SubGroups
        For j = 0 To USize(SubGroups)
            Set CurrentShader = GetShader(SubGroups(j))
            Dim Size As Long
            Size = Add(p_Meshes, VBGLMesh.Create(CurrentShader, SubGroups(i).Layout, SubGroups(i).ByteData, SubGroups(i).Faces, False))
            p_Meshes(Size).Material = GetMaterial(SubGroups(i).Material)
            p_Meshes(Size).Textures = GetTextures(p_Meshes(Size).Material)
        Next j
    Next i
End Sub

Private Function GetMaterial(Name As String) As GLMaterial
    Dim i As Long
    For i = 0 To UBound(Materials)
        If p_Materials(i).Name = Name Then
            Set GetMaterial = p_Materials(i)
            Exit Function
        End If
    Next i
End Function

Private Function GetTextures(Material As GLMaterial) As VBGLTexture()
    Dim i As Long
    Dim ReturnArr() As VBGLTexture
    If Material Is Nothing Then Exit Function
    For i = 0 To USize(p_LoadedTextures)
        Dim FileName    As String      : FileName    = p_LoadedTextures(i).FilePath
        Dim StartPoint  As Long        : StartPoint  = InStrRev(FileName, "\")
        Dim EndPoint    As Long        : EndPoint    = InStrRev(FileName, ".")
        If StartPoint = 0 Then StartPoint = 1
        If EndPoint = 0 Then EndPoint = Len(FileName)
        Dim NewFileName As String      : NewFileName = MidP(FileName, StartPoint + 1, EndPoint - 1)
        If FileName = Material.MapTexture  Then Call Add(ReturnArr, p_LoadedTextures(i))
        If FileName = Material.MapAmbient  Then Call Add(ReturnArr, p_LoadedTextures(i))
        If FileName = Material.MapDiffuse  Then Call Add(ReturnArr, p_LoadedTextures(i))
        If FileName = Material.MapSpecular Then Call Add(ReturnArr, p_LoadedTextures(i))
    Next i
    GetTextures = ReturnArr
End Function

Private Sub LoadFolder(FolderPath As String)
    Dim FSO    As Object: Set FSO = CreateObject("Scripting.FileSystemObject")
    Dim Folder As Object: Set Folder = FSO.GetFolder(FolderPath)
    Dim File   As Object
    For Each File In Folder.Files
        Call Loader.Add(File.Path)
    Next File
    Dim SubFolder As Object
    For Each SubFolder In Folder.SubFolders
        Call LoadFolder(SubFolder.Path)
    Next SubFolder
End Sub

Private Sub ProcessLoader(ObjectLoader As IObjLoader, MaterialLoader As IMtlLoader)
    Dim FilePath   As String
    Dim Points()   As String
    Dim FileFormat As String
    Do
        FilePath = Loader.ConsumeNext()
        If FilePath = Empty Then Exit Do
        Points = Split(FilePath, ".")
        FileFormat = Points(Ubound(Points))
        Select Case FileFormat
            Case "bmp", "png", "gif", "jpg", "tiff"
                Call Add(p_LoadedTextures, VBGLTexture.Create(FilePath, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, "Diffuse"))
            Case "obj"
                Call ObjectLoader.Load(FilePath)
            Case "mtl"
                Call MaterialLoader.Load(FilePath)
                Call Merge(p_Materials, MaterialLoader.Materials)
            Case Else
                Debug.Print "Invalid FileFormat: " & FilePath
        End Select
    Loop
End Sub

Private Sub GetTexturesFromMaterial()
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

Private Sub GetMaterials(Group As GLGroup)
    Dim i As Long, j As Long, k As Long
    Dim Size As Long: Size = -1
    Dim Found As Boolean
    Dim Arr() As GLMaterial
    Arr = Materials
    For i = 0 To Group.Count
        For j = 0 To Ubound(p_Materials)
            Found = False
            For k = 0 To Size
                If Arr(k).Name = p_Materials(j).Name Then Found = True
            Next k
            If Group.Subgroup(i).Material <> Empty And Found = False Then
                Size = Size + 1
                ReDim Preserve Arr(Size)
                Set Arr(Size) = p_Materials(j)
            End If
            Skip:
        Next j
    Next i
    Materials = Arr
End Sub

Private Function GetShader(SubGroup As GLSubGroup) As VBGLShader
    Dim Template As VBGLShaderTemplate
    Set Template = VBGLShaderTemplate.Create("Vertex-Fragment", "460 core")
    Dim Uni() As VBGLShaderVariable
    Call VBGLShaderVariable.Add(Uni, "uniform", "mat4", "Model")
    Call VBGLShaderVariable.Add(Uni, "uniform", "mat4", "View")
    Call VBGLShaderVariable.Add(Uni, "uniform", "mat4", "Projection")
    Call VBGLShaderVariable.AddVariable(Uni, Nothing)

    Dim i As Long
    For i = 0 To USize(Materials)
        If p_Materials(i).Name = SubGroup.Material Then
            Dim Color()  As Single
            Dim Size As Long

            Color  = p_Materials(i).ColorAmbient
            Size = USize(Color) + 1
            If Size <> 0 Then
                Call VBGLShaderVariable.Add(Uni, "uniform", "vec" & Size, "AmbientColor")
                Call VBGLShaderVariable.Add(Uni, "uniform", "float"     , "AmbientFactor")
            End If

            Color  = p_Materials(i).ColorDiffuse
            Size = USize(Color) + 1
            If Size <> 0 Then
                Call VBGLShaderVariable.Add(Uni, "uniform", "vec" & Size, "DiffuseColor")
            End If

            Color = p_Materials(i).ColorSpecular
            Size = USize(Color) + 1
            If Size <> 0 Then
                Call VBGLShaderVariable.Add(Uni, "uniform", "vec" & Size, "SpecularColor")
                Call VBGLShaderVariable.Add(Uni, "uniform", "float"     , "SpecularFactor")
            End If 
        End If
    Next i
    For i = 0 To USize(p_LoadedTextures)
        Call VBGLShaderVariable.Add(Uni, "uniform", "sampler2D", "TextureDiffuse" & i)
    Next i
    Call VBGLShaderVariable.Add(Uni, "uniform", "vec3"     , "LightPosition")
    Call VBGLShaderVariable.Add(Uni, "uniform", "vec3"     , "LightColor")
    Call VBGLShaderVariable.Add(Uni, "uniform", "vec3"     , "ViewPosition")
    Call VBGLShaderVariable.Add(Uni, "uniform", "float"    , "Shininess")

    Call Template.SetUp(SubGroup.Layout, Uni)
    Dim Code As String
    Code = Template.GetShader()
    Debug.Print Code
    '

    For i = 0 To USize(p_LoadedShaders)
        If p_LoadedShaders(i).Code = Code Then
            Set GetShader = p_LoadedShaders(i)
            Exit Function
        End If
    Next i
    Set GetShader = VBGLShader.CreateFromText(Code)
    ReDim p_LoadedShaders(USize(p_LoadedShaders) + 1)
    Set p_LoadedShaders(USize(p_LoadedShaders)) = GetShader
End Function

Private Sub Merge(Arr As Variant, Arr2 As Variant)
    Dim OldSize As Long: OldSize = USize(Arr) + 1
    Dim NewSize As Long: NewSize = OldSize + (USize(Arr2) + 1) - 1
    ReDim Preserve Arr(NewSize)
    Dim i As Long
    For i = 0 To USize(Arr2)
        Set Arr(i + OldSize) = Arr2(i)
    Next i
End Sub

Private Function Add(Arr As Variant, Value As Variant) As Long
    Add = USize(Arr) + 1
    ReDim Preserve Arr(Add)
    Call Assign(Arr(Add), Value)
End Function

Private Sub Assign(Value1 As Variant, Value2 As Variant)
    If IsObject(Value2) Then
        Set Value1 = Value2
    Else
        Let Value1 = Value2
    End If
End Sub

Private Function MidP(Text As String, StartPoint As Long, EndPoint As Long) As String
    MidP = Mid(Text, StartPoint, (EndPoint - StartPoint) + 1)
End Function

Private Function USize(Arr As Variant, Optional Dimension As Long = 1)
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr, Dimension)
End Function