# Data
### Version 1.0
| X                        | Y                |
| --------                 | -------          |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLContext      |
| Tags                     | OOP, VBA, OpenGL |

## Purpose

Ensures standardized Data for all implementing classes

--------------------------------------------------------

## Overview

Data is very important for a graphics library.
It can vary depending on use case.
Anyone who has worked with VBA for a while may realize how limiting it actually is.
One such case is the topic of rewritablity.
This documentation refers to `VBGLData.cls` and everything that uses it.

What are templates in C++?
In short, they are a way to write a function that does something without having to specify a datatype as input.
Example:
```cpp
template <typename T>
T Add(T var1, T var2)
{
    return var1 + var2
}

//will create:

int Add(int var1, int var2)
float Add(float var1, float var2)
```
This way you only have to write it once and add another datatype.
VBA does not have this luxury.
What VBA does have is `Variant`
`Variant` can be anything, a number, a string, an object, an array, all at the same time and nothing too.
Sounds awesome right? It is.
But there is one problem:
OpenGL works with alot of pointers, where the data has to be aligned properly. Variants make this very complicated, as they can change so easily and also VarPtr() works differently for them too.
So, no Variant then. What can we do?
One solution is `VBGLData`
`VBGLData` is the C++ Template while the Implementations such as IDataSingle are used as the data-holder


--------------------------------------------------------

## Properties

| Property         | Type         | Public | Description |
| --------         | -------      | ------ | -------     |
| Let Get Data     | XXX          | True   | Depending on implementation will work with different DataTypes        |

## Methods
| Property | Type         | Public | Description |
| -------- | -------      | ------ | -------     |
| Create   | XXX          | True   | Will Create together with Data-Type        |

--------------------------------------------------------

## Examples:  
1. Simple
```vb
    Dim SingleData As IDataSingle
    Set SingleData = VBGLData.CreateSingle(ExternalData) 'Will create a VBGLData class that is used as Single
```
The neat things with this method:
We can create Functions, that take in VBGLData as an argument and NOT IDataSingle:
```vb
Private Sub VertexBufferNewData(NewData As VBGLData)
    VertexBuffer.Data = NewData
End Sub
```
This way we can pass data without having to worry if it is of the right datatype (as long as we assign data to the variable before calling the function, as VBGLData as a class is not complete without its Implementation)

2. Interchange the bytedata between 2 different Datatypes:
```vb
    Dim SingleData As IDataSingle
    Set SingleData = VBGLData.CreateSingle(ExternalData)
    Set SingleData = ExternalData

    Dim LongData As IDataLong
    Set LongData = VBGLData.Create(vbLong)
    LongData.ByteData = SingleData.ByteData
```
* Data is the original Data (if it was created as vbSingle then it will use DataSingle)
* ByteData will return the ByteData of the original Data (if it was created as vbSingle then it will use DataSingle)

## Extra Information
XXX

## Dependencies
* VBGLContext

## Testing
Tested by looking into memory layout of different implementations

## Lifecycle Notes
Creation and deletion inside VBGL-Object Lifetime

## See Also:
[Context](..\Context)