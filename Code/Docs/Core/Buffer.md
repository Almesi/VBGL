## VBGLBuffer.cls
This Class creates a Buffer Object, assigns it data and binds it.
It works by implementing all Buffer Objects.
It can update its data.




# VBGLBuffer
### Version 1.0
| X                        | Y                |
| --------                 | -------          |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLData         |
| Tags                     | OOP, VBA, OpenGL |

## Purpose

Represents an OpenGL Buffer

--------------------------------------------------------

## Overview

Holds the data passed to OpenGL, holds its ID and can be updated with new data
Created as an Interface-Handler to include more Buffers in the future than just Vertex and IndexBuffer


--------------------------------------------------------

## Properties

| Property    | Type         | Public | Description                           |
| --------    | -------      | ------ | -------                               |
| Let Get ID  | Long         | True   | Used to determine Object              |
| Let Get Data| VBGLData     | True   | The data that was uploaded to the GPU |

## Methods
| Property    | Type         | Public | Description                        |
| --------    | -------      | ------ | -------                            |
| CreateXXX   | As XXX       | True   | XXX is the type of Buffer          |
| Bind        | Void         | True   | Binds this Buffer to Context       |
| Unbind      | Void         | True   | Unbinds all Buffers (of that type) |
| Update      | Void         | True   | Updates data on GPU with new data  |

Update will check if it needs to create a new buffer with new size of it the current buffersize is sufficient for quicker updating

--------------------------------------------------------

## Examples:  
1. Describe what the Example is about
```vb
Public Sub Test()
    ' Create Data - Triangle with Position and Color
    Dim Vertices() As Single
    ReDim Vertices(14)
    Vertices = ArraySingle( _
                              -1, 0, 1, 0, 0, _ 
                              +0, 1, 0, 0, 0, _
                              +1, 0, 0, 0, 1  _
                          )

    ' Create ByteData from SingleData
    Dim NewSize    As Long      : NewSize = (USize(Vertices) + 1) * LenB(Vertices(0))
    Dim Temp()     As Byte      : ReDim Temp(NewSize - 1)
    Call CopyMemory(Temp(0), VarPtr(Vertices(0)), NewSize)
    Dim VertexData As IDataByte : Set VertexData = VBGLData.CreateByte(Temp)

    Dim Buffer As IBufferVertex
    Set Buffer = VBGLBuffer.CreateVertexBuffer(VertexData)
End Sub
```
## Extra Information
This Class can be improved for memory efficiency, as currently creating extra data pollutes the ram.

## Dependencies
* VBGLData

## Testing
Tested in Examples and Tests

## Lifecycle Notes
Has to be created in the VBGL-Object Lifecycle

## See Also:
[Data](..\Data)