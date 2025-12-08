# VBGLRenderObject
### Version 1.0
| X                        | Y                |
| ------------------------ | ---------------- |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLDrawable, VBGLFrame, VBGLCallback, VBGLIInput |
| Tags                     | VBA, OpenGL, UI, Drawable, Input, Rendering |

## Purpose

`VBGLRenderObject` is a class designed to act as a seperate Sub-Mainloop.
It:

* Maintains a list of drawables.
* Handles input through `VBGLIInput`.
* Supports OpenGL frame binding and unbinding.
* Provides customizable display, idle, keyboard, mouse, and scroll callbacks.
* Manages a background RGBA color for rendering.
* Implements `VBGLDrawable` for seamless integration with the OpenGL rendering system.

---

## Properties

| Property         | Type             | Description |
| ---------------- | ---------------- | ----------- |
| Drawable(Index)   | VBGLDrawable     | Returns the drawable at a given index. |
| UserInput         | VBGLIInput       | Gets or sets the input handler. |
| Frame             | VBGLFrame        | Gets or sets the rendering frame. |
| Callbacks         | VBGLCallback     | Gets or sets the callback handler. |
| R                 | Single           | Red component of the background color. |
| G                 | Single           | Green component of the background color. |
| B                 | Single           | Blue component of the background color. |
| A                 | Single           | Alpha component of the background color. |

---

## Methods

### Creation & Initialization
| Method                   | Description |
| ------------------------ | ----------- |
| `Create(n_UserInput, n_Frame, n_Callbacks)` | Factory method to create a new `VBGLRenderObject` with input, frame, and optional callbacks. |
| `CreateCallbacks(Obj)`   | Generates default OpenGL callbacks for display, idle, keyboard, and mouse events. |
| `AddDrawable(n_Drawable)` | Adds a drawable to the internal drawables array. |
| `RemoveDrawable()`        | Removes the last drawable from the array. |
| `Draw()`                 | Binds the frame, draws all managed drawables, then unbinds the frame. |
| `VBGLDrawable_Draw()`     | Implements `VBGLDrawable` interface to call `Draw()`. |
| `AssignColor(R, G, B, A)` | Sets the background RGBA color. |
| `Loopp()`                | Main loop display function: clears the screen, sets background color, draws, and swaps buffers. |

### Input Handling
| Method                   | Description |
| ------------------------ | ----------- |
| `KeyBoard(Char, x, y)`    | Sends a key down event to the `UserInput` handler. |
| `KeyBoardUp(Char, x, y)`  | Sends a key up event to the `UserInput` handler. |
| `MouseMove(x, y)`         | Sends a mouse move event to the `UserInput` handler. |
| `MouseWheel(wheel, direction, x, y)` | Sends a mouse wheel event to the `UserInput` handler. |

---

## Extra Information

* `VBGLRenderObject` allows multiple `VBGLDrawable` objects to be rendered in a single OpenGL frame.
* It supports background color customization and default callbacks for standard input events.
* Designed to integrate smoothly with an OpenGL-based VBA GUI or graphics engine.
* Implements `VBGLDrawable` for direct rendering within other renderable objects.

---

## Example
See the Tests Folder
The mainloop in VBGLTestAll uses RenderObjects to create SubRenderObjects for the test-cases


## Dependencies
* VBGLContext
* VBGLCallback
* VBGLIInput
* VBGLFrame

## Testing
See the Tests Folder

## Lifecycle Notes
During VBGLContext Lifecycle

## See Also: