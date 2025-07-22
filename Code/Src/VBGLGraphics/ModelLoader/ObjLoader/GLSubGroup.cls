VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "GLSubGroup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private Declare PtrSafe Sub CopyMemory Lib "kernel32" Alias "RtlCopyMemory" (ByRef Destination As Any, ByVal Source As Any, ByVal Length As Long)

Private p_Material   As String
Private p_Smoothing  As String
Private p_Vertices   As GLVertex
Private p_Textures   As GLVertex
Private p_Normals    As GLVertex
Private p_Colors     As GLVertex
Private p_Faces      As GLFace
Private p_Layout     As VBGLLayout

Public Property Let Material(n_Material   As String)           : Let p_Material  = n_Material  : End Property
Public Property Let Smoothing(n_Smoothing As String)           : Let p_Smoothing = n_Smoothing : End Property
Public Property Let Vertices(n_Vertices   As GLVertex)         : Set p_Vertices  = n_Vertices  : End Property
Public Property Let Textures(n_Textures   As GLVertex)         : Set p_Textures  = n_Textures  : End Property
Public Property Let Normals(n_Normals     As GLVertex)         : Set p_Normals   = n_Normals   : End Property
Public Property Let Colors(n_Colors       As GLVertex)         : Set p_Colors    = n_Colors    : End Property
Public Property Let Faces(n_Faces         As GLFace)           : Set p_Faces     = n_Faces     : End Property
Public Property Let Layout(n_Layout       As VBGLLayout)       : Set p_Layout    = n_Layout    : End Property

Public Property Get Material()            As String            : Let Material    = p_Material  : End Property
Public Property Get Smoothing()           As String            : Let Smoothing   = p_Smoothing : End Property
Public Property Get Vertices()            As GLVertex          : Set Vertices    = p_Vertices  : End Property
Public Property Get Textures()            As GLVertex          : Set Textures    = p_Textures  : End Property
Public Property Get Normals()             As GLVertex          : Set Normals     = p_Normals   : End Property
Public Property Get Colors()              As GLVertex          : Set Colors      = p_Colors    : End Property
Public Property Get Faces()               As GLFace            : Set Faces       = p_Faces     : End Property
Public Property Get Layout()              As VBGLLayout        : Set Layout      = p_Layout    : End Property

Public Function Create(n_Material As String, n_Smoothing As String, GroupData As String) As GLSubGroup
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
    End With
    If Create.Vertices Is Nothing And Create.Textures Is Nothing And Create.Normals Is Nothing And Create.Colors Is Nothing And Create.Faces Is Nothing Then
        Set Create = Nothing
    End If
End Function

Public Function ByteData() As IDataByte
    Dim NewSize As Long: NewSize = Faces.Count * Layout.ByteSize()
    Dim ReturnArr()   As Byte: ReDim ReturnArr(NewSize - 1)

    Dim ArrV()  As Byte: If Not Vertices Is Nothing Then ArrV = Vertices.Data.ByteData
    Dim ArrT()  As Byte: If Not Textures Is Nothing Then ArrT = Textures.Data.ByteData
    Dim ArrN()  As Byte: If Not Normals  Is Nothing Then ArrN = Normals.Data.ByteData
    Dim ArrC()  As Byte: If Not Colors   Is Nothing Then ArrC = Colors.Data.ByteData

    Dim ArrVB   As Long: If Not Vertices Is Nothing Then ArrVB = Vertices.Element.GetTypeByteSize
    Dim ArrTB   As Long: If Not Textures Is Nothing Then ArrTB = Textures.Element.GetTypeByteSize
    Dim ArrNB   As Long: If Not Normals  Is Nothing Then ArrNB = Normals.Element.GetTypeByteSize
    Dim ArrCB   As Long: If Not Colors   Is Nothing Then ArrCB = Colors.Element.GetTypeByteSize

    Dim ArrVF() As Long: If Not Vertices Is Nothing Then ArrVF = Faces.Vertex()
    Dim ArrTF() As Long: If Not Textures Is Nothing Then ArrTF = Faces.Texture()
    Dim ArrNF() As Long: If Not Normals  Is Nothing Then ArrNF = Faces.Normal()
    Dim ArrCF() As Long: If Not Colors   Is Nothing Then ArrCF = Faces.Color()

    Dim ByteSize As Long

    Dim i As Long, j As Long
    For i = 0 To Faces.Count - 1
        For j = 0 To Layout.Size

            Dim Index As Long
            Dim Length As Long
            Dim Offset As Long
            Dim Pointer As LongPtr
            Select Case True
                Case Layout.Element(j).GetCategory = "Position"
                    Length = ArrVB
                    Index = (ArrVF(i)) * Length
                    Pointer = VarPtr(ArrV(Index))
                Case Layout.Element(j).GetCategory = "Texture"
                    Length = ArrTB
                    Index = (ArrTF(i)) * Length
                    Pointer = VarPtr(ArrT(Index))
                Case Layout.Element(j).GetCategory = "Normal"
                    Length = ArrNB
                    Index = (ArrNF(i)) * Length
                    Pointer = VarPtr(ArrN(Index))
                Case Layout.Element(j).GetCategory = "Color"
                    Length = ArrCB
                    Index = (ArrCF(i)) * Length
                    Pointer = VarPtr(ArrC(Index))
            End Select
            Call CopyMemory(ReturnArr(Offset), Pointer, Length)
            Offset = Offset + Length
        Next j
    Next i
    Set ByteData = VBGLData.Create(vbByte)
    ByteData.Data = ReturnArr
End Function

Private Function GetVertices(SearchFor As String, Data As String) As GLVertex
    Dim SearchData  As String  : SearchData = GetDataArea(SearchFor, Data)
    If SearchData = Empty Then Exit Function
    Dim Size        As Long    : Size = GetSize(SearchFor, SearchData)
    Dim Arr()       As String  : Arr = Split(Replace(SearchData, SearchFor, " "), " ")
    Set GetVertices = GLVertex.CreateFromStringArray(VBGLLayout.GetEnum(GetWhat(SearchFor), Size), Arr)
End Function

Private Function GetLayout(Data As String, Vertex As GLVertex, Texture As GLVertex, Normal As GLVertex, Color As GLVertex) As VBGLLayout
    Dim SearchData  As String  : SearchData = GetDataArea("f ", Data)
    Dim Setup       As String
    If SearchData = Empty Then
        If Not Vertex  Is Nothing Then Setup = "1" 
        If Not Texture Is Nothing Then Setup = SetUp & "/2" 
        If Not Normal  Is Nothing Then Setup = SetUp & "/3" 
        If Not Color   Is Nothing Then Setup = SetUp & "/4" 
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
    If Vertex  Is Nothing Then VertexElement  = VBGLLayoutType.XYZ    Else VertexElement  = Vertex.Element.LayoutType
    If Texture Is Nothing Then TextureElement = VBGLLayoutType.TxTy   Else TextureElement = Texture.Element.LayoutType
    If Normal  Is Nothing Then NormalElement  = VBGLLayoutType.NxNyNz Else NormalElement  = Normal.Element.LayoutType
    If Color   Is Nothing Then ColorElement   = VBGLLayoutType.RGBB   Else ColorElement   = Color.Element.LayoutType
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

Private Function GetFaces(Layout As VBGLLayout, Data As String) As GLFace
    Dim SearchData  As String  : SearchData = GetDataArea("f ", Data)
    If SearchData = Empty Then Exit Function
    Dim Arr()       As String  : Arr = Split(SearchData, " ")
    SearchData = Replace(SearchData, "f ", " ")
    SearchData = Replace(SearchData, "/", " ")
    Arr = Split(SearchData, " ")
    Set GetFaces = GLFace.CreateFromStringArray(Layout, Arr)
End Function

Private Function GetDataArea(SearchFor As String, Data As String) As String
    Dim StartPoint As Long: StartPoint = InStr(1, Data, SearchFor)
    Dim EndPoint   As Long: EndPoint   = InStrRev(Data, SearchFor)
    If StartPoint = 0 Or EndPoint = 0 Or StartPoint = EndPoint Then Exit Function

    Dim LastPoint  As Long: LastPoint  = InStr(EndPoint, Data, vbCrLf)
    If LastPoint = 0 Then LastPoint = Len(Data) + 1 
    GetDataArea = Replace(MidP(Data, StartPoint + Len(SearchFor), LastPoint - 1), vbCrLf, "")
End Function

Private Function USize(Arr As Variant, Optional Dimension As Long = 1)
    On Error Resume Next
    USize = -1
    USize = Ubound(Arr, Dimension)
End Function

Private Function MidP(Text As String, StartPoint As Long, EndPoint As Long) As String
    MidP = Mid(Text, StartPoint, (EndPoint - StartPoint) + 1)
End Function

Private Function GetWhat(Text As String) As String
    Select Case Text
        Case "v " : GetWhat = "Position"
        Case "vt ": GetWhat = "Texture"
        Case "vn ": GetWhat = "Normal"
        Case "vc ": GetWhat = "Color"
        Case Else
    End Select
End Function

Private Function GetSize(SearchFor As String, Text As String) As Long
    Dim Point1 As Long
    Dim Point2 As Long
    Point1 = InStr(1, Text, SearchFor)
    Point2 = InStr(Point1 + Len(SearchFor), Text, SearchFor)
    Dim Arr() As String
    Arr = Split(MidP(Text, Point1 + Len(SearchFor), Point2 - 1), " ")
    GetSize = USize(Arr) + 1
End Function