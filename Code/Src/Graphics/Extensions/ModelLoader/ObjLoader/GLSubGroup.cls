VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "GLSubGroup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

'Everything inside a GLGroup seperated by smoothing or material difference

Private p_Material   As String
Private p_Smoothing  As String
Private p_Vertices   As VBGLVertex
Private p_Textures   As VBGLVertex
Private p_Normals    As VBGLVertex
Private p_Colors     As VBGLVertex
Private p_Faces      As VBGLFace
Private p_Layout     As VBGLLayout

Public Property Let Material(ByVal n_Material   As String)      : Let p_Material  = n_Material  : End Property
Public Property Let Smoothing(ByVal n_Smoothing As String)      : Let p_Smoothing = n_Smoothing : End Property
Public Property Let Vertices(ByVal n_Vertices   As VBGLVertex)  : Set p_Vertices  = n_Vertices  : End Property
Public Property Let Textures(ByVal n_Textures   As VBGLVertex)  : Set p_Textures  = n_Textures  : End Property
Public Property Let Normals(ByVal n_Normals     As VBGLVertex)  : Set p_Normals   = n_Normals   : End Property
Public Property Let Colors(ByVal n_Colors       As VBGLVertex)  : Set p_Colors    = n_Colors    : End Property
Public Property Let Faces(ByVal n_Faces         As VBGLFace)    : Set p_Faces     = n_Faces     : End Property
Public Property Let Layout(ByVal n_Layout       As VBGLLayout)  : Set p_Layout    = n_Layout    : End Property

Public Property Get Material()                  As String       : Let Material    = p_Material  : End Property
Public Property Get Smoothing()                 As String       : Let Smoothing   = p_Smoothing : End Property
Public Property Get Vertices()                  As VBGLVertex   : Set Vertices    = p_Vertices  : End Property
Public Property Get Textures()                  As VBGLVertex   : Set Textures    = p_Textures  : End Property
Public Property Get Normals()                   As VBGLVertex   : Set Normals     = p_Normals   : End Property
Public Property Get Colors()                    As VBGLVertex   : Set Colors      = p_Colors    : End Property
Public Property Get Faces()                     As VBGLFace     : Set Faces       = p_Faces     : End Property
Public Property Get Layout()                    As VBGLLayout   : Set Layout      = p_Layout    : End Property

Public Function Create(ByVal n_Material As String, ByVal n_Smoothing As String, ByVal GroupData As String) As GLSubGroup
    Set Create = New GLSubGroup
    Dim Data As String
    With Create
        .Material  = n_Material
        .Smoothing = n_Smoothing
        .Vertices  = GetVertices("v " , GroupData)
        .Textures  = GetVertices("vt ", GroupData)
        .Normals   = GetVertices("vn ", GroupData)
        .Colors    = GetVertices("vc ", GroupData)
        .Layout    = GetLayout(GroupData, .Vertices, .Textures, .Normals, .Colors)
        .Faces     = GetFaces(.Layout, GroupData)
        If IsNothing(.Vertices) And IsNothing(.Textures) And IsNothing(.Normals) And IsNothing(.Colors) And IsNothing(.Faces) Then
            Set Create = Nothing
        End If
    End With
End Function

Public Function ByteData() As IDataByte
    Dim NewSize As Long: NewSize = Faces.Count * Layout.ByteSize()
    Dim ReturnArr()   As Byte: ReDim ReturnArr(NewSize - 1)

    Dim ArrV()  As Byte: If IsSomething(Vertices) Then ArrV = Vertices.Data.ByteData
    Dim ArrT()  As Byte: If IsSomething(Textures) Then ArrT = Textures.Data.ByteData
    Dim ArrN()  As Byte: If IsSomething(Normals)  Then ArrN = Normals.Data.ByteData
    Dim ArrC()  As Byte: If IsSomething(Colors)   Then ArrC = Colors.Data.ByteData

    Dim ArrVB   As Long: If IsSomething(Vertices) Then ArrVB = Vertices.Element.ByteSize
    Dim ArrTB   As Long: If IsSomething(Textures) Then ArrTB = Textures.Element.ByteSize
    Dim ArrNB   As Long: If IsSomething(Normals)  Then ArrNB = Normals.Element.ByteSize
    Dim ArrCB   As Long: If IsSomething(Colors)   Then ArrCB = Colors.Element.ByteSize

    Dim ArrVF() As Long: If IsSomething(Vertices) Then ArrVF = Faces.Vertex()
    Dim ArrTF() As Long: If IsSomething(Textures) Then ArrTF = Faces.Texture()
    Dim ArrNF() As Long: If IsSomething(Normals)  Then ArrNF = Faces.Normal()
    Dim ArrCF() As Long: If IsSomething(Colors)   Then ArrCF = Faces.Color()

    Dim ByteSize As Long

    Dim i As Long, j As Long
    For i = 0 To Faces.Count - 1
        For j = 0 To Layout.Size

            Dim Index As Long
            Dim Length As Long
            Dim Offset As Long
            Dim Pointer As LongPtr
            Select Case True
                Case Layout.Element(j).Category = "Position"
                    Length = ArrVB
                    Index = (ArrVF(i)) * Length
                    Pointer = VarPtr(ArrV(Index))
                Case Layout.Element(j).Category = "Texture"
                    Length = ArrTB
                    Index = (ArrTF(i)) * Length
                    Pointer = VarPtr(ArrT(Index))
                Case Layout.Element(j).Category = "Normal"
                    Length = ArrNB
                    Index = (ArrNF(i)) * Length
                    Pointer = VarPtr(ArrN(Index))
                Case Layout.Element(j).Category = "Color"
                    Length = ArrCB
                    Index = (ArrCF(i)) * Length
                    Pointer = VarPtr(ArrC(Index))
            End Select
            Call CopyMemory(ReturnArr(Offset), Pointer, Length)
            Offset = Offset + Length
        Next j
    Next i
    Set ByteData = VBGLData.CreateByte(ReturnArr)
End Function

Private Function GetVertices(ByVal SearchFor As String, ByVal Data As String) As VBGLVertex
    Dim SearchData  As String  : SearchData = GetDataArea(SearchFor, Data)
    If SearchData = Empty Then Exit Function
    Dim Size        As Long    : Size = GetSize(SearchFor, SearchData)
    Dim Arr()       As String  : Arr = Split(Replace(SearchData, SearchFor, " "), " ")
    Set GetVertices = VBGLVertex.CreateFromStringArray(VBGLLayout.GetEnum(GetWhat(SearchFor), Size), Arr)
End Function

Private Function GetLayout(ByVal Data As String, ByVal Vertex As VBGLVertex, ByVal Texture As VBGLVertex, ByVal Normal As VBGLVertex, ByVal Color As VBGLVertex) As VBGLLayout
    Dim SearchData  As String  : SearchData = GetDataArea("f ", Data)
    Dim Setup       As String
    If SearchData = Empty Then
        If IsSomething(Vertex)  Then Setup = "1" 
        If IsSomething(Texture) Then Setup = SetUp & "/2" 
        If IsSomething(Normal)  Then Setup = SetUp & "/3" 
        If IsSomething(Color)   Then Setup = SetUp & "/4" 
    Else
        Dim Arr()       As String
        Arr = Split(SearchData, " ")
        Setup = Arr(0)
    End If

    Dim Temp() As VBGLLayoutType

    Dim VertexElement  As VBGLLayoutType
    Dim TextureElement As VBGLLayoutType
    Dim NormalElement  As VBGLLayoutType
    Dim ColorElement   As VBGLLayoutType
    If IsNothing(Vertex)  Then VertexElement  = VBGLLayoutType.XYZ    Else VertexElement  = Vertex.Element.LayoutType
    If IsNothing(Texture) Then TextureElement = VBGLLayoutType.TxTy   Else TextureElement = Texture.Element.LayoutType
    If IsNothing(Normal)  Then NormalElement  = VBGLLayoutType.NxNyNz Else NormalElement  = Normal.Element.LayoutType
    If IsNothing(Color)   Then ColorElement   = VBGLLayoutType.RGBB   Else ColorElement   = Color.Element.LayoutType
    Select Case True
        Case Setup Like "*#/*#/*#/*#" : ReDim Temp(3): Temp(0) = VertexElement  :Temp(1) = TextureElement :Temp(2) = NormalElement    :Temp(3) = ColorElement
        Case Setup Like "*#/*#//*#"   : ReDim Temp(2): Temp(0) = VertexElement  :Temp(1) = TextureElement :Temp(2) = ColorElement
        Case Setup Like "*#//*#/*#"   : ReDim Temp(2): Temp(0) = VertexElement  :Temp(1) = NormalElement  :Temp(2) = ColorElement
        Case Setup Like "/*#/*#/*#"   : ReDim Temp(2): Temp(0) = TextureElement :Temp(1) = NormalElement  :Temp(2) = ColorElement
        Case Setup Like "*#/*#/*#"    : ReDim Temp(2): Temp(0) = VertexElement  :Temp(1) = TextureElement :Temp(2) = NormalElement
        Case Setup Like "//*#/*#"     : ReDim Temp(1): Temp(0) = NormalElement  :Temp(1) = ColorElement
        Case Setup Like "/*#//*#"     : ReDim Temp(1): Temp(0) = TextureElement :Temp(1) = ColorElement
        Case Setup Like "/*#/*#"      : ReDim Temp(1): Temp(0) = TextureElement :Temp(1) = NormalElement
        Case Setup Like "*#///*#"     : ReDim Temp(1): Temp(0) = VertexElement  :Temp(1) = ColorElement
        Case Setup Like "*#//*#"      : ReDim Temp(1): Temp(0) = VertexElement  :Temp(1) = NormalElement
        Case Setup Like "*#/*#"       : ReDim Temp(1): Temp(0) = VertexElement  :Temp(1) = TextureElement
        Case Setup Like "///*#"       : ReDim Temp(0): Temp(0) = ColorElement
        Case Setup Like "//*#"        : ReDim Temp(0): Temp(0) = NormalElement
        Case Setup Like "/*#"         : ReDim Temp(0): Temp(0) = TextureElement
        Case Setup Like "*#"          : ReDim Temp(0): Temp(0) = VertexElement
    End Select
    Set GetLayout = VBGLLayout.Create(vbSingle, Temp)
End Function

Private Function GetFaces(ByVal Layout As VBGLLayout, ByVal Data As String) As VBGLFace
    Dim SearchData  As String  : SearchData = GetDataArea("f ", Data)
    If SearchData = Empty Then Exit Function
    Dim Arr()       As String  : Arr = Split(SearchData, " ")
    SearchData = Replace(SearchData, "f ", " ")
    SearchData = Replace(SearchData, "/", " ")
    Arr = Split(SearchData, " ")
    Set GetFaces = VBGLFace.CreateFromStringArray(Layout, Arr)
End Function

Private Function GetDataArea(ByVal SearchFor As String, ByVal Data As String) As String
    Dim StartPoint As Long: StartPoint = InStr(1, Data, SearchFor)
    Dim EndPoint   As Long: EndPoint   = InStrRev(Data, SearchFor)
    If StartPoint = 0 Or EndPoint = 0 Or StartPoint = EndPoint Then Exit Function

    Dim LastPoint  As Long: LastPoint  = InStr(EndPoint, Data, vbCrLf)
    If LastPoint = 0 Then LastPoint = Len(Data) + 1 
    GetDataArea = Replace(VBGLMidP(Data, StartPoint + Len(SearchFor), LastPoint - 1), vbCrLf, "")
End Function

Private Function GetWhat(ByVal Text As String) As String
    Select Case Text
        Case "v " : GetWhat = "Position"
        Case "vt ": GetWhat = "Texture"
        Case "vn ": GetWhat = "Normal"
        Case "vc ": GetWhat = "Color"
        Case Else
    End Select
End Function

Private Function GetSize(ByVal SearchFor As String, ByVal Text As String) As Long
    Dim Point1 As Long
    Dim Point2 As Long
    Point1 = InStr(1, Text, SearchFor)
    Point2 = InStr(Point1 + Len(SearchFor), Text, SearchFor)
    Dim Arr() As String
    Arr = Split(VBGLMidP(Text, Point1 + Len(SearchFor), Point2 - 1), " ")
    GetSize = USize(Arr) + 1
End Function