VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLTextureManagerHelper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Public Enum VBGLTextureManagerHelperSetUp
    VBGLTextureManagerHelperSetUpColumn = 0
    VBGLTextureManagerHelperSetUpRow    = 1
    VBGLTextureManagerHelperSetUpGrid   = 2
End Enum

Private p_Identifier  As String
Private p_X           As Long
Private p_Y           As Long
Private p_Width       As Long
Private p_Height      As Long
Private p_ByteWidth   As Long
Private p_ByteHeight  As Long
Private p_RowCount    As Long
Private p_ColumnCount As Long
Private p_SetUp       As VBGLTextureManagerHelperSetUp
Private p_PreName     As String
Private p_Names()     As String
Private p_Data()      As Byte


Public Property Let Identifier(ByVal  n_Identifier  As String)                        : p_Identifier         = n_Identifier    : End Property
Public Property Let X(ByVal           n_X           As Long)                          : p_X                  = n_X             : End Property
Public Property Let Y(ByVal           n_Y           As Long)                          : p_Y                  = n_Y             : End Property
Public Property Let Width(ByVal       n_Width       As Long)                          : p_Width              = n_Width         : End Property
Public Property Let Height(ByVal      n_Height      As Long)                          : p_Height             = n_Height        : End Property
Public Property Let ByteWidth(ByVal   n_ByteWidth   As Long)                          : p_ByteWidth          = n_ByteWidth     : End Property
Public Property Let ByteHeight(ByVal  n_ByteHeight  As Long)                          : p_ByteHeight         = n_ByteHeight    : End Property
Public Property Let RowCount(ByVal    n_RowCount    As Long)                          : p_RowCount           = n_RowCount      : End Property
Public Property Let ColumnCount(ByVal n_ColumnCount As Long)                          : p_ColumnCount        = n_ColumnCount   : End Property
Public Property Let SetUp(ByVal       n_SetUp       As VBGLTextureManagerHelperSetUp) : p_SetUp              = n_SetUp         : End Property
Public Property Let PreName(ByVal     n_PreName     As String)                        : p_PreName            = n_PreName       : End Property
Public Sub          LetData(ByRef     n_Data()      As Byte)                          : p_Data               = n_Data          : End Sub
Public Sub          LetNames(ByRef    n_Names()     As String)                        : p_Names              = n_Names         : End Sub
Public Sub          AddName(ByVal     Name          As String)                        : Call VBGLAdd(p_NamesName)              : End Sub

Public Property Get Identifier()                    As String                         : Identifier           = p_Identifier    : End Property
Public Property Get X()                             As Long                           : X                    = p_X             : End Property
Public Property Get Y()                             As Long                           : Y                    = p_Y             : End Property
Public Property Get Width()                         As Long                           : Width                = p_Width         : End Property
Public Property Get Height()                        As Long                           : Height               = p_Height        : End Property
Public Property Get ByteWidth()                     As Long                           : ByteWidth            = p_ByteWidth     : End Property
Public Property Get ByteHeight()                    As Long                           : ByteHeight           = p_ByteHeight    : End Property
Public Property Get RowCount()                      As Long                           : RowCount             = p_RowCount      : End Property
Public Property Get ColumnCount()                   As Long                           : ColumnCount          = p_ColumnCount   : End Property
Public Property Get SetUp()                         As VBGLTextureManagerHelperSetUp  : SetUp                = p_SetUp         : End Property
Public Property Get PreName()                       As String                         : PreName              = p_PreName       : End Property
Public Function     GetData()                       As Byte()                         : GetData              = p_Data          : End Function
Public Function     GetNames()                      As String()                       : GetNames             = p_Names         : End Function