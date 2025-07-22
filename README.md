# VBGL - Visual Basic Graphics Library
VBGL is a Visual Basic-based graphics library designed to interface with OpenGL for rendering 3D models and graphics. It provides an approach to handling OpenGL contexts, shaders, models, textures, and rendering pipelines in Visual Basic.

## Structure

### Code
- **TestGL.xlsm**: Use this file to Test this Library

### Documentation
- **Graph.png**   : Visual representation of the system architecture or data flow.
- **Contribution**: If you wish to contribute please look into the `Contribution.md` File

### Res
- **freeglut.dll / freeglut64.dll**: Required runtime libraries for OpenGL rendering.
- **Capsule, Cube, Teapot**        : Resource folders containing `.obj`, `.mtl`, and Image files for 3D models used in demonstrations.

## Getting Started

### You just want to test the library?
1. Open TestGL.xlsm
2. Open VBE
3. GoTo Tools->References and Add "Microsoft Visual Basic for Applications Extensibility 5.3" (This is used to dinamically load the entire Code)
4. Run Macro `Test`

### You want to use the Library?
1. Add Declarations to your Project
2. Create Context via VBGLContext (Needs FilePath to FreeGlut/FreeGlut64)
3. Create Window via VBGLWindow
4. Define Callback Functions
5. Create usable Data via VBGLModel
6. Call Mainloop