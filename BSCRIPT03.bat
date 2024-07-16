@echo off
setlocal

:menu
cls
echo Select from 1 to 8:
echo 1. ipconfig
echo 2. tasklist/taskkill
echo 3. chkdsk
echo 4. format
echo 5. defrag
echo 6. find
echo 7. attributes
echo 8. Exit

set /p choice=Enter your choice (1-8): 

if "%choice%"=="1" (
    call :ipconfig
) else if "%choice%"=="2" (
    call :tasklist_taskkill
) else if "%choice%"=="3" (
    call :chkdsk
) else if "%choice%"=="4" (
    call :format
) else if "%choice%"=="5" (
    call :defrag
) else if "%choice%"=="6" (
    call :find
) else if "%choice%"=="7" (
    call :attributes
) else if "%choice%"=="8" (
    exit /b
) else (
    echo Invalid choice. Please enter a number between 1 and 8.
    pause
    goto :menu
)

goto :eof

:ipconfig
ipconfig
pause
goto :menu

:tasklist_taskkill
set /p action=Enter action (tasklist/taskkill): 
if "%action%"=="tasklist" (
    tasklist
) else if "%action%"=="taskkill" (
    set /p pid=Enter PID to kill: 
    taskkill /PID %pid% /F
) else (
    echo Invalid action. Please enter either tasklist or taskkill.
)
pause
goto :menu

:chkdsk
chkdsk
pause
goto :menu

:format
echo Warning: Formatting a drive will erase all data on it (are you sure?).
wmic logicaldisk get deviceid, volumename, description
echo =======================================================
echo To stop access of format tool, use "ctrl+c" to escape
set /p drive=Enter drive letter to format (e.g., C:):
format %drive%
pause
goto :menu

:defrag
wmic logicaldisk get deviceid, volumename, description
set /p drive=Enter drive letter to defragment (e.g., C:): 
defrag %drive%
pause
goto :menu

:find
echo /V - Displays all lines not containing the specified string.
echo /C - Displays only the count of the number of lines that contained a match in each of the files.
echo /I - Ignores the case of letters in the string search.
echo /N - Displays the found line preceded by the relative line number.
echo =======================================================
set /p keyword=Enter keyword to search: 
find "%keyword%"
pause
goto :menu

:attributes
echo +R - Use the +R option to make a file read-only.
echo -R - Use the -R option to change the file protection attribute back to normal.
echo +A - Use the +A option to set the ARCHIVE attribute of a file.
echo -A - Use the -A option to turn off the ARCHIVE attribute.
echo +H - Use the +H option to set the HIDDEN attribute of a file so that it will not appear in a directory listing.
echo -H - Use the -H option to turn off the HIDDEN attribute.
echo +S - Use the +S option to set the SYSTEM attribute of a file.
echo -S - Use the -S option to turn off the SYSTEM attribute.
echo /S - Use the /S switch to set attributes on subdirectories found within the specified path.
echo =======================================================
set /p file=Enter file path along with file to be attrib'd: 
attrib %file%
pause
goto :menu
