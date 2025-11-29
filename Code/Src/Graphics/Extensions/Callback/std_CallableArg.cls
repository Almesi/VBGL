VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "std_CallableArg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private p_Optionall    As String
Private p_AsValue      As String
Private p_Param        As String
Private p_Name         As String
Private p_ReturnType   As String
Private p_ReturnValue  As String
Private p_Values       As Variant

Public Property Get Optionall()    As String : Optionall    = p_Optionall    : End Property
Public Property Get AsValue()      As String : AsValue      = p_AsValue      : End Property
Public Property Get Param()        As String : Param        = p_Param        : End Property
Public Property Get Name()         As String : Name         = p_Name         : End Property
Public Property Get ReturnType()   As String : ReturnType   = p_ReturnType   : End Property
Public Property Get ReturnValue()  As String : ReturnValue  = p_ReturnValue  : End Property

Public Property Let Values(ByVal n_Values As Variant)
    If IsObject(n_Values) Then
        Set p_Values = n_Values
    Else
        Let p_Values = n_Values
    End If
End Property

Public Property Get Values() As Variant
    If IsObject(p_Values) Then
        Set Values = p_Values
    Else
        Let Values = p_Values
    End If
End Property

Public Function Clone() As std_CallableArg
    Set Clone = CreateFromText(Text)
End Function

Public Function CreateFromText(ByVal Definition As String) As std_CallableArg
    Set CreateFromText = New std_CallableArg
    With CreateFromText
        Call .ParseDefinition(Definition)
    End With
End Function

Public Function Text() As String
    Dim Result As String
    Result = Result & Iif(Optionall   <> Empty, Optionall & " ", Empty)
    Result = Result & Iif(AsValue     <> Empty, AsValue  & " ", Empty)
    Result = Result & Iif(Param       <> Empty, Param    & " ", Empty)
    Result = Result & Name
    Result = Result & Iif(ReturnType  <> Empty, " As " & ReturnType, "As Variant")
    Result = Result & Iif(ReturnValue <> Empty, ReturnValue & " ", Empty)
    Text = Result
End Function

Public Sub ParseDefinition(ByVal Definition As String)
    Dim Temp() As String
    Dim Index As Long
    Temp = Split(Definition, " ")
    If Temp(Index) = Empty Then Index = Index + 1
    If UCase(Temp(Index)) = "OPTIONALl" Then
        p_Optionall  = Temp(Index)
        Index = Index + 1
    End If
    If UCase(Temp(Index)) = "BYVAL" Or UCase(Temp(Index)) = "BYREF" Then
        p_AsValue = Temp(Index)
        Index = Index + 1
    End If
    If UCase(Temp(Index)) = "PARAMARRAY" Then
        p_Param = Temp(Index)
        Index = Index + 1
    End If
    p_Name = Temp(Index)
    Index = Index + 1
    If Index =< USize(Temp) Then
        If UCase(Temp(Index)) Like "AS" Then
            p_ReturnType = Temp(Index + 1)
        End If
    Else
        p_ReturnType = "Variant"
    End If
    Index = Index + 1
    If UCase(Optionall) = "OPTIONALl" And UBound(Temp) >= Index Then
        p_ReturnValue = " = " & Temp(Index)
    End If
    If AsValue = Empty Then
        p_AsValue = "ByRef"
    End If
End Sub

Private Function Missing(Optional ByVal DontPopulateThisVariable) As Variant
    Missing = DontPopulateThisVariable
End Function

Private Sub Class_Initialize()
    Values = Missing()
End Sub