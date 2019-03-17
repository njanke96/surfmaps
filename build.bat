:: Custom vmf building script
:: Example: .\build.bat surf_map
@echo off
CLS

:: Set the paths
SET bindir="E:\SteamLibrary\steamapps\common\Source SDK Base 2013 Multiplayer\bin"
SET mapsrc="E:\mapping\mapsrc"
SET copyto="C:\Program Files (x86)\Steam\steamapps\sourcemods\momentum\maps"

:: Set VPROJECT
SET VPROJECT="C:\Program Files (x86)\Steam\steamapps\sourcemods\momentum"
:::: END OF CONFIGURATION

SET mapname=%*
IF "%mapname%"=="" (GOTO FAIL)

SET vmffile=%mapsrc%\%mapname%.vmf
SET bspfile=%mapsrc%\%mapname%.bsp
ECHO building %mapname%.vmf

:: Clean old files
DEL %mapsrc%\%mapname%.bsp
DEL %mapsrc%\%mapname%.log
DEL %mapsrc%\%mapname%.prt

:: VBSP
%bindir%\vbsp.exe -game %VPROJECT% %vmffile%

:: VVIS
SET /P fastvvis="Fast VVIS? (y/n)"
IF /I %fastvvis% NEQ y (GOTO FULLVVIS)

ECHO **Running vvis with the -fast flag
%bindir%\vvis.exe -fast -game %VPROJECT% %bspfile%
GOTO VRADPROMPT

:FULLVVIS
%bindir%\vvis.exe -game %VPROJECT% %bspfile%

:: VRAD
:VRADPROMPT
SET /P runvrad="Run VRAD? (y/n)"
IF /I %runvrad% NEQ y (GOTO COPYFILE)

%bindir%\vrad.exe -ldr -game %VPROJECT% %bspfile%

:COPYFILE
COPY %bspfile% %copyto%\%mapname%.bsp

GOTO END

:FAIL
echo Please specify the mapname in an argument.

:END
