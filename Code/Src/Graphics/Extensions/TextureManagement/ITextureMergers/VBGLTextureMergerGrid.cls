VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLTextureMergerGrid"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Implements VBGLITextureMerger


Private SystemWidth As Long
Private SystemHeight As Long

Private MaxHeight As Long
Private MaxWidth  As Long
Private MaxByteHeight As Long
Private MaxByteWidth  As Long

Private p_ColumnFirst As Boolean ' If True ColumnFirst, if not Column first

Private Function VBGLITextureMerger_Merge(ByRef SubTextures() As VBGLTextureManagerHelper, ByVal BPP As Long, Optional ByRef OverWriteMaxHeight As Long = 0, Optional ByRef OverWriteMaxWidth As Long = 0) As Byte()
    Dim ProcessedSubs() As VBGLTextureManagerHelper
    ProcessedSubs = SplitSubTextures(SubTextures)

    Call InitMetaData(ProcessedSubs, BPP)
    If OverWriteMaxHeight <> 0 Then
        MaxHeight = OverWriteMaxHeight
    End If
    If OverWriteMaxWidth <> 0 Then
        MaxWidth = OverWriteMaxWidth
        MaxByteWidth = MaxWidth * BPP
    End If
    Call AssignPositions(ProcessedSubs)
    Dim Result() As Byte

    Result = AssignData(ProcessedSubs)

    
    VBGLITextureMerger_Merge = Result
    SubTextures              = ProcessedSubs
    OverWriteMaxHeight       = MaxHeight
    OverWriteMaxWidth        = MaxWidth

    'Dim y As Long, x As Long
    'Dim i As Long
    'Debug.Assert False
    'For y = 0 To MaxHeight - 1
    '    Dim Red   As Byte
    '    Dim Green As Byte
    '    Dim Blue  As Byte
    '    For x = 0 To MaxByteWidth - 1 Step +BPP
    '        If BPP = 4 Then
    '            Red    = Result(y, x + 1)
    '            Blue   = Result(y, x + 3)
    '            Green  = Result(y, x + 2)
    '        Else
    '            Red    = Result(y, x)
    '        End If
    '        Range("A1").Offset(y, x / BPP).Interior.Color = RGB(Blue, Red, Green)
    '    Next x
    'Next y
End Function


Public Property Let ColumnFirst(ByVal n_ColumnFirst As Boolean)
    p_ColumnFirst = n_ColumnFirst
End Property
Public Property Get ColumnFirst() As Boolean
    ColumnFirst = p_ColumnFirst
End Property

Public Function Create(ByVal n_ColumnFirst As Boolean) As VBGLTextureMergerGrid
    Set Create = New VBGLTextureMergerGrid
    With Create
        .ColumnFirst = n_ColumnFirst
        Call .Init()
    End With
End Function

Friend Sub Init()
    Call glGetIntegerv(GL_MAX_TEXTURE_SIZE, SystemWidth)
    SystemHeight = SystemWidth
End Sub


'================================
'=============Output=============
'================================

'1. Step: Get SubTextures of SubTextures
Private Function SplitSubTextures(ByRef SubTextures() As VBGLTextureManagerHelper) As VBGLTextureManagerHelper()
    Dim Result() As VBGLTextureManagerHelper
    Dim Index As Long
    Index = 0
    Do Until Index > USize(SubTextures)
        Dim NewArr() As VBGLTextureManagerHelper
        NewArr = GetSubTextures(SubTextures(Index))
        Call VBGLMerge(Result, NewArr)
        Index = Index + 1
    Loop
    SplitSubTextures = Result
End Function

Private Function GetSubTextures(ByVal SubTexture As VBGLTextureManagerHelper) As VBGLTextureManagerHelper()
    With SubTexture
        Dim RowSize    As Long   : RowSize    = .RowCount
        Dim ColumnSize As Long   : ColumnSize = .ColumnCount
        Dim Width      As Long   : Width      = .Width      / ColumnSize
        Dim Height     As Long   : Height     = .Height     / RowSize
        Dim ByteWidth  As Long   : ByteWidth  = .ByteWidth  / ColumnSize
        Dim ByteHeight As Long   : ByteHeight = .ByteHeight / RowSize
        Dim Names()    As String : Names      = .GetNames
    End With

    Dim Result() As VBGLTextureManagerHelper
    ReDim Result(RowSize * ColumnSize - 1)

    Dim i As Long, j As Long
    Dim Index As Long
    For i = 0 To RowSize - 1
        For j = 0 To ColumnSize - 1
            Dim WidthSum  As Long
            Dim HeightSum As Long

            Dim Data() As Byte
            Dim NewSub As VBGLTextureManagerHelper

            Let Data = GetSubTextureData(SubTexture.GetData, WidthSum, HeightSum, ByteWidth, ByteHeight)
            Set NewSub = New VBGLTextureManagerHelper
            With NewSub
                If USize(Names) >= Index Then
                    .Identifier  = SubTexture.PreName & Names(Index)
                Else
                    .Identifier  = SubTexture.PreName
                End If
                .Width       = Width
                .Height      = Height
                .ByteWidth   = USize(Data, 2) + 1
                .ByteHeight  = USize(Data, 1) + 1
                .RowCount    = 1
                .ColumnCount = 1
                Call .LetData(Data)
            End With

            Set Result(Index) = NewSub
            If SubTexture.SetUp = VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpColumn Or VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpGrid Then
                WidthSum = WidthSum + ByteWidth
            End If
            Index = Index + 1
        Next j
        If SubTexture.SetUp = VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpRow Or VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpGrid Then
            HeightSum = HeightSum + ByteHeight
        End If
        WidthSum = 0
    Next i
    GetSubTextures = Result
End Function

Private Function GetSubTextureData(ByRef Data() As Byte, ByVal x As Long, ByVal y As Long, ByVal ByteWidth As Long, ByVal ByteHeight As Long) As Byte()
    Dim ix As Long, iy As Long
    Dim Result() As Byte
    If ByteHeight =< 0 Or ByteWidth =< 0 Then Exit Function
    ReDim Result(ByteHeight -1, ByteWidth - 1)

    For iy = 0 To ByteHeight - 1
        For ix = 0 To ByteWidth - 1
            Result(iy, ix) = Data(y + iy, x + ix)
        Next ix
    Next iy

    GetSubTextureData = Result
End Function



'2. Step: Initialize MaxHeight and Maxwidth
Private Sub InitMetaData(ByRef SubTextures() As VBGLTextureManagerHelper, ByVal BPP As Long)
    MaxHeight     = 0
    MaxWidth      = 0
    MaxByteHeight = 0
    MaxByteWidth  = 0
    If ColumnFirst Then
        Call CalcMax(SubTextures, SystemHeight, MaxHeight    , MaxWidth, "Height", "Width")
        Call CalcMax(SubTextures, SystemHeight * BPP, MaxByteHeight, MaxByteWidth, "ByteHeight", "ByteWidth")
    Else
        Call CalcMax(SubTextures, SystemWidth, MaxWidth    , MaxHeight, "Width", "Height")
        Call CalcMax(SubTextures, SystemWidth * BPP, MaxByteWidth, MaxByteHeight, "ByteWidth", "ByteHeight")
    End If
End Sub

Private Sub CalcMax(ByRef SubTextures() As VBGLTextureManagerHelper, ByVal Limit As Long, ByRef CurrentTotal As Long, ByRef OtherTotal As Long, ByVal CurrentText As String, ByVal OtherText As String)
    Dim Current    As Long
    Dim Other      As Long
    Dim Max        As Long
    Dim OtherCount As Long
    Dim OtherMax   As Long

    Dim i As Long
    OtherCount = 1
    For i = 0 To USize(SubTextures)
        Dim CurrentOffset     As Long
        Dim OtherOffset       As Long

        CurrentOffset     = std_Callable.Create(SubTextures(i), CurrentText , vbGet, -1).Run()
        OtherOffset       = std_Callable.Create(SubTextures(i), OtherText   , vbGet, -1).Run()

        If (Current + CurrentOffset) > Limit Then
            OtherCount = OtherCount + 1
            If Current > Max Then Max = Current
            Current = CurrentOffset
            OtherMax = OtherOffset
        Else
            Current = Current + CurrentOffset
            If OtherOffset > OtherMax Then OtherMax = OtherOffset
        End If
    Next

    OtherTotal   = OtherCount * OtherMax
    If Current > Max Then
        CurrentTotal = Current
    Else
        CurrentTotal = Max
    End If


End Sub



'3. Step: Assign Positions
Private Sub AssignPositions(ByRef SubTextures() As VBGLTextureManagerHelper)
    Dim i As Long
    Dim CurrX As Long
    Dim CurrY As Long
    Dim RowHeight As Long
    
    For i = 0 To USize(SubTextures)
        With SubTextures(i)
            .x = CurrX
            .y = CurrY
            CurrX = CurrX + .ByteWidth
            If .ByteHeight > RowHeight Then RowHeight = .ByteHeight
            If CurrX >= MaxByteWidth Then
                CurrX = 0
                CurrY = CurrY + RowHeight
                RowHeight = 0
            End If
        End With
    Next i
End Sub

'4. Step: Assign Data
Private Function AssignData(ByRef SubTextures() As VBGLTextureManagerHelper) As Byte()
    Dim i As Long
    Dim Result() As Byte
    ReDim Result(MaxByteHeight -1, MaxByteWidth - 1)
    For i = 0 To USize(SubTextures)
        With SubTextures(i)
            Call AssignSubData(Result, .GetData, .x, .y, .ByteWidth, .ByteHeight)
        End With
    Next i
    AssignData = Result
End Function

Private Sub AssignSubData(ByRef Data() As Byte, SubData() As Byte, ByVal x As Long, ByVal y As Long, ByVal ByteWidth As Long, ByVal ByteHeight As Long)
    Dim ix As Long, iy As Long
    If ByteWidth =< 0 And ByteHeight =< 0 Then Exit Sub
    For iy = 0 To ByteHeight - 1
        For ix = 0 To ByteWidth - 1
            Data(y + iy, x + ix) = SubData(iy, ix)
        Next ix
    Next iy
End Sub