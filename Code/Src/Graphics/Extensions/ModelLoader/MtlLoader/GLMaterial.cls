VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "GLMaterial"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

'.mtl files as an Object

Private p_ColorAmbient()  As Single
Private p_ColorDiffuse()  As Single
Private p_ColorSpecular() As Single
Private p_Shininess       As Single
Private p_Opacity         As Single
Private p_Transparency    As Single
Private p_OpticalDensity  As Single
Private p_Illumination    As Single
Private p_MapTexture      As String
Private p_MapAmbient      As String
Private p_MapDiffuse      As String
Private p_MapSpecular     As String
Private p_Name            As String

Public Property Let ColorAmbient(ByRef n_ColorAmbient()   As Single)  : p_ColorAmbient   = n_ColorAmbient  : End Property
Public Property Let ColorDiffuse(ByRef n_ColorDiffuse()   As Single)  : p_ColorDiffuse   = n_ColorDiffuse  : End Property
Public Property Let ColorSpecular(ByRef n_ColorSpecular() As Single)  : p_ColorSpecular  = n_ColorSpecular : End Property
Public Property Let Shininess(ByVal n_Shininess           As Single)  : p_Shininess      = n_Shininess     : End Property
Public Property Let Opacity(ByVal n_Opacity               As Single)  : p_Opacity        = n_Opacity       : End Property
Public Property Let Transparency(ByVal n_Transparency     As Single)  : p_Transparency   = n_Transparency  : End Property
Public Property Let OpticalDensity(ByVal n_OpticalDensity As Single)  : p_OpticalDensity = n_OpticalDensity: End Property
Public Property Let Illumination(ByVal n_Illumination     As Single)  : p_Illumination   = n_Illumination  : End Property
Public Property Let MapTexture(ByVal n_MapTexture         As String)  : p_MapTexture     = n_MapTexture    : End Property
Public Property Let MapAmbient(ByVal n_MapAmbient         As String)  : p_MapAmbient     = n_MapAmbient    : End Property
Public Property Let MapDiffuse(ByVal n_MapDiffuse         As String)  : p_MapDiffuse     = n_MapDiffuse    : End Property
Public Property Let MapSpecular(ByVal n_MapSpecular       As String)  : p_MapSpecular    = n_MapSpecular   : End Property
Public Property Let Name(ByVal n_Name                     As String)  : p_Name           = n_Name          : End Property

Public Property Get ColorAmbient()                        As Single() : ColorAmbient     = p_ColorAmbient  : End Property
Public Property Get ColorDiffuse()                        As Single() : ColorDiffuse     = p_ColorDiffuse  : End Property
Public Property Get ColorSpecular()                       As Single() : ColorSpecular    = p_ColorSpecular : End Property
Public Property Get Shininess()                           As Single   : Shininess        = p_Shininess     : End Property
Public Property Get Opacity()                             As Single   : Opacity          = p_Opacity       : End Property
Public Property Get Transparency()                        As Single   : Transparency     = p_Transparency  : End Property
Public Property Get OpticalDensity()                      As Single   : OpticalDensity   = p_OpticalDensity: End Property
Public Property Get Illumination()                        As Single   : Illumination     = p_Illumination  : End Property
Public Property Get MapTexture()                          As String   : MapTexture       = p_MapTexture    : End Property
Public Property Get MapAmbient()                          As String   : MapAmbient       = p_MapAmbient    : End Property
Public Property Get MapDiffuse()                          As String   : MapDiffuse       = p_MapDiffuse    : End Property
Public Property Get MapSpecular()                         As String   : MapSpecular      = p_MapSpecular   : End Property
Public Property Get Name()                                As String   : Name             = p_Name          : End Property