VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLFontLayout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


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


Public Function GetData(ByVal Text As String, ByRef FontColor() As Single, ByVal Scalee As Single, ByVal xStart As Single, ByVal yStart As Single) As Single()
    Dim i As Long
    Dim TextSize As Long
    TextSize = Len(Text)

    Dim ReturnArr() As Single
    Dim ColorSize As Long
    ColorSize = USize(FontColor) + 1
    ReDim ReturnArr(TextSize * CharacterByteSize(ColorSize) - 1)

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
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, Index)
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, Index)
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, Index)
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, Index)
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, Index)
            Call AddVertex(ReturnArr, 0 , 0 , xpos, ypos , FontColor, Index)
            GoTo Skip:
        End If

        
        
        xpos   = xpos   + (Char.Left * Scalee * Normalx)
        xoff   = xpos   + (Char.Width * Scalee * Normalx)
        ypos   = yStart - ((BaseLine - Char.Top) * Scalee * Normaly)
        yoff   = ypos   - (Char.Rows * Scalee * Normaly)
        'x, y, z, r, g, b, tx, ty
        With Texture.SubTexture(CharIndex)
            Call AddVertex(ReturnArr, .GetX("TopLeft")     , .GetY("TopLeft")     , xpos  , ypos , FontColor, Index)
            Call AddVertex(ReturnArr, .GetX("TopRight")    , .GetY("TopRight")    , xoff  , ypos , FontColor, Index)
            Call AddVertex(ReturnArr, .GetX("BottomLeft")  , .GetY("BottomLeft")  , xpos  , yoff , FontColor, Index)
            Call AddVertex(ReturnArr, .GetX("TopRight")    , .GetY("TopRight")    , xoff  , ypos , FontColor, Index)
            Call AddVertex(ReturnArr, .GetX("BottomRight") , .GetY("BottomRight") , xoff  , yoff , FontColor, Index)
            Call AddVertex(ReturnArr, .GetX("BottomLeft")  , .GetY("BottomLeft")  , xpos  , yoff , FontColor, Index)
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
        If BitMap.rows > MaxHeight Then MaxHeight = BitMap.rows
        If BitMap.Width > 0 Then
            BPP = Abs(BitMap.pitch) / BitMap.Width
        End If
        CharCount = CharCount + 1
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
    Dim GlyphIndex As Long
    Dim ErrorNum As Long
    Dim Glyph  As FT_GlyphSlotRec
    Dim BitMap As FT_Bitmap
    Dim xOffset As Long
    Dim CharCode As Long

    ReDim Characters(CharCount)

    Dim Identifiers() As String
    Dim Tx() As Long
    Dim Tx2() As Long
    Dim Ty() As Long
    Dim Ty2() As Long
    ReDim Identifiers(CharCount)
    ReDim Tx(CharCount)
    ReDim Tx2(CharCount)

    ReDim Ty(CharCount)
    ReDim Ty2(CharCount)
    
    Dim atlas() As Byte
    ReDim atlas(Byte4Size * MaxHeight - 1)

    Dim i As Long
    Dim PrevX As Long
    PrevX = -1
    For i = 0 To CharCount
        CharCode = i + FirstChar
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
        
        Tx(i) = xOffset
        If BitMap.width > 0 And BitMap.rows > 0 Then
            xOffset = CopyBitMap(atlas, BitMap, xOffset)
            Ty(i)          = 1
            Ty2(i)         = BitMap.Rows
        Else
            Ty(i)          = 0
            Ty2(i)         = 0
        End If
        Tx2(i) = xOffset
        Characters(i)  = Char
        Identifiers(i) = ChrW(CharCode)
        
    Next i

    Dim n_Data As IDataByte
    Set n_Data = VBGLData.CreateByte(atlas)

    Dim SubTextureFactory As VBGLSubTexture
    Set SubTextureFactory = VBGLSubTexture.CreateFactory(Byte4Size, MaxHeight)
    
    Dim n_Texture As VBGLTexture
    Dim TextureFactory As VBGLTexture
    Set TextureFactory = New VBGLTexture
    With TextureFactory
        .Width           = MaxWidth
        .Height          = MaxHeight
        .BPP             = BPP
        .InternalFormat  = GL_RED
        .Format          = GL_RED
        .GLTextureMin    = GL_LINEAR
        .GLTextureMag    = GL_LINEAR
        .GLTextureWrapS  = GL_CLAMP_TO_EDGE
        .GLTextureWrapT  = GL_CLAMP_TO_EDGE
    End With
    Set n_Texture = TextureFactory.CreateFromData(n_Data, n_Name)
    n_Texture.Width = Byte4Size

    Dim n_SubTextures() As VBGLSubTexture
    n_Texture.SubTextures = SubTextureFactory.CreateFromArray(Identifiers, Tx, Ty, Tx2, Ty2)

    Texture = n_Texture
End Sub

Private Function FlipData(ByRef Arr() As Byte) As Byte()
    Dim ReturnArr() As Byte
    ReDim ReturnArr(Byte4Size * MaxHeight - 1)
    Dim x As Long
    Dim y As Long
    Dim Ptr As Long
    Dim FlipPtr As Long
    For y = 0 To MaxHeight - 1
        For x = 0 To Byte4Size - 1
            Ptr     = y * Byte4Size + x
            FlipPtr = (MaxHeight - 1 - y) * Byte4Size + x
            ReturnArr(Ptr) = Arr(FlipPtr)
        Next x
    Next y
    FlipData = ReturnArr
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

Private Sub AddVertex(ByRef Arr() As Single, ByVal Tx As Single, ByVal Ty As Single, ByVal xPos As Single, ByVal yPos As Single, ByRef FontColor() As Single, ByRef Index As Long)
    Call Add(Arr, xPos, Index)
    Call Add(Arr, yPos, Index)
    Call Add(Arr, 0.0!, Index)
    Call Add(Arr, FontColor, Index)
    Call Add(Arr, Tx, Index)
    Call Add(Arr, Ty, Index)
End Sub

Private Function CopyBitMap(ByRef Arr() As Byte, BitMap As FT_Bitmap, ByVal Index As Long, Optional ByVal StartTopLeft As Boolean = True) As Long
    Dim X As Long, Y As Long
    Dim Temp() As Byte

    Dim NewSize As Long : NewSize = BitMap.rows * Abs(BitMap.pitch)
    ReDim Temp(NewSize - 1)
    Call CopyMemory(Temp(0), BitMap.buffer, NewSize)
    For Y = 0 To BitMap.Rows - 1
        For X = 0 To BitMap.Width - 1
            Dim ArrPtr  As Long
            If StartTopLeft Then
                ArrPtr = Index + ((Y * Byte4Size) + X)
            Else
                ArrPtr = Index + (((BitMap.Rows - 1 - Y) * Byte4Size) + X)
            End If
            
            Dim DataPtr As Long
            
            If BitMap.Pitch > 0 Then
                DataPtr = Y * BitMap.Pitch + X
            Else
                DataPtr = (BitMap.rows - 1 - Y) * (-BitMap.pitch) + X
            End If
            Arr(ArrPtr) = Temp(DataPtr)
            'Range("A1").Offset(Y, Index + X).Interior.Color = RGB(Arr(ArrPtr), Arr(ArrPtr), Arr(ArrPtr))
        Next X
    Next Y
    CopyBitMap = Index + BitMap.Width
End Function

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
    CharIndex = AscW(Mid(Text, Index, 1)) - FirstChar
    If CharIndex < 0 Then
        GetChar = GetChar(Text, Index - 1)
    Else
        GetChar = Characters(CharIndex)
    End If
End Function

Private Sub Class_Initialize()
    CharCount = -1
End Sub