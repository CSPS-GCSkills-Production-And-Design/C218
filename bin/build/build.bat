@echo off
title Build process

echo SASS minimification
echo.
call npm run build-css
title Build process - SASS minimification
echo.
echo Javascript optimization
echo.
call node ..\core\js\lib\r.js -o build.js
title Build process - Javascript optimization