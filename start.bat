echo ========================================
echo 🧩 Rubik's Cube Portfolio Server
echo ========================================
echo.

:: Check Node.js first (preferred)
node --version >nul 2>&1
if not errorlevel 1 (
    echo ✅ Node.js found. Starting with npx serve...
    npx serve . --listen 8000 --open
    goto :end
)

:: Fallback: Check Python
python --version >nul 2>&1
if not errorlevel 1 (
    echo ✅ Python found. Starting HTTP server...
    cd /d "%~dp0"
    python -m http.server 8000
    goto :end
)

:: Python 2 fallback
python -V 2>nul | findstr /C:"Python 2" >nul
if not errorlevel 1 (
    echo ✅ Python 2 found. Starting HTTP server...
    cd /d "%~dp0"
    python -m SimpleHTTPServer 8000
    goto :end
)

:: Final fallback: PowerShell
echo ⚠️  Using PowerShell HTTP server (Windows only)...
powershell -Command "httpListener = New-Object System.Net.HttpListener; httpListener.Prefixes.Add('http://localhost:8000/'); httpListener.Start(); while($true) { $context = httpListener.GetContext(); $response = $context.Response; $response.ContentType = 'text/html'; $response.OutputStream.Write([byte[]](Get-Content '%~dp0index.html' -Encoding byte), 0, (Get-Content '%~dp0index.html' -Encoding byte).Length); $response.Close() }"

:end
echo.
echo 🌐 Server running at http://localhost:8000
echo 📱 Open in browser to view portfolio
pause
