VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLTexture"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private Declare PtrSafe Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (ByRef Destination As Any, ByVal Source As Any, ByVal Length As Long)

Private p_Context  As VBGLContext
Private p_ID       As Long
Private p_FilePath As String
Private p_Data()   As Byte
Private p_Width    As Long
Private p_Height   As Long
Private p_BPP      As Long
Private p_Typee    As String

Public Property Let Context(n_Context        As VBGLContext):    Set p_Context  = n_Context     : End Property
Public Property Let ID(n_ID                  As Long)       :    Let p_ID       = n_ID          : End Property
Public Property Let FilePath(n_FilePath      As String)     :    Let p_FilePath = n_FilePath    : End Property
Public Property Let Data(n_Data()            As Byte)       :    Let p_Data     = n_Data        : End Property
Public Property Let Width(n_Width            As Long)       :    Let p_Width    = n_Width       : End Property
Public Property Let Height(n_Height          As Long)       :    Let p_Height   = n_Height      : End Property
Public Property Let BPP(n_BPP                As Long)       :    Let p_BPP      = n_BPP         : End Property
Public Property Let Typee(n_Typee            As String)     :    Let p_Typee    = n_Typee       : End Property

Public Property Get Context()                As VBGLContext :    Set Context    = p_Context     : End Property
Public Property Get ID()                     As Long        :    Let ID         = p_ID          : End Property
Public Property Get FilePath()               As String      :    Let FilePath   = p_FilePath    : End Property
Public Property Get Data()                   As Byte()      :    Let Data       = p_Data        : End Property
Public Property Get Width()                  As Long        :    Let Width      = p_Width       : End Property
Public Property Get Height()                 As Long        :    Let Height     = p_Height      : End Property
Public Property Get BPP()                    As Long        :    Let BPP        = p_BPP         : End Property
Public Property Get Typee()                  As String      :    Let Typee      = p_Typee       : End Property

Public Property Get Pointer() As LongPtr
    Pointer = VarPtr(p_Data(0))
End Property


Public Function Create(Path As String, InternalFormat As Long, Format As Long, GLTextureMin As Long, GLTextureMag As Long, GLTextureWrapS As Long, GLTextureWrapT As Long, n_Type As String) As VBGLTexture
    Set Create = New VBGLTexture
    With Create
        Dim Image       As stdImage : Set Image     = stdImage.CreateFromFile(Path)
        Dim ColorData() As Long     :     ColorData = Image.Colors()

        Dim NewData() As Byte
        NewData = SwapColors(ColorData, 2, 1, 0, 3) 'BGRA --> 'RGBA
        .Data     = NewData
        .Width    = Image.Width
        .Height   = Image.Height
        .BPP      = Image.BitsPixel / 8 '8 Bits per Byte
        .FilePath = Path
        .Typee    = n_Type

        Dim TempID As Long
        Call glGenTextures(1, TempID)
        .ID = TempID
        Call .Bind()
        Call glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GLTextureMin)
        Call glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GLTextureMag)
        Call glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GLTextureWrapS)
        Call glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GLTextureWrapT)
        Call glTexImage2D(GL_TEXTURE_2D, 0, InternalFormat, .Width, .Height, 0, Format, GL_UNSIGNED_BYTE, NewData(0))
    End With
End Function

Public Function SwapColors(Arr() As Long, ParamArray Order() As Variant) As Byte()
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

Public Sub Activate(Index As Long)
    Call glActiveTexture(GL_TEXTURE0 + Index)
End Sub

Public Sub Bind()
    Context.CurrentTexture2D = ID
End Sub

Public Sub Unbind()
    Context.CurrentTexture2D = 0
End Sub

Private Sub Class_Initialize()
    Context = VBGLContext
End Sub

Private Sub Class_Terminate()
    Call glDeleteTextures(1, ID)
    Context.CurrentTexture2D = 0
End Sub