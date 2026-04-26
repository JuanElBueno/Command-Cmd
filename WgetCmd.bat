@echo off
setlocal enabledelayedexpansion
color 9f

set Version=V1.4.2

REM Verificar permisos de administrador
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
	cls
	echo [!] Error: Este script requiere permisos de administrador
	echo.
	pause
	exit /b 1
)

REM Verificar conexión a internet
ping -n 1 8.8.8.8 >nul 2>&1
if %ERRORLEVEL% neq 0 goto sinconexion

REM Establecer título según arquitectura
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
	set Titulo=Juan El Bueno %Version% (32 bits)
) else (
	set Titulo=Juan El Bueno %Version% (64 bits)
)
title %Titulo%

REM Verificar si wget ya está instalado
if exist "C:\Windows\System32\wget.exe" (
	cls
	echo [+] Wget ya está instalado exitosamente
	echo.
	echo [+] Saliendo...
	timeout /T 3 >nul
	exit /b 0
) else (
	goto InstalarWget
)

:InstalarWget
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
	cd /d C:\Windows\System32 || (
		echo [!] Error: No se puede acceder a System32
		timeout /T 5 >nul
		exit /b 1
	)
	echo [*] Descargando wget versión 32 bits...
	powershell -NoProfile -Command "iwr 'https://eternallybored.org/misc/wget/1.21.4/32/wget.exe' -OutFile 'wget.exe' -ErrorAction SilentlyContinue" >nul 2>&1
	if !ERRORLEVEL! neq 0 (
		echo [!] Error al descargar wget 32 bits
		timeout /T 5 >nul
		exit /b 1
	)
	echo [+] wget 32 bits instalado correctamente
) else (
	cd /d C:\Windows\System32 || (
		echo [!] Error: No se puede acceder a System32
		timeout /T 5 >nul
		exit /b 1
	)
	echo [*] Descargando wget versión 64 bits...
	powershell -NoProfile -Command "iwr 'https://eternallybored.org/misc/wget/1.21.4/64/wget.exe' -OutFile 'wget.exe' -ErrorAction SilentlyContinue" >nul 2>&1
	if !ERRORLEVEL! neq 0 (
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

:sinconexion
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
