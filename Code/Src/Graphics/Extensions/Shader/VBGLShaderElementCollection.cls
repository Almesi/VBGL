VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLShaderElementCollection"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private p_Elements() As VBGLIShaderElement
Private p_Size As Long

Public Property Let Elements(ByVal n_Elements As Variant)            
    Let p_Elements = n_Elements
    Size = USize(n_Elements)      
End Property
Public Property Let Element(ByVal Index As Long, ByVal n_Element As VBGLIShaderElement) 
    Set p_Elements(Index) = n_Element        
End Property
Public Property Get Elements() As Variant             
    Let Elements = p_Elements       
End Property
Public Property Get Element(ByVal Index As Long) As VBGLIShaderElement  
    Set Element = p_Elements(Index)
End Property
Public Property Let Size(ByVal n_Size As Long)            
    Let p_Size = n_Size       
End Property
Public Property Get Size() As Long 
    Let Size = p_Size      
End Property

Public Function Create(ParamArray Variables() As Variant) As VBGLShaderElementCollection
    Dim i As Long
    Dim Temp() As VBGLIShaderElement
    ReDim Temp(UBound(Variables))
    For i = 0 To Ubound(Variables)
        Set Temp(i) = Variables(i)
    Next i
    Set Create = CreateArr(Temp)
End Function
Public Function CreateArr(Variables() As VBGLIShaderElement) As VBGLShaderElementCollection
    Set CreateArr = New VBGLShaderElementCollection
    With CreateArr
        .Elements = Variables
        .Size = USize(Variables)
    End With
End Function

Public Function Add(ByVal Value As VBGLIShaderElement) As VBGLIShaderElement
    Size = Size + 1
    ReDim Preserve p_Elements(Size)
    Set p_Elements(Size) = Value
    Set Add = Value
End Function

Public Function Find(ByVal Value As String) As Variant
    Dim i As Long
    For i = 0 To USize(p_Elements)
        If p_Elements(i).GetVariable.Name = Value Then
            Set Find = p_Elements(i)
            Exit Function
        End If
    Next i
    Set Find = Nothing
End Function

Public Function Reverse() As VBGLShaderElementCollection
    Dim i As Long
    Dim Temp() As VBGLIShaderElement
    ReDim Temp(Size)
    For i = 0 To Size
        Set Temp(i) = Element(i).GetVariable.Reverse
    Next i
    Set Reverse = CreateArr(Temp)
End Function

Public Function AddUnique(ByVal Value As VBGLIShaderElement) As VBGLIShaderElement
    Set AddUnique = Find(Value.GetVariable.Name)
    If IsNothing(AddUnique) Then Set AddUnique = Add(Value) 
End Function

Public Function Transform(ByVal Text As String) As VBGLShaderVariable
    If Text = Empty Then Exit Function
    If Size = -1 Then Exit Function
    Dim Var As VBGLIShaderElement
    Set Var = Element(Size)

    Dim StartIndex As Long
    StartIndex = Size

    Repeat:
    Dim Result As VBGLShaderVariable
    If IsSomething(Var) Then
        Set Result = Var.GetVariable.Clone()
    ElseIf StartIndex = 0 Then
        Set Result = Var.GetVariable.Clone()
    Else
        StartIndex = StartIndex - 1
        Set Var = Element(StartIndex)
        GoTo Repeat
    End If

    Dim FirstIndex As Long, SecondIndex As Long
    For FirstIndex = StartIndex To 1 Step -1
        If IsSomething(Element(FirstIndex)) Then
            For SecondIndex = FirstIndex - 1 To 1 Step-1
                If IsSomething(Element(SecondIndex)) Then
                    Exit For
                End If
            Next SecondIndex
    
            Dim StartPoint  As Long: StartPoint = InStr(1, Text, "VAR" & SecondIndex)
            Dim EndPoint    As Long: EndPoint   = InStr(1, Text, "VAR" & FirstIndex)
            If EndPoint = 0 Then
                EndPoint = Len("VAR" & SecondIndex)
            Else
                EndPoint = EndPoint + Len("VAR" & FirstIndex) - 1
            End If
            Dim NewText         As String: NewText = VBGLMidP(Text, StartPoint, EndPoint)
            Dim NextVar         As VBGLShaderVariable
            Set NextVar = Element(SecondIndex).GetVariable()
            Set Result = NextVar.MakeNewVariable(Result, SecondIndex, FirstIndex, NewText, NextVar.Operator)
            Text = Replace(Text, NewText, "VAR" & SecondIndex)
        End If
    Next FirstIndex
    Result.Name = Replace(Text, "VAR0", Result.Name)
    Set Transform = Result
End Function

Private Sub Class_Initialize()
    Size = -1
End Sub