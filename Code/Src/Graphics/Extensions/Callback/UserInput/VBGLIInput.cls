VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLIInput"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Option Explicit

Public Function Handle(ByVal Button As Long, ByVal Value As Long, ParamArray Args() As Variant) As Variant
End Function
Public Function KeyDown(ByVal Value As Long, ParamArray Args() As Variant) As Variant
End Function
Public Function KeyUp(ByVal Value As Long, ParamArray Args() As Variant) As Variant
End Function
Public Function MouseMove(ByVal Value As Long, ParamArray Args() As Variant) As Variant
End Function
Public Function MouseClick(ByVal Value As Long, ParamArray Args() As Variant) As Variant
End Function
Public Function MouseWheel(ByVal Value As Long, ParamArray Args() As Variant) As Variant
End Function