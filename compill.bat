del final /q
mkdir final
mkdir final\BackupsExe
for %%a in (*.ahk) do if "%%a"=="main.ahk" (Compress\Ahk2Exe.exe /in %%a /icon easylife.ico) else (Compress\Ahk2Exe.exe /in %%a)
copy *.exe final\BackupsExe
for %%a in (*.exe) do Compress\mpress.exe %%a
move *.exe final
copy config.ini final

rem @echo off

set dd=%DATE%
set tt=%TIME%

set /a ddd=%dd:~0,2%
IF %ddd% LSS 10 (
  SET day=0%ddd%) else (
  SET day=%ddd%)
set month=%dd:~3,2%
set year=%dd:~6,4%

set /a ttt=%tt:~0,2%

IF %ttt% LSS 10 (
  SET hour=0%ttt%) else (
  SET hour=%ttt%)

SET minute=%tt:~3,2%
SET sec=%tt:~6,2%

cd final
"%programfiles%\WinRar\Winrar.exe" A %day%.%month%.%year%_%hour%.%minute%.rar *.*
cd ..\
mkdir release
move final\*.rar release