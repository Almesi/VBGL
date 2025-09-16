VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "std_ErrorInterpret"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Implements IErrorInterpret

Private p_Variable As Variant

Public Property Let Variable(ByVal n_Variable As Variant)
    If IsObject(n_Variable) Then
        Set p_Variable = n_Variable
    Else
        Let p_Variable = n_Variable
    End If
End Property
Public Property Get Variable() As Variant
    If IsObject(p_Variable) Then
        Set Variable = p_Variable
    Else
        Let Variable = p_Variable
    End If
End Property

Public Function Create(ByVal n_Variable As Variant) As std_ErrorInterpret
    Set Create = New std_ErrorInterpret
    Create.Variable = n_Variable
End Function

Private Function IErrorInterpret_Interpret() As String
    Select Case VarType(Variable)
        Case vbString : IErrorInterpret_Interpret = Cstr(Variable)
        Case vbSingle : IErrorInterpret_Interpret = Cstr(Variable)
        Case vbDouble : IErrorInterpret_Interpret = Cstr(Variable)
        Case vbLong   : IErrorInterpret_Interpret = Cstr(Variable)
        Case vbInteger: IErrorInterpret_Interpret = Cstr(Variable)
        Case Else     : IErrorInterpret_Interpret = "NON-PRINTABLE-VALUE"
    End Select
End Function