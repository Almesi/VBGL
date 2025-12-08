# Declarations
### Version 1.0
| X                        | Y                |
| --------                 | -------          |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | OpenGL           |
| Tags                     | OOP, VBA, OpenGL |

## Purpose

VBA-Wrapper for OpenGL functions, so they can be used in VBA/VB

--------------------------------------------------------

## Overview

This Folder holds all Declarations of all OpenGL Functions, Procedures, Variables and Constants defined from version 1.0 to 4.6 and Extras.

All other classes are dependant on these declarations, as they are the actual functions that implement OpenGL in VBA.


--------------------------------------------------------

## Properties
XXX

## Methods
XXX

--------------------------------------------------------

## Examples:  
1. Describe what the Example is about
```vb
Public Sub FonctionOpenGL(ByVal Path As String)
    If LoadLibrary(Path & "\freeglut.dll") = 0 Then
        Exit Sub
    End If
    Call glutInit(0&, "")
    Call glutInitDisplayMode(GLUT_RGBA Or GLUT_DOUBLE Or GLUT_DEPTH)
    Call glutCreateWindow("Test")
    Call glutSetOption(GLUT_ACTION_ON_WINDOW_CLOSE, GLUT_ACTION_GLUTMAINLOOP_RETURNS)
    Call glutDisplayFunc(AddressOf CallBackDraw)
    Call glutMainLoop()
End Function

Public Sub CallBackDraw()
    Call glClear(GL_COLOR_BUFFER_BIT Or GL_DEPTH_BUFFER_BIT)
    Call glutSwapBuffers()
End Sub
```

## Extra Information
XXX

## Dependencies
* Freeglut.dll / Freeglut64.dll
* OpenGL Implemenation on your GPU

## Testing
Done by the original Author
I did not find him to link him, so if you are the original Developer or know him please let me know

## Lifecycle Notes
As they are Functions they always exist(1.0)
All other Versions (>1.0) have to be dynamically loaded from the GPU (done by VBGLContext and VBGLWindow)

## See Also:
Great thanks to [The most important Link](https://arkham46.developpez.com/articles/office/vbaopengl/?page=page_1).
Under this link you can find everything you need to get started with OpenGL in VBA