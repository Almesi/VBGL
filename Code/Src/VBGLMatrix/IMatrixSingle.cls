VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "IMatrixSingle"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public Property Let Item(Row As Long, Column As Long, Value As Single)
Public Property Get Item(Row As Long, Column As Long) As Single
Public Property Let Rows(n_RowsSingle As Long)
Public Property Get Rows() As Long
Public Property Let Columns(n_ColumnsSingle As Long)
Public Property Get Columns() As Long
Public Property Let Data(n_DataSingle As Variant)
Public Property Get Data() As Variant
Public Sub Diagonals(Value As Single)
Public Sub Clear(Value As Single)
Public Function Add(Matrix1 As Variant, Matrix2 As Variant) As Single()
Public Function Subtract(Matrix1 As Variant, Matrix2 As Variant) As Single()
Public Function Multiply(Matrix1 As Variant, Matrix2 As Variant) As Single()
Public Function Divide(Matrix1 As Variant, Matrix2 As Variant) As Single()
Public Function Scalee(Matrix1 As Variant, Value As Single) As Single()
Public Function Translate(Matrix1 As Variant, Value As Single) As Single()
Public Function RotateX(Dimensions As Long, Theta As Single) As Single()
Public Function RotateY(Dimensions As Long, Theta As Single) As Single()
Public Function RotateZ(Dimensions As Long, Theta As Single) As Single()
Public Function Rotate(Dimensions As Long, Optional ThetaX As Single = 3.14156, Optional ThetaY As Single = 3.14156, Optional ThetaZ As Single = 3.14156) As Single()
Public Function Compare(Matrix1 As Variant, Matrix2 As Variant, Operator As Long) As Single()
Public Function Transpose(Matrix1 As Variant) As Single()
Public Function Inverse(Matrix1 As Variant) As Single()
Public Function Ortho(Dimensions As Long, Left As Single, Right As Single, Bottom As Single, Top As Single, Near As Single, Far As Single) As Single()
Public Function Perspective(Dimensions As Long, Theta As Single, Aspect As Single, zNear As Single, zFar As Single) As Single()
Public Function Normalize(Matrix1 As Variant) As Single()
Public Function Cross(Matrix1 As Variant, Matrix2 As Variant) As Single()
Public Function Dot(Matrix1 As Variant, Matrix2 As Variant) As Single
Public Function LookAt(Position As Variant, Direction As Variant, Y As Variant) As Single()
Public Sub Display()