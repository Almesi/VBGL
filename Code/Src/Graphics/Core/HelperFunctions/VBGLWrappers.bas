Attribute VB_Name = "VBGLWrappers"

Option Explicit

'=========================================
' VBGL Wrapper Conversion Functions
'=========================================

Public Function VBGLCSng(ByVal v As Variant) As Single
    VBGLCSng = CSng(v)
End Function

Public Function VBGLCLng(ByVal v As Variant) As Long
    VBGLCLng = CLng(v)
End Function

Public Function VBGLCDbl(ByVal v As Variant) As Double
    VBGLCDbl = CDbl(v)
End Function

Public Function VBGLCStr(ByVal v As Variant) As String
    VBGLCStr = CStr(v)
End Function

Public Function VBGLCBool(ByVal v As Variant) As Boolean
    VBGLCBool = CBool(v)
End Function

Public Function VBGLCDate(ByVal v As Variant) As Date
    VBGLCDate = CDate(v)
End Function
