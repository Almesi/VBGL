VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "IMtlLoader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Public Sub Load(FilePath As String)
Public Property Let Materials(n_Materials() As GLMaterial)
Public Property Get Materials() As GLMaterial()