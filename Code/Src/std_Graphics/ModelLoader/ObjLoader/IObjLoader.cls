VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "IObjLoader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Public Sub Load(FilePath As String)
Public Property Let Objects(n_Objects() As GLObject)
Public Property Get Objects() As GLObject()
Public Property Let Object(Index As Long, n_Object As GLObject)
Public Property Get Object(Index As Long) As GLObject
Public Function Groups() As GLGroup()