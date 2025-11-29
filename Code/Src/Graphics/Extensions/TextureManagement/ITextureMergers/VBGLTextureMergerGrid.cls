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
Private MaxWidth As Long

' If True ColumnFirst, if not Column first
Private p_ColumnFirst As Boolean


Private Function VBGLITextureMerger_Merge(ByRef SubTextures() As VBGLTextureManagerHelper, Optional ByVal OverWriteMaxHeight As Long = 0, Optional ByVal OverWriteMaxWidth As Long = 0) As Byte()
    Dim ProcessedSubs() As VBGLTextureManagerHelper
    ProcessedSubs = InsertSubTextures(SubTextures)

    Call InitMetaData(ProcessedSubs)
    If OverWriteMaxHeight <> 0 Then MaxHeight = OverWriteMaxHeight
    If OverWriteMaxWidth  <> 0 Then MaxWidth  = OverWriteMaxWidth
    Call AssignPositions(ProcessedSubs)
    Dim Result() As Byte
    Result = AssignData(ProcessedSubs)
    VBGLITextureMerger_Merge = Result
    SubTextures = ProcessedSubs
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
'1. Step: Initialize MaxHeight and Maxwidth
Private Sub InitMetaData(ByRef SubTextures() As VBGLTextureManagerHelper)
    MaxHeight = 0
    MaxWidth = 0

    If ColumnFirst Then
        Call CalcColumnFirst(SubTextures)
    Else
        Call CalcRowFirst(SubTextures)
    End If
End Sub

Private Sub CalcRowFirst(ByRef SubTextures() As VBGLTextureManagerHelper)
    Dim CurrentRowWidth As Long
    Dim CurrentRowHeight As Long
    Dim TotalHeight As Long

    Dim i As Long
    For i = 0 To USize(SubTextures)
        Dim Item As VBGLTextureManagerHelper
        Set Item = SubTextures(i)
        If CurrentRowWidth + Item.Width > SystemWidth Then
            TotalHeight = TotalHeight + CurrentRowHeight
            If CurrentRowWidth > MaxWidth Then MaxWidth = CurrentRowWidth
            CurrentRowWidth = Item.Width
            CurrentRowHeight = Item.Height
        Else
            CurrentRowWidth = CurrentRowWidth + Item.Width
            If Item.Height > CurrentRowHeight Then
                CurrentRowHeight = Item.Height
            End If
        End If
    Next

    TotalHeight = TotalHeight + CurrentRowHeight
    If CurrentRowWidth > MaxWidth Then MaxWidth = CurrentRowWidth
    MaxHeight = TotalHeight
End Sub

Private Sub CalcColumnFirst(ByRef SubTextures() As VBGLTextureManagerHelper)
    Dim CurrentColWidth As Long
    Dim CurrentColHeight As Long
    Dim TotalWidth As Long

    Dim i As Long
    For i = 0 To USize(SubTextures)
        Dim Item As VBGLTextureManagerHelper
        Set Item = SubTextures(i)
        If CurrentColHeight + Item.Height > SystemHeight Then
            TotalWidth = TotalWidth + CurrentColWidth
            If CurrentColHeight > MaxHeight Then MaxHeight = CurrentColHeight
            CurrentColWidth = Item.Width
            CurrentColHeight = Item.Height
        Else
            CurrentColHeight = CurrentColHeight + Item.Height
            If Item.Width > CurrentColWidth Then
                CurrentColWidth = Item.Width
            End If
        End If
    Next

    TotalWidth = TotalWidth + CurrentColWidth
    If CurrentColHeight > MaxHeight Then MaxHeight = CurrentColHeight
    MaxWidth = TotalWidth
End Sub



'2. Step: Assign Positions
Private Sub AssignPositions(ByRef SubTextures() As VBGLTextureManagerHelper)
    Dim i As Long
    Dim CurrMaxHeight As Long
    Dim CurrMaxWidth  As Long

    For i = 1 To USize(SubTextures)
        With SubTextures(i - 1)
            .y = CurrMaxHeight
            .x = CurrMaxWidth

            If ColumnFirst Then
                CurrMaxHeight = CurrMaxHeight + .Height
                If CurrMaxHeight >= MaxHeight Then CurrMaxHeight = 0
            Else
                CurrMaxWidth  = CurrMaxWidth  + .Width
                If CurrMaxWidth  >= MaxWidth  Then CurrMaxWidth  = 0
            End If
        End With
    Next i
End Sub

'3. Step: Assign Data
Private Function AssignData(ByRef SubTextures() As VBGLTextureManagerHelper) As Byte()
    Dim i As Long
    Dim Result() As Byte
    ReDim Result(MaxHeight -1, MaxWidth - 1)
    For i = 0 To USize(SubTextures)
        With SubTextures(i)
            Call AssignSubData(Result, .GetData, .x, .y, .Width, .Height)
        End With
    Next i
    AssignData = Result
End Function

'================================
'=============Helper=============
'================================


Private Function InsertSubTextures(ByRef SubTextures() As VBGLTextureManagerHelper) As VBGLTextureManagerHelper()
    Dim Result() As VBGLTextureManagerHelper
    Dim Index As Long
    Index = 0 
    Do Until Index > USize(SubTextures)
        Dim NewArr() As VBGLTextureManagerHelper
        NewArr = GetSubTextures(SubTextures(Index))
        Call VBGLMerge(Result, NewArr)
        Index = Index + USize(NewArr)
        Index = Index + 1
    Loop
    InsertSubTextures = Result
End Function

Private Function GetSubTextures(ByVal SubTexture As VBGLTextureManagerHelper) As VBGLTextureManagerHelper()
    Dim Width As Long
    Dim Height As Long
    Dim Size As Long
    Size = SubTexture.Count

    Select Case SubTexture.SetUp
        Case VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpColumn
            Width  = SubTexture.Width / Size
            Height = SubTexture.Height
        Case VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpRow
            Width  = SubTexture.Width
            Height = SubTexture.Height / Size
        Case VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpGrid
            Width  = SubTexture.Width  / Size
            Height = SubTexture.Height / Size
    End Select

    Dim Result() As VBGLTextureManagerHelper
    ReDim Result(Size - 1)
    Dim i As Long
    Dim WidthSum  As Long
    Dim HeightSum As Long
    Dim Names() As String
    Names = SubTexture.GetNames
    For i = 0 To Size - 1
        Dim Data() As Byte
        Dim NewSub As VBGLTextureManagerHelper

        Let Data = GetSubTextureData(SubTexture.GetData, WidthSum, HeightSum, Width, Height)
        Set NewSub = New VBGLTextureManagerHelper
        With NewSub
            .Identifier = Names(i)
            .Width      = Width
            .Height     = Height
            .Count      = 1
            Call .LetData(Data)
        End With
        
        Set Result(i) = NewSub
        Select Case SubTexture.SetUp
            Case VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpColumn
                WidthSum  = WidthSum  + Height 
            Case VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpRow
                HeightSum = HeightSum + Height
            Case VBGLTextureManagerHelperSetUp.VBGLTextureManagerHelperSetUpGrid
                WidthSum  = WidthSum  + Height 
                HeightSum = HeightSum + Height
        End Select
    Next i
    GetSubTextures = Result
End Function


Private Function GetSubTextureData(ByRef Data() As Byte, ByVal x As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long) As Byte()
    Dim ix As Long, iy As Long
    Dim Result() As Byte
    ReDim Result(Height -1, Width - 1)

    For iy = 0 To Height - 1
        For ix = 0 To Width - 1
            Result(iy, ix) = Data(y + iy, x + ix)
        Next ix
    Next iy

    GetSubTextureData = Result
End Function


Private Sub AssignSubData(ByRef Data() As Byte, SubData() As Byte, ByVal x As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)
    Dim ix As Long, iy As Long

    For iy = 0 To Height - 1
        For ix = 0 To Width - 1
            Data(y + iy, x + ix) = SubData(iy, ix)
        Next ix
    Next iy
End Sub
