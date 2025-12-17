VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Option Explicit

Implements VBGLDrawable

Private Const DEFAULT_WIDTH        As Single  = 0.1!
Private Const DEFAULT_PADDING      As Single  = 0.01!
Private Const DEFAULT_HEIGHT       As Single  = 0.1!
Private Const DEFAULT_COLUMNCOUNT  As Long    = -1

Private Type Element
    Drawable          As VBGLDrawable
    Frame             As VBGLFrame
    BackgroundColor() As Single
    X                 As Single
    Padding           As Single
    Width             As Single
End Type

Private Type ItemRow
    Elements()  As Element
    ColumnCount As Long
    X           As Single
    Y           As Single
    Height      As Single
End Type


Private Rows()                As ItemRow
Private RowCount              As Long

Private p_Properties          As VBGLProperties
Private p_GlobalHeight        As Single
Private p_GlobalWidth         As Single
Private p_GlobalPadding       As Single
Private p_GlobalColumnCount   As Long

Public Property Let Properties(ByVal n_Value          As VBGLProperties) : Set p_Properties        = n_Value             : End Property
Public Property Let GlobalHeight(ByVal n_Value        As Single)         : Let p_GlobalHeight      = n_Value             : End Property
Public Property Let GlobalWidth(ByVal n_Value         As Single)         : Let p_GlobalWidth       = n_Value             : End Property
Public Property Let GlobalPadding(ByVal n_Value       As Single)         : Let p_GlobalPadding     = n_Value             : End Property
Public Property Let GlobalColumnCount(ByVal n_Value   As Long)           : Let p_GlobalColumnCount = n_Value             : End Property

Public Property Get Properties()                      As VBGLProperties  : Set Properties          = p_Properties        : End Property
Public Property Get GlobalHeight()                    As Single          : Let GlobalHeight        = p_GlobalHeight      : End Property
Public Property Get GlobalWidth()                     As Single          : Let GlobalWidth         = p_GlobalWidth       : End Property
Public Property Get GlobalPadding()                   As Single          : Let GlobalPadding       = p_GlobalPadding     : End Property
Public Property Get GlobalColumnCount()               As Long            : Let GlobalColumnCount   = p_GlobalColumnCount : End Property

Public Function Create(ByVal n_Properties As VBGLProperties, _
              Optional ByVal Height       As Single = DEFAULT_HEIGHT , _
              Optional ByVal Width        As Single = DEFAULT_WIDTH  , _
              Optional ByVal Padding      As Single = DEFAULT_PADDING, _
              Optional ByVal ColumnCount  As Long   = DEFAULT_COLUMNCOUNT)
    Set Create = New VBGLList
    With Create
        .Properties    = n_Properties
        .GlobalHeight  = Height
        .GlobalWidth   = Width
        .GlobalPadding = Padding
        .GlobalColumnCount = ColumnCount
    End With
End Function

Public Function CreateProperties() As VBGLProperties
    Dim i As Long
    Set CreateProperties = New VBGLProperties
    With CreateProperties
        .AddProperty("X")
        .AddProperty("Y")
        .AddProperty("Z")
    End With
End Function

Public Sub Draw()
    Dim y As Long
    Dim x As Long

    Dim PrevFrame As VBGLFrame
    Set PrevFrame = CurrentContext.CurrentFrame
    For y = 0 To RowCount
        For x = 0 To Rows(y).ColumnCount
            With Rows(y).Elements(x)
                Call .Frame.Bind()
                Call .Frame.ClearColorArr(.BackgroundColor)
                Call .Drawable.Draw()
            End With
        Next x
    Next y
    Call PrevFrame.Bind()
End Sub

'RowHandling
    'Array As Single()
    Public Sub SetRowHeights(ParamArray Values() As Variant)
        Dim i As Long
        For i = 0 To Ubound(Values)
            If TypeName(Values(i)) = "Single" Then
                Call SetRowHeight(i, Values(i))
            End If
        Next i
    End Sub

    Public Sub SetRowHeightAll(ByVal Value As Single)
        Dim i As Long
        For i = 0 To RowCount
            Call SetRowHeight(i, Value)
        Next i
    End Sub

    Public Sub SetRowHeight(ByVal Row As Long, ByVal Value As Single)
        Rows(Row).Height = Value
    End Sub

    Public Sub AddRows(ByVal Count As Long)
        Dim i As Long
        For i = 0 To Count
            Call AddRow()
        Next i
    End Sub

    Public Sub AddRow()
        RowCount = RowCount + 1
        ReDim Preserve Rows(RowCount)
        With Rows(RowCount)
        .Height = IIf(GlobalHeight <> 0, GlobalHeight, DEFAULT_HEIGHT)
            If RowCount > 0 Then
                .Y = Rows(RowCount - 1).Y - Rows(RowCount - 1).Height
            Else
                .Y = Properties.Value("Y")
            End If
            .X = Properties.Value("X")
            If GlobalColumnCount <> DEFAULT_COLUMNCOUNT Then
                ReDim Preserve .Elements(GlobalColumnCount)
            End If
            .ColumnCount = GlobalColumnCount
        End With
    End Sub
'

'ColumnHandling
    'Array As Single()
    Public Sub SetColumnWidths(ByVal Row As Long, ParamArray Values() As Variant)
        Dim i As Long
        For i = 0 To Ubound(Values)
            If TypeName(Values(i)) = "Single" Then
                Call SetWidth(Row, i, Values(i))
            End If
        Next i
    End Sub

    Public Sub SetColumnWidthAll(ByVal Value As Single)
        Dim i As Long, j As Long
        For i = 0 To RowCount
            For j = 0 To Rows(i).ColumnCount
                Call SetWidth(i, j, Value)
            Next j
        Next i
    End Sub

    Public Sub SetColumnWidth(ByVal Column As Long, ByVal Value As Single)
        Dim i As Long
        For i = 0 To RowCount
            Call SetWidth(i, Column, Value)
        Next i
    End Sub

    Public Sub SetWidth(ByVal Row As Long, ByVal Column As Long, ByVal Value As Single)
        Rows(Row).Elements(Column).Width = Value
    End Sub

    'Backgroundcolor() As Single
    Public Sub AddElement(ByVal Row As Long, ByVal Element As VBGLDrawable, Optional BackgroundColor As Variant)
        Dim NewSize As Long
        With Rows(Row)
            NewSize = .ColumnCount + 1
            ReDim Preserve .Elements(NewSize)
            .ColumnCount = NewSize
            With .Elements(NewSize)
                Set .Drawable = Element
                .Width   = Iif(GlobalWidth   <> 0, GlobalWidth  , DEFAULT_WIDTH)
                .Padding = Iif(GlobalPadding <> 0, GlobalPadding, DEFAULT_PADDING)

                If NewSize > 0 Then
                    .X = Rows(Row).Elements(NewSize - 1).X +     _
                         Rows(Row).Elements(NewSize - 1).Width + _
                         Rows(Row).Elements(NewSize - 1).Padding
                Else
                    .X = Rows(Row).X
                End If
                Dim TempColor(3) As Single
                .BackgroundColor = Iif(IsMissing(BackgroundColor), TempColor, BackgroundColor)
            End With
        End With
    End Sub

    Public Function GetElement(ByVal Row As Long, ByVal Column As Long) As VBGLDrawable
        Set GetElement = Rows(Row).Elements(Column).Drawable
    End Function

    Public Sub SetBackgroundColor(ByVal Row As Long, ByVal Column As Long, ByRef Color() As Single)
        Rows(Row).Columns(Column).BackgroundColor = Color
    End Sub
'

Private Sub VBGLDrawable_Draw()
    Call Draw()
End Sub

Public Sub Build()
    Dim Row As Long, Column As Long
    For Row = 0 To RowCount
        For Column = 0 To Rows(Row).ColumnCount
            Set Rows(Row).Elements(Column).Frame = CreateFrame(Row, Column)
        Next Column
    Next Row
End Sub

Private Function CreateFrame(ByVal Row As Long, ByVal Column As Long) As VBGLFrame
    Dim n_ScissorX       As Single : n_ScissorX       = Map(Rows(Row).Elements(Column).X      , -1, 1, 0, 1)
    Dim n_ScissorY       As Single : n_ScissorY       = Map(Rows(Row).Y - Rows(Row).Height    , -1, 1, 0, 1)
    Dim n_ScissorWidth   As Single : n_ScissorWidth   = MapD(Rows(Row).Elements(Column).Width, -1, 1, 0, 1)
    Dim n_ScissorHeight  As Single : n_ScissorHeight  = MapD(Rows(Row).Height                , -1, 1, 0, 1)
    Dim n_ViewportX      As Single : n_ViewportX      = n_ScissorX
    Dim n_ViewportY      As Single : n_ViewportY      = n_ScissorY
    Dim n_ViewportWidth  As Single : n_ViewportWidth  = n_ScissorWidth
    Dim n_ViewportHeight As Single : n_ViewportHeight = n_ScissorHeight

    Set CreateFrame = VBGLFrame.CreateFromWindow(n_ScissorX, n_ScissorY, n_ScissorWidth, n_ScissorHeight, n_ViewportX, n_ViewportY, n_ViewportWidth, n_ViewportHeight, CurrentContext.CurrentWindow)
End Function

Private Function Map(ByVal Inputt As Single, ByVal Low1 As Single, ByVal High1 As Single, ByVal Low2 As Single, ByVal High2 As Single) As Single
    Map = Low2 + (Inputt - Low1) * (High2 - Low2) / (High1 - Low1)
End Function

Private Function MapD(ByVal Inputt As Single, ByVal Low1 As Single, ByVal High1 As Single, ByVal Low2 As Single, ByVal High2 As Single) As Single
    MapD = Ratio(Range(Inputt, Low1, High1), Low2, High2)
End Function

Private Function Range(ByVal Inputt As Single, ByVal Low As Single, ByVal High As Single) As Single
    Range = Inputt / (High - Low)
End Function

Private Function Ratio(ByVal Inputt As Single, ByVal Low As Single, ByVal High As Single) As Single
    Ratio = Inputt * (High - Low)
End Function

'-------------------------------------
' Initialization
'-------------------------------------
Private Sub Class_Initialize()
    RowCount         = -1
End Sub