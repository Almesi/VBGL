Attribute VB_Name = "FreeTypeDeclaration"


Option Explicit


' =========================================
' Basic aliased scalar types
' =========================================
' Using Long (32-bit signed) for FT_Int/FT_Short/FT_UShort/FT_UInt/FT_Pos/FT_Fixed in params/structs,
' and LongPtr for pointers/handles.
' This matches typical Win64 calling conventions for VBA.
'
' NOTE: FT_Fixed and FT_Pos are 32-bit in FreeType; VBA Long is 32-bit, which fits.

' =========================================
' Opaque pointer "handles"
' =========================================


 ' Opaque handle wrapper for clarity (not used in API)
#If VBA7 Then
    Public Type FT_Library:    p As LongPtr: End Type
    Public Type FT_Module:     p As LongPtr: End Type
    Public Type FT_Driver:     p As LongPtr: End Type
    Public Type FT_Renderer:   p As LongPtr: End Type
    Public Type FT_Face:       p As LongPtr: End Type
    Public Type FT_Size:       p As LongPtr: End Type
    Public Type FT_GlyphSlot:  p As LongPtr: End Type
    Public Type FT_CharMap:    p As LongPtr: End Type
#End If

' =========================================
' Public value structs (used in parameters)
' =========================================

Public Type FT_Generic
    data As LongPtr
    finalizer As LongPtr ' pointer to function
End Type

Public Type FT_Vector
    x As Long
    y As Long
End Type

Public Type FT_BBox
    xMin As Long
    yMin As Long
    xMax As Long
    yMax As Long
End Type

Public Type FT_Matrix
    xx As Long
    xy As Long
    yx As Long
    yy As Long
End Type

Public Type FT_UnitVector
    x As Long
    y As Long
End Type

Public Type FT_FaceRec
    num_faces As Long
    face_index As Long
    face_flags As Long
    style_flags As Long
    num_glyphs As Long
    
    family_name As LongPtr ' char*
    style_name As LongPtr  ' char*
    
    num_fixed_sizes As Long
    available_sizes As LongPtr ' FT_Bitmap_Size*
    
    num_charmaps As Long
    charmaps As LongPtr ' FT_CharMap*
    
    generic_data As FT_Generic
    
    bbox As FT_BBox
    units_per_EM As Integer
    ascender As Integer
    descender As Integer
    height As Integer
    
    max_advance_width As Integer
    max_advance_height As Integer
    underline_position As Integer
    underline_thickness As Integer
    
    glyph As LongPtr ' FT_GlyphSlot
    size As LongPtr ' FT_Size
    charmap As LongPtr ' FT_CharMap
End Type

Public Type FT_Glyph_Metrics
    width As Long
    height As Long
    horiBearingX As Long
    horiBearingY As Long
    horiAdvance As Long
    vertBearingX As Long
    vertBearingY As Long
    vertAdvance As Long
End Type

Public Type FT_Bitmap
    rows As Long
    width As Long
    pitch As Long
    buffer As LongPtr
    num_grays As Integer
    pixel_mode As Byte
    palette_mode As Byte
    palette As LongPtr
End Type

Public Type FT_GlyphSlotRec
    library As LongPtr  ' FT_Library
    face As LongPtr     ' FT_Face
    next As LongPtr     ' FT_GlyphSlot
    reserved As Long
    generic As FT_Generic
    
    metrics As FT_Glyph_Metrics
    linearHoriAdvance As Long
    linearVertAdvance As Long
    advance As FT_Vector
    
    format As Long
    bitmap As FT_Bitmap
    bitmap_left As Long
    bitmap_top As Long
    
    outline As LongPtr  ' FT_Outline
    num_subglyphs As Long
    subglyphs As LongPtr
    
    control_data As LongPtr
    control_len As Long
    
    other As LongPtr
    lsb_delta As Long
    rsb_delta As Long
End Type

Public Type FT_CharMapRec
    face As LongPtr ' FT_Face
    encoding As Long
    platform_id As Integer
    encoding_id As Integer
End Type

Public Type FT_Size_Metrics
    x_ppem      As Integer ' FT_UShort
    y_ppem      As Integer ' FT_UShort
    x_scale     As Long    ' FT_Fixed
    y_scale     As Long    ' FT_Fixed
    ascender    As Long    ' FT_Pos
    descender   As Long    ' FT_Pos
    height      As Long    ' FT_Pos
    max_advance As Long    ' FT_Pos
End Type

Public Type FT_SizeRec
    face    As LongPtr ' FT_Face
    generic As FT_Generic
    metrics As FT_Size_Metrics
End Type

Public Type FT_Bitmap_Size
    height As Integer
    width  As Integer
    size   As Long
    x_ppem As Long
    y_ppem As Long
End Type

Public Enum FT_Size_Request_Type
    FT_SIZE_REQUEST_TYPE_NOMINAL  = 0
    FT_SIZE_REQUEST_TYPE_REAL_DIM = 1
    FT_SIZE_REQUEST_TYPE_BBOX     = 2
    FT_SIZE_REQUEST_TYPE_CELL     = 3
    FT_SIZE_REQUEST_TYPE_SCALES   = 4
    FT_SIZE_REQUEST_TYPE_MAX      = 5
End Enum

Public Type FT_Size_RequestRec
    reqType        As Long           ' FT_Size_Request_Type
    width          As Long           ' 26.6 or 1/64th units per header usage
    height         As Long
    horiResolution As Long            ' FT_UInt
    vertResolution As Long            ' FT_UInt
End Type

' FT_Parameter (used by FT_Open_Args)
Public Type FT_Parameter
    tag  As Long       ' FT_ULong
    data As LongPtr    ' FT_Pointer (generic pointer)
End Type

' FT_Open_Args
Public Type FT_Open_Args
    flags        As Long    ' FT_UInt
    memory_base  As LongPtr ' const FT_Byte*
    memory_size  As Long    ' FT_Long
    pathname     As LongPtr ' FT_String* (use StrPtr on Unicode strings)
    stream       As LongPtr ' FT_Stream (opaque)
    driver       As LongPtr ' FT_Module
    num_params   As Long    ' FT_Int
    params       As LongPtr ' FT_Parameter* (use VarPtr(params(0)))
End Type

' =========================================
' Encodings (resolved FT_ENC_TAG values)
' =========================================
' Computed as (a<<24)|(b<<16)|(c<<8)|d with ASCII bytes
Public Const FT_ENCODING_NONE           As Long = 0
Public Const FT_ENCODING_MS_SYMBOL      As Long = 1937337698 ' 'symb'
Public Const FT_ENCODING_UNICODE        As Long = 1970170211 ' 'unic'
Public Const FT_ENCODING_SJIS           As Long = 1936353651 ' 'sjis'
Public Const FT_ENCODING_PRC            As Long = 1734484000 ' 'gb  '
Public Const FT_ENCODING_BIG5           As Long = 1651074869 ' 'big5'
Public Const FT_ENCODING_WANSUNG        As Long = 2002873971 ' 'wans'
Public Const FT_ENCODING_JOHAB          As Long = 1785686113 ' 'joha'
Public Const FT_ENCODING_ADOBE_STANDARD As Long = 1094995778 ' 'ADOB'
Public Const FT_ENCODING_ADOBE_EXPERT   As Long = 1094992453 ' 'ADBE'
Public Const FT_ENCODING_ADOBE_CUSTOM   As Long = 1094992451 ' 'ADBC'
Public Const FT_ENCODING_ADOBE_LATIN_1  As Long = 1818326065 ' 'lat1'
Public Const FT_ENCODING_OLD_LATIN_2    As Long = 1818326066 ' 'lat2'
Public Const FT_ENCODING_APPLE_ROMAN    As Long = 1634889070 ' 'armn'

Public Const FT_ENCODING_GB2312         As Long = FT_ENCODING_PRC
Public Const FT_ENCODING_MS_SJIS        As Long = FT_ENCODING_SJIS
Public Const FT_ENCODING_MS_GB2312      As Long = FT_ENCODING_PRC
Public Const FT_ENCODING_MS_BIG5        As Long = FT_ENCODING_BIG5
Public Const FT_ENCODING_MS_WANSUNG     As Long = FT_ENCODING_WANSUNG
Public Const FT_ENCODING_MS_JOHAB       As Long = FT_ENCODING_JOHAB

' Compatibility aliases
'Public Const ft_encoding_none           As Long = FT_ENCODING_NONE
'Public Const ft_encoding_unicode        As Long = FT_ENCODING_UNICODE
'Public Const ft_encoding_symbol         As Long = FT_ENCODING_MS_SYMBOL
'Public Const ft_encoding_latin_1        As Long = FT_ENCODING_ADOBE_LATIN_1
'Public Const ft_encoding_latin_2        As Long = FT_ENCODING_OLD_LATIN_2
'Public Const ft_encoding_sjis           As Long = FT_ENCODING_SJIS
'Public Const ft_encoding_gb2312         As Long = FT_ENCODING_PRC
'Public Const ft_encoding_big5           As Long = FT_ENCODING_BIG5
'Public Const ft_encoding_wansung        As Long = FT_ENCODING_WANSUNG
'Public Const ft_encoding_johab          As Long = FT_ENCODING_JOHAB
'Public Const ft_encoding_adobe_standard As Long = FT_ENCODING_ADOBE_STANDARD
'Public Const ft_encoding_adobe_expert   As Long = FT_ENCODING_ADOBE_EXPERT
'Public Const ft_encoding_adobe_custom   As Long = FT_ENCODING_ADOBE_CUSTOM
'Public Const ft_encoding_apple_roman    As Long = FT_ENCODING_APPLE_ROMAN

' =========================================
' FT_Face flags
' =========================================
Public Const FT_FACE_FLAG_SCALABLE         As Long = &H1
Public Const FT_FACE_FLAG_FIXED_SIZES      As Long = &H2
Public Const FT_FACE_FLAG_FIXED_WIDTH      As Long = &H4
Public Const FT_FACE_FLAG_SFNT             As Long = &H8
Public Const FT_FACE_FLAG_HORIZONTAL       As Long = &H10
Public Const FT_FACE_FLAG_VERTICAL         As Long = &H20
Public Const FT_FACE_FLAG_KERNING          As Long = &H40
Public Const FT_FACE_FLAG_FAST_GLYPHS      As Long = &H80
Public Const FT_FACE_FLAG_MULTIPLE_MASTERS As Long = &H100
Public Const FT_FACE_FLAG_GLYPH_NAMES      As Long = &H200
Public Const FT_FACE_FLAG_EXTERNAL_STREAM  As Long = &H400
Public Const FT_FACE_FLAG_HINTER           As Long = &H800
Public Const FT_FACE_FLAG_CID_KEYED        As Long = &H1000
Public Const FT_FACE_FLAG_TRICKY           As Long = &H2000
Public Const FT_FACE_FLAG_COLOR            As Long = &H4000
Public Const FT_FACE_FLAG_VARIATION        As Long = &H8000
Public Const FT_FACE_FLAG_SVG              As Long = &H10000
Public Const FT_FACE_FLAG_SBIX             As Long = &H20000
Public Const FT_FACE_FLAG_SBIX_OVERLAY     As Long = &H40000

' Style flags
Public Const FT_STYLE_FLAG_ITALIC As Long = (1)
Public Const FT_STYLE_FLAG_BOLD   As Long = (2)

' =========================================
' FT_Open_Args flags
' =========================================
Public Const FT_OPEN_MEMORY   As Long = &H1
Public Const FT_OPEN_STREAM   As Long = &H2
Public Const FT_OPEN_PATHNAME As Long = &H4
Public Const FT_OPEN_DRIVER   As Long = &H8
Public Const FT_OPEN_PARAMS   As Long = &H10

' Compatibility aliases
'Public Const ft_open_memory   As Long = FT_OPEN_MEMORY
'Public Const ft_open_stream   As Long = FT_OPEN_STREAM
'Public Const ft_open_pathname As Long = FT_OPEN_PATHNAME
'Public Const ft_open_driver   As Long = FT_OPEN_DRIVER
'Public Const ft_open_params   As Long = FT_OPEN_PARAMS

' =========================================
' FT_Load flags
' =========================================
Public Const FT_LOAD_DEFAULT                     As Long = &H0
Public Const FT_LOAD_NO_SCALE                    As Long = (&H1)
Public Const FT_LOAD_NO_HINTING                  As Long = (&H2)
Public Const FT_LOAD_RENDER                      As Long = (&H4)
Public Const FT_LOAD_NO_BITMAP                   As Long = (&H8)
Public Const FT_LOAD_VERTICAL_LAYOUT             As Long = (&H10)
Public Const FT_LOAD_FORCE_AUTOHINT              As Long = (&H20)
Public Const FT_LOAD_CROP_BITMAP                 As Long = (&H40)
Public Const FT_LOAD_PEDANTIC                    As Long = (&H80)
Public Const FT_LOAD_ADVANCE_ONLY                As Long = (&H100)
Public Const FT_LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH As Long = (&H200)
Public Const FT_LOAD_NO_RECURSE                  As Long = (&H400)
Public Const FT_LOAD_IGNORE_TRANSFORM            As Long = (&H800)
Public Const FT_LOAD_MONOCHROME                  As Long = (&H1000)
Public Const FT_LOAD_LINEAR_DESIGN               As Long = (&H2000)
Public Const FT_LOAD_SBITS_ONLY                  As Long = (&H4000)
Public Const FT_LOAD_NO_AUTOHINT                 As Long = (&H8000)
Public Const FT_LOAD_COLOR                       As Long = (&H100000)
Public Const FT_LOAD_COMPUTE_METRICS             As Long = (&H200000)
Public Const FT_LOAD_BITMAP_METRICS_ONLY         As Long = (&H400000)
Public Const FT_LOAD_SVG_ONLY                    As Long = (&H800000)
Public Const FT_LOAD_NO_SVG                      As Long = (&H1000000)

' Target render mode encoding (upper bits macro FT_LOAD_TARGET_)
Public Const FT_LOAD_TARGET_NORMAL               As Long = (&H0)           ' uses current raster target
Public Const FT_LOAD_TARGET_LIGHT                As Long = (&H10000)
Public Const FT_LOAD_TARGET_MONO                 As Long = (&H20000)
Public Const FT_LOAD_TARGET_LCD                  As Long = (&H30000)
Public Const FT_LOAD_TARGET_LCD_V                As Long = (&H40000)

' =========================================
' Render modes (FT_Render_Mode)
' =========================================
Public Enum FT_Render_Mode
    FT_RENDER_MODE_NORMAL = 0
    FT_RENDER_MODE_LIGHT  = 1
    FT_RENDER_MODE_MONO   = 2
    FT_RENDER_MODE_LCD    = 3
    FT_RENDER_MODE_LCD_V  = 4
    FT_RENDER_MODE_SDF    = 5
    FT_RENDER_MODE_MAX    = 6
End Enum

'Public Const ft_render_mode_normal As Long = FT_RENDER_MODE_NORMAL
'Public Const ft_render_mode_mono   As Long = FT_RENDER_MODE_MONO

' =========================================
' Kerning modes (FT_Kerning_Mode)
' =========================================
Public Enum FT_Kerning_Mode
    FT_KERNING_DEFAULT  = 0
    FT_KERNING_UNFITTED = 1
    FT_KERNING_UNSCALED = 2
End Enum

'Public Const ft_kerning_default  As Long = FT_KERNING_DEFAULT
'Public Const ft_kerning_unfitted As Long = FT_KERNING_UNFITTED
'Public Const ft_kerning_unscaled As Long = FT_KERNING_UNSCALED

' =========================================
' Subglyph flags
' =========================================
Public Const FT_SUBGLYPH_FLAG_ARGS_ARE_WORDS     As Long = &H1
Public Const FT_SUBGLYPH_FLAG_ARGS_ARE_XY_VALUES As Long = &H2
Public Const FT_SUBGLYPH_FLAG_ROUND_XY_TO_GRID   As Long = &H4
Public Const FT_SUBGLYPH_FLAG_SCALE              As Long = &H8
Public Const FT_SUBGLYPH_FLAG_XY_SCALE           As Long = &H40
Public Const FT_SUBGLYPH_FLAG_2X2                As Long = &H80
Public Const FT_SUBGLYPH_FLAG_USE_MY_METRICS     As Long = &H200

' =========================================
' FsType flags
' =========================================
Public Const FT_FSTYPE_INSTALLABLE_EMBEDDING        As Long = &H0
Public Const FT_FSTYPE_RESTRICTED_LICENSE_EMBEDDING As Long = &H2
Public Const FT_FSTYPE_PREVIEW_AND_PRINT_EMBEDDING  As Long = &H4
Public Const FT_FSTYPE_EDITABLE_EMBEDDING           As Long = &H8
Public Const FT_FSTYPE_NO_SUBSETTING                As Long = &H100
Public Const FT_FSTYPE_BITMAP_EMBEDDING_ONLY        As Long = &H200

' =========================================
' Version constants
' =========================================
Public Const FREETYPE_MAJOR As Long = 2
Public Const FREETYPE_MINOR As Long = 13
Public Const FREETYPE_PATCH As Long = 3

' =========================================
' Function declarations
' =========================================
#If VBA7 Then
    ' Library lifecycle
    Public Declare PtrSafe Function FT_Init_FreeType                Lib "freetype64.dll" (ByRef alibrary  As LongPtr) As Long
    Public Declare PtrSafe Function FT_Done_FreeType                Lib "freetype64.dll" (ByVal library   As LongPtr) As Long
    Public Declare PtrSafe Function FT_Reference_Face               Lib "freetype64.dll" (ByVal face      As LongPtr) As Long
    Public Declare PtrSafe Function FT_Done_Face                    Lib "freetype64.dll" (ByVal face      As LongPtr) As Long
    Public Declare PtrSafe Function FT_Get_Charmap_Index            Lib "freetype64.dll" (ByVal charmap   As LongPtr) As Long
    Public Declare PtrSafe Function FT_Face_CheckTrueTypePatents    Lib "freetype64.dll" (ByVal face      As LongPtr) As Long
    Public Declare PtrSafe Function FT_FloorFix                     Lib "freetype64.dll" (ByVal a         As Long)    As Long
    Public Declare PtrSafe Function FT_RoundFix                     Lib "freetype64.dll" (ByVal a         As Long)    As Long
    Public Declare PtrSafe Function FT_CeilFix                      Lib "freetype64.dll" (ByVal a         As Long)    As Long
    Public Declare PtrSafe Function FT_Get_Postscript_Name          Lib "freetype64.dll" (ByVal face      As LongPtr) As LongPtr
    Public Declare PtrSafe Function FT_Face_GetVariantSelectors     Lib "freetype64.dll" (ByVal face      As LongPtr) As LongPtr
    Public Declare PtrSafe Function FT_Get_FSType_Flags             Lib "freetype64.dll" (ByVal face      As LongPtr) As Integer
    Public Declare PtrSafe Function FT_Attach_File                  Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal filepathname      As LongPtr)             As Long
    Public Declare PtrSafe Function FT_Select_Size                  Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal strike_index      As Long)                As Long
    Public Declare PtrSafe Function FT_Attach_Stream                Lib "freetype64.dll" (ByVal face      As LongPtr   , ByRef parameters        As FT_Open_Args)        As Long
    Public Declare PtrSafe Function FT_Render_Glyph                 Lib "freetype64.dll" (ByVal slot      As LongPtr   , ByVal render_mode       As Long)                As Long
    Public Declare PtrSafe Function FT_Select_Charmap               Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal encoding          As Long)                As Long
    Public Declare PtrSafe Function FT_Get_Char_Index               Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal charcode          As Long)                As Long
    Public Declare PtrSafe Function FT_Set_Charmap                  Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal charmap           As LongPtr)             As Long
    Public Declare PtrSafe Function FT_Get_First_Char               Lib "freetype64.dll" (ByVal face      As LongPtr   , ByRef agindex           As Long)                As Long
    Public Declare PtrSafe Function FT_Get_Name_Index               Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal glyph_name        As LongPtr)             As Long
    Public Declare PtrSafe Function FT_Face_GetVariantsOfChar       Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal charcode          As Long)                As LongPtr
    Public Declare PtrSafe Function FT_Face_GetCharsOfVariant       Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal variantSelector   As Long)                As LongPtr
    Public Declare PtrSafe Function FT_MulFix                       Lib "freetype64.dll" (ByVal a         As Long      , ByVal b                 As Long)                As Long
    Public Declare PtrSafe Function FT_DivFix                       Lib "freetype64.dll" (ByVal a         As Long      , ByVal b                 As Long)                As Long
    Public Declare PtrSafe Sub      FT_Vector_Transform             Lib "freetype64.dll" (ByRef v         As FT_Vector , ByRef m                 As FT_Matrix)                          
    Public Declare PtrSafe Function FT_Face_SetUnpatentedHinting    Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal value             As Long)                As Long
    Public Declare PtrSafe Function FT_Request_Size                 Lib "freetype64.dll" (ByVal face      As LongPtr   , ByRef req               As FT_Size_RequestRec)  As Long
    Public Declare PtrSafe Function FT_Set_Pixel_Sizes              Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal pixel_width       As Long         , ByVal pixel_height    As Long)    As Long
    Public Declare PtrSafe Function FT_Load_Glyph                   Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal glyph_index       As Long         , ByVal load_flags      As Long)    As Long
    Public Declare PtrSafe Function FT_Load_Char                    Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal char_code         As Long         , ByVal load_flags      As Long)    As Long
    Public Declare PtrSafe Sub      FT_Set_Transform                Lib "freetype64.dll" (ByVal face      As LongPtr   , ByRef matrix            As FT_Matrix    , ByRef delta           As FT_Vector)
    Public Declare PtrSafe Sub      FT_Get_Transform                Lib "freetype64.dll" (ByVal face      As LongPtr   , ByRef matrix            As FT_Matrix    , ByRef delta           As FT_Vector)
    Public Declare PtrSafe Function FT_Get_Next_Char                Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal char_code         As Long         , ByRef agindex         As Long)    As Long
    Public Declare PtrSafe Function FT_Face_Properties              Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal num_properties    As Long         , ByVal properties      As LongPtr) As Long
    Public Declare PtrSafe Function FT_Face_GetCharVariantIndex     Lib "freetype64.dll" (ByRef face      As LongPtr   , ByRef charcode          As Long         , ByRef variantSelector As Long)    As Long
    Public Declare PtrSafe Function FT_Face_GetCharVariantIsDefault Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal charcode          As Long         , ByVal variantSelector As Long)    As Long
    Public Declare PtrSafe Function FT_MulDiv                       Lib "freetype64.dll" (ByVal a         As Long      , ByVal b                 As Long         , ByVal c               As Long)    As Long
    Public Declare PtrSafe Function FT_New_Face                     Lib "freetype64.dll" (ByVal library   As LongPtr   , ByVal filepathname      As LongPtr      , ByVal face_index      As Long    , ByRef aface           As LongPtr) As Long
    Public Declare PtrSafe Function FT_Open_Face                    Lib "freetype64.dll" (ByVal library   As LongPtr   , ByRef args              As FT_Open_Args , ByVal face_index      As Long    , ByRef aface           As LongPtr) As Long
    Public Declare PtrSafe Function FT_Get_Track_Kerning            Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal point_size        As Long         , ByVal degree          As Long    , ByRef akerning        As Long)    As Long
    Public Declare PtrSafe Function FT_Get_Glyph_Name               Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal glyph_index       As Long         , ByVal buffer          As LongPtr , ByVal buffer_max      As Long)    As Long
    Public Declare PtrSafe Sub      FT_Library_Version              Lib "freetype64.dll" (ByVal library   As LongPtr   , ByRef amajor            As Long         , ByRef aminor          As Long    , ByRef apatch          As Long)
    Public Declare PtrSafe Function FT_New_Memory_Face              Lib "freetype64.dll" (ByVal library   As LongPtr   , ByVal file_base         As LongPtr      , ByVal file_size       As Long    , ByVal face_index      As Long    , ByRef aface           As LongPtr)   As Long
    Public Declare PtrSafe Function FT_Get_Kerning                  Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal left_glyph        As Long         , ByVal right_glyph     As Long    , ByVal kern_mode       As Long    , ByRef akerning        As FT_Vector) As Long
    Public Declare PtrSafe Function FT_Set_Char_Size                Lib "freetype64.dll" (ByVal face      As LongPtr   , ByVal char_width        As Long         , ByVal char_height     As Long    , ByVal horz_resolution As Long    , ByVal vert_resolution As Long)      As Long
    Public Declare PtrSafe Function FT_Get_SubGlyph_Info            Lib "freetype64.dll" (ByVal glyph     As LongPtr   , ByVal sub_index         As Long         , ByRef p_index         As Long    , ByRef p_flags         As Long    , ByRef p_arg1          As Long, ByRef p_arg2 As Long, ByRef p_transform As FT_Matrix) As Long

#Else
    Public Declare Function FT_Init_FreeType                Lib "freetype.dll" (ByRef alibrary  As LongPtr) As Long
    Public Declare Function FT_Done_FreeType                Lib "freetype.dll" (ByVal library   As LongPtr) As Long
    Public Declare Function FT_Reference_Face               Lib "freetype.dll" (ByVal face      As LongPtr) As Long
    Public Declare Function FT_Done_Face                    Lib "freetype.dll" (ByVal face      As LongPtr) As Long
    Public Declare Function FT_Get_Charmap_Index            Lib "freetype.dll" (ByVal charmap   As LongPtr) As Long
    Public Declare Function FT_Face_CheckTrueTypePatents    Lib "freetype.dll" (ByVal face      As LongPtr) As Long
    Public Declare Function FT_FloorFix                     Lib "freetype.dll" (ByVal a         As Long)    As Long
    Public Declare Function FT_RoundFix                     Lib "freetype.dll" (ByVal a         As Long)    As Long
    Public Declare Function FT_CeilFix                      Lib "freetype.dll" (ByVal a         As Long)    As Long
    Public Declare Function FT_Get_Postscript_Name          Lib "freetype.dll" (ByVal face      As LongPtr) As LongPtr
    Public Declare Function FT_Face_GetVariantSelectors     Lib "freetype.dll" (ByVal face      As LongPtr) As LongPtr
    Public Declare Function FT_Get_FSType_Flags             Lib "freetype.dll" (ByVal face      As LongPtr) As Integer
    Public Declare Function FT_Attach_File                  Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal filepathname      As LongPtr)             As Long
    Public Declare Function FT_Select_Size                  Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal strike_index      As Long)                As Long
    Public Declare Function FT_Attach_Stream                Lib "freetype.dll" (ByVal face      As LongPtr   , ByRef parameters        As FT_Open_Args)        As Long
    Public Declare Function FT_Render_Glyph                 Lib "freetype.dll" (ByVal slot      As LongPtr   , ByVal render_mode       As Long)                As Long
    Public Declare Function FT_Select_Charmap               Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal encoding          As Long)                As Long
    Public Declare Function FT_Get_Char_Index               Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal charcode          As Long)                As Long
    Public Declare Function FT_Set_Charmap                  Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal charmap           As LongPtr)             As Long
    Public Declare Function FT_Get_First_Char               Lib "freetype.dll" (ByVal face      As LongPtr   , ByRef agindex           As Long)                As Long
    Public Declare Function FT_Get_Name_Index               Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal glyph_name        As LongPtr)             As Long
    Public Declare Function FT_Face_GetVariantsOfChar       Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal charcode          As Long)                As LongPtr
    Public Declare Function FT_Face_GetCharsOfVariant       Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal variantSelector   As Long)                As LongPtr
    Public Declare Function FT_MulFix                       Lib "freetype.dll" (ByVal a         As Long      , ByVal b                 As Long)                As Long
    Public Declare Function FT_DivFix                       Lib "freetype.dll" (ByVal a         As Long      , ByVal b                 As Long)                As Long
    Public Declare Sub      FT_Vector_Transform             Lib "freetype.dll" (ByRef v         As FT_Vector , ByRef m                 As FT_Matrix)                          
    Public Declare Function FT_Face_SetUnpatentedHinting    Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal value             As Long)                As Long
    Public Declare Function FT_Request_Size                 Lib "freetype.dll" (ByVal face      As LongPtr   , ByRef req               As FT_Size_RequestRec)  As Long
    Public Declare Function FT_Set_Pixel_Sizes              Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal pixel_width       As Long         , ByVal pixel_height    As Long)    As Long
    Public Declare Function FT_Load_Glyph                   Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal glyph_index       As Long         , ByVal load_flags      As Long)    As Long
    Public Declare Function FT_Load_Char                    Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal char_code         As Long         , ByVal load_flags      As Long)    As Long
    Public Declare Sub      FT_Set_Transform                Lib "freetype.dll" (ByVal face      As LongPtr   , ByRef matrix            As FT_Matrix    , ByRef delta           As FT_Vector)
    Public Declare Sub      FT_Get_Transform                Lib "freetype.dll" (ByVal face      As LongPtr   , ByRef matrix            As FT_Matrix    , ByRef delta           As FT_Vector)
    Public Declare Function FT_Get_Next_Char                Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal char_code         As Long         , ByRef agindex         As Long)    As Long
    Public Declare Function FT_Face_Properties              Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal num_properties    As Long         , ByVal properties      As LongPtr) As Long
    Public Declare Function FT_Face_GetCharVariantIndex     Lib "freetype.dll" (ByRef face      As LongPtr   , ByRef charcode          As Long         , ByRef variantSelector As Long)    As Long
    Public Declare Function FT_Face_GetCharVariantIsDefault Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal charcode          As Long         , ByVal variantSelector As Long)    As Long
    Public Declare Function FT_MulDiv                       Lib "freetype.dll" (ByVal a         As Long      , ByVal b                 As Long         , ByVal c               As Long)    As Long
    Public Declare Function FT_New_Face                     Lib "freetype.dll" (ByVal library   As LongPtr   , ByVal filepathname      As LongPtr      , ByVal face_index      As Long    , ByRef aface           As LongPtr) As Long
    Public Declare Function FT_Open_Face                    Lib "freetype.dll" (ByVal library   As LongPtr   , ByRef args              As FT_Open_Args , ByVal face_index      As Long    , ByRef aface           As LongPtr) As Long
    Public Declare Function FT_Get_Track_Kerning            Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal point_size        As Long         , ByVal degree          As Long    , ByRef akerning        As Long)    As Long
    Public Declare Function FT_Get_Glyph_Name               Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal glyph_index       As Long         , ByVal buffer          As LongPtr , ByVal buffer_max      As Long)    As Long
    Public Declare Sub      FT_Library_Version              Lib "freetype.dll" (ByVal library   As LongPtr   , ByRef amajor            As Long         , ByRef aminor          As Long    , ByRef apatch          As Long)
    Public Declare Function FT_New_Memory_Face              Lib "freetype.dll" (ByVal library   As LongPtr   , ByVal file_base         As LongPtr      , ByVal file_size       As Long    , ByVal face_index      As Long    , ByRef aface           As LongPtr)   As Long
    Public Declare Function FT_Get_Kerning                  Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal left_glyph        As Long         , ByVal right_glyph     As Long    , ByVal kern_mode       As Long    , ByRef akerning        As FT_Vector) As Long
    Public Declare Function FT_Set_Char_Size                Lib "freetype.dll" (ByVal face      As LongPtr   , ByVal char_width        As Long         , ByVal char_height     As Long    , ByVal horz_resolution As Long    , ByVal vert_resolution As Long)      As Long
    Public Declare Function FT_Get_SubGlyph_Info            Lib "freetype.dll" (ByVal glyph     As LongPtr   , ByVal sub_index         As Long         , ByRef p_index         As Long    , ByRef p_flags         As Long    , ByRef p_arg1          As Long, ByRef p_arg2 As Long, ByRef p_transform As FT_Matrix) As Long
#End If

Public Function LoadFreeType(ByVal FilePath As String) As Boolean
    Static Initialized As Boolean
    If Initialized = True Then
        LoadFreeType = True
        Exit Function
    End If
    Dim NewError As std_Error
    Set NewError = std_Error.Create("FreeTypeDeclaration", "severe", "LoadFreeType", "Could not load FreeType: VAR0", Empty, FilePath)
    #If VBA7 Then
        LoadFreeType = LoadLibrary(FilePath & "\freetype64.dll")
    #Else
        LoadFreeType = LoadLibrary(FilePath & "\freetype.dll")
    #End If
    If CurrentContext.ErrorHandler.Handle(LoadFreeType = False, NewError) Then
        Exit Function
    End If
    LoadFreeType = True
    Initialized = True
End Function