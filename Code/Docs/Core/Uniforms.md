# VBGLUniforms
### Version 1.0

Encapsulates OpenGL uniform variable management for a given VBGLShader.
Parses shader source code to detect declared uniform variables.
Stores metadata (name, type, location).
Provides methods to update uniform values (float, int, vec, mat, arrays).
Tracks assigned values internally for later retrieval/debugging.

## Members

| Property    | Type          | Description |
| --------    | -------       | -------     |
| Count       | Long = 1      | Used as the count parameter for most glUniform calls (always 1 for single uniforms).
| Uniforms    | Uniform()     | Uniforms with all their Information stored
| Size        | Long          | Upperbound of Uniforms
| Shader      | VBGLShader    | Parent Shader, used for Binding

## Properties
1. `Data(Name As String, n_Data As Variant)`
    * Sets the value of a uniform.
    * Automatically calls the correct OpenGL setter based on:
        + Single() + mat*  → glUniformMatrix*fv
        + Single() + vec*  → glUniform*fv
        + Long()   + nvec* → glUniform*iv
        + Single   + float → glUniform1f
        + Long     + int/sampler2D → glUniform1i

2. `Location(Name As String) As Long`
    * Returns the OpenGL location of the uniform, or -1 if not found.

3. `Data(Name As String) As Variant`
    * Returns the last set value of the uniform, or Empty if none.

## Methods
1. `DataArr(Name As String, ParamArray n_Data() As Variant)`
    * Convenience wrapper to assign multiple values without declaring an array first.
    * Converts param array into Single() or Long().
    * Calls Data(Name).

2. `Create(n_Shader As VBGLShader) As VBGLUniforms`
    * Creates a new VBGLUniforms instance and populates uniforms by calling .UpdateUniforms(n_Shader).

3. `UpdateUniforms(n_Shader As VBGLShader)`
    * Binds the shader.
    * Scans its source code line-by-line for uniform declarations.
    * For each uniform:
        + Extracts Name and DataType.
        + Queries OpenGL (glGetUniformLocation) to get location.
        + Appends a new Uniform entry into the Uniforms array.

## Example
```vb
Public Sub TestUniforms()
    ' Assume we already compiled/linked a shader
    Dim Shader As VBGLShader
    Set Shader = VBGLShader.Create("basic.vert", "basic.frag")

    ' Assign simple float uniform
    Shader.Uniforms.Data("TextureSampler") = 0

    ' Assign vector uniform
    'either
    Dim colorVec(2) As Single
    colorVec(0) = 1!: colorVec(1) = 0!: colorVec(2) = 0!
    Shader.Uniforms.Data("FontColor") = colorVec
    'or
    Call Shader.Uniforms.DataArr("FontColor", 1!, 0!, 0!)

    ' Assign matrix uniform (4x4 identity), alternatively use VBGLMatrix.Data
    Dim mat(3, 3) As Single
    Dim i As Long
    For i = 0 To 3
        mat(i, i) = 1!
    Next i
    Shader.Uniforms.Data("Model") = mat
End Sub
```