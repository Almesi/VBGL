VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "GLFileObject"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Implements IObjLoader

Private p_Objects()      As GLObject
Private p_Count          As Long
Private p_DotOrComma     As String
Private p_Loader         As VBGLFileLoader

Public Property Let Count(n_Count            As Long)           : Let p_Count      = n_Count      : End Property
Public Property Let DotOrComma(n_DotOrComma  As String)         : Let p_DotOrComma = n_DotOrComma : End Property
Public Property Let Loader(n_Loader          As VBGLFileLoader) : Set p_Loader     = n_Loader     : End Property

Public Property Get Count()                  As Long            : Let Count        = p_Count      : End Property
Public Property Get DotOrComma()             As String          : Let DotOrComma   = p_DotOrComma : End Property
Public Property Get Loader()                 As VBGLFileLoader  : Set Loader       = p_Loader     : End Property
' 
'# Comment
'o ObjectName
'v 1, 1, 1
'mtllib Mat.mtl

' turns to:
'% = vbCrLf
'# Comment%o ObjectName%v 1, 1, 1%mtllib Mat.mtl

' This gets split into
'# Comment  [Data2]
'           [Name2]
'v 1, 1, 1  [Data1]
'ObjectName [Name1]

'Seperate workflow
'mtllib Mat.mtl
Public Function Create(n_Loader As VBGLFileLoader, Optional n_DotOrComma As String = ".") As GLFileObject
    Set Create = New GLFileObject
    With Create
        .DotOrComma     = n_DotOrComma
        .Loader         = n_Loader
    End With
End Function

Private Function IObjLoader_Groups() As GLGroup()
    Dim Arr() As GLGroup

    Dim i As Long, j As Long
    Dim Index As Long

    For i = 0 To Count
        ReDim Preserve Arr(USize(Arr) + (p_Objects(i).Count + 1))
        For j = 0 To p_Objects(i).Count
            Set Arr(Index) = p_Objects(i).Groups()(j)
            Index = Index + 1
        Next j
    Next i
    IObjLoader_Groups = Arr
End Function

Private Property Let IObjLoader_Objects(n_Objects() As GLObject)
    Let p_Objects = n_Objects
End Property
Private Property Get IObjLoader_Objects() As GLObject()
    Let IObjLoader_Objects = p_Objects
End Property

Public Property Let IObjLoader_Object(Index As Long, n_Object As GLObject)
    Set p_Objects(Index) = n_Object
End Property
Public Property Get IObjLoader_Object(Index As Long) As GLObject
    Set IObjLoader_Object = p_Objects(Index)
End Property

Private Sub IObjLoader_Load(FilePath As String)
    Dim LoadedText As String: LoadedText = DeleteEmptyLines(DeleteComments(LoadText(FilePath)))
    Dim ObjData As String
    If DotOrComma <> "." Then
        LoadedText = Replace(LoadedText, ".mtl", "}mtl")
        LoadedText = Replace(LoadedText, ".", DotOrComma)
        LoadedText = Replace(LoadedText, "}mtl", ".mtl")
    End If
    LoadedText = GetMaterialData(FilePath, LoadedText)
    ObjData = GetObjectData(LoadedText)
    If ObjData <> Empty Then Call Add(Empty, ObjData)
End Sub

Private Function GetMaterialData(CurrentFilePath As String, Text As String) As String
    Dim EndName As Long
    Dim Name As String
    Dim Pointer As Long: Pointer = 1
    GetMaterialData = Text
    Do 
        Pointer = InStr(1, GetMaterialData, "mtllib ")
        If Pointer = 0 Then Exit Do
        EndName = InStr(Pointer, GetMaterialData, vbCrLf)
        If EndName = 0 Then EndName = Len(GetMaterialData) + 1
        Name = VBGLMidP(GetMaterialData, Pointer + Len("mtllib "), EndName - 1)
        Call Loader.AddIf(GetFilePath(CurrentFilePath, Name))
        GetMaterialData = VBGLMidP(GetMaterialData, 1, Pointer - 1) & VBGLMidP(GetMaterialData, EndName + 2, Len(GetMaterialData))
    Loop
End Function

Private Function GetObjectData(ByVal Text As String) As String
    Dim Name As String
    Dim Data As String
    Dim EndName As Long

    Dim ObjIndex As Long: ObjIndex = InStr(1, Text, "o ")
    If ObjIndex > 0 Then
        GetObjectData = VBGLMidP(Text, 1, ObjIndex - 1)
        EndName = InStr(ObjIndex, Text, vbCrLf)
        If EndName = 0 Then EndName = Len(Text)
        Name = VBGLMidP(Text, ObjIndex + Len("o "), EndName - 1)
        Data = GetObjectData(VBGLMidP(Text, EndName + 2, Len(Text)))
        Call Add(Name, Data)
    Else
        GetObjectData = Text
    End If
End Function

Private Function LoadText(FilePath As String) As String 
    Dim FSO As Object
    Dim File As Object
    Set FSO = CreateObject("Scripting.FileSystemObject")
    Set File = FSO.OpenTextFile(FilePath)
    LoadText = File.ReadAll
    File.Close
End Function

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
        GetFilePath = VBGLMidP(GetFilePath, 1, Len(GetFilePath) - 1)
    Else
        GetFilePath = GetFilePath & ReturnDir(i)
    End If
End Function

Private Function DeleteComments(Text As String) As String
    Dim StartPoint As Long
    Dim EndPoint As Long

    StartPoint = 1
    DeleteComments = Text
    Do
        StartPoint = InStr(StartPoint, DeleteComments, "#")
        If StartPoint = 0 Then Exit Function
        EndPoint = Instr(StartPoint, DeleteComments, vbCrLf)
        If EndPoint = 0 Then
            DeleteComments = VBGLMidP(DeleteComments, 1, StartPoint - 1)
            Exit Function
        End If
        DeleteComments = VBGLMidP(DeleteComments, 1, StartPoint - 1) & VBGLMidP(DeleteComments, EndPoint + 2, Len(DeleteComments))
    Loop
End Function

Private Function DeleteEmptyLines(Text As String) As String
    Dim Search As String: Search = vbCrLf & vbCrLf

    Dim StartPoint As Long
    Dim i As Long
    DeleteEmptyLines = Text
    Do
        StartPoint = InStr(1, DeleteEmptyLines, Search)
        If StartPoint = 0 Then Exit Do
        Do Until Mid(Text, StartPoint + i, Len(Search)) <> Search
            i = i + 2
        Loop
        DeleteEmptyLines = VBGLMidP(DeleteEmptyLines, 1, StartPoint - 1) & VBGLMidP(DeleteEmptyLines, StartPoint + i, Len(Text))
    Loop
End Function

Private Sub Add(Name As String, Data As String)
    Dim NewObject As GLObject
    Set NewObject = GLObject.Create(Name, Data)
    If IsNothing(NewObject) Then Exit Sub
    Count = Count + 1
    ReDim Preserve p_Objects(Count)
    Set p_Objects(Count) = NewObject
End Sub

Private Sub Class_Initialize()
    Count = -1
End Sub