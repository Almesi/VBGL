VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLTextureManager"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private p_Merger    As VBGLITextureMerger
Private p_MaxHeight As Long
Private p_MaxWidth  As Long

Private ToLoad() As VBGLTextureManagerHelper

Public Property Let Merger(ByVal    n_Merger    As VBGLITextureMerger) : Set p_Merger   = n_Merger    : End Property
Public Property Let MaxHeight(ByVal n_MaxHeight As Long)               : Let p_MaxHeight= n_MaxHeight : End Property
Public Property Let MaxWidth(ByVal  n_MaxWidth  As Long)               : Let p_MaxWidth = n_MaxWidth  : End Property

Public Property Get Merger()                    As VBGLITextureMerger  : Set Merger     = p_Merger    : End Property
Public Property Get MaxHeight()                 As Long                : Let MaxHeight  = p_MaxHeight : End Property
Public Property Get MaxWidth()                  As Long                : Let MaxWidth   = p_MaxWidth  : End Property

Public Function Create(ByVal n_Merger As VBGLITextureMerger, ByVal n_MaxHeight As Long, ByVal n_MaxWidth As Long) As VBGLTextureManager
    Set Create = New VBGLTextureManager
    With Create
        .Merger    = n_Merger
        .MaxWidth  = n_MaxWidth
        .MaxHeight = n_MaxHeight
    End With
End Function

Public Function CreateTexture(ByVal Factory As VBGLTexture, ByVal Name As String, Optional ByVal UniformName As String = Empty, Optional ByVal Flip As Boolean = False) As VBGLTexture
    Dim Result()          As VBGLTextureManagerHelper : Let Result            = ToLoad
    Dim Data()            As Byte                     : Let Data              = Merger.Merge(Result, MaxHeight, MaxWidth)
    Dim SubTextures()     As VBGLSubTexture           : Let SubTextures       = CreateSubTextures(Factory, Result)

    Set CreateTexture = Factory.CreateFromData(FlipData(Data, Flip), Name, UniformName)
    CreateTexture.SubTextures = SubTextures
End Function

Public Function LoadFromFolder(ByVal FolderPath As String, ByVal Recursive As Boolean, ByVal Count As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ParamArray Names() As Variant) As Boolean
    Dim Size As Long
    Size = Ubound(Names)
    Dim nNames() As String
    If Size <> -1 Then
        ReDim nNames(Size)
        Dim i As Long
        For i = 0 To Size
            nNames(i) = CStr(Names(i))
        Next i
    End If
    LoadFromFolder = LoadFromFolderArr(FolderPath, Recursive, Count, SetUp, Names)
End Function

Public Function LoadFromFolderArr(ByVal FolderPath As String, ByVal Recursive As Boolean, ByVal Count As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ByRef Names() As String) As Boolean
    Dim File As Object
    For Each File In Folder.Files
        If USize(Names) = 0 Then
          LoadFromFolderArr = LoadFromFile(File.Path, Count, SetUp, File.Name)
        Else
          LoadFromFolderArr = LoadFromFileArr(File.Path, Count, SetUp, Names)
        End If
    Next
    If Recursive Then
        Dim SubFolder As Object
        For Each SubFolder In Folder.SubFolders
            LoadFromFolderArr = LoadFromFolderArr(SubFolder, Ignore)
        Next
    End If
End Function

Public Function LoadFromFile(ByVal FilePath As String, ByVal Count As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ParamArray Names() As Variant) As Boolean
    Dim Size As Long
    Size = Ubound(Names)
    Dim nNames() As String
    If Size <> -1 Then
        ReDim nNames(Size)
        Dim i As Long
        For i = 0 To Size
            nNames(i) = CStr(Names(i))
        Next i
    End If
    LoadFromFile = LoadFromFileArr(FilePath, Count, SetUp, nNames)
End Function

Public Function LoadFromFileArr(ByVal FilePath As String, ByVal Count As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ByRef Names() As String) As Boolean
    Dim Image       As stdImage : Set Image     = stdImage.CreateFromFile(FilePath)
    Dim ColorData() As Long     : Let ColorData = Image.Colors()
    Dim NewData()   As Byte     : Let NewData   = SwapColors(ColorData, 2, 1, 0, 3) 'BGRA --> 'RGBA

    Call AddHelper(NewData, Image.Height, Image.Width, Count, SetUp, Names)
End Function

' Data as 2D Array
Public Function LoadFromData(ByRef Data() As Byte, ByVal Count As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ParamArray Names() As Variant) As Boolean
    Dim Size As Long
    Size = Ubound(Names)
    Dim nNames() As String
    If Size <> -1 Then
        ReDim nNames(Size)
        Dim i As Long
        For i = 0 To Size
            nNames(i) = CStr(Names(i))
        Next i
    End If
    LoadFromData = LoadFromDataArr(Data, Count, SetUp, nNames)
End Function

Public Function LoadFromDataArr(ByRef Data() As Byte, ByVal Count As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ByRef Names() As String) As Boolean
    Call AddHelper(Data, USize(Data, 1) + 1, USize(Data, 2) + 1, Count, SetUp, Names)
End Function




Private Sub AddHelper(ByRef Data() As Byte, ByVal Height As Long, ByVal Width As Long, ByVal Count As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ByRef Names() As String)
    Dim NewHelper As VBGLTextureManagerHelper
    Set NewHelper = New VBGLTextureManagerHelper
    With NewHelper
        .Count  = Count
        .SetUp  = SetUp
        .Height = Height
        .Width  = Width
        Call .LetData(Data)
        Call .LetNames(Names)
    End With
    Call VBGLAdd(ToLoad, NewHelper)
End Sub

Private Function CreateSubTextures(ByVal TextureFactory As VBGLTexture, ByRef Helpers() As VBGLTextureManagerHelper) As VBGLSubTexture()
    Dim Size         As Long   : Size = USize(Helpers)
    Dim Identifier() As String : ReDim Identifier(Size)
    Dim X1()         As Long   : ReDim X1(Size)
    Dim Y1()         As Long   : ReDim Y1(Size)
    Dim X2()         As Long   : ReDim X2(Size)
    Dim Y2()         As Long   : ReDim Y2(Size)

    Dim i As Long
    For i = 0 To Size
        Identifier(i) = Helpers(i).Identifier
        X1(i)         = Helpers(i).X
        Y1(i)         = Helpers(i).Y
        X2(i)         = Helpers(i).X + Helpers(i).Width
        Y2(i)         = Helpers(i).Y + Helpers(i).Height
    Next i
    Dim SubTextureFactory As VBGLSubTexture
    Set SubTextureFactory = VBGLSubTexture.CreateFactory(TextureFactory.Width, TextureFactory.Height, False)

    CreateSubTextures = SubTextureFactory.CreateFromArray(Identifier, X1, Y1, X2, Y2)
End Function

Private Function SwapColors(ByRef Arr() As Long, ParamArray Order() As Variant) As Byte()
    Dim NewSize     As Long: NewSize = (Ubound(Arr, 1) * Ubound(Arr, 2) * 4) - 1
    Dim OrderSize   As Long: OrderSize = UBound(Order)
    Dim ReturnArr() As Byte: ReDim ReturnArr(NewSize)
    Dim Temp()      As Long: ReDim Temp(OrderSize)
    Call CopyMemory(ReturnArr(0), VarPtr(Arr(1, 1)), NewSize)

    Dim i As Long, j As Long

    For i = 0 To NewSize Step +(OrderSize + 1)
        For j = 0 To OrderSize
            Temp(j) = ReturnArr(i + Order(j))
        Next j
        For j = 0 To OrderSize
            ReturnArr(i + j) = Temp(j)
        Next j
    Next i
    SwapColors = ReturnArr
End Function

Private Function FlipData(ByRef Arr() As Byte, ByVal Flip As Boolean) As IDataByte
    Dim ReturnArr() As Byte
    Dim y As Long
    Dim x As Long

    If Flip Then
        ReDim ReturnArr(MaxWidth - 1, MaxHeight - 1)
    Else
        ReDim ReturnArr(MaxHeight - 1, MaxWidth - 1)
    End If
    For y = 0 To MaxHeight - 1
        For x = 0 To MaxWidth - 1
            If Flip Then
                ReturnArr(x, y) = Arr(y, x)
            Else
                ReturnArr(y, x) = Arr(y, x)
            End If
        Next x
    Next y
    Set FlipData = VBGLData.CreateByte(ReturnArr)
End Function