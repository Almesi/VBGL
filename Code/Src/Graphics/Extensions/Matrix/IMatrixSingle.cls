VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "IMatrixSingle"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Option Explicit

Public Property Let Item(ByVal Row As Long, ByVal Column As Long, ByVal Value As Single)
Public Property Get Item(ByVal Row As Long, ByVal Column As Long) As Single
Public Property Let Rows(ByVal n_RowsSingle As Long)
Public Property Get Rows() As Long
Public Property Let Columns(ByVal n_ColumnsSingle As Long)
Public Property Get Columns() As Long
Public Property Let Data(ByVal n_DataSingle As Variant)
Public Property Get Data() As Variant

Public Function DataRow(ByVal Row As Long, ByVal Optional Count As Long = -1) As Single()
Public Function DataColumn(ByVal Column As Long, ByVal Optional Count As Long = -1) As Single()
Public Sub      Diagonals(ByVal Value As Single)
Public Sub      Clear(ByVal Value As Single)
Public Function Add(ByVal Matrix1 As Variant, ByVal Matrix2 As Variant) As Single()
Public Function Subtract(ByVal Matrix1 As Variant, ByVal Matrix2 As Variant) As Single()
Public Function Multiply(ByVal Matrix1 As Variant, ByVal Matrix2 As Variant) As Single()
Public Function Divide(ByVal Matrix1 As Variant, ByVal Matrix2 As Variant) As Single()
Public Function Scalee(ByVal Matrix1 As Variant, ByVal Value As Single) As Single()
Public Function Translate(ByVal Matrix1 As Variant, ByVal Value As Single) As Single()
Public Function RotateX(ByVal Dimensions As Long, ByVal Theta As Single) As Single()
Public Function RotateY(ByVal Dimensions As Long, ByVal Theta As Single) As Single()
Public Function RotateZ(ByVal Dimensions As Long, ByVal Theta As Single) As Single()
Public Function Rotate(ByVal Dimensions As Long, ByVal Optional ThetaX As Single = 3.14156, ByVal Optional ThetaY As Single = 3.14156, ByVal Optional ThetaZ As Single = 3.14156) As Single()
Public Function Compare(ByVal Matrix1 As Variant, ByVal Matrix2 As Variant, ByVal Operator As Long) As Single()
Public Function Transpose(ByVal Matrix1 As Variant) As Single()
Public Function Inverse(ByVal Matrix1 As Variant) As Single()
Public Function Ortho(ByVal Dimensions As Long, ByVal Left As Single, ByVal Right As Single, ByVal Bottom As Single, ByVal Top As Single, ByVal Near As Single, ByVal Far As Single) As Single()
Public Function Perspective(ByVal Dimensions As Long, ByVal Theta As Single, ByVal Aspect As Single, ByVal zNear As Single, ByVal zFar As Single) As Single()
Public Function Normalize(ByVal Matrix1 As Variant) As Single()
Public Function Cross(ByVal Matrix1 As Variant, ByVal Matrix2 As Variant) As Single()
Public Function Dot(ByVal Matrix1 As Variant, ByVal Matrix2 As Variant) As Single
Public Function LookAt(ByVal Position As Variant, ByVal Direction As Variant, ByVal Y As Variant) As Single()
Public Sub Display()