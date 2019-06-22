#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
UrlDownloadToFile, https://raw.githubusercontent.com/Tremorok/NorthGodAHK/master/release/list.txt, list.txt
Sleep, 2000
Loop, read, %A_ScriptDir%\list.txt
{
  LastString := A_LoopReadLine
}
if RegExMatch(LastString, "(.*)\s(.*)", SubPat)
{
  FileName := SubPat1
  FileSize := SubPat2
  FileURL = https://raw.githubusercontent.com/Tremorok/NorthGodAHK/master/release/%FileName%.zip
  ;MsgBox, FileName = %FileName%
}
UrlConfig = %A_ScriptDir%\NorthGodAHK\config.ini
;MsgBox, %UrlConfig%
IfExist, %UrlConfig%
  isExist := True
if (isExist = True) {
  Loop, read, %A_ScriptDir%\NorthGodAHK\config.ini
  {
    if RegExMatch(A_LoopReadLine, "version=(.*.)", SubStep)
    {
      FileNameConf := SubStep1
      ;MsgBox, FileNameConf = %FileNameConf%`nFileName = %FileName%
      Break
    }
    ;MsgBox, A_LoopReadLine = %A_LoopReadLine%
  }
  ;MsgBox, %FileNameConf%
  if (FileNameConf = FileName) {
    FileDelete,  %A_ScriptDir%\list.txt
    ;MsgBox, У вас уже последняя версия.
    MsgBox, 4132, Alarm, У вас уже стоит последняя версия.`nХотите переустановить?
    IfMsgBox Yes
      Goto, Install
    Else
      ExitApp
    ;Sleep, 65000
  }
  Else
    Goto, Install
}
Else
  Goto, Install
;Sleep, 60000
Return

Install:
FileRemoveDir, NorthGodAHK
FileCreateDir, NorthGodAHK
;MsgBox, %FileURL%
DownloadFile(FileURL, "temp.zip")
ArcPath = %A_ScriptDir%\temp.zip
OutPath = %A_ScriptDir%\NorthGodAHK
FileCreateDir, %A_ScriptDir%\NorthGodAHK
Shell := ComObjCreate("Shell.Application")
Items := Shell.NameSpace(ArcPath).Items
Items.Filter(73952, "*")
Shell.NameSpace(OutPath).CopyHere(Items, 16)
FileDelete,  %A_ScriptDir%\temp.zip
FileDelete,  %A_ScriptDir%\list.txt
MsgBox, Установка завершина.
ExitApp

DownloadFile(UrlToFile, SaveFileAs, Overwrite := True, UseProgressBar := True) {
  If (!Overwrite && FileExist(SaveFileAs))
    Return
  If (UseProgressBar) {
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WebRequest.Open("HEAD", UrlToFile)
    WebRequest.Send()
    FinalSize := FileSize
    Progress, H80, , Downloading..., %UrlToFile%
    SetTimer, __UpdateProgressBar, 100
  }
  UrlDownloadToFile, %UrlToFile%, %SaveFileAs%
  If (UseProgressBar) {
    Progress, Off
    SetTimer, __UpdateProgressBar, Off
}
Return

__UpdateProgressBar:
  CurrentSize := FileOpen(SaveFileAs, "r").Length
  CurrentSizeTick := A_TickCount
  Speed := Round((CurrentSize/1024-LastSize/1024)/((CurrentSizeTick-LastSizeTick)/1000)) . " Kb/s"
  LastSizeTick := CurrentSizeTick
  LastSize := FileOpen(SaveFileAs, "r").Length
  PercentDone := Round(CurrentSize/FinalSize*100)
  Progress, %PercentDone%, %PercentDone%`% Done, Downloading...  (%Speed%), Downloading %SaveFileAs% (%PercentDone%`%)
Return
}