VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLTexture"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private p_ID             As Long
Private p_Data           As VBGLData
Private p_Name           As String
Private p_UniformName    As String
Private p_SubTextures()  As VBGLSubTexture

Private p_Width          As Long
Private p_Height         As Long
Private p_BPP            As Long
Private p_GLTextureMin   As Long
Private p_GLTextureMag   As Long
Private p_GLTextureWrapS As Long
Private p_GLTextureWrapT As Long
Private p_InternalFormat As Long
Private p_Format         As Long


' Instance
Public Property Let ID(ByVal n_ID                   As Long)          :    Let p_ID          = n_ID          : End Property
Public Property Let Data(ByVal n_Data               As VBGLData)      :    Set p_Data        = n_Data        : End Property
Public Property Let Name(ByVal n_Name               As String)        :    Let p_Name        = n_Name        : End Property
Public Property Let UniformName(ByVal n_UniformName As String)        :    Let p_UniformName = n_UniformName : End Property
Public Property Let SubTextures(ByVal n_SubTextures As Variant)       :    Let p_SubTextures = n_SubTextures : End Property

Public Property Get ID()                            As Long           :    Let ID            = p_ID          : End Property
Public Property Get Data()                          As VBGLData       :    Set Data          = p_Data        : End Property
Public Property Get Name()                          As String         :    Let Name          = p_Name        : End Property
Public Property Get UniformName()                          As String         :    Let UniformName   = p_UniformName : End Property
Public Property Get SubTextures()                   As Variant        :    Let SubTextures   = p_SubTextures : End Property

Public Property Get SubTexture(ByVal Index As Long) As VBGLSubTexture
    Set SubTexture = p_SubTextures(Index)
End Property
Public Property Get SubTextureID(ByVal n_Identifier As String) As VBGLSubTexture
    Dim i As Long
    For i = 0 To USize(p_SubTextures)
        If SubTexture(i).Identifier = n_Identifier Then
            Set SubTextureID = SubTexture(i)
            Exit Function
        End If
    Next i
End Property



' Factory
Public Property Let Width(ByVal n_Width                   As Long) : Let p_Width          = n_Width          : End Property
Public Property Let Height(ByVal n_Height                 As Long) : Let p_Height         = n_Height         : End Property
Public Property Let BPP(ByVal n_BPP                       As Long) : Let p_BPP            = n_BPP            : End Property
Public Property Let GLTextureMin(ByVal n_GLTextureMin     As Long) : Let p_GLTextureMin   = n_GLTextureMin   : End Property
Public Property Let GLTextureMag(ByVal n_GLTextureMag     As Long) : Let p_GLTextureMag   = n_GLTextureMag   : End Property
Public Property Let GLTextureWrapS(ByVal n_GLTextureWrapS As Long) : Let p_GLTextureWrapS = n_GLTextureWrapS : End Property
Public Property Let GLTextureWrapT(ByVal n_GLTextureWrapT As Long) : Let p_GLTextureWrapT = n_GLTextureWrapT : End Property
Public Property Let InternalFormat(ByVal n_InternalFormat As Long) : Let p_InternalFormat = n_InternalFormat : End Property
Public Property Let Format(ByVal n_Format                 As Long) : Let p_Format         = n_Format         : End Property

Public Property Get Width()                               As Long  : Let Width            = p_Width          : End Property
Public Property Get Height()                              As Long  : Let Height           = p_Height         : End Property
Public Property Get BPP()                                 As Long  : Let BPP              = p_BPP            : End Property
Public Property Get GLTextureMin()                        As Long  : Let GLTextureMin     = p_GLTextureMin   : End Property
Public Property Get GLTextureMag()                        As Long  : Let GLTextureMag     = p_GLTextureMag   : End Property
Public Property Get GLTextureWrapS()                      As Long  : Let GLTextureWrapS   = p_GLTextureWrapS : End Property
Public Property Get GLTextureWrapT()                      As Long  : Let GLTextureWrapT   = p_GLTextureWrapT : End Property
Public Property Get InternalFormat()                      As Long  : Let InternalFormat   = p_InternalFormat : End Property
Public Property Get Format()                              As Long  : Let Format           = p_Format         : End Property


Public Function Create(ByVal Path As String, Optional ByVal n_Name As String = Empty, Optional ByVal n_UniformName As String = Empty) As VBGLTexture
    Dim Image       As stdImage
    Dim ColorData() As Long
    Set Image = stdImage.CreateFromFile(Path)
    Let ColorData = Image.Colors()
    Dim NewData() As Byte
    NewData = SwapColors(ColorData, 2, 1, 0, 3) 'BGRA --> 'RGBA

    Dim n_NewData As IDataByte
    Set n_NewData = VBGLData.CreateByte(NewData)
    Height = Image.Height
    Width  = Image.Width
    BPP    = Image.BitsPixel / 8
    Set Create = CreateFromData(n_NewData, n_Name, n_UniformName)
End Function

Public Function CreateFromData(ByVal n_Data As VBGLData, Optional ByVal n_Name As String = Empty, Optional ByVal n_UniformName As String = Empty) As VBGLTexture
    Dim Found As VBGLTexture
    Set Found = Find(n_Data)
    If IsSomething(Found) Then
        Set CreateFromData = Found
        Exit Function
    End If

    Set CreateFromData = Factory()
    With CreateFromData
        .Data        = n_Data
        .Name        = n_Name
        .UniformName = n_UniformName

        Dim TempID As Long
        Call glGenTextures(1, TempID)
        .ID = TempID
        Call .Bind()
        Call glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GLTextureMin)
        Call glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GLTextureMag)
        Call glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GLTextureWrapS)
        Call glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GLTextureWrapT)
        Dim TempData() As Byte
        TempData = .Data.Data
        If USize(TempData, 2) <> -1 Then
            Call glTexImage2D(GL_TEXTURE_2D, 0, InternalFormat, Width, Height, 0, Format, GL_UNSIGNED_BYTE, TempData(0, 0))
        Else
            Call glTexImage2D(GL_TEXTURE_2D, 0, InternalFormat, Width, Height, 0, Format, GL_UNSIGNED_BYTE, TempData(0))
        End If
    End With
    Call VBGLAdd(LoadedTextures, CreateFromData)
End Function

Public Function Factory() As VBGLTexture
    Set Factory = New VBGLTexture
    With Factory
        .Width          = Width
        .Height         = Height
        .BPP            = BPP
        .GLTextureMin   = GLTextureMin
        .GLTextureMag   = GLTextureMag
        .GLTextureWrapS = GLTextureWrapS
        .GLTextureWrapT = GLTextureWrapT
        .InternalFormat = InternalFormat
        .Format         = Format
    End With
End Function

Public Sub Activate(ByVal Index As Long)
    Call glActiveTexture(GL_TEXTURE0 + Index)
End Sub

Public Sub Bind()
    CurrentContext.CurrentTexture2D = Me
End Sub

Public Sub Unbind()
    CurrentContext.CurrentTexture2D = Nothing
End Sub

'For Caching
Private Function Find(ByVal n_Data As VBGLData) As VBGLTexture
    Dim i As Long
    Dim j As Long
    For i = 0 To USize(LoadedTextures)
        Dim Arr1() As Byte: Arr1 = LoadedTextures(i).Data.ByteData
        Dim Arr2() As Byte: Arr2 = n_Data.ByteData
        If USize(Arr1) = USize(Arr2) Then
            For j = 0 To USize(Arr1)
                If Arr1(j) <> Arr2(j) Then
                    Exit Function
                End If
            Next j
            Set Find = LoadedTextures(i)
            Exit Function
        End If
    Next i
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

Private Sub Class_Initialize()
    InternalFormat  = GL_RGBA
    Format          = GL_RGBA
    GLTextureMin    = GL_LINEAR
    GLTextureMag    = GL_LINEAR
    GLTextureWrapS  = GL_CLAMP_TO_EDGE
    GLTextureWrapT  = GL_CLAMP_TO_EDGE
End Sub

Private Sub Class_Terminate()
    Call glDeleteTextures(1, ID)
    CurrentContext.CurrentTexture2D = Nothing
End Sub