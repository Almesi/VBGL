VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "std_MsgBoxDestination"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Implements IDestination

Private Count As Long
Private p_Variable As Long

Private Property Let Variable(n_Variable As Long) 
    p_Variable = n_Variable 
End Property

Public Property Get Variable() As Long
    Variable = p_Variable 
End Property


Public Function Create(Optional n_Variable As Long = 0) As std_MsgBoxDestination
    Set Create = New std_MsgBoxDestination
End Function

Private Function IDestination_Add(ByVal Message As String, ReturnValue As Variant) As Long
    ReturnValue = MsgBox(Message, Variable)
    IDestination_Add = Count
    Count = Count + 1
End Function