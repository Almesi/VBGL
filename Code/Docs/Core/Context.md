# VBGLContext Class Documentation
### Version 1.0
## Overview
The `VBGLContext` class represents an OpenGL rendering context in Visual Basic.  
It is the most important class, as it is the foundation on which every other Core class build.
It encapsulates OpenGL states, manages rendering resources (shaders, buffers, textures, etc.), and provides utilities to configure and control OpenGL functionality.

---

## Properties

| Property            | Type            | Description |
| --------            | -------         | -------     |
| DisplayFuncArr      | String()        | Stack of FreeGlut Callback Functions
| IdleFuncArr         | String()        | Stack of FreeGlut Callback Functions
| KeyboardFuncArr     | String()        | Stack of FreeGlut Callback Functions
| PassiveMotionFuncArr| String()        | Stack of FreeGlut Callback Functions
| MouseWheelFuncArr   | String()        | Stack of FreeGlut Callback Functions
| CurrentWindow       | VBGLWindow      | The currently Bound Object of that Type
| CurrentShader       | VBGLShader      | The currently Bound Object of that Type
| CurrentVAO          | VBGLVertexArray | The currently Bound Object of that Type
| CurrentVBO          | IBufferVertex   | The currently Bound Object of that Type
| CurrentEBO          | IBufferIndex    | The currently Bound Object of that Type
| CurrentTexture2D    | VBGLTexture     | The currently Bound Object of that Type
| StencilTest         | Boolean         | Determines if Test is Enabled
| DepthTest           | Boolean         | Determines if Test is Enabled
| BlendTest           | Boolean         | Determines if Test is Enabled
| CullFace            | Boolean         | Determines if Test is Enabled
| CullMode            | Long            | Mode of Test
| FrontFace           | Long            | Mode of Test
| PolygonMode         | Long            | Mode of Test

This List will likely expand in the future with more Callbacks

## Error Handling
Uses [std_ErrorHandler](https://github.com/Almesi/VBA_StandardLibrary/blob/main/Doc/Class/Generics/Errorhandling.md)

---

## Methods

```vb
Public Function Create(Optional ByVal FilePath As String = Empty, 
                       Optional ByVal ContextProfile As Long = 0, 
                       Optional ByVal ContextFlag As Long = 0, 
                       Optional ByVal Logger As IDestination = Nothing, 
                       Optional ByVal Shower As IDestination = Nothing) As VBGLContext
```
    * Loads the FreeGLUT library (Freeglut.dll / Freeglut64.dll).
    * Initializes GLUT context.

2. `RenderSettings(Inputt As Long, Value As Boolean)`
    * Enables/disables OpenGL features (glEnable/glDisable).

3. `RenderValue(Inputt As Long, Value1 As Long, Optional Value2 As Long, Optional Value3 As Long)`
    * Configures OpenGL state functions (e.g., glDepthFunc, glStencilFunc, glCullFace).

4. `Clear()`
    * Clears buffers (GL_COLOR_BUFFER_BIT, GL_DEPTH_BUFFER_BIT, GL_STENCIL_BUFFER_BIT) depending on enabled states.

5. `ClearColor(Optional r As Single = 0, Optional g As Single = 0, Optional b As Single = 0, Optional a As Single = 1)`
    * Sets the clear color (glClearColor).

---

## GLUT Callback Registration
The following are the Procedures, that set the Callback Function.  
* `SetDisplayFunc(Pointer As LongPtr)`
* `SetIdleFunc(Pointer As LongPtr)`
* `SetKeyboardFunc(Pointer As LongPtr)`
* `SetPassiveMotionFunc(Pointer As LongPtr)`
* `SetMouseWheelFunc(Pointer As LongPtr)`

### Stack Management
Freeglut has no clean way of changing its Callback Functions.
Once set and you will have to live with it (especially glutMainLoop).
To ensure better testability a Callback Stack was created.
Freeglut still uses only one Procedure, but that Procedure uses Visual Basic's `Application.Run` Function to Call the "real" Callback
#### Adding
* `AddDisplayFunc(Value As String)`
* `AddIdleFunc(Value As String)`
* `AddKeyboardFunc(Value As String)`
* `AddPassiveMotionFunc(Value As String)`
* `AddMouseWheelFunc(Value As String)`

#### Get Stack Value
* `DisplayFunc() As String`
* `IdleFunc() As String`
* `KeyboardFunc() As String`
* `PassiveMotionFunc() As String`
* `MouseWheelFunc() As String`


## Main Loop
* Starts the GLUT main loop (glutMainLoop).
* Can be combined with Stack Management



























# VBGLContext
### Version 1.0
| X                        | Y                |
| --------                 | -------          |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | Everything else  |
| Tags                     | OOP, VBA, OpenGL |

## Purpose

Object Oriented Implemenation of an OpenGL Context.
Holds the State maschine of a single Context.

--------------------------------------------------------

## Overview

It works by taking in a FilePath to freeglut.dll/freeglut64.dll and creating an OpenGL Context.
It is the most important class, as it is the foundation on which every other Core class build.
It encapsulates OpenGL states, manages rendering resources (shaders, buffers, textures, etc.), and provides utilities to configure and control OpenGL functionality.

* Required environment (VBA, VB)
* Dependencies (Declarations-Folder, Freeglut)
* Limitations (Not tested for more than 1 Object)

--------------------------------------------------------

## Properties

| Property            | Type             | Description |
| --------            | -------          | -------     |
| CurrentWindow       | VBGLWindow       | The currently Bound Object of that Type
| CurrentShader       | VBGLShader       | The currently Bound Object of that Type
| CurrentVAO          | VBGLVertexArray  | The currently Bound Object of that Type
| CurrentVBO          | IBufferVertex    | The currently Bound Object of that Type
| CurrentEBO          | IBufferIndex     | The currently Bound Object of that Type
| CurrentTexture2D    | VBGLTexture      | The currently Bound Object of that Type
| CurrentFrame        | VBGLFrame        | The currently Bound Object of that Type
| ErrorHandler        | std_ErrorHandler | Handles all Errors, provided you activate it and use version > 4.30
| StencilTest         | Boolean          | Determines if Test is Enabled
| DepthTest           | Boolean          | Determines if Test is Enabled
| BlendTest           | Boolean          | Determines if Test is Enabled
| CullTest            | Boolean          | Determines if Test is Enabled
| ScissorTest         | Boolean          | Determines if Test is Enabled
| StencilFuncFunc     |Long              | Arguments of StencilFunc Function
| StencilFuncRef      |Long              | Arguments of StencilFunc Function
| StencilFuncMask     |Long              | Arguments of StencilFunc Function
| DepthFunc           |Long              | Argument  of DepthFunc   Function
| BlendFuncsFactor    |Long              | Arguments of BlendFunc   Function
| BlendFuncdFactor    |Long              | Arguments of BlendFunc   Function
| CullFace            |Long              | Argument  of CullFace    Function
| FrontFace           |Long              | Current FrontFace
| ScissorX            |Long              | Values of glScissor
| ScissorY            |Long              | Values of glScissor
| ScissorWidth        |Long              | Values of glScissor
| ScissorHeight       |Long              | Values of glScissor
| ViewportX           |Long              | Values of glViewPort
| ViewportY           |Long              | Values of glViewPort
| ViewportWidth       |Long              | Values of glViewPort
| ViewportHeight      |Long              | Values of glViewPort


Currently this big list of properties exists, to wrap the Context into an Object.

## Methods
| Property | Type         | Public | Description |
| -------- | -------      | ------ | -------     |
| Create   | VBGLContext  | True   | Creates an OpenGL Context with the passed arguments        |
| SetXXX   | Void         | True   | Change XXX against any Freeglut callbackfunction. This will set up the callback        |
| LetXXX   | Void         | True   |  Change XXX against any Context-Object like VAO, EBO, Texture, Window etc. Let-Property        |
| GetXXX   | XXX          | True   |  Change XXX against any Context-Object like VAO, EBO, Texture, Window etc. Get-Property        |
| LetXXXTest   | Void         | True   |  Change XXX against any Test like StencilTest, DepthTest |
| GetXXXTest   | Void         | True   |  Change XXX against any Test like StencilTest, DepthTest |
| XXXFunc      | Void         | True   |  Change XXX against any AssignFunction like StencilFunc, DepthFunc |
| MainLoop      | Void         | True   |  Enter MainLoop |
| LeaveMainLoop | Void         | True   |  Leave MainLoop |
| Clear         | Void         | True   |  Clears OpenGL according to activated Tests |
| ClearColor    | Void         | True   |  Clears Color of currently bound Frame |
| ClearColorArr | Void         | True   | ClearColor, but takes in array instead of paramarray |

Let Properties also have side-effects to handle those objects uniquely

--------------------------------------------------------

## Examples:  
1. Describe what the Example is about
```vb
Public Sub RunApp(ByVal PathToDLL As String)
    Dim Shower       As IDestination     : Set Shower = Nothing
    Dim Logger       As IDestination     : Set Logger = std_ImmiedeateDestination.Create()
    Set CurrentContext = VBGLContext.Create(PathToDLL, GLUT_CORE_PROFILE, GLUT_DEBUG, Logger, Shower)
    If IsNothing(CurrentContext) Then Exit Sub

    CurrentContext.BlendTest = True 
    CurrentContext.DepthTest = True
    CurrentContext.CullTest = True
    Call CurrentContext.BlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    Call CurrentContext.CullFace(GL_BACK)

    '
    'Other OpenGL Code and Rendering
    '

    With CurrentContext
        Call .SetDisplayFunc(AddressOf LoopSub)
        Call .SetIdleFunc(AddressOf    LoopSub)
        Call .MainLoop()
    End With
End Sub
```
## Extra Information
* There exists a Public `CurrentContext As VBGLContext` Object.
    1. Is is used throughout the entire Library.
    2. It exists, since you usually only want to work with one bound Context
* The Context needs to be destroyed before running the code again. Otherwise `GlutInit` will crash your program


## Dependencies
* Declarations
* Freeglut.dll / Freeglut64.dll

## Testing
Tested in every Example and test, as they only work if the context exists

## Lifecycle Notes
Has to be the first VBGL Object that is created
Has to be the last VBGL Object that is destroyed

## See Also:
[Overview](..\..\Docs)