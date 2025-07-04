VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLCamera"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_ExPosed = False


Option Explicit

Public Enum VBGLCameraMovement
    FORWARD  = 0
    BACKWARD = 1
    LEFT     = 2
    RIGHTT   = 3
    UPP      = 4
    DOWN     = 5
End Enum


Private Position()    As Single
Private Front()       As Single
Private Up()          As Single
Private Right()       As Single
Private WorldUp()     As Single
Private p_Yaw         As Single
Private p_Pitch       As Single
Private p_Roll        As Single
Private p_Speed       As Single
Private p_Sensitivity As Single
Private p_FOV         As Single

Public Property Let Yaw(n_Yaw                 As Single) : p_Yaw         = n_Yaw         : End Property
Public Property Let Pitch(n_Pitch             As Single) : p_Pitch       = n_Pitch       : End Property
Public Property Let Roll(n_Roll               As Single) : p_Roll        = n_Roll        : End Property
Public Property Let Speed(n_Speed             As Single) : p_Speed       = n_Speed       : End Property
Public Property Let Sensitivity(n_Sensitivity As Single) : p_Sensitivity = n_Sensitivity : End Property
Public Property Let FOV(n_FOV                 As Single) : p_FOV         = n_FOV         : End Property

Public Property Get Yaw()                     As Single  : Yaw           = p_Yaw         : End Property
Public Property Get Pitch()                   As Single  : Pitch         = p_Pitch       : End Property
Public Property Get Roll()                    As Single  : Roll          = p_Roll        : End Property
Public Property Get Speed()                   As Single  : Speed         = p_Speed       : End Property
Public Property Get Sensitivity()             As Single  : Sensitivity   = p_Sensitivity : End Property
Public Property Get FOV()                     As Single  : FOV           = p_FOV         : End Property

Public Function Create(X As Single, Y As Single, Z As Single, UpX As Single, UpY As Single, UpZ As Single, n_Yaw As Single, n_Pitch As Single, n_Roll As Single, n_Speed As Single, n_Sensitivity As Single, n_FOV As Single) As VBGLCamera
    Set Create = New VBGLCamera
    With Create
        Call .UpdatePosition(X, Y, Z)
        Call .UpdateUp(UpX, UpY, UpZ)
        Call .UpdateRotation(n_Yaw, n_Pitch, n_Roll)
        Call .UpdateRest(n_Speed, n_Sensitivity, n_FOV)
    End With
End Function

Public Sub UpdateRest(n_Speed As Single, n_Sensitivity As Single, n_FOV As Single)
    Speed       = n_Speed
    Sensitivity = n_Sensitivity
    FOV         = n_FOV
    Call UpdateCameraVectors()
End Sub

Public Sub UpdatePosition(X As Single, Y As Single, Z As Single)
    Position(0, 0) = X
    Position(0, 1) = Y
    Position(0, 2) = Z
    Call UpdateCameraVectors()
End Sub

Public Sub UpdateUp(X As Single, Y As Single, Z As Single)
    Up(0, 0) = X
    Up(0, 1) = Y
    Up(0, 2) = Z
    Call UpdateCameraVectors()
End Sub

Public Sub UpdateRotation(n_Yaw As Single, n_Pitch As Single, n_Roll As Single)
    Yaw   = n_Yaw
    Pitch = n_Pitch
    Roll  = n_Roll
    Call UpdateCameraVectors()
End Sub

Public Function GetView() As IMatrixSingle
    Set GetView = VBGLMatrix.Create(vbSingle, 3, 3)
    Call GetView.Diagonals(1)
    GetView.Data = GetView.LookAt(Position, GetView.Add(Position, Front), Up)
End Function
Public Function GetPosition() As IMatrixSingle
    Set GetPosition = GetView()
    GetPosition.Item(0, 0) = 1
    GetPosition.Item(0, 1) = 0
    GetPosition.Item(0, 2) = 0
    GetPosition.Item(1, 0) = 0
    GetPosition.Item(1, 1) = 1
    GetPosition.Item(1, 2) = 0
    GetPosition.Item(2, 0) = 0
    GetPosition.Item(2, 1) = 0
    GetPosition.Item(2, 2) = 1
End Function
Public Function GetDirection() As IMatrixSingle
    Set GetDirection = GetView()
    GetDirection.Item(0, 3) = 0
    GetDirection.Item(1, 3) = 0
    GetDirection.Item(2, 3) = 0
End Function
Public Function GetPerspective(Width As Single, Height As Single, Near As Single, Far As Single) As IMatrixSingle
    Set GetPerspective = VBGLMatrix.Create(vbSingle, 3, 3)
    GetPerspective.Data = GetPerspective.Perspective(3, Radian(FOV), Width / Height, Near, Far)
    GetPerspective.Data = GetPerspective.Transpose(GetPerspective.Data)
End Function

Public Sub Move(Direction As VBGLCameraMovement, DeltaTime As Single)
    Dim Velocity As Single
    Velocity = Speed * DeltaTime
    If Velocity = 0 Then Exit Sub
    Dim Temp As IMatrixSingle
    Set Temp = VBGLMatrix.Create(vbSingle, 3, 3)
    Select Case Direction
        Case VBGLCameraMovement.FORWARD  : Position = Temp.Add(Position      , Temp.Scalee(Front, Velocity))
        Case VBGLCameraMovement.BACKWARD : Position = Temp.Subtract(Position , Temp.Scalee(Front, Velocity))
        Case VBGLCameraMovement.LEFT     : Position = Temp.Subtract(Position , Temp.Cross(Temp.Scalee(Front, Velocity), WorldUp))
        Case VBGLCameraMovement.RIGHTT   : Position = Temp.Add(Position      , Temp.Cross(Temp.Scalee(Front, Velocity), WorldUp))
        Case VBGLCameraMovement.UPP      : Position(0, 1) = Position(0, 1) + 1
        Case VBGLCameraMovement.DOWN     : Position(0, 1) = Position(0, 1) - 1
    End Select 
    Call UpdateCameraVectors()
End Sub

Public Sub Look(XOffset As Single, YOffset As Single, Optional ConstrainPitch As Boolean = True)
    Xoffset = Xoffset * Sensitivity
    Yoffset = Yoffset * Sensitivity
    Yaw     = Yaw     + Xoffset
    Pitch   = Pitch   - Yoffset
    If ConstrainPitch Then
        If Pitch > +89.0! Then : Pitch = +89.0!
        If Pitch < -89.0! Then : Pitch = -89.0!
    End If
    Call UpdateCameraVectors()
End Sub

Public Sub Zoom(YOffset As Single)
    FOV = FOV - Yoffset
    If (FOV < 01.0!) Then FOV = 1.0!
    If (FOV > 45.0!) Then FOV = 45.0!
    Call UpdateCameraVectors()
End Sub

Private Sub UpdateCameraVectors()
    Dim Transformed() As Single
    ReDim Transformed(0, 2)

    Dim Temp As IMatrixSingle
    Set Temp = VBGLMatrix.Create(vbSingle, 0, 2)
    Transformed(0, 0) = cos(Radian(Yaw)) * cos(Radian(Pitch))
    Transformed(0, 1) = sin(Radian(Pitch))
    Transformed(0, 2) = sin(Radian(Yaw)) * cos(Radian(Pitch))
    Front = Temp.Normalize(Transformed)
    Right = Temp.Normalize(Temp.Cross(Front, WorldUp))
    Up    = Temp.Normalize(Temp.Cross(Right, Front))
End Sub

Private Function Radian(Degree As Single) As Single
    Radian = Degree * 3.1415265 / 180
End Function

Private Sub Class_Initialize()
    ReDim Position(0, 2) : Position(0, 0) = 0: Position(0, 1) = 0: Position(0, 2) = 0
    ReDim Front(0, 2)    : Front(0, 0)    = 0: Front(0, 1)    = 0: Front(0, 2)    = -1
    ReDim Up(0, 2)       : Up(0, 0)       = 0: Up(0, 1)       = 1: Up(0, 2)       = 0
    ReDim Right(0, 2)    : Right(0, 0)    = 0: Right(0, 1)    = 0: Right(0, 2)    = 0
    ReDim WorldUp(0, 2)  : WorldUp(0, 0)  = 0: WorldUp(0, 1)  = 1: WorldUp(0, 2)  = 0
End Sub