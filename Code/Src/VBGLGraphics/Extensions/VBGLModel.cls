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
Private p_Materials()      As GLMaterial
Private p_Loader           As VBGLFileLoader

Public Property Let Meshes(n_Meshes()                 As VBGLMesh)       : Let p_Meshes         = n_Meshes         : End Property
Public Property Let Materials(n_Materials()           As GLMaterial)     : Let p_Materials      = n_Materials      : End Property
Public Property Let Loader(n_Loader                   As VBGLFileLoader) : Set p_Loader         = n_Loader         : End Property

Public Property Get Meshes()                          As VBGLMesh()      : Let Meshes           = p_Meshes         : End Property
Public Property Get Materials()                       As GLMaterial()    : Let Materials        = p_Materials      : End Property
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
            Size = VBGLAdd(p_Meshes, VBGLMesh.Create(CurrentShader, SubGroups(i).Layout, SubGroups(i).ByteData, SubGroups(i).Faces, False))
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
    If IsNothing(Material) Then Exit Function
    For i = 0 To USize(LoadedTextures)
        Dim FileName    As String      : FileName    = LoadedTextures(i).FilePath
        Dim StartPoint  As Long        : StartPoint  = InStrRev(FileName, "\")
        Dim EndPoint    As Long        : EndPoint    = InStrRev(FileName, ".")
        If StartPoint = 0 Then StartPoint = 1
        If EndPoint = 0 Then EndPoint = Len(FileName)
        Dim NewFileName As String      : NewFileName = VBGLMidP(FileName, StartPoint + 1, EndPoint - 1)
        If FileName = Material.MapTexture  Then Call VBGLAdd(ReturnArr, LoadedTextures(i))
        If FileName = Material.MapAmbient  Then Call VBGLAdd(ReturnArr, LoadedTextures(i))
        If FileName = Material.MapDiffuse  Then Call VBGLAdd(ReturnArr, LoadedTextures(i))
        If FileName = Material.MapSpecular Then Call VBGLAdd(ReturnArr, LoadedTextures(i))
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
                Call VBGLTexture.Create(FilePath, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, Empty)
            Case "obj"
                Call ObjectLoader.Load(FilePath)
            Case "mtl"
                Call MaterialLoader.Load(FilePath)
                Call VBGLMerge(p_Materials, MaterialLoader.Materials)
            Case Else
                Call CurrentContext.ErrorHandler.Handle(CurrentContext.ErrorHandler.IS_ERROR, std_Error.Create("VBGLModel", "middle", "", "Invalid FileFormat of File VAR0", FilePath))
        End Select
    Loop
End Sub

Private Sub GetTexturesFromMaterial()
    Dim i As Long
    For i = 0 To USize(p_Materials)
        If p_Materials(i).MapTexture  <> Empty Then
            If Loader.AddIf(p_Materials(i).MapTexture) = -1 Then
                Call VBGLTexture.Create(p_Materials(i).MapTexture, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, Empty)
            End If
        End If
        If p_Materials(i).MapAmbient  <> Empty Then
            If Loader.AddIf(p_Materials(i).MapAmbient) = -1 Then
                Call VBGLTexture.Create(p_Materials(i).MapAmbient, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, Empty)
            End If
        End If
        If p_Materials(i).MapDiffuse  <> Empty Then
            If Loader.AddIf(p_Materials(i).MapDiffuse) = -1 Then
                Call VBGLTexture.Create(p_Materials(i).MapDiffuse, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, Empty)
            End If
        End If
        If p_Materials(i).MapSpecular <> Empty Then
            If Loader.AddIf(p_Materials(i).MapSpecular) = -1 Then
                Call VBGLTexture.Create(p_Materials(i).MapSpecular, GL_RGBA, GL_RGBA, GL_NEAREST, GL_NEAREST, GL_REPEAT, GL_REPEAT, Empty)
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
    Dim Uni As New VBGLShaderElementCollection
    Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniformOut, "mat4", "Model", "*"))
    Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniformOut, "mat4", "View", "*"))
    Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniformOut, "mat4", "Projection", "*"))
    Call Uni.Add(Nothing)

    Dim i As Long
    For i = 0 To USize(Materials)
        If p_Materials(i).Name = SubGroup.Material Then
            Dim Color()  As Single
            Dim Size As Long

            Color  = p_Materials(i).ColorAmbient
            Size = USize(Color) + 1
            If Size <> 0 Then
                Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniform, "vec" & Size, "AmbientColor", "*"))
                Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniform, "float"     , "AmbientFactor", "*"))
            End If

            Color  = p_Materials(i).ColorDiffuse
            Size = USize(Color) + 1
            If Size <> 0 Then
                Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniform, "vec3"     , "LightPosition", "*"))
                Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniform, "vec" & Size, "DiffuseColor", "*"))
            End If

            Color = p_Materials(i).ColorSpecular
            Size = USize(Color) + 1
            If Size <> 0 Then
                Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniform, "vec" & Size, "SpecularColor", "*"))
                Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniform, "float"     , "SpecularFactor", "*"))
                Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniform, "float"    , "Shininess", "*"))
                Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniform, "vec3"     , "ViewPosition", "*"))
            End If 

            Dim Counter As Long
            Counter = 0
            If p_Materials(i).MapTexture  <> Empty Then Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniformOut, "sampler2D", "TextureDiffuse" & Counter, "*")): Counter = Counter + 1
            If p_Materials(i).MapAmbient  <> Empty Then Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniformOut, "sampler2D", "TextureDiffuse" & Counter, "*")): Counter = Counter + 1
            If p_Materials(i).MapDiffuse  <> Empty Then Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniformOut, "sampler2D", "TextureDiffuse" & Counter, "*")): Counter = Counter + 1
            If p_Materials(i).MapSpecular <> Empty Then Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniformOut, "sampler2D", "TextureDiffuse" & Counter, "*")): Counter = Counter + 1
            Call Uni.Add(VBGLShaderVariable.CreateElement(VBGLShaderStateUniform, "vec3"     , "LightColor", "*"))
        End If
    Next i

    Call Template.SetUp(SubGroup.Layout, Uni)
    Dim Code As String
    Code = Template.GetShader()
    Debug.Print Code
    Set GetShader = VBGLShader.CreateFromText(Code)
End Function