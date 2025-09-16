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