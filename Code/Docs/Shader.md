## Shader
### VBGLShader.cls
This Class creates a Shader Program, Links it and Caches everything.
It also holds the Entire SourceCode of the Shader to compare it with other SourceCode to reduce redundancy.
Binding occurs on VBGLContext.
Use CreateShader to create a single Shader according to ShaderType
Use CreateShaderProgram to create entire program from shaders and links them