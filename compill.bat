del final /q
del latestversion /q
mkdir final
mkdir final\images
mkdir final\extensions
mkdir latestversion
mkdir latestversion\extensions
mkdir latestversion\images
mkdir final\BackupsExe
for %%a in (*.ahk) do if "%%a"=="main.ahk" (Compress\Ahk2Exe.exe /in %%a /icon NGAHK.ico) else (Compress\Ahk2Exe.exe /in %%a)
for %%a in (extensions\*.ahk) do (Compress\Ahk2Exe.exe /in %%a)
copy *.exe final\BackupsExe
copy extensions\*.exe final\BackupsExe\extensions
for %%a in (*.exe) do Compress\mpress.exe %%a
for %%a in (extensions\*.exe) do Compress\mpress.exe %%a
move *.exe final
move extensions\*.exe final\extensions
copy final\extensions\*.exe latestversion\extensions
copy config.ini final
copy images\*.* final\images
copy images\*.* latestversion\images
copy changelog.txt final
copy changelog.txt latestversion
copy images latestversion
copy final\*.* latestversion
copy final\changelog.txt
copy latestversion\changelog.txt
copy update.bat final\update.bat
copy update.bat latestversion\update.bat
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
cd final
"..\Compress\7z.exe" A %var1%.zip *.*
"..\Compress\7z.exe" A %var1%.zip images\*.*
"..\Compress\7z.exe" A %var1%.zip extensions\*.*
cd ..\
mkdir release
move final\*.zip release
copy release\%var1%.zip latestversion
ren latestversion\%var1%.zip latestversion.zip