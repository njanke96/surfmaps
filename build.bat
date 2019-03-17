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
IF "%mapname%"=="" (GOTO NAMEFAIL)

SET vmffile=%mapsrc%\%mapname%.vmf
SET bspfile=%mapsrc%\%mapname%.bsp
ECHO building %mapname%.vmf

:: Clean old files
DEL %mapsrc%\%mapname%.bsp
DEL %mapsrc%\%mapname%.log
DEL %mapsrc%\%mapname%.prt

:: Prompt build speed
:: 1: Full VVIS, Full RAD
:: 2: Fast VVIS, Full RAD
:: 3: Fast VVIS, No RAD
:: 4: No VVIS, No RAD
SET /P buildspeed="Build speed? (1/2/3/4): "

:: VBSP
%bindir%\vbsp.exe -game %VPROJECT% %vmffile%

:: VVIS
IF /I %buildspeed%==1 (GOTO FULLVVIS)
IF /I %buildspeed%==4 (GOTO POSTVVIS)

ECHO **Running vvis with the -fast flag
%bindir%\vvis.exe -fast -game %VPROJECT% %bspfile%
GOTO POSTVVIS

:FULLVVIS
%bindir%\vvis.exe -game %VPROJECT% %bspfile%

:POSTVVIS

:: VRAD
IF /I %buildspeed%==3 (GOTO COPYFILE)
IF /I %buildspeed%==4 (GOTO COPYFILE)

%bindir%\vrad.exe -ldr -game %VPROJECT% %bspfile%

:COPYFILE
COPY %bspfile% %copyto%\%mapname%.bsp

GOTO END

:NAMEFAIL
echo Please specify the mapname in an argument.

:END
