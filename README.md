# VBGL - Visual Basic Graphics Library
VBGL is a Visual Basic-based graphics library designed to interface with OpenGL for rendering 3D models and graphics.
It provides an approach to handling OpenGL contexts, shaders, models, textures, and rendering pipelines in Visual Basic.

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













To run or use VBGL, you will need:
Microsoft Excel (or another Office application that supports VBA).
Windows OS (because of FreeGLUT native binaries)
The FreeGLUT DLLs (both 32-bit and/or 64-bit as needed)
If using VBA’s extensibility features (std_VBProject.cls), ensure Microsoft Visual Basic for Applications Extensibility 5.3 reference is enabled.

### Getting Started

#### You just want to test it?
* Open TestGL.xlsm in Excel.
* Open the VBA Editor (press ALT + F11).
* Go to Tools → References, and check Microsoft Visual Basic for Applications Extensibility 5.3.
* Run the macro named Test.
* You should see a window pop up, that asks you to select a Test.
* Select the test and press "t" to test it, press "ESC" to go back.

#### You want to use it?
* Include the entire "Declarations" Folder into your Project
* Include the entire "Core" Folder into your Project

##### Main Way
The start will always be the same:
0. Do whatever you need before using OpenGL
1. Create an OpenGL Context
2. Create a Window
3. Create OpenGL objects you need
4. Create the rest of things you need to do
5. Set Callbacks for Freeglut
6. Call mainloop
7. Cleanup

### Examples
In the Graphics Folder, there is the folder Examples
There you can find importable examples with dependencies written on top of file as a comment


### Contribution
Contributions are welcome! If you would like to help, read the [Contribution Document](Contribution.md)