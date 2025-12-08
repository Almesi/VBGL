Attribute VB_Name = "ExampleRenderObject"

Option Explicit

'================================================================================
' Shows how use RenderObject Class to create Sub-Mainloops
' FreeGlut does not allow to leave the mainloop without destroying the window.
' Sometimes you want to have subloop in the mainloop
' That can be fixed with RenderObject, which should be used as a SubLoop
' By creating a "CurrentRenderObject" Object, which is used by the actual mainloop you can change the functionality of the mainloop by changing the Object
'================================================================================

' Currently no example, but VBGLTestAll1 basically does the same