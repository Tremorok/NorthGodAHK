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
set var1=%day%.%month%.%year%

git init
git add .
git commit -m "%var1%"
git push https://github.com/Tremorok/NorthGodAHK master