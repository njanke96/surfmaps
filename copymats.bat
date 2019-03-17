:: Copy materials
@echo off

:: Set paths
SET matsrc="E:\mapping\materials"
SET copyto="C:\Program Files (x86)\Steam\steamapps\sourcemods\momentum\materials"

XCOPY %matsrc% %copyto% /S /E /Y