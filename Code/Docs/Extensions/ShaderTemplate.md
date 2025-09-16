## Shader

### `VBGLShaderTemplate.cls`

Sometimes you don’t want to create a new shader for every possibility.  
Sometimes you need shaders with textures, sometimes with normals, sometimes both, sometimes neither.  
Managing all of this in small or large projects can be cumbersome.  

`VBGLShaderTemplate` aims to simplify this by creating shaders at runtime based on the provided `VBGLLayout` and `Uniforms`.

Before explaining how it works, let's review its helper classes.

---

### `VBGLShaderVariable`

GLSL variables can appear like this:

```glsl
vec3 Example = vec3(Val1, Val2, Val3);
layout(location = 0) in vec3 Position;
in vec3 VSOutput;
out vec3 VSOutput;
uniform sampler2D TextureDiffuse;
```

`VBGLShaderVariable` represents these variables with the following attributes:

1. **State** – Where the variable comes from:  
    * `in`  
    * `layout(location = i) in`  
    * `out`  
    * `uniform`  
    * `var` (temporary variable inside a procedure)
2. **DataType** – GLSL datatype:  
    * `vecX`  
    * `matX`  
    * `float`, `int`, `void`  
3. **Name** – The variable name.  
4. **Operator** – How the variable will be used in calculations.

---

### `VBGLShaderWorkflow`

A workflow defines how input data is processed and assigned in a shader.

Use cases:

* Assign values to shader outputs after calculations.  
* Declare a variable for later use.  
* Perform arithmetic or function calls on uniforms or variables.

**Workflow components:**

1. **WFType** – Defines how data is used.  
2. **Template** – Describes how variables work together.  
3. **Vars** – Array of variables, processed and mapped to the template.

Example of type adjustment:
```glsl
VAR0 = VAR1 * VAR2 --> Output = Color1 * Color2
```
Pretty simple example, but what if the all the variables have different datatypes?  

```glsl
vec2 Color1
vec3 Color2
vec4 Output
```
For this case VBGLShaderWorkflow adjusts the Variables to fit together:
```glsl
VAR0 = VAR1 * VAR2 --> Output = vec4(vec3(Color1, 1.0) * Color2, 1.0)
```
The other way is possible too:
```glsl
vec2 VAR0 = VAR1 * VAR2 --> Output = vec2(vec3(Color1, 1.0) * Color2)
```

Shader output handling (like `gl_Position`) is automated by using `WFType` and `Template`, so outputs adjust dynamically based on input variables and matrices.

---

### `VBGLShaderFunction`

To keep shaders readable, `VBGLShaderFunction` allows creating reusable functions.

Attributes:

1. `ReturnType`  
2. `Name`  
3. `ReturnVariable` – accommodates GLSL outputs like `gl_Position`, `gl_FragColor`.  
4. `Compile` – whether the function is included in the final shader.  
5. `Arguments`  
6. `Workflows`  
7. `Variables` – checks for naming conflicts.

This class builds function strings based on workflows, arguments, and return values.  
It supports both GLSL predefined functions (like `texture`, `dot`) and user-defined functions (like `Ambient`, `Diffuse`).

---

### `VBGLIShaderElement` and `VBGLShaderElementCollection`

`VBGLIShaderElement` can be a Variable, Workflow, or Function.  
It exposes the following interface:

* `GetVariable() As VBGLShaderVariable` – Get the object.  
* `GetVariableCall(WithReturnType As Boolean) As String` – Get callable string.  
* `GetVariableAll() As String` – Get full expression.  
* `Element() As Variant` – Return the original object.

**Examples:**

*Variable:*

| Function          | Output |
|----------         |-------|
| `GetVariable`     | Original Object |
| `GetVariableCall` | `vec3 variable` |
| `GetVariableAll`  | `vec3 variable` |
| `Element`         | Original Object |

*Function:*

| Function          | Output |
|----------         |-------|
| `GetVariable`     | ReturnType |
| `GetVariableCall` | `function(arg1, arg2)` |
| `GetVariableAll`  | `function(arg1, arg2){return arg1 + arg2}` |
| `Element`         | Original Object |

*Workflow:*

| Function          | Output |
|----------         |-------|
| `GetVariable`     | Transformed Variables |
| `GetVariableCall` | `(Transformed Variables or vec3 Transformed Variables)` |
| `GetVariableAll`  | `(Transformed Variables or vec3 Transformed Variables{CODE})` |
| `Element`         | Original Object |

`VBGLShaderElementCollection` is simply an array of `VBGLIShaderElement`.

---

### `VBGLShaderTemplate`

The template builds shader pipelines dynamically. Example:

* `"Vertex-Fragment"` → creates a VertexObject linked to a FragmentObject.

**Layout Inputs:**

1. `Position` (vec1–vec4)  
2. `Texture`  (vec2–vec3)  
3. `Normal`   (vec3–vec4)  
4. `Color`    (vec1–vec4)

**Uniform States:**

| State | Description        |
|-------|------------        |
| `VBGLShaderStateLayout`    | `layout(location = x) in` – Input from buffer |
| `VBGLShaderStateIn`        | `in` – Input to current shader |
| `VBGLShaderStateOut`       | `out` – Output from current shader |
| `VBGLShaderStateUniform`   | `uniform` – Standard uniform input (names are important) |
| `VBGLShaderStateUniformOut`| `uniformOut` – Output of current shader function |
| `VBGLShaderStateVariable`  | `var` – Function-scope variable |
| `VBGLShaderStateFunction`  | `func` – Function as state |
| `VBGLShaderStateArgument`  | `arg` – Function argument |
| `VBGLShaderStateMorph`     | `x:y` – Replaces variable `x` with `y` |

**Pipeline Interpretation:**

*Vertex Shader:*

1. Transform `Position` to `vec4` and assign to `gl_Position`.  
2. Pass `Texture` to FragmentShader.  
3. Compute `Normal` using Model/View matrices if available, then pass to FragmentShader.  
4. Pass `Color` to FragmentShader.

*Fragment Shader:*

1. Positions should not exist.  
2. Use `Texture` with sampler uniform for `gl_FragColor`.  
3. Use `Normal` for lighting (Ambient, Diffuse, Specular).  
4. Transform `Color` to `vec4` for `gl_FragColor`.