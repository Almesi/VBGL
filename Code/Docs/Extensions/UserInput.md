# VBGLIInput
### Version 1.0
| X                        | Y                |
| ------------------------ | ---------------- |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Related Modules/Classes  | VBGLGeneralInput, std_Callable |
| Tags                     | VBA, Input, Event Handling, Interface |

## Purpose

`VBGLIInput` defines a standard interface for input handling in the VBGL system. It provides the following abstract methods for capturing and responding to user input:

* `Handle(Button, Value, Args())` — Generic handler for any input.
* `KeyDown(Value, Args())` — Triggered when a key is pressed.
* `KeyUp(Value, Args())` — Triggered when a key is released.
* `MouseMove(Value, Args())` — Triggered when the mouse moves.
* `MouseClick(Value, Args())` — Triggered when a mouse button is clicked.
* `MouseWheel(Value, Args())` — Triggered when the mouse wheel is scrolled.

This class is meant to be implemented by other classes like `VBGLGeneralInput`.

---

# VBGLGeneralInput
### Version 1.0
| X                        | Y                |
| ------------------------ | ---------------- |
| Author                   | Almesi           |
| Created                  | 2025-12-04       |
| Last Updated             | 2025-12-04       |
| Implements               | VBGLIInput       |
| Tags                     | VBA, Input, Event Handling, Keyboard, Mouse, Callbacks |

## Purpose

`VBGLGeneralInput` is a concrete implementation of the `VBGLIInput` interface. It allows registering callbacks for specific keys, key releases, mouse buttons, and mouse wheel movements. It supports global callbacks for "any key" and "else" cases.
It can also add more than 1 callback to any key.

It maintains:

* A dynamic array of `KeyHandler` records for each button/type combination.
* Optional `ElseCallable` and `AnyCallable` for unspecified or generic input handling.

---

## Enums

| Enum                  | Description |
| --------------------- | ----------- |
| `VBGLButtonType`      | Represents the type of input: Key, KeyUp, Mouse, Wheel, or Not Defined (`Nott`). |

---

## Private Types

| Type                  | Fields | Description |
| --------------------- | ------ | ----------- |
| `KeyHandler`           | Button (VBGLButtonType), Value (Long), Callables (std_Callables) | Stores a set of callbacks for a specific button and value combination. |

---

## Private Fields

| Field                | Type                  | Description |
| -------------------- | -------------------  | ----------- |
| Keys()               | KeyHandler()          | Array of key handlers. |
| Size                 | Long                  | Number of key handlers. |
| ElseCallable         | std_Callable          | Callback for undefined input. |
| AnyCallable          | std_Callable          | Callback for any input. |

---

## Methods

### Creation
| Method               | Description |
| -------------------  | ----------- |
| `Create()`           | Factory method to create a new `VBGLGeneralInput` instance. |
| `AddKey(Value, Func)`    | Register a callback for key press. |
| `AddKeyUp(Value, Func)`  | Register a callback for key release. |
| `AddMouse(Value, Func)`  | Register a callback for mouse button. |
| `AddWheel(Value, Func)`  | Register a callback for mouse wheel. |
| `AddElse(Func)`          | Register a callback for unspecified input. |
| `AddAny(Func)`           | Register a callback for any input. |
| `Handle(Button, Value, Args())` | Handles generic input. |
| `KeyDown(Value, Args())`        | Handles key press events. |
| `KeyUp(Value, Args())`          | Handles key release events. |
| `MouseMove(Value, Args())`      | Handles mouse movement. |
| `MouseClick(Value, Args())`     | Handles mouse clicks. |
| `MouseWheel(Value, Args())`     | Handles mouse wheel events. |
| `Add(Button, Value, Func)` | Internal method to add a callback to a `KeyHandler`. |
| `RunArr(Button, Value, Args)` | Executes the callbacks for a button/value combination. |
| `GetKeys(Button, Value)` | Retrieves the `KeyHandler` for a given button/value, returns a default `Nott` if not found. |
| `GetKeysIndex(Button, Value)` | Returns the index of a key handler in the `Keys` array, or -1 if not found. |

---

---

## Example

```vb
Dim InputHandler As VBGLGeneralInput
Set InputHandler = VBGLGeneralInput.Create()

' Add callback for key "A"
Call InputHandler.AddKey(Asc("A"), std_Callable.Create(Me, "OnKeyA", vbMethod, 0).Bind(Var).FixArgs(True))

' Add callback for mouse click button 1
Call InputHandler.AddMouse(1, std_Callable.Create(Me, "OnMouseClick", vbMethod, 2))

' Add generic callback for any input
Call InputHandler.AddAny(std_Callable.Create(Me, "OnAnyInput", vbMethod, 3))
```


## Extra Information
XXX

## Dependencies
* VBGLIInput
* VBGLCallback

## Testing
Tested

## Lifecycle Notes
Creatable Anytime

## See Also: