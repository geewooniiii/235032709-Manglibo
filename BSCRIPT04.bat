@echo off
setlocal enabledelayedexpansion

:goBack
echo Enter the source directory:
set /p "dir=Source Directory: "
if not exist "!dir!" (
    echo Folder does not exist. Please try again.
    goto :goBack
)

:goBackDest
echo Enter the destination directory:
set /p "dest=Destination Directory: "
if not exist "!dest!" (
    echo Folder does not exist. Please try again.
    goto :goBackDest
)

set "archive=!dest!\archive"
if not exist "!archive!" (
    mkdir "!archive!"
)

cd /d "!dir!"

forfiles /m *.txt /d -365 /c "cmd /c move @file "!archive!""

echo Here are the text files sorted by date/time:
for /f "delims=" %%i in ('dir /b /o:d *.txt') do (
    echo %%i
)

:fileLoop
dir

echo Enter the file from "!dir!" to move to "!dest!" (or type 'done' to finish): 
set /p "file="

if /I "!file!"=="done" (
    echo Done.
    goto :end
)
if not exist "!file!" (
    cls
    echo File does not exist. Please try again.
    goto :fileLoop
)

move "!file!" "!dest!\archive"
goto :fileLoop

:end
echo Here are the files in the archive directory sorted by size:
for /f "tokens=*" %%A in ('dir /b /s /o:s "!archive!"') do (
    echo %%~nA %%~pA
)

:deleteLoop
echo Do you want to delete the old, large files? (Files larger than 1MB will be deleted.) (yes/no/finish/repeat):
set /p "delete= "

if /I "!delete!"=="yes" (
    for /R "!dest!\archive" %%F in (*.txt) do (
        if %%~zF GTR 1000000 (
            del /P "%%F"
        )
    )
    goto :deleteLoop
) else if /I "!delete!"=="no" (
    echo Files will not be deleted.
    goto :deleteLoop
) else if /I "!delete!"=="finish" (
    echo Selected "finish".
    goto :finally
) else if /I "!delete!"=="repeat" (
    echo Going back.
    goto :goBack
) else (
    echo Invalid input. Please try again.
    goto :deleteLoop
)

:finally
echo Done!
pause
