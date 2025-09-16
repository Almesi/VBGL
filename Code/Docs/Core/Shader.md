# VBGLShader.cls
### Version 1.0
## Overview

The `VBGLShader` class provides a Visual Basic wrapper around OpenGL shader objects and programs.

---

It manages:
* Creation of vertex and fragment shaders.
* Compilation and linking of shaders into programs.
* Binding/unbinding of programs to the current OpenGL context.
* Caching of shaders and programs to avoid redundant compilation.
* Error handling with detailed compiler and linker logs.
* Automatic uniform management via the VBGLUniforms class.

This class also stores the full source code of each shader or program. The stored source is used for comparison, ensuring that duplicate shaders/programs are not recompiled unnecessarily.

The class is tightly coupled with the VBGLContext (for error handling and active shader tracking) and VBGLUniforms (for uniform discovery and management).

---

## Properties

| Property | Type         | Description |
| -------- | -------      | -------     |
| Context  | VBGLContext  | The rendering context this shader/program belongs to.
| Code     | String       | Full source code
| ID       | Long         | OpenGL object ID for the shader/program
| Uniforms | VBGLUniforms | Container of all uniform variables discovered in the program.


## Methods
### Creation & Compilation

1. `Create() As VBGLShader`
    * Creates a new empty shader program (via glCreateProgram).

2. `CreateShader(ShaderType As Long, SourceCode As String) As VBGLShader`
    * Creates, compiles, and caches a single shader (vertex or fragment).
    * ShaderType: OpenGL shader type (GL_VERTEX_SHADER or GL_FRAGMENT_SHADER).

3. `CreateShaderProgram(VertexCode As String, FragmentCode As String) As VBGLShader`
    * Creates a full shader program by compiling and linking vertex and fragment shaders.
    * Generates a VBGLUniforms object.

4. `CreateFromFile(VertexShaderFile As String, FragmentShaderFile As String) As VBGLShader`
    * Loads vertex and fragment source code from text files and Calls CreateShaderProgram.

5. `CreateFromText(Text As String) As VBGLShader`
    * Splits a combined shader source string (vertex|fragment) and creates a program.

6. `CompileShader(SourceCode As String) As Boolean`
    * Compiles shader source and checks for errors.
    * Returns True if successful.

7. `LinkShader(VertexShader As VBGLShader, FragmentShader As VBGLShader) As Boolean`
    * Links a vertex and fragment shader into a complete program.
    * Returns True if successful.

8. `Bind()`
    * Activates this shader program and updates CurrentContext.

9. `Unbind()`
    * Deactivates any currently bound shader program and updates CurrentContext.

10. `DeleteShader(Shader As Long)`
    * Deletes a shader object from OpenGL memory.

## Error Handling
Uses [std_ErrorHandler](https://github.com/Almesi/VBA_StandardLibrary/blob/main/Doc/Class/Generics/Errorhandling.md)


---

## Examples:  
1. Vertex-Fragment Shader
```vb
Public Sub TestShader()
    Dim VertexShader   As String
    Dim FragmentShader As String

    VertexShader   = "Your\File\Path.xxx"
    FragmentShader = "Your\File\Path.xxx"

    Dim Shader As VBGLShader
    Set Shader = VBGLShader.CreateFromFile(VertexShader, FragmentShader)
    Call Shader.Bind()
End Sub
```
2. Seperate Shaders and Linking
```vb
Public Sub TestShader()
    Dim VertexShader   As String
    Dim FragmentShader As String

    VertexShader   = "Your\File\Path.xxx"
    FragmentShader = "Your\File\Path.xxx"

    Dim VertexShaderObj   As VBGLShader
    Dim FragmentShaderObj As VBGLShader

    Set VertexShaderObj   = GLShader.CreateShader(VertexShader)
    Set FragmentShaderObj = GLShader.CreateShader(FragmentShader)

    Dim LinkedShader As VBGLShader
    Set LinkedShader = VBGLShader.LinkShader(VertexShaderObj, FragmentShaderObj)
    Call LinkedShader.Bind()
End Sub
```
3. Shader Caching
```vb
Public Sub TestShader()
    Dim VertexShader   As String
    Dim FragmentShader As String

    VertexShader   = "Your\File\Path.xxx"
    FragmentShader = "Your\File\Path.xxx"

    Dim VertexShaderObj   As VBGLShader
    Dim NewVertexShader As VBGLShader
    Dim FragmentShaderObj As VBGLShader

    Set VertexShaderObj   = GLShader.CreateShader(VertexShader)
    Set NewVertexShader   = GLShader.CreateShader(VertexShader)   'Will NOT create a new Object, instead fill find Shader with same SourceCode
    Set FragmentShaderObj = GLShader.CreateShader(FragmentShader)


    Dim LinkedShader    As VBGLShader
    Dim NewLinkedShader As VBGLShader
    ' Those 2 Are the same
    Set LinkedShader    = VBGLShader.LinkShader(VertexShaderObj, FragmentShaderObj)
    Set NewLinkedShader = VBGLShader.LinkShader(NewVertexShader, FragmentShaderObj)   'Will NOT create a new Object, instead fill find Shader with same SourceCode
    Call LinkedShader.Bind()
End Sub
```

---

## Uniform Management

Each successfully linked program automatically constructs a VBGLUniforms object.
This object introspects all uniforms declared in the shaders and exposes methods to set values (matrices, vectors, floats, etc.).
For further Documentation see [VBGLUniforms.md](VBGLUniforms.md)

## Lifecycle Notes
Initialization: Class_Initialize sets the shader’s context to CurrentContext.
Termination: Class_Terminate automatically deletes the shader/program from OpenGL memory.