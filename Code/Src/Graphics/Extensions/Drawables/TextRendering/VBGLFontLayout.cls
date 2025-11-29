VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLFontLayout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

'Texture Object and Properties to designate Characters

Private Const PointToPixel As Long = 64

Private Type Character
    Width      As Long
    Rows       As Long
    Left       As Long
    Top        As Long
    Advance    As Long
    Character  As String
End Type

Private Dict    As Object
Private DictRev As Object

Private Characters() As Character
Private p_Name       As String
Private p_CharCount  As Long
Private p_Size       As Long
Private p_Texture    As VBGLTexture
Private p_FirstChar  As Long
Private p_MaxWidth   As Long
Private p_MaxHeight  As Long
Private p_BPP        As Long

Public Property Let Name(ByVal n_Name           As String)       : Let p_Name      = n_Name        : End Property
Public Property Let CharCount(ByVal n_CharCount As Long)         : Let p_CharCount = n_CharCount   : End Property
Public Property Let Size(ByVal n_Size           As Long)         : Let p_Size      = n_Size        : End Property
Public Property Let Texture(ByVal n_Texture     As VBGLTexture)  : Set p_Texture   = n_Texture     : End Property
Public Property Let FirstChar(ByVal n_FirstChar As Long)         : Let p_FirstChar = n_FirstChar   : End Property
Public Property Let MaxWidth(ByVal n_MaxWidth   As Long)         : Let p_MaxWidth  = n_MaxWidth    : End Property
Public Property Let MaxHeight(ByVal n_MaxHeight As Long)         : Let p_MaxHeight = n_MaxHeight   : End Property
Public Property Let BPP(ByVal n_BPP             As Long)         : Let p_BPP       = n_BPP         : End Property

Public Property Get Name()                      As String        : Let Name        = p_Name        : End Property
Public Property Get CharCount()                 As Long          : Let CharCount   = p_CharCount   : End Property
Public Property Get Size()                      As Long          : Let Size        = p_Size        : End Property
Public Property Get Texture()                   As VBGLTexture   : Set Texture     = p_Texture     : End Property
Public Property Get FirstChar()                 As Long          : Let FirstChar   = p_FirstChar   : End Property
Public Property Get MaxWidth()                  As Long          : Let MaxWidth    = p_MaxWidth    : End Property
Public Property Get MaxHeight()                 As Long          : Let MaxHeight   = p_MaxHeight   : End Property
Public Property Get BPP()                       As Long          : Let BPP         = p_BPP         : End Property

Public Function Create(ByVal LoadFilePath As String, ByVal FontFilePath As String, ByVal n_Size As Long, Optional ByVal n_Name As String = Empty) As VBGLFontLayout
    Dim Face As LongPtr
    Dim Library As LongPtr
    Call LoadFont(LoadFilePath, FontFilePath, n_Size, Library, Face)
    Set Create = New VBGLFontLayout
    If Face <> 0 Then
        Call Create.SetUp(Face, n_Name)
        With Create
            .Size = n_Size
            If .Name = Empty Then
                Dim StartPoint As Long: StartPoint = InStrRev(FontFilePath, "\")
                Dim EndPoint   As Long: EndPoint   = InStrRev(FontFilePath, ".")
                .Name = VBGLMidP(FontFilePath, StartPoint + 1, EndPoint - 1) & .Size
            End If
        End With
    End If
    If Face     <> 0 Then Call FT_Done_Face(Face)
    If Library  <> 0 Then Call FT_Done_FreeType(Library)
End Function


Public Function GetData(ByVal Text As String, ByRef FontColor() As Single, ByRef BackgroundColor() As Single, ByVal Scalee As Single, ByVal xStart As Single, ByVal yStart As Single) As Single()
    Dim i As Long
    Dim TextSize As Long
    TextSize = Len(Text)

    Dim ReturnArr() As Single
    Dim ColorSize     As Long : ColorSize = USize(FontColor) + 1
    Dim BackColorSize As Long : BackColorSize = USize(BackgroundColor) + 1
    ReDim ReturnArr(TextSize * CharacterByteSize(ColorSize + BackColorSize) - 1)

    Dim Index As Long

    Dim BaseLine As Single
    BaseLine = CalculateBaseLine

    Dim xpos     As Single
    Dim xoff     As Single
    Dim ypos     As Single
    Dim yoff     As Single

    xpos = xStart
    yPos = yStart

    Dim Normalx As Single : Normalx = CurrentContext.CurrentWindow.NormalWidth
    Dim Normaly As Single : Normaly = CurrentContext.CurrentWindow.NormalHeight

    For i = 1 To TextSize
        Dim CharIndex As Long
        Dim Char As Character
        Char = GetChar(Text, i)
        CharIndex = AscW(Mid(Text, i, 1)) - FirstChar
        If CharIndex < 0 Then
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, BackgroundColor, Index)
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, BackgroundColor, Index)
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, BackgroundColor, Index)
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, BackgroundColor, Index)
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, BackgroundColor, Index)
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, BackgroundColor, Index)
            GoTo Skip:
        End If

        
        
        xpos   = xpos   + (Char.Left * Scalee * Normalx)
        xoff   = xpos   + (Char.Width * Scalee * Normalx)
        ypos   = yStart - ((BaseLine - Char.Top) * Scalee * Normaly)
        yoff   = ypos   - (Char.Rows * Scalee * Normaly)
        'x, y, z, r, g, b, tx, ty
        With Texture.SubTexture(CharIndex)
            Call AddVertex(ReturnArr, .GetX("TopLeft")     , .GetY("TopLeft")     , xpos  , ypos , FontColor, BackgroundColor, Index)
            Call AddVertex(ReturnArr, .GetX("TopRight")    , .GetY("TopRight")    , xoff  , ypos , FontColor, BackgroundColor, Index)
            Call AddVertex(ReturnArr, .GetX("BottomLeft")  , .GetY("BottomLeft")  , xpos  , yoff , FontColor, BackgroundColor, Index)
            Call AddVertex(ReturnArr, .GetX("TopRight")    , .GetY("TopRight")    , xoff  , ypos , FontColor, BackgroundColor, Index)
            Call AddVertex(ReturnArr, .GetX("BottomRight") , .GetY("BottomRight") , xoff  , yoff , FontColor, BackgroundColor, Index)
            Call AddVertex(ReturnArr, .GetX("BottomLeft")  , .GetY("BottomLeft")  , xpos  , yoff , FontColor, BackgroundColor, Index)
        End With
        xpos = xpos + (Char.Advance * Scalee * Normalx)
        Skip:
    Next i
    GetData = ReturnArr
End Function

Private Sub LoadFont(ByVal LoadFilePath As String, ByVal FontFilePath As String, ByVal Size As Long, ByRef Library As LongPtr, ByRef Face As LongPtr)
    Dim ErrorNum  As Long
    Dim PathArr() As Byte
    Dim NewError  As std_Error

    If LoadFreeType(LoadFilePath) = False Then Exit Sub

    ErrorNum = FT_Init_FreeType(Library)
    Set NewError = std_Error.Create("FreeTypeDeclaration", "minor", "LoadFont", "Couldnt initialize FreeType VAR0", Empty, ErrorNum)
    If ErrorNum <> 0 Then
        Call CurrentContext.ErrorHandler.Raise(NewError)
        Exit Sub
    End If

    PathArr = StringToCharArray(FontFilePath)
    ErrorNum = FT_New_Face(Library, VarPtr(PathArr(0)), 0, Face)
    Set NewError = std_Error.Create("FreeTypeDeclaration", "minor", "LoadFont", "Couldnt load Face VAR0", Empty, FontFilePath)
    If ErrorNum <> 0 Then
        Call CurrentContext.ErrorHandler.Raise(NewError)
        Exit Sub
    End If

    Call FT_Set_Pixel_Sizes(Face, 0, Size)
End Sub

Public Sub SetUp(ByVal Face As LongPtr, Optional ByVal n_Name As String = Empty)
    Call GetMaxValues(Face)
    Call GetCharacters(Face, n_Name)
End Sub

Public Function CharacterByteSize(ByVal ColorSize As Long) As Long
    Dim PositionSize As Long : PositionSize = 3
    Dim TextureSize  As Long : TextureSize  = 2
    Dim VertexCount  As Long : VertexCount  = 6
    CharacterByteSize = VertexCount * (PositionSize + ColorSize + TextureSize)
End Function


Private Sub GetMaxValues(ByVal Face As LongPtr)
    Dim CharCode As Long
    Dim GlyphIndex As Long
    Dim ErrorNum As Long
    Dim BitMap   As FT_Bitmap
    Dim Glyph    As FT_GlyphSlotRec
    Dim FaceObj  As FT_FaceRec

    FirstChar = FT_Get_First_Char(Face, GlyphIndex)
    CharCode = FirstChar
    FaceObj  = GetFace(Face)
    Dim i As Long
    Do While GlyphIndex <> 0
        ErrorNum = FT_Load_Glyph(Face, GlyphIndex, FT_LOAD_RENDER)
        If CurrentContext.ErrorHandler.Handle(ErrorNum <> 0, std_Error.Create("FreeTypeDeclaration", "severe", "GetMaxValues", "failed to load glyph: VAR0 | ErrorNum: VAR1", Empty, CharCode, ErrorNum)) Then
            Exit Sub
        End If

        Call CopyMemory(Glyph , FaceObj.Glyph, Len(Glyph))
        BitMap = Glyph.BitMap

        If Glyph.Advance.X = 0 Then Exit Do

        MaxWidth = MaxWidth + BitMap.width
        If BitMap.rows  > MaxHeight Then MaxHeight = BitMap.rows
        If BitMap.Width > 0         Then BPP       = Abs(BitMap.pitch) / BitMap.Width

        CharCount = CharCount + 1
        Dict(CharCount) = CharCode
        DictRev(CharCode) = CharCount
        CharCode = FT_Get_Next_Char(Face, CharCode, GlyphIndex)
    Loop
End Sub

' Render and pack all glyphs into one big grayScale buffer
' Layout is:
'1234567890ABCDEF1234567890ABCDEF
'
'1       /\      |   |----\
'2      /  \     |   |     |
'3     /----\    |   |/---/
'4    /      \   |   |<
'5   /        \  |   |\---\
'6               |   |     |
'7               |   |----/

'That way there MIGHT be unused data in form of [A] at the bottom.
' This function builds this data like this:
' For each Character-->For each row of character-->paste Character width
Private Sub GetCharacters(ByVal Face As LongPtr, Optional ByVal n_Name As String)
    Dim ErrorNum As Long
    Dim Glyph  As FT_GlyphSlotRec
    Dim BitMap As FT_Bitmap
    Dim CharCode As Long

    ReDim Characters(CharCount)

    Dim Manager As VBGLTextureManager
    Set Manager = VBGLTextureManager.Create(VBGLTextureMergerGrid.Create(False), MaxHeight, Byte4Size)

    Dim i As Long
    For i = 0 To CharCount
        CharCode = Dict(i)
        ErrorNum = FT_Load_Char(Face, CharCode, FT_LOAD_RENDER)
        If CurrentContext.ErrorHandler.Handle(ErrorNum <> 0 , std_Error.Create("VBGLFontLayout", "severe", "GetCharacters", "failed to load glyph: VAR0 | VAR1", Empty, CharCode, ErrorNum)) Then
            Exit Sub
        End If

        Glyph = GetGlyph(Face)
        BitMap = Glyph.BitMap

        Dim Char As Character
        Char.Width      = BitMap.width
        Char.Rows       = BitMap.rows
        Char.Left       = Glyph.bitmap_left
        Char.Top        = Glyph.bitmap_top
        Char.Advance    = Glyph.Advance.x / PointToPixel
        Char.Character  = ChrW(CharCode)
        
        Characters(i)  = Char
        Dim Data() As Byte
        If BitMap.Width <> 0 Then
            Data = CopyBitMap(BitMap, True)
            Call Manager.LoadFromData(Data, 1, VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpColumn, ChrW(CharCode))
        Else
            ReDim Data(0, 0)
            Call Manager.LoadFromData(Data, 1, VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpColumn, ChrW(CharCode))
        End If
    Next i
    'Call glPixelStorei(GL_UNPACK_ALIGNMENT, 1)
    Texture = Manager.CreateTexture(TextureFactory, n_Name, "TextboxTexture", True)
End Sub

Private Function TextureFactory() As VBGLTexture
    Set TextureFactory = New VBGLTexture
    With TextureFactory
        .Width           = Byte4Size
        .Height          = MaxHeight
        .BPP             = BPP
        .InternalFormat  = GL_RED
        .Format          = GL_RED
        .GLTextureMin    = GL_LINEAR
        .GLTextureMag    = GL_LINEAR
        .GLTextureWrapS  = GL_CLAMP_TO_EDGE
        .GLTextureWrapT  = GL_CLAMP_TO_EDGE
    End With
End Function 

Private Function GetFace(ByVal Face As LongPtr) As FT_FaceRec
    Dim TempFace As FT_FaceRec
    Call CopyMemory(TempFace , Face, Len(TempFace))
    GetFace = TempFace
End Function

Private Function GetGlyph(ByVal Face As LongPtr) As FT_GlyphSlotRec
    Dim TempFace As FT_FaceRec
    Dim Glyph    As FT_GlyphSlotRec
    TempFace = GetFace(Face)
    Call CopyMemory(Glyph, TempFace.glyph , Len(Glyph))
    GetGlyph = Glyph
End Function

Private Sub Add(ByRef Arr() As Single, ByVal Value As Variant, ByRef Index As Long)
    Dim i As Long
    If IsArray(Value) Then
        For i = 0 To USize(Value)
            Arr(Index) = Value(i)
            Index = Index + 1
        Next i
    Else
        Arr(Index) = CSng(Value)
        Index = Index + 1
    End If
End Sub

Private Sub AddVertex(ByRef Arr() As Single, ByVal Tx As Single, ByVal Ty As Single, ByVal xPos As Single, ByVal yPos As Single, ByRef FontColor() As Single, ByRef BackgroundColor() As Single, ByRef Index As Long)
    Call Add(Arr, xPos, Index)
    Call Add(Arr, yPos, Index)
    Call Add(Arr, 0.0!, Index)
    Call Add(Arr, FontColor, Index)
    Call Add(Arr, BackgroundColor, Index)
    Call Add(Arr, Tx, Index)
    Call Add(Arr, Ty, Index)
End Sub

Private Function CalculateBaseLine() As Long
    Dim i As Long
    Dim MaxAscend As Long
    For i = 0 To Ubound(Characters)
        If MaxAscend < Characters(i).Top Then
            MaxAscend = Characters(i).Top
        End If
    Next i
    CalculateBaseLine = MaxAscend
End Function

Private Function Byte4Size() As Long
    Byte4Size = Int((MaxWidth + 3) / 4) * 4
End Function

Private Function GetChar(ByVal Text As String, ByVal Index As Long) As Character
    Dim CharIndex As Long
    Dim Char As Character
    CharIndex = DictRev(AscW(Mid(Text, Index, 1)))
    If CharIndex < 0 Then
        ' return an empty char structure or a dedicated missing glyph
        Dim EmptyC As Character
        EmptyC.Width = 0
        EmptyC.Rows = 0
        EmptyC.Left = 0
        EmptyC.Top = 0
        EmptyC.Advance = 0
        EmptyC.Character = "?"
        GetChar = EmptyC
    Else
        GetChar = Characters(CharIndex)
    End If
End Function

Private Function CopyBitMap(ByRef BitMap As FT_Bitmap, Optional ByVal StartTopLeft As Boolean = True) As Byte()
    Dim X As Long, Y As Long

    Dim NewSize  As Long : NewSize = BitMap.rows * Abs(BitMap.pitch)
    Dim Result() As Byte : ReDim Result(BitMap.Rows - 1, Abs(BitMap.pitch) - 1)
    Dim Temp()   As Byte : ReDim Temp(NewSize - 1)
    Call CopyMemory(Temp(0), BitMap.buffer, NewSize)
    For Y = 0 To BitMap.Rows - 1
        For X = 0 To BitMap.Width - 1
            Dim ArrY As Long, ArrX As Long
            If StartTopLeft Then
                ArrY = Y
                ArrX = X
            Else
                ArrY = BitMap.Rows - 1 - Y
                ArrX = X
            End If

            Dim DataPtr As Long
            If BitMap.Pitch > 0 Then
                DataPtr = Y * BitMap.Pitch + X
            Else
                DataPtr = (BitMap.rows - 1 - Y) * (-BitMap.pitch) + X
            End If
            Result(ArrY, ArrX) = Temp(DataPtr)
        Next X
    Next Y
    CopyBitMap = Result
End Function

Private Sub Class_Initialize()
    Set Dict    = CreateObject("Scripting.Dictionary")
    Set DictRev = CreateObject("Scripting.Dictionary")
    Call Dict.RemoveAll()
    Call DictRev.RemoveAll()
    CharCount = -1
End Sub