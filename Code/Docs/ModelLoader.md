## Obj Files
.obj Files defines its data globally. That means no matter where in the file it is declared it can be used at any other point in the file
.obj Files also define objects, groups, materials, smoothings and many more things.
All of that is very unreadable once loaded
To create better readability the classes are created:
1. Objects hold a Name and Groups
2. Groups hold a Name and Subgroups
3. Subgroups hold a set of usable data, used Material, used Smoothing and DataLayout
4. GLVertex hold the specific VertexData (Position, Texture, Normal or Color)
5. GLFace holds the Indices for each VertexData in GLVertex

#### Objects
* Defined by `o `
* Followed by `[Name]`
* Everything after that will be intepreted as `Group` Data up to the next `o `

#### Groups
* Defined by `g `
* Followed by `[Name]`
* Everything after that will be intepreted as `SubGroup` Data up to the next `g `

#### SubGroups
* Defined by `s ` and `usemtl `
* Followed by `[Value]`
* Everything after that will be intepreted as `GLVertex AND GLFace` Data up to the next `s ` and `usemtl `
* May combine SubGroups into one if
    1. Subgroup has no Values means every following subgroup will recieve its VertexData
    2. Subgroup has same Values as another Subgroup

#### GLVertex
* Defined by `v ` or `vt ` or  `vn `
* Followed by `[Value] {[Value]} {[Value]} {[Value]}`
* Nothing comes after it

#### GLFace
* Defined by `f `
* Followed by `[Pointer] {[Pointer]} {[Pointer]} {[Pointer]}`
* Nothing comes after it
* Reevaluates its Pointers according to the size of its data
    See this example:
    [12, 10, 180, 12, 439, 11] --> [2, 0, 3, 2, 4, 1]

## Mtl Files
This class is a simple Line-by Line reader which creates a `GLMaterial` Object for each `newmtl ` Line
It is used for Shaders to Update Uniforms and to add textures