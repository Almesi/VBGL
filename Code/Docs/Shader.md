## Shader
### VBGLShader.cls
This Class creates a Shader Program, Links it and cleans up the residual Vertex-and Fragment Shaders.
It also holds the Entire SourceCode of the Shader to compare it with other SourceCode to reduce redundancy.
Binding occurs on VBGLContext.
### VBGLShaderTemplate.cls
Sometimes the user doesnt want to create a new Shader for every possibility.
Sometimes you need Shaders with textures, sometimes with normals, sometimes both, sometimes neither.
Managing all that on small or big projects can be cumbersome.
`VBGLShaderTemplate` tries to ease that up, by creating shaders at runtime according to the passed `VBGLLayout` and `Uniforms`.
Before i explain how it works exactly i need to explain its helping Classes:
#### VBGLShaderVariable
GLSL creates functions as:
* `vec3 Example      = vec3(Val1, Val2, Val3)`
* `layout (location = 0) in vec3 Position`
* `in vec3 VSOutput`
* `out vec3 VSOutput`
* `uniform sampler2D TextureDiffuse`
This Class defines these Variables the following way:
1. `State` --> where does this Variable come from?
    * in
    * layout (location = i) in
    * out
    * uniform
    * var (not part of glsl but a temporary Variable declared inside `VBGLShaderTemplate`)
2. `DataType` --> declared datatype of Variable
Examples are:
    * vecX
    * matX
    * float
    * int
    * void
3. `Name` --> duh
#### VBGLShaderWorkflow
A Workflow is used to define how the Input Data will be used
Consider this:
Sometimes you want to assign certain Values to the Shaderoutput on the last line, as calculations need to be done before that.
Sometimes you just want to declare a variable and use it later, sometimes you want to assign it a value directly
Sometimes uniforms are multiplied, sometimes added, sometimes used as an argument for function etc.
To achieve this `VBGLShaderWorkflow` was created.
It works like this:
1. `WFType` --> Workflow type (how should the following data be used)
2. `Template` --> This declares how many variables work how together
3. `Vars` -->ParamArray of Variables. They will be processed and assigned to the corresponding part of the template
Why not combine Template and Vars beforehand?
The problem of assigning Variable Names to the template comes with the fact, that not all variables are created equal
Take this example:
`VAR0 = VAR1 * VAR2` --> `Output = Color1 * Color2`
Pretty simple example, but what if the all the variables have different datatypes?
`vec2 Color1`
`vec3 Color2`
`vec4 Output`
For this case `VBGLShaderWorkflow` adjusts the Variables to fit together:
`VAR0 = VAR1 * VAR2` --> `Output = vec4(vec3(Color1, 1.0) * Color2, 1.0)`
The other way is possible too:
`vec2 VAR0 = VAR1 * VAR2` --> `Output = vec2(vec3(Color1, 1.0) * Color2)`

Another important case is the ShaderOutput, Lets say gl_Position:
We usually take as input a vec3 Position, but sometimes we also have Model, view and Projection matrices.
You may also have more use cases.
If we define it as just a string it would be cumbersome to update the output everytime the program runs into a new Variable.
`VBGLShaderWorkflow` uses WFType and Template to expand the output variable and move it to the end of the function.
#### VBGLShaderFunction
At one point stuffing everything into one big Shader WILL become unreadable. To ease that up this class creates functions, that can be called.
A function has the following:
1. ReturnType
2. Name
3. ReturnVariableFor all other cases
4. Arguments
5. Workflows

Why does ReturnVariable exist if we already have ReturnType and Name?
There is a reason to that:
The Shader Programs are also considered "functions", just with no returnvalue. Their Name is "main", but the output of these functions is not called "main".
It is called `gl_Position`, `gl_FragColor` etc. To accomodate for that there is the ReturnVariable, which will return the "real" Value.
For all other cases ReturnType and Name would be the same as the once in ReturnVariable

This class will then create a function-string based on the returntype,name,arguments and workflows it has recieved

### VBGLShaderTemplate
With that defined we can come back to the Template.
Currently there are 4 defined layout-inputs:
1. Position (vec1 - vec4)
2. Texture  (vec2 - vec3)
3. Normal   (vec3 - vec4)
4. Color    (vec1 - vec4)

They are intepreted as follows:
* VertexShader
    1. Position is transformed to vec4 and passed to gl_Position
        Several are used by multiplying to gl_Position
    2. Textures are passed to FragmentShader
    3. Normals depend on Uniform Input
        If there are Model and View Uniforms it will be calculated using them
        With or without Uniforms it passes to FragmentShader
    4. Colors are passed to the FragmentShader
* FragmentShader
    1. Positions should not exist at this point
    2. Textures are used with a corresponding sampler Uniform to gl_FragColor
    3. Normals are used with many different Uniforms for Ambient, Diffuse and Specular Lighting
    4. Colors are transformed to vec4 and used on gl_FragColor