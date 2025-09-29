VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "VBGLTestFramework"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True


Option Explicit

Private p_AfterEach  As VBGLCallable
Private p_BeforeEach As VBGLCallable
Private p_AfterAll   As VBGLCallable
Private p_BeforeAll  As VBGLCallable
Private p_AllTests()      As VBGLTest
Private p_SelectedTests() As VBGLTest

Public Property Let AfterEach(ByVal  Value As VBGLCallable): Set p_AfterEach  = Value        : End Property
Public Property Let BeforeEach(ByVal Value As VBGLCallable): Set p_BeforeEach = Value        : End Property
Public Property Let AfterAll(ByVal   Value As VBGLCallable): Set p_AfterAll   = Value        : End Property
Public Property Let BeforeAll(ByVal  Value As VBGLCallable): Set p_BeforeAll  = Value        : End Property

Public Property Get AfterEach()            As VBGLCallable : Set AfterEach    = p_AfterEach  : End Property
Public Property Get BeforeEach()           As VBGLCallable : Set BeforeEach   = p_BeforeEach : End Property
Public Property Get AfterAll()             As VBGLCallable : Set AfterAll     = p_AfterAll   : End Property
Public Property Get BeforeAll()            As VBGLCallable : Set BeforeAll    = p_BeforeAll  : End Property

Public Property Let LetAllTests(ByVal Values As Variant)
    p_AllTests = Values
End Property
Public Property Get AllTests() As VBGLTest()
    AllTests = p_AllTests
End Property

Public Property Get SelectedTests() As VBGLTest()
    SelectedTests = p_SelectedTests
End Property

Public Property Get GetTest(ByVal Index As Long) As VBGLTest
    Set GetTest = p_AllTests(Index)
End Property
Public Property Get SelectedTest(ByVal Index As Long) As VBGLTest
    Set SelectedTest = p_SelectedTests(Index)
End Property

Public Function Create(n_Tests() As VBGLTest) As VBGLTestFramework
    Set Create = New VBGLTestFramework
    With Create
        .LetAllTests = n_Tests
    End With
End Function

Public Function CreateFromProject(ByVal Proj As VBIDE.VBProject, ByVal NamingConvention As String) As VBGLTestFramework
    Dim Component As VBIDE.VBComponent

    Dim n_Tests() As VBGLTest
    For Each Component in Proj.VBComponents
        Call SearchComponent(n_Tests, Component, NamingConvention)
    Next Component
    Set CreateFromProject = Create(n_Tests)
End Function

Public Sub SelectTest(ByVal Index As Long)
    Call VBGLAddUnique(p_SelectedTests, GetTest(Index))
End Sub

Public Sub DeselectTest(ByVal Index As Long)
    Call VBGLArrayRemove(p_SelectedTests, Index)
End Sub

Public Sub ChangeSelectTest(ByVal Index As Long)
    If IsSelected(Index) Then
        Call DeselectTest(Index)
    Else
        Call SelectTest(Index)
    End If
End Sub

Public Function IsSelected(ByVal Index As Long) As Boolean
    Dim i As Long
    Dim SearchTest As VBGLTest
    Set SearchTest = GetTest(Index)
    For i = 0 To USize(SelectedTests)
        If SelectedTest(i) Is SearchTest Then
            IsSelected = True
            Exit Function
        End If
    Next i
End Function
Public Function IsSelectedName(ByVal Name As String) As Boolean
    Dim i As Long
    For i = 0 To USize(SelectedTests)
        If SelectedTest(i).Name = Name Then
            IsSelected = True
            Exit Function
        End If
    Next i
End Function

Public Sub SelectAllTests()
    SelectedTests = AllTests
End Sub

Public Sub SelectFromName(ByVal Name As String)
    Dim i As Long
    For i = 0 To USize(AllTests)
        If AllTests(i).Name = Name Then
            Call VBGLAddUnique(p_SelectedTests, AllTests(i))
            Exit Sub
        End If
    Next i
End Sub

Public Function TestAll(Optional ByVal Expected As Variant) As Boolean()
    Dim i As Long
    Dim ReturnArr() As Boolean
    Dim Size As Long
    Size = USize(SelectedTests)
    If IsSomething(BeforeAll) Then Call BeforeAll.Handle()
    If Size = -1 Then Exit Function
    ReDim ReturnArr(Size)
    For i = 0 To Size
        ReturnArr(i) = Test(i, Expected)
    Next i
    If IsSomething(AfterAll) Then Call AfterAll.Handle()
End Function

Public Function Test(ByVal Index As Long, Optional ByVal Expected As Variant) As Boolean
    If IsSomething(BeforeEach) Then Call BeforeEach.Handle()
    Test = SelectedTest(Index).Run(Expected)
    If IsSomething(AfterEach) Then Call AfterEach.Handle()
End Function

Public Function GetFromName(ByVal Name As String) As VBGLTest
    Dim i As Long
    For i = 0 To USize(AllTests)
        If GetTest(i).Name = Name Then
            Set GetFromName = GetTest(i)
            Exit Function
        End If
    Next i
End Function


Private Sub SearchComponent(ByRef Arr() As VBGLTest, ByVal Component As VBIDE.VBComponent, ByVal NamingConvention As String)
    Dim Line As String
    Dim i As Long
    Dim CodeMod As VBIDE.CodeModule

    Set CodeMod = Component.CodeModule
    For i = 1 To CodeMod.CountOfLines
        Line = CodeMod.Lines(i, 1)
        If Line Like NamingConvention & "*" Then
            Call VBGLAdd(Arr, GetProcedure(Component , Line, NamingConvention))
        End If
    Next i
End Sub

Private Function GetProcedure(ByVal Component As VBIDE.VBComponent, ByVal Code As String, ByVal NamingConvention As String) As VBGLTest
    Dim SearchText As String
    Dim StartPoint As Long
    Dim EndPoint As Long
    Dim Name As String
    Dim Callable As VBGLCallable

    SearchText = NamingConvention
    SearchText = Replace(SearchText, "Public Sub "     , Empty)
    SearchText = Replace(SearchText, "Public Function ", Empty)
    
    StartPoint = InStr(1, Code, SearchText)
    EndPoint = InStr(StartPoint, Code, "(")
    Name = VBGLMidP(Code, StartPoint, EndPoint - 1)
    Set Callable = VBGLCallable.Create(Nothing, Name, vbMethod, GetArgCount(Code))
    Set GetProcedure = VBGLTest.Create(Callable)
End Function

Private Function GetArgCount(ByVal Code As String) As Long
    Dim StartPoint As Long
    Dim EndPoint   As Long
    Dim Args       As String
    Dim ArgsArr()  As String

    StartPoint = InStr(1, Code, "(")
    EndPoint = InStrRev(Code, ")")
    If StartPoint + 1 >= EndPoint Then
        GetArgCount = -1
    Else
        Args = VBGLMidP(Code, StartPoint + 1, EndPoint - 1)
        ArgsArr = Split(Args, ",")
        GetArgCount = USize(ArgsArr)
    End If
End Function