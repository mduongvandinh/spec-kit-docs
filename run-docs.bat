@echo off
echo Starting Spec-Kit Documentation Server...
echo.

:: Check if docsify-cli is installed
where docsify >nul 2>nul
if %errorlevel% neq 0 (
    echo docsify-cli not found. Installing...
    npm install -g docsify-cli
    echo.
)

:: Start server
echo Opening http://localhost:3000
echo Press Ctrl+C to stop the server
echo.
start http://localhost:3000
docsify serve . -p 3000
