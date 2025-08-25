VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "std_ErrorHandler"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Option Explicit

Private p_Logger As IDestination
Private p_Shower As IDestination


Public Function IS_ERROR() As Boolean
    IS_ERROR = True
End Function

Public Property Let Logger(n_Logger  As IDestination)  : Set p_Logger = n_Logger : End Property
Public Property Let Shower(n_Shower  As IDestination)  : Set p_Shower = n_Shower : End Property

Public Property Get Logger()          As IDestination  : Set Logger   = p_Logger : End Property
Public Property Get Shower()          As IDestination  : Set Shower   = p_Shower : End Property


Public Function Create(n_Shower As IDestination, n_Logger As IDestination) As std_ErrorHandler
    Set Create = New std_ErrorHandler
    With Create
        .Logger = n_Logger
        .Shower = n_Shower
    End With
End Function

Public Function Handle(Condition As Boolean, ConditionError As std_Error) As Boolean
    Dim Message As String
    Dim ShowVariable As Variant
    Dim LogVariable  As Variant
    If Condition = IS_ERROR Then
        Message = ConditionError.HandleDebug()
        If Not Logger Is Nothing Then Call Logger.Add(Message, ShowVariable)
        If Not Shower is Nothing Then Call Shower.Add(Message, LogVariable)
    End If
    Handle = Condition
End Function