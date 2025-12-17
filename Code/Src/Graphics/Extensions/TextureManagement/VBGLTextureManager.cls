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

Private p_Merger        As VBGLITextureMerger
Private p_MaxHeight     As Long
Private p_MaxWidth      As Long
Private p_MaxByteHeight As Long
Private p_MaxByteWidth  As Long
Private p_Flip          As Boolean
Private p_Transpose     As Boolean
Private p_PreName       As String


Private ToLoad() As VBGLTextureManagerHelper

Public Property Let Merger(ByVal        n_Merger        As VBGLITextureMerger) : Set p_Merger        = n_Merger        : End Property
Public Property Let MaxHeight(ByVal     n_MaxHeight     As Long)               : Let p_MaxHeight     = n_MaxHeight     : End Property
Public Property Let MaxWidth(ByVal      n_MaxWidth      As Long)               : Let p_MaxWidth      = n_MaxWidth      : End Property
Public Property Let MaxByteHeight(ByVal n_MaxByteHeight As Long)               : Let p_MaxByteHeight = n_MaxByteHeight : End Property
Public Property Let MaxByteWidth(ByVal  n_MaxByteWidth  As Long)               : Let p_MaxByteWidth  = n_MaxByteWidth  : End Property
Public Property Let Flip(ByVal          n_Flip          As Boolean)            : Let p_Flip          = n_Flip          : End Property
Public Property Let Transpose(ByVal     n_Transpose     As Boolean)            : Let p_Transpose     = n_Transpose     : End Property
Public Property Let PreName(ByVal       n_PreName       As String)             : Let p_PreName       = n_PreName       : End Property

Public Property Get Merger()                            As VBGLITextureMerger  : Set Merger          = p_Merger        : End Property
Public Property Get MaxHeight()                         As Long                : Let MaxHeight       = p_MaxHeight     : End Property
Public Property Get MaxWidth()                          As Long                : Let MaxWidth        = p_MaxWidth      : End Property
Public Property Get MaxByteHeight()                     As Long                : Let MaxByteHeight   = p_MaxByteHeight : End Property
Public Property Get MaxByteWidth()                      As Long                : Let MaxByteWidth    = p_MaxByteWidth  : End Property
Public Property Get Flip()                              As Boolean             : Let Flip            = p_Flip          : End Property
Public Property Get Transpose()                         As Boolean             : Let Transpose       = p_Transpose     : End Property
Public Property Get PreName()                           As String              : Let PreName         = p_PreName       : End Property


Public Function Create(ByVal n_Merger As VBGLITextureMerger, Optional ByVal n_MaxHeight As Long = 0, Optional ByVal n_MaxWidth As Long = 0, Optional ByVal n_MaxByteHeight As Long = 0, Optional ByVal n_MaxByteWidth As Long = 0) As VBGLTextureManager
    Set Create = New VBGLTextureManager
    With Create
        .Merger    = n_Merger
        .MaxWidth  = n_MaxWidth
        .MaxHeight = n_MaxHeight
        .MaxByteWidth  = n_MaxByteWidth
        .MaxByteHeight = n_MaxByteHeight
    End With
End Function

Public Function CreateTexture(ByVal Factory As VBGLTexture, ByVal Name As String, Optional ByVal UniformName As String = Empty) As VBGLTexture
    Dim NewMaxHeight      As Long                     : Let NewMaxHeight      = MaxHeight
    Dim NewMaxWidth       As Long                     : Let NewMaxWidth       = MaxWidth
    Dim Result()          As VBGLTextureManagerHelper : Let Result            = ToLoad
    Dim Data()            As Byte                     : Let Data              = Merger.Merge(Result, Factory.BPP, NewMaxHeight, NewMaxWidth)

    MaxHeight     = NewMaxHeight
    MaxWidth      = NewMaxWidth
    Dim SubTextures()     As VBGLSubTexture           : Let SubTextures       = CreateSubTextures(Factory, Result)
    Dim ProcessedData() As Byte
    ProcessedData = Data
    If Flip      Then ProcessedData = FlipData(ProcessedData)
    If Transpose Then ProcessedData = TransposeData(ProcessedData)
    Set CreateTexture = Factory.CreateFromData(VBGLData.CreateByte(ProcessedData), Name, UniformName)
    CreateTexture.SubTextures = SubTextures
End Function

Public Function LoadFromFolder(ByVal FolderPath As String, ByVal Recursive As Boolean, ByVal RowCount As Long, ByVal ColumnCount As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ParamArray Names() As Variant) As Boolean
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
    LoadFromFolder = LoadFromFolderArr(FolderPath, Recursive, RowCount, ColumnCount, SetUp, nNames)
End Function

Public Function LoadFromFolderArr(ByVal FolderPath As String, ByVal Recursive As Boolean, ByVal RowCount As Long, ByVal ColumnCount As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ByRef Names() As String) As Boolean
    Dim File As Object
    Dim fso    As Object : Set fso    = CreateObject("Scripting.FileSystemObject")
    Dim Folder As Object : Set Folder = fso.GetFolder(FolderPath)
    For Each File In Folder.Files
        If USize(Names) = 0 Then
          LoadFromFolderArr = LoadFromFile(File.Path, RowCount, ColumnCount, SetUp, File.Name)
        Else
          LoadFromFolderArr = LoadFromFileArr(File.Path, RowCount, ColumnCount, SetUp, Names)
        End If
    Next
    If Recursive Then
        Dim SubFolder As Object
        For Each SubFolder In Folder.SubFolders
            LoadFromFolderArr = LoadFromFolderArr(SubFolder.Path, Recursive, RowCount, ColumnCount, SetUp, Names)
        Next
    End If
End Function

Public Function LoadFromFile(ByVal FilePath As String, ByVal RowCount As Long, ByVal ColumnCount As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ParamArray Names() As Variant) As Boolean
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
    LoadFromFile = LoadFromFileArr(FilePath, RowCount, ColumnCount, SetUp, nNames)
End Function

Public Function LoadFromFileArr(ByVal FilePath As String, ByVal RowCount As Long, ByVal ColumnCount As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ByRef Names() As String) As Boolean
    Dim Image       As stdImage : Set Image     = stdImage.CreateFromFile(FilePath)
    Dim ColorData() As Long     : Let ColorData = Image.Colors()
    Dim NewData()   As Byte     : Let NewData   = SwapColors(ColorData, 2, 1, 0, 3) 'BGRA --> 'RGBA
    PreName = VBGLMidP(FilePath, InStrRev(FilePath, "\") + 1, InStr(1, FilePath, ".") - 1)
    Call AddHelper(NewData, Image.Height, Image.Width, RowCount, ColumnCount, SetUp, Names)
End Function

' Data as 2D Array
Public Function LoadFromData(ByRef Data() As Byte, ByVal RowCount As Long, ByVal ColumnCount As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ParamArray Names() As Variant) As Boolean
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
    LoadFromData = LoadFromDataArr(Data, RowCount, ColumnCount, SetUp, nNames)
End Function

Public Function LoadFromDataArr(ByRef Data() As Byte, ByVal RowCount As Long, ByVal ColumnCount As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ByRef Names() As String) As Boolean
    Call AddHelper(Data, USize(Data, 1) + 1, USize(Data, 2) + 1, RowCount, ColumnCount, SetUp, Names)
End Function

' Sorting
' Assumes USize(PreNames) * USize(SubNames) = USize(Subs)
Public Sub SortByArrayFamily(ByVal Texture As VBGLTexture, ByRef PreNames() As String, ByRef SubNames() As String)
    Dim Subs() As VBGLSubTexture
    Subs = Texture.SubTextures

    Dim Count As Long: Count = UBound(Subs)
    Dim i As Long, j As Long

    Dim FamilySize As Long
    FamilySize = USize(SubNames) + 1

    ' Helper arrays for parsed names and ranking
    Dim PreIdx() As Long, SubIdx() As Long, Rank() As Long
    ReDim PreIdx(Count)
    ReDim SubIdx(Count)
    ReDim Rank(Count)

    ' Parse prename + subname
    For i = 0 To Count
        Dim Name As String
        Name = Subs(i).Identifier
        PreIdx(i) = GetPrefixIndex(Name, PreNames)
        SubIdx(i) = GetSuffixIndex(PreNames(PreIdx(i)), Name, SubNames)
        Rank(i)   = PreIdx(i) * FamilySize + SubIdx(i)
    Next i

    Dim Temp As VBGLSubTexture
    Dim TempR As Long

    Dim Result() As VBGLSubTexture
    ReDim Result(Count)
    For i = 0 To Count
        Set Result(Rank(i)) = Subs(i)
    Next i

    ' Assign sorted list back
    Texture.SubTextures = Result
End Sub



Private Function GetPrefixIndex(ByVal Name As String, ByRef PreNames() As String) As Long
    Dim i As Long
    For i = 0 To UBound(PreNames)
        If Mid(Name, 1, Len(PreNames(i))) = PreNames(i) Then
            GetPrefixIndex = i
            Exit Function
        End If
    Next i
    GetPrefixIndex = -1
End Function

Private Function GetSuffixIndex(ByVal PreName As String, ByVal Name As String, ByRef SubNames() As String) As Long
    Dim i As Long

    Dim Search As String
    Search = Replace(Name, PreName, Empty)
    For i = 0 To UBound(SubNames)
        If SubNames(i) = Search Then
            GetSuffixIndex = i
            Exit Function
        End If
    Next i
    GetSuffixIndex = -1
End Function

Private Sub AddHelper(ByRef Data() As Byte, ByVal Height As Long, ByVal Width As Long, ByVal RowCount As Long, ByVal ColumnCount As Long, ByVal SetUp As VBGLTextureManagerHelperSetUp, ByRef Names() As String)
    Dim NewHelper As VBGLTextureManagerHelper
    Set NewHelper = New VBGLTextureManagerHelper
    With NewHelper
        .RowCount     = RowCount
        .ColumnCount  = ColumnCount
        .SetUp        = SetUp
        .Height       = Height
        .Width        = Width
        .ByteHeight   = USize(Data, 1) + 1
        .ByteWidth    = USize(Data, 2) + 1
        .PreName      = PreName
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
        With Helpers(i)
            Identifier(i) = .Identifier
            If .Width <> 0 Then
                X1(i)         = (.X / (.ByteWidth  / .Width))
                Y1(i)         = (.Y / (.ByteHeight / .Height))
                X2(i)         = (.X / (.ByteWidth  / .Width))  + .Width
                Y2(i)         = (.Y / (.ByteHeight / .Height)) + .Height
            End If
        End With
    Next i
    If TextureFactory.Height = 0 Then TextureFactory.Height = MaxHeight
    If TextureFactory.Width  = 0 Then TextureFactory.Width  = MaxWidth

    Dim SubTextureFactory As VBGLSubTexture
    Set SubTextureFactory = VBGLSubTexture.CreateFactory(TextureFactory.Width, TextureFactory.Height, False)

    CreateSubTextures = SubTextureFactory.CreateFromArray(Identifier, X1, Y1, X2, Y2)
End Function

Private Function SwapColors(ByRef Arr() As Long, ParamArray Order() As Variant) As Byte()
    Dim SizeY       As Long: SizeY   = Ubound(Arr, 1)
    Dim SizeX       As Long: SizeX   = Ubound(Arr, 2)
    Dim OrderSize   As Long: OrderSize = UBound(Order)
    Dim Temp()      As Long: ReDim Temp(OrderSize)
    Dim NewSize     As Long: NewSize = SizeY * SizeX * 4
    Dim ReturnArr() As Byte: ReDim ReturnArr(SizeY * 4 - 1, SizeX - 1)
    Call CopyMemory(ReturnArr(0, 0), VarPtr(Arr(1, 1)), NewSize)

    Dim y As Long, x As Long, i As Long
    Dim Offset As Long
    For y = 0 To SizeY - 1
        For x = 0 To SizeX - 1
            Offset = y * (OrderSize + 1)
            For i = 0 To OrderSize
                Temp(i) = ReturnArr(Offset + Order(i), x)
            Next i
            For i = 0 To OrderSize
                ReturnArr(Offset + i, x) = Temp(i)
            Next i
        Next x
    Next y
    
    SwapColors = FlipData(TransposeData(ReturnArr))
End Function

Private Function TransposeData(ByRef Arr() As Byte) As Byte()
    Dim ReturnArr() As Byte
    Dim y As Long
    Dim x As Long
    Dim MaxY As Long
    Dim MaxX As Long

    MaxY = USize(Arr, 1)
    MaxX = USize(Arr, 2)
    ReDim ReturnArr(MaxX, MaxY)
    For y = 0 To MaxY
        For x = 0 To MaxX
            ReturnArr(x, y) = Arr(y, x)
        Next x
    Next y
    TransposeData = ReturnArr
End Function

Private Function FlipData(ByRef Arr() As Byte) As Byte()
    Dim UpperX As Long
    Dim UpperY As Long
    Dim X As Long
    Dim Y As Long
    Dim ResultArr() As Byte
    
    UpperX = USize(Arr, 2)
    UpperY = USize(Arr, 1)
    
    ReDim ResultArr(UpperY, UpperX)
    
    For Y = 0 To UpperY
        For X = 0 To UpperX
            ResultArr(UpperY - Y, X) = Arr(Y, X)
        Next X
    Next Y
    
    FlipData = ResultArr
End Function

Private Function SwitchXY(ByRef Arr() As Byte) As Byte()
    Dim ReturnArr() As Byte
    Dim y As Long
    Dim x As Long
    Dim MaxY As Long
    Dim MaxX As Long

    MaxY = USize(Arr, 1)
    MaxX = USize(Arr, 2)
    ReDim ReturnArr(MaxX, MaxY)
    For y = 0 To MaxY
        For x = 0 To MaxX
            ReturnArr(x, y) = Arr(y, x)
        Next x
    Next y
    SwitchXY = ReturnArr
End Function