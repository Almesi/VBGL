VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "MtlParser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit


Implements IMtlLoader

Private p_Materials() As GLMaterial
Private Size          As Long
Private p_DotOrComma  As String
Private p_Loader      As GLFileLoader

Public Property Let DotOrComma(n_DotOrComma  As String)       : Let p_DotOrComma = n_DotOrComma : End Property
Public Property Let Loader(n_Loader          As GLFileLoader) : Set p_Loader     = n_Loader     : End Property

Public Property Get DotOrComma()             As String        : Let DotOrComma   = p_DotOrComma : End Property
Public Property Get Loader()                 As GLFileLoader  : Set Loader       = p_Loader     : End Property

Public Function Create(n_Loader As GLFileLoader, Optional n_DotOrComma As String = ".") As MtlParser
    Set Create = New MtlParser
    Create.Loader     = n_Loader
    Create.DotOrComma = n_DotOrComma
End Function

Private Property Let IMtlLoader_Materials(n_Materials() As GLMaterial)
    Let p_Materials = n_Materials
End Property
Private Property Get IMtlLoader_Materials() As GLMaterial()
    Let IMtlLoader_Materials = p_Materials
End Property

Private Sub IMtlLoader_Load(FilePath As String)
    Dim FSO As Object, FileStream As Object
    Dim Line As String, Parts() As String
    Dim ReturnArr() As GLMaterial
    
    Set FSO = CreateObject("Scripting.FileSystemObject")
    Set FileStream = FSO.OpenTextFile(FilePath, 1)
    
    Do Until FileStream.AtEndOfStream
        Line = Trim(FileStream.ReadLine)
        If Line = "" Or Mid(Line, 1, 1) = "#" Then GoTo NextLine
        
        If DotOrComma = "," Then
            If Line Like "*#.#*" Then Line = Replace(Line, ".", ",")
        End If
        Parts = Split(Line)
        
        Select Case LCase(Parts(0))
            Case "newmtl"
                Size = Size + 1
                ReDim Preserve ReturnArr(Size)
                Set ReturnArr(Size) = New GLMaterial
                ReturnArr(Size).Name = Parts(1)
            Case "ka"
                Dim ColorAmbient() As Single: ReDim ColorAmbient(2)
                ColorAmbient(0) = CSng(Parts(1))
                ColorAmbient(1) = CSng(Parts(2))
                ColorAmbient(2) = CSng(Parts(3))
                ReturnArr(Size).ColorAmbient = ColorAmbient
            Case "kd"
                Dim ColorDiffuse() As Single: ReDim ColorDiffuse(2)
                ColorDiffuse(0) = CSng(Parts(1))
                ColorDiffuse(1) = CSng(Parts(2))
                ColorDiffuse(2) = CSng(Parts(3))
                ReturnArr(Size).ColorDiffuse = ColorDiffuse
            Case "ks"
                Dim ColorSpecular() As Single: ReDim ColorSpecular(2)
                ColorSpecular(0) = CSng(Parts(1))
                ColorSpecular(1) = CSng(Parts(2))
                ColorSpecular(2) = CSng(Parts(3))
                ReturnArr(Size).ColorSpecular = ColorSpecular
            Case "ns"               : ReturnArr(Size).Shininess      = CSng(Parts(1))
            Case "d"                : ReturnArr(Size).Opacity        = CSng(Parts(1))
            Case "tr"               : ReturnArr(Size).Transparency   = CSng(Parts(1))
            Case "ni"               : ReturnArr(Size).OpticalDensity = CSng(Parts(1))
            Case "illum"            : ReturnArr(Size).Illumination   = CSng(Parts(1))
            Case "map_ka"           : ReturnArr(Size).MapAmbient  = GetFilePath(FilePath, Parts(1))
            Case "map_kd"           : ReturnArr(Size).MapDiffuse  = GetFilePath(FilePath, Parts(1))
            Case "map_ks"           : ReturnArr(Size).MapSpecular = GetFilePath(FilePath, Parts(1))
            Case "map_bump", "bump" : ReturnArr(Size).MapTexture  = GetFilePath(FilePath, Parts(1))
        End Select
    NextLine:
    Loop
    FileStream.Close
    IMtlLoader_Materials = ReturnArr
End Sub

' CurrentFilePath = "Dir1\Dir2\Dir3\Object.obj"
' Text1 = "Material.mtl          --> Dir1\Dir2\Dir3\Material.mtl
' Text1 = ".\.\Material.mtl      --> Dir1\Material.mtl
' Text1 = "Res\Mat\Material.mtl  --> Dir1\Dir2\Dir3\Res\Mat\Material.mtl
Private Function GetFilePath(CurrentFilePath As String, Text As String) As String
    Dim Directories() As String: Directories = Split(Text, "\")
    Dim CurrentDir()  As String: CurrentDir = Split(CurrentFilePath, "\")
    Dim ReturnDir()   As String: ReDim ReturnDir(Ubound(CurrentDir) + Ubound(Directories) + 1)

    Dim i As Long
    Dim Pointer As Long
    For i = 0 To Ubound(CurrentDir) - 1
        ReturnDir(Pointer) = CurrentDir(i)
        Pointer = Pointer + 1
    Next i
    For i = 0 To Ubound(Directories)
        If Directories(i) = "." Then
            Pointer = Pointer - 1
            ReturnDir(Pointer) = Empty
        Else
            ReturnDir(Pointer) = Directories(i)
            Pointer = Pointer + 1
        End If
    Next i
    For i = 0 To Ubound(ReturnDir) - 1
        If ReturnDir(i) = Empty Then Exit For
        GetFilePath = GetFilePath & ReturnDir(i) & "\"
    Next i
    If ReturnDir(i) = Empty Then
        GetFilePath = MidP(GetFilePath, 1, Len(GetFilePath) - 1)
    Else
        GetFilePath = GetFilePath & ReturnDir(i)
    End If
End Function

Private Function MidP(Text As String, StartPoint As Long, EndPoint As Long) As String
    MidP = Mid(Text, StartPoint, (EndPoint - StartPoint) + 1)
End Function

Private Sub Class_Initialize()
    Size = -1
End Sub