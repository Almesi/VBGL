VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLData"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private Declare PtrSafe Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (ByRef Destination As Any, ByVal Source As Any, ByVal Length As Long)

Implements IDataSingle
Implements IDataLong
Implements IDataString
Implements IDataByte

Private p_Typee        As VbVarType
Private p_Count        As Long
Private p_Size         As Long
Private p_ByteData()   As Byte
Private p_DataSingle() As Single
Private p_DataLong()   As Long
Private p_DataString() As String
Private p_DataByte()   As Byte

Public Function Create(DataType As VbVarType)
    Set Create = New VBGLData
    Create.Typee = DataType
    Select Case DataType
        Case vbSingle: Create.Size = 4
        Case vbLong  : Create.Size = 4
        Case vbString: Create.Size = 2
        Case vbByte  : Create.Size = 1
    End Select
End Function

Public Property Let Data(n_Data As Variant)
    Select Case Typee
        Case vbSingle : p_DataSingle = n_Data
        Case vbLong   : p_DataLong   = n_Data
        Case vbString : p_DataString = n_Data
        Case vbByte   : p_DataByte   = n_Data
    End Select
End Property
Public Property Get Data() As Variant
    Select Case Typee
        Case vbSingle : Data = p_DataSingle
        Case vbLong   : Data = p_DataLong
        Case vbString : Data = p_DataString
        Case vbByte   : Data = p_DataByte
    End Select
End Property

Public Property Let ByteData(n_Data() As Byte)
    p_ByteData = n_Data
End Property
Public Property Get ByteData() As Byte()
    ByteData = p_ByteData
End Property

Public Property Let Count(n_Count As Long)
    p_Count = n_Count
End Property
Public Property Get Count() As Long
    Count = p_Count
End Property

Public Property Let Size(n_Size As Long)
    p_Size = n_Size
End Property
Public Property Get Size() As Long
    Size = p_Size
End Property

Public Property Let Typee(n_Type As VbVarType)
    p_Typee = n_Type
End Property
Public Property Get Typee() As VbVarType
    Typee = p_Typee
End Property

' IDataString
    Private Property Let IDataString_Data(n_Data As Variant)
        p_DataString = n_Data
        Count        = Ubound(p_DataString) + 1
        Dim ByteSize As Long: ByteSize = Count * Size
        Dim Temp() As Byte: ReDim Temp(ByteSize - 1)
        Call CopyMemory(Temp(0), VarPtr(p_DataString(0)), ByteSize)
        p_ByteData = Temp
    End Property
    Private Property Get IDataString_Data() As Variant
        IDataString_Data = p_DataString
    End Property

    Private Property Get IDataString_ByteData() As Byte()
        IDataString_ByteData = p_ByteData
    End Property
'
' IDataByte
    Private Property Let IDataByte_Data(n_Data As Variant)
        p_DataByte = n_Data
        p_ByteData = n_Data
        Count      = Ubound(p_DataByte) + 1
    End Property
    Private Property Get IDataByte_Data() As Variant
        IDataByte_Data = p_DataByte
    End Property

    Private Property Get IDataByte_ByteData() As Byte()
        IDataByte_ByteData = p_ByteData
    End Property
'
' IDataSingle
    Private Property Let IDataSingle_Data(n_Data As Variant)
        p_DataSingle = n_Data
        Count        = Ubound(p_DataSingle) + 1
        Dim ByteSize As Long: ByteSize = Count * Size
        Dim Temp() As Byte: ReDim Temp(ByteSize - 1)
        Call CopyMemory(Temp(0), VarPtr(p_DataSingle(0)), ByteSize)
        p_ByteData = Temp
    End Property
    Private Property Get IDataSingle_Data() As Variant
        IDataSingle_Data = p_DataSingle
    End Property

    Private Property Get IDataSingle_ByteData() As Byte()
        IDataSingle_ByteData = p_ByteData
    End Property
'
' IDataLong
    Private Property Let IDataLong_Data(n_Data As Variant)
        p_DataLong = n_Data
        Count        = Ubound(p_DataLong) + 1
        Dim ByteSize As Long: ByteSize = Count * Size
        Dim Temp() As Byte: ReDim Temp(ByteSize - 1)
        Call CopyMemory(Temp(0), VarPtr(p_DataLong(0)), ByteSize)
        p_ByteData = Temp
    End Property
    Private Property Get IDataLong_Data() As Variant
        IDataLong_Data = p_DataLong
    End Property

    Private Property Get IDataLong_ByteData() As Byte()
        IDataLong_ByteData = p_ByteData
    End Property
'