@echo off

:menu
cls
echo.
echo Select a shape:
echo 1. Circle
echo 2. Triangle
echo 3. Quadrilateral
echo 4. Exit
set /p shape="Enter your choice (1, 2, 3, 4): "

if "%shape%"=="1" goto circle
if "%shape%"=="2" goto triangle
if "%shape%"=="3" goto quadrilateral
if "%shape%"=="4" goto exit
echo Invalid! Try again.
goto menu



:circle
set /p radius="Enter the radius of the circle: "
set /a area=314 * %radius% * %radius% / 100
echo The area of the circle is %area%
pause
goto menu



:triangle
set /p a="Enter the length of side a: "
set /p b="Enter the length of side b: "
set /p c="Enter the length of side c: "

set /a s=(%a% + %b% + %c%) / 2
set /a area=s*(s-%a%)*(s-%b%)*(s-%c%)
set /a area=%area% ** 0.5

if %a%==%b% if %b%==%c% (
    echo The triangle is equilateral.
    goto triangle_end
)

if %a%==%b% (
    echo The triangle is isosceles.
    goto triangle_end
)
if %a%==%c% (
    echo The triangle is isosceles.
    goto triangle_end
)
if %b%==%c% (
    echo The triangle is isosceles.
    goto triangle_end
)

echo The triangle is scalene.

:triangle_end
echo The area of the triangle is %area%
pause
goto menu



:quadrilateral
set /p length="Enter the length: "
set /p width="Enter the width: "
set /a area=%length% * %width%
echo The area of the quadrilateral is %area%

if %length%==%width% (
    echo The quadrilateral is a square.
) else (
    echo The quadrilateral is a rectangle.
)
pause
goto menu

:exit
pause
exit
