# Spec-Kit Documentation Server
Write-Host "Starting Spec-Kit Documentation Server..." -ForegroundColor Green
Write-Host ""

# Check if docsify-cli is installed
$docsifyInstalled = Get-Command docsify -ErrorAction SilentlyContinue

if (-not $docsifyInstalled) {
    Write-Host "docsify-cli not found. Installing..." -ForegroundColor Yellow
    npm install -g docsify-cli
    Write-Host ""
}

# Start server
Write-Host "Opening http://localhost:3000" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Gray
Write-Host ""

Start-Process "http://localhost:3000"
docsify serve . -p 3000
