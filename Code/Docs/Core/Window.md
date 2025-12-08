# VBGLWindow
### Version 1.0
| X                        | Y                |
| --------                 | -------          |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLContext      |
| Tags                     | OOP, VBA, OpenGL |

## Purpose

VBGLWindow represents a managed OpenGL window within a VBA/Visual Basic 6 environment, providing facilities for window creation, OpenGL context setup, input control, timing/FPS management, and viewport/scissor initialization.
It exists to abstract away the lower-level GLUT and OpenGL setup steps, making window creation in VB more consistent and object-oriented.

--------------------------------------------------------

## Overview


* VBGLWindow encapsulates the lifecycle of an OpenGL rendering window using GLUT bindings for VBA. The class handles:
* Creation and reuse of windows (preventing duplicate titles)
* OpenGL context version selection (default 4.6)
* Automatic mapping of OpenGL functions into VBA (RemapVBToGL)
* Initial viewport/scissor setup
* Managing rendering frames (VBGLFrame)
* FPS limiting using WinAPI Sleep
* Window binding/unbinding to a global rendering context

This is the primary entry point for creating OpenGL rendering windows.
It will reuse an existing window if another window with the same title already exists.
FPS limiter uses VBA Timer (1-ms precision varies).



--------------------------------------------------------

## Properties

| Property     | Type      | Public  | Description                                                                  |
| ------------ | --------- | ------- | ---------------------------------------------------------------------------- |
| ID           | Long      | Get/Let | GLUT window ID used by OpenGL for referencing.                               |
| Title        | String    | Get/Let | Human-readable title of the window. Also prevents duplicate window creation. |
| Height       | Long      | Get/Let | Height in pixels.                                                            |
| Width        | Long      | Get/Let | Width in pixels.                                                             |
| FPS          | Single    | Get/Let | Requested maximum frames per second (0 = unlimited).                         |
| Frame        | VBGLFrame | Get/Let | Rendering frame buffer / drawing boundary object.                            |
| NormalHeight | Single    | Get     | Returns `1 / Height` for normalized transforms.                              |
| NormalWidth  | Single    | Get     | Returns `1 / Width` for normalized transforms.                               |


## Methods

|Method    | Type       | Public | Description              |
| ---      | ---        | ---    | ---                      |
| Create() | VBGLWindow | True   | Creates an OpenGL window |
| Cursor() | Void       | True   | Warps the mouse cursor to the specified coordinates inside the window. |
| GetWindowHwnd | Long (HWND) | True   | Returns the OS-level window handle for integration with WinAPI. |
| Bind()     | None    | True   | Sets this window as the active context in `CurrentContext`. |
| Unbind()   | None    | True   | Clears active window context.                               |
| LimitFPS() | Single  | True   | Pauses execution to maintain target FPS and returns the actual achieved FPS. |
| Find()          | VBGLWindow | False | Searches `LoadedWindows` for window by title.                      |
| CreateWindow()         | Long       | False | Wrapper for `glutCreateWindow`, sets title.                        |
| RemapVBToGL(ToInclude) | Boolean    | False | Recursively loads OpenGL function maps for all supported versions. |



--------------------------------------------------------

## Examples:  
1. Create a Basic OpenGL Window
```vb
Public Sub CreateWindow()
    Dim Win As VBGLWindow
    Set Win = VBGLWindow.Create(800, 600, GLUT_RGBA Or GLUT_DOUBLE, _
                                "DemoWindow", "4_6", True)
    Win.FPS = 60
    Win.Bind
    ' Application main loop here
End Sub
```

2. Limit Frame Rate
```vb
Public Sub FPS()
    Dim Win As VBGLWindow
    Set Win = VBGLWindow.Create(640, 480, GLUT_RGBA, "FPS Test")
    Do
        Debug.Print Win.LimitFPS()
    Loop
End Sub
```

3. Move Cursor in Window
```vb
Public Sub Cursor()
    Dim Win As VBGLWindow
    Set Win = VBGLWindow.Create(400, 300, GLUT_RGBA, "Cursor Window")
    Win.Cursor 200, 150
End Sub
```



## Extra Information
* The window automatically destroys itself in Class_Terminate.
* The OpenGL mappers (RemapVBToGL1_1, RemapVBToGL4_6, etc.) provide late-binding for GL extensions.
* CurrentContext is expected to be a global structure managing pipelines, scissoring, and viewport state.

## Dependencies
* VBGLCurrentContext
* VBGLFrame

## Testing
Not tested properly. The following needs to be tested:
* Test window creation under various OpenGL versions (2.0 → 4.6).
* Verify FPS limiting under heavy and light workloads.
* Ensure multiple windows do not conflict (Frame and Context states must remain isolated).

## Lifecycle Notes
* Instances are normally created through .Create() only.
* When a window is terminated, the underlying GLUT window is destroyed.
* Avoid manually destroying the object while inside the main loop.
* Context switching can occur using Bind() and Unbind().
* It must be the second VBGL Object that is created(Right after VBGLContext)
* It must be the second-last VBGL Object that is destroyed(Right before VBGLContext)

## See Also:
[VBGLFrame](..\Frame.md)
[CurrentContext](..\Context.md)