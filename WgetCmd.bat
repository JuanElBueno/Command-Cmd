@echo off
color 9f

set Version=V1.4.1

ping -n 1 juanelbueno.github.io >nul 2>&1
if %ERRORLEVEL% neq 0 goto sinconexioni

:titulot

if "%PROCESSOR_ARCHITECTURE%"=="x86" (
  set Titulo=Juan El Bueno %Version% (32 bits)
  title %Titulo%
) else (
  set Titulo=Juan El Bueno %Version% (64 bits)
  title %Titulo%
)

IF EXIST C:\Windows\System32\wget.exe ( 
	cls
	echo [+] Wget instalado exitosamente
	echo.
	echo [+] Saliendo...
	timeout /T 3 >nul 
	exit /b 0
) else (
	goto InstalarWget
)

:InstalarWget
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
	cd C:\Windows\System32
	echo [*] Descargando wget versión 32 bits...
	powershell -command iwr 'https://eternallybored.org/misc/wget/1.21.4/32/wget.exe' -OutFile 'wget.exe' >nul 2>&1
	if %ERRORLEVEL% neq 0 (
		echo [!] Error al descargar wget 32 bits
		timeout /T 5 >nul
		exit /b 1
	)
	echo [+] wget 32 bits instalado correctamente
) else (
	cd C:\Windows\System32
	echo [*] Descargando wget versión 64 bits...
	powershell -command iwr 'https://eternallybored.org/misc/wget/1.21.4/64/wget.exe' -OutFile 'wget.exe' >nul 2>&1
	if %ERRORLEVEL% neq 0 (
		echo [!] Error al descargar wget 64 bits
		timeout /T 5 >nul
		exit /b 1
	)
	echo [+] wget 64 bits instalado correctamente
)
echo.
echo [+] Saliendo...
timeout /T 3 >nul
exit /b 0

:sinconexioni
mode con: cols=52 lines=18 
cls
echo [!] *************************************************
echo [!] 
echo [!] No tienes conexion a internet
echo [!] Intenta de nuevo mas tarde
echo [!] 
echo [!] *************************************************
timeout /T 5 >nul
exit /b 1
