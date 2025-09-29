VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "std_ImmiedeateDestination"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Implements IDestination

Private Count As Long

Public Function Create() As std_ImmiedeateDestination
    Set Create = New std_ImmiedeateDestination
End Function

Private Function IDestination_Add(ByVal Message As String, ByRef ReturnValue As Variant) As Long
    ReturnValue = Empty
    Debug.Print Message
    IDestination_Add = Count
    Count = Count + 1
End Function