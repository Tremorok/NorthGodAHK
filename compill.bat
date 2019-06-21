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
set var1=%day%.%month%.%year%_%hour%.%minute%

del final /q
mkdir final
mkdir final\images
mkdir final\extensions
mkdir final\BackupsExe
mkdir final\BackupsExe\extensions
for %%a in (*.ahk) do if "%%a"=="main.ahk" (Compress\Ahk2Exe.exe /in %%a /icon NGAHK.ico) else Compress\Ahk2Exe.exe /in %%a
for %%a in (extensions\*.ahk) do (Compress\Ahk2Exe.exe /in %%a)
copy *.exe final\BackupsExe
copy extensions\*.exe final\BackupsExe\extensions
for %%a in (*.exe) do (Compress\mpress.exe %%a)
for %%a in (extensions\*.exe) do (Compress\mpress.exe %%a)
move *.exe final
move extensions\*.exe final\extensions

@echo off

set "file=config.ini"
for /f "delims=" %%i in ('"type "%file%"& del "%file%""') do (
 for /f "delims==" %%j in ("%%i") do ((
  for /f "delims=" %%k in ('
   "(if %%j==version echo version=%var1%)"
  ') do echo %%k
  )|| echo.%%i
  )>>"%file%"
 )

copy config.ini final
copy images\*.* final\images
copy changelog.txt final
copy final\changelog.txt
copy update.bat final\update.bat

cd final
"..\Compress\7z.exe" A %var1%.zip *.*
"..\Compress\7z.exe" A %var1%.zip images\*.*
"..\Compress\7z.exe" A %var1%.zip extensions\*.*
cd ..\
mkdir release
move final\%var1%.zip release

for %%I in (release\%var1%.zip) do (set zipsize=%%~zI)
set var2=%var1% %zipsize%
Echo %var2%>>release\list.txt
exit