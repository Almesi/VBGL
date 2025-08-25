## Shader
### VBGLShaderTemplate.cls
Sometimes the user doesnt want to create a new Shader for every possibility.
Sometimes you need Shaders with textures, sometimes with normals, sometimes both, sometimes neither.
Managing all that on small or big projects can be cumbersome.
`VBGLShaderTemplate` tries to ease that up, by creating shaders at runtime according to the passed `VBGLLayout` and `Uniforms`.
Before i explain how it works exactly i willexplain its helping Classes:
#### VBGLShaderVariable
GLSL creates functions as:
* `vec3 Example      = vec3(Val1, Val2, Val3)`
* `layout (location = 0) in vec3 Position`
* `in vec3 VSOutput`
* `out vec3 VSOutput`
* `uniform sampler2D TextureDiffuse`
This Class defines these Variables the following way:
1. `State` --> where does this Variable come from? Examples are:
    * in
    * layout (location = i) in
    * out
    * uniform
    * var (not part of glsl but a temporary Variable declared inside a procedure )
2. `DataType` --> declared datatype of Variable. Examples are:
    * vecX
    * matX
    * float
    * int
    * void
3. `Name` --> duh
4. `Operator` --> How should be the variable used?
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
3. `Vars` -->Array of Elements. They will be processed and assigned to the corresponding part of the template
Why not combine Template and Vars beforehand?
The problem of assigning Variable Names to the template comes with the fact, that not all variables are created equal
Take this example:
`VAR0 = VAR1 * VAR2` --> `Output = Color1 * Color2`
Pretty simple example, but what if the all the variables have different datatypes?
`vec2 Color1`
`vec3 Color2`
`vec4 Output`
For this case `VBGLShaderWorkflow` adjusts the Variables to fit together:
`VAR0 = VAR1 * VAR2` --> `Output = vec4(vec3(Color1, 1.0) * Color2), 1.0)`
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
1. `ReturnType`
2. `Name`
3. `ReturnVariable` For all other cases
4. `Compile` If it should be included in the final shader-output-string
5. `Arguments`
6. `Workflows`
7. `Variables` Used to check if a function was already defined to not cause naming issues

Why does ReturnVariable exist if we already have ReturnType and Name?
There is a reason to that:
The Shader Programs are also considered "functions", just with no returnvalue. Their Name is "main", but the output of these functions is not called "main".
It is called `gl_Position`, `gl_FragColor` etc. To accomodate for that there is the ReturnVariable, which will return the "real" Value.
For all other cases ReturnType and Name would be the same as the once in ReturnVariable

This class will then create a function-string based on the returntype,name,arguments and workflows it has recieved
This class has lots of predefined functions.
Those include: not-compilable functions predefined by glsl like `texture` or `dot` and compilable - user defined functions like `Ambient` or `Diffuse`

### VBGLIShaderElement And VBGLShaderElementCollection
`VBGLIShaderElement` can be Variable, Workflow or Function.
It defines a usable expression for the using class.
The Interface defines 4 Functions: 
`GetVariable() As VBGLShaderVariable`
Used to get a defined Variable
`GetVariableCall(WithReturnType As Boolean) As String`
Used to get a Callable expression as String
`GetVariableAll() As String`
Used to get entire expression
`Element() As Variant`
Used to return original Object


Examples:
* VBGLShaderVariable: 
1. GetVariable     : Original Object
2. GetVariableCall : (variable|vec3 variable)
3. GetVariableAll  : (variable|vec3 variable)
4. Element         : Original Object
* VBGLShaderFunction: 
1. GetVariable     : ReturnType
2. GetVariableCall : (function(arg1, arg2)|function(arg1, arg2))
3. GetVariableAll  : (function(arg1, arg2)|function(vec3 arg1, vec3 arg2)){return arg1 + arg2}
4. Element         : Original Object
* VBGLShaderWorkflow: 
1. GetVariable     : Transformed Variables
2. GetVariableCall : (Transformed Variables|vec3 Transformed Variables)
3. GetVariableAll  : (Transformed Variables|vec3 Transformed Variables{CODE})
4. Element         : Original Object
`VBGLShaderElementCollection` is just an Array of VBGLIShaderElement 

### VBGLShaderTemplate
With that defined we can come back to the Template.
Depending on the PipeLine-String it will create a Object-PipeLine
Example: "Vertex-Fragment" will create the VertexObject, which has NextShader FragmentObject
Currently there are 4 defined layout-inputs:
1. Position (vec1 - vec4)
2. Texture  (vec2 - vec3)
3. Normal   (vec3 - vec4)
4. Color    (vec1 - vec4)

Uniforms are used for all other input manipulation
Uniforms can have the following states:
VBGLShaderStateLayout     = "layout (location = x) in"
* Used for Input of first shader from Buffer
VBGLShaderStateIn         = "in"
* Used for Input of current shader
VBGLShaderStateOut        = "out"
* Used for Output of current shader
VBGLShaderStateUniform    = "uniform"
* Used as not-further-defined uniform input. NAMES ARE EXTREMELY IMPORTANT, AS MANY ARE RESERVED FOR FUNCTIONS
VBGLShaderStateUniformOut = "uniformOut"
* Used directly on output of current shader function
VBGLShaderStateVariable   = "var"
* Function scope variable
VBGLShaderStateFunction   = "func"
* Function as state
VBGLShaderStateArgument   = "arg"
* Argument Variable of Function
VBGLShaderStateMorph      = "x:y"
* Replaces Name of x with Name of y

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
    2. Textures are used with a corresponding texture function and a sampler Uniform to gl_FragColor
    3. Normals are used with many different Uniforms for Ambient, Diffuse and Specular Lighting Functions
    4. Colors are transformed to vec4 and used on gl_FragColor