#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Loop,
{
  IfWinActive, ahk_exe Northgard.exe
  {
    WinGetPos,,, Width, Height, ahk_exe Northgard.exe
    y1 := Height - 260
    ToolTip, Founded`n%A_ScriptDir%`n%Width%x%Height%, 250, 58, 1
    Sleep, 5000
    ToolTip,,,, 1
    Break
  }
  IfWinNotActive, ahk_exe Northgard.exe
  {
    Sleep, 100
  }
}

#MaxThreadsPerHotkey 3
F1::
#MaxThreadsPerHotkey 1
Send, {e Down}
Sleep, 100
Send, {e Up}
Sleep, 200
IfWinActive, ahk_exe Northgard.exe
  if (ErrorLevel = 0) {
    ImageSearch, FX, FY, 0, 0, Width, Height, %A_ScriptDir%\images\stopicon.bmp
      if (ErrorLevel = 0) {
        ToolTip, FX = %FX% || FY = %FY%, 250, 35, 2
        MouseMove, FX, FY, 1
        Sleep, 5000
    }}

Return
;PixelSearch,xCordChel,yCordChel, 0, 0, Width, Height, 0x4D4D4D, 0, Fast
;if (ErrorLevel = 0)
;{
;  xCordChel := xCordChel + 1
;  ToolTip, 1 этап
;  PixelSearch,xCordChel,yCordChel, xCordChel, yCordChel, xCordChel, yCordChel, 0xA3A3A3, 0, Fast
;  if (ErrorLevel = 0)
;  {
;    ToolTip, 2 этап
;    xCordChel := xCordChel + 1
;      PixelSearch,,, xCordChel, yCordChel, xCordChel, yCordChel, 0xE5E5E5, 0, Fast
;      if (ErrorLevel = 0)
;      {
;        ToolTip, 3 этап
;        ToolTip, WellDone!!
;      }
;  }
;}
;Else
;  ToolTip, блять
;MouseMove, xCordChel, yCordChel
;Return

;===================================
;======Всякий калл для дебага=======
;===================================
#MaxThreadsPerHotkey 3
Numpad0:: ;вкл/выкл дебаг
#MaxThreadsPerHotkey 1
If DebugTurnOn = True
  DebugTurnOn := False
Else
  DebugTurnOn := True
Return

#MaxThreadsPerHotkey 3
Numpad1:: ;Проверка пикселей
#MaxThreadsPerHotkey 1
if (TestListOn = True) {
  TestListOn := False
  Return
}
TestListOn := True
Loop,
{
  If (TestListOn = False) {
    ToolTip,,,, 5
    Break
  }
  ListSteps := "List:`n"
  loop, 10
  {
    PixelSearch,,, Color%A_Index%, y3, Color%A_Index%, y3, 0x160857, 0, Fast
    if ErrorLevel = 0
      Next = Step%A_Index% = Yes`n
    Else
      Next = Step%A_Index% = No`n
    ListSteps = %ListSteps%%Next%
  }
  IfWinActive, Grim Dawn
  {
    ToolTip, %ListSteps%, 10, %yCordHorListSteps%, 5
  }
  IfWinNotActive, Grim Dawn
  {
    ToolTip,,,, 5
  }
  Sleep, 100
}
Return