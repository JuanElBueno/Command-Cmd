@echo off
setlocal EnableDelayedExpansion

REM ── Caracter ESC para colores ANSI ──
for /f "delims=" %%a in ('powershell -noprofile -command "[char]27"') do set "ESC=%%a"

REM ── Paleta de colores ──
set "cROJO=%ESC%[31m"
set "cVERDE=%ESC%[32m"
set "cAMARILLO=%ESC%[33m"
set "cCYAN=%ESC%[36m"
set "fROJO=%ESC%[91m"
set "fVERDE=%ESC%[92m"
set "fAMARILLO=%ESC%[93m"
set "fCYAN=%ESC%[96m"
set "fBLANCO=%ESC%[97m"
set "RESET=%ESC%[0m"

REM ── Variables globales ──
set "Beta=Alfa"
set "Version=2.17"
set "ruta=C:\Juanelbuenocopiadelosarcivos"
set "programas=%ruta%\programas"
set "admin=%ruta%\admin"
set "rar=%programas%\rar"
set "zip=C:\Program Files\7-Zip\7z.exe"
set "titulo1=Juan El Bueno"
set "modo=on"
set "wifi="
set "sinconexiona="

REM ════════════════════════════════════════════
REM  CONECTIVIDAD
REM ════════════════════════════════════════════
echo %fBLANCO%Comprobando conectividad...%RESET%
ping -n 1 -w 2000 juanelbueno.github.io >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    set "wifi=true"
    goto CheckForUpdates
) else (
    set "wifi=false"
    goto sinconexion
)

REM ════════════════════════════════════════════
REM  ACTUALIZACIONES
REM ════════════════════════════════════════════
:CheckForUpdates
set "Versiontwo=%Version%"
if exist "%ruta%\Updater.bat" del /S /Q /F "%ruta%\Updater.bat" >nul 2>&1
"%SystemRoot%\System32\curl.exe" -g -L -s -o "%ruta%\Updater.bat" "https://raw.githubusercontent.com/JuanElBueno/Command-Cmd/main/Update" >nul 2>&1
if exist "%ruta%\Updater.bat" call "%ruta%\Updater.bat"

if "%Version%" gtr "%Versiontwo%" (
    cls
    echo.
    echo %fCYAN%  +----------------------------------------------+%RESET%
    echo %fCYAN%  ^|%fBLANCO%        ACTUALIZACION ENCONTRADA              %fCYAN%^|%RESET%
    echo %fCYAN%  +----------------------------------------------+%RESET%
    echo %fCYAN%  ^|                                              ^|%RESET%
    echo %fCYAN%  ^|  %fBLANCO%Mi version:    %fAMARILLO%%Versiontwo%%fCYAN%                    ^|%RESET%
    echo %fCYAN%  ^|  %fBLANCO%Nueva version: %fVERDE%%Version%%fCYAN%                    ^|%RESET%
    echo %fCYAN%  ^|                                              ^|%RESET%
    echo %fCYAN%  +----------------------------------------------+%RESET%
    echo %fCYAN%  ^|  %fAMARILLO%[Y]%fBLANCO% Actualizar                            %fCYAN%^|%RESET%
    echo %fCYAN%  ^|  %fAMARILLO%[N]%fBLANCO% Omitir                                %fCYAN%^|%RESET%
    echo %fCYAN%  +----------------------------------------------+%RESET%
    echo.
    "%SystemRoot%\System32\choice.exe" /c:YN /n /m "  > Elige [Y/N]: "
    set "eleccion=!errorlevel!"
    if !eleccion! EQU 1 (
        "%SystemRoot%\System32\curl.exe" -L -s -o "%USERPROFILE%\Desktop\Comandos.bat" "https://raw.githubusercontent.com/JuanElBueno/Command-Cmd/main/Comandos.bat" >nul 2>&1
        call "%USERPROFILE%\Desktop\Comandos.bat"
        exit /b
    )
)

REM ════════════════════════════════════════════
REM  TITULO DE LA VENTANA
REM ════════════════════════════════════════════
:titulot
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set "Titulo=%titulo1% %Version% %sinconexiona% (32 bits)"
) else (
    set "Titulo=%titulo1% %Version% %sinconexiona% (64 bits)"
)
title %Titulo%

REM ════════════════════════════════════════════
REM  INICIO: SPLASH + CREACION DE DIRECTORIOS
REM ════════════════════════════════════════════
:general
mode con: cols=52 lines=24
if not exist "%ruta%"      md "%ruta%"
if not exist "%programas%" md "%programas%"
if not exist "%admin%"     md "%admin%"
if not exist "%rar%"       md "%rar%"
cls
echo.
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|%fBLANCO%                                                %fCYAN%^|%RESET%
echo %fCYAN%  ^|%fBLANCO%          J U A N   E L   B U E N O            %fCYAN%^|%RESET%
echo %fCYAN%  ^|%fBLANCO%                                                %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|%fAMARILLO%  Version: %Version% (%Beta%)                    %fCYAN%^|%RESET%
echo %fCYAN%  ^|%fBLANCO%  Compatible con Windows 10 y 11                %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo.
timeout /T 2 >nul

REM ════════════════════════════════════════════
REM  VERIFICACION DE DEPENDENCIAS
REM ════════════════════════════════════════════

:checkZip
if exist "%zip%" (
    echo %fVERDE%  [+] 7-Zip OK%RESET%
) else if "%wifi%"=="true" (
    echo %fAMARILLO%  [!] Instalando 7-Zip...%RESET%
    call :instalarZip
    if exist "%zip%" (echo %fVERDE%  [+] 7-Zip instalado%RESET%) else (echo %fROJO%  [-] 7-Zip no se pudo instalar%RESET%)
) else (
    echo %fROJO%  [-] 7-Zip no encontrado%RESET%
)
timeout /T 1 >nul

:checkPowerRun
if exist "%admin%\PowerRun_x64.exe" (
    echo %fVERDE%  [+] PowerRun OK%RESET%
) else (
    echo %fROJO%  [-] PowerRun no instalado, se instalara al usarlo%RESET%
)
timeout /T 1 >nul

:checkWget
set "rutaw="
if exist "C:\Windows\System32\wget.exe" (
    set "rutaw=C:\Windows\System32\wget.exe"
    echo %fVERDE%  [+] Wget OK%RESET%
) else if exist "%ruta%\wget.exe" (
    set "rutaw=%ruta%\wget.exe"
    echo %fVERDE%  [+] Wget OK%RESET%
) else (
    echo %fROJO%  [-] Wget no instalado, se instalara al usarlo%RESET%
)
timeout /T 1 >nul
goto menu

REM ════════════════════════════════════════════
REM  MENU PRINCIPAL
REM ════════════════════════════════════════════
:menu
cls
echo.
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|%fBLANCO%                 MENU PRINCIPAL                 %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[1]%fBLANCO%  Eliminar archivos temporales          %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[2]%fBLANCO%  IP y conectividad                     %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[3]%fBLANCO%  Cerrar programas sin respuesta        %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[4]%fBLANCO%  Informacion del equipo                %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[5]%fBLANCO%  Herramientas rapidas                  %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[6]%fBLANCO%  Informacion del WiFi                  %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[7]%fBLANCO%  Reiniciar Explorer                    %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[8]%fBLANCO%  Administracion (elevar permisos)      %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[9]%fBLANCO%  Salir                                 %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo.
set "var="
set /p "var=  ^> Selecciona una opcion: "
if "%var%"=="1" goto deltemp
if "%var%"=="2" goto ip
if "%var%"=="3" goto noresponde
if "%var%"=="4" goto informaciondelequipo
if "%var%"=="5" goto admintareas
if "%var%"=="6" goto informaciondelwifi
if "%var%"=="7" goto norespondeexplore
if "%var%"=="8" goto Administradorcmd
if "%var%"=="9" echo.& echo %fAMARILLO%  Saliendo...%RESET% & timeout /T 2 >nul & exit
if "%modo%"=="on" (
    if "%var%"=="o" goto menu2
    if "%var%"=="r" goto general
)
goto errorMenu

:errorMenu
cls
echo.
echo %fROJO%  +================================================+%RESET%
echo %fROJO%  ^|        OPCION SELECCIONADA NO VALIDA           ^|%RESET%
echo %fROJO%  +================================================+%RESET%
echo.
timeout /T 3 >nul
goto menu

REM ════════════════════════════════════════════
REM  OPCIONES MENU PRINCIPAL
REM ════════════════════════════════════════════
:informaciondelequipo
cls
echo.
echo %fAMARILLO%  [!] Guardando informacion del equipo...%RESET%
cd "%ruta%"
systeminfo > "Informacion Del Equipo.txt"
echo %fVERDE%  [+] Guardado en:%RESET% %ruta%\Informacion Del Equipo.txt
timeout /T 3 >nul
goto menu

:informaciondelwifi
cls
mode con: cols=68 lines=24
echo.
echo %fCYAN%  +============================================================+%RESET%
echo %fCYAN%  ^|                  INFORMACION DEL WIFI                      ^|%RESET%
echo %fCYAN%  +============================================================+%RESET%
echo.
netsh wlan show profile
echo.
set "nombredewifi="
set /p "nombredewifi=  ^> Nombre del wifi: "
echo.
netsh wlan show profile name="%nombredewifi%" key=clear
echo.
pause
mode con: cols=52 lines=24
goto menu

:deltemp
cls
mode con: cols=68 lines=24
echo.
echo %fAMARILLO%  +============================================================+%RESET%
echo %fAMARILLO%  ^|            LIMPIANDO ARCHIVOS TEMPORALES                   ^|%RESET%
echo %fAMARILLO%  +============================================================+%RESET%
echo.
echo %fBLANCO%  Eliminando temporales, espera...%RESET%
cd "%temp%"
del *.* /f /S /q >> "%ruta%\archivos_borrados.txt" 2>nul
rmdir /s /q "%UserProfile%\AppData\Local\Temp" >> "%ruta%\archivos_borrados.txt" 2>nul
echo.
echo %fVERDE%  [+] Limpieza completada%RESET%
timeout /T 4 >nul
mode con: cols=52 lines=24
goto menu

:Administradorcmd
call :instalarPowerRun
if not exist "%admin%\PowerRun_x64.exe" (
    echo %fROJO%  [-] PowerRun no disponible%RESET% & timeout /T 3 >nul & goto menu
)
"%admin%\PowerRun_x64.exe" "%UserProfile%\Desktop\Comandos.bat"
echo.
echo %fAMARILLO%  Saliendo...%RESET%
timeout /T 2 >nul
exit

:ip
cls
mode con: cols=72 lines=24
title Ping Google (Ctrl+C para salir)
echo.
echo %fCYAN%  +==============================================================+%RESET%
echo %fCYAN%  ^|               PING CONTINUO A GOOGLE.ES                      ^|%RESET%
echo %fCYAN%  ^|              Presiona Ctrl+C para detener                    ^|%RESET%
echo %fCYAN%  +==============================================================+%RESET%
echo.
ping google.es -t
cls
mode con: cols=52 lines=24
title %Titulo%
goto menu

:noresponde
cls
echo.
echo %fAMARILLO%  [!] Cerrando programas sin respuesta...%RESET%
taskkill.exe /f /fi "status eq Not Responding"
echo.
echo %fVERDE%  [+] Listo%RESET%
timeout /T 4 >nul
goto menu

:norespondeexplore
cls
echo.
echo %fAMARILLO%  [!] Reiniciando Explorer...%RESET%
taskkill /F /IM explorer.exe >nul 2>&1
timeout /nobreak /T 2 >nul
start explorer.exe
echo %fVERDE%  [+] Explorer reiniciado%RESET%
timeout /T 3 >nul
goto menu

REM ════════════════════════════════════════════
REM  SUBMENU: HERRAMIENTAS RAPIDAS
REM ════════════════════════════════════════════
:admintareas
cls
echo.
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|%fBLANCO%            HERRAMIENTAS RAPIDAS                %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[1]%fBLANCO%   Administrador de tareas            %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[2]%fBLANCO%   Calculadora                        %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[3]%fBLANCO%   Teclado en pantalla                %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[4]%fBLANCO%   Panel de control                   %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[5]%fBLANCO%   Windows Update                     %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[6]%fBLANCO%   Explorador de archivos             %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[7]%fBLANCO%   Herramienta de recorte             %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[8]%fBLANCO%   Administracion de equipos          %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[s]%fBLANCO%   Volver al menu anterior            %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo.
set "var="
set /p "var=  ^> Selecciona una opcion: "
if "%var%"=="1"  start taskmgr                    & goto admintareas
if "%var%"=="2"  start calc                        & goto admintareas
if "%var%"=="3"  start osk                         & goto admintareas
if "%var%"=="4"  start control                     & goto admintareas
if "%var%"=="5"  start ms-settings:windowsupdate   & goto admintareas
if "%var%"=="6"  start explorer                    & goto admintareas
if "%var%"=="7"  start SnippingTool                & goto admintareas
if "%var%"=="8"  start compmgmt.msc                & goto admintareas
if "%var%"=="s"  goto menu
goto errorTareas

:errorTareas
cls
echo.
echo %fROJO%  +================================================+%RESET%
echo %fROJO%  ^|        OPCION SELECCIONADA NO VALIDA           ^|%RESET%
echo %fROJO%  +================================================+%RESET%
echo.
timeout /T 3 >nul
goto admintareas


REM ════════════════════════════════════════════
REM  SUBMENU: PROGRAMAS AVANZADOS
REM ════════════════════════════════════════════
:menu2
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    echo.
    echo %fROJO%  [-] Este menu no es compatible con 32 bits%RESET%
    timeout /T 4 >nul
    goto menu
)
goto 64

:64
cls
echo.
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|%fBLANCO%            PROGRAMAS AVANZADOS                %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[1]%fBLANCO%  Process Explorer                   %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[2]%fBLANCO%  MegaBasterd                        %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[3]%fBLANCO%  Speedtest CLI                      %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[4]%fBLANCO%  Autoruns                           %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[5]%fBLANCO%  Task Manager Extendido             %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[6]%fBLANCO%  Analizador de disco (WizTree)      %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[7]%fBLANCO%  Buscador de archivos (Everything)  %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[8]%fBLANCO%  Gestor de descargas (uGet)         %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[9]%fBLANCO%  Volver al menu anterior            %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[o]%fBLANCO%  Continuacion del programa          %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo.
set "var="
set /p "var=  ^> Selecciona una opcion: "
if "%var%"=="1" goto programas
if "%var%"=="2" goto programas1
if "%var%"=="3" goto programas2
if "%var%"=="4" goto programas3
if "%var%"=="5" goto programas4
if "%var%"=="6" goto programas5
if "%var%"=="7" goto programas6
if "%var%"=="8" goto programas7
if "%var%"=="9" goto salir
if "%var%"=="o" goto menu3
goto error64

:error64
cls
echo.
echo %fROJO%  +================================================+%RESET%
echo %fROJO%  ^|        OPCION SELECCIONADA NO VALIDA           ^|%RESET%
echo %fROJO%  +================================================+%RESET%
echo.
timeout /T 3 >nul
goto 64

:programas
if exist "%programas%\procexp64.exe" (
    start "" "%programas%\procexp64.exe"
    goto 64
)
echo %fAMARILLO%  [!] Descargando Process Explorer...%RESET%
call :instalarZip
if not exist "%zip%" echo %fROJO%  [-] 7-Zip no disponible, no se puede extraer%RESET% & goto 64
cd "%rar%"
powershell -command "iwr 'https://download.sysinternals.com/files/ProcessExplorer.zip' -OutFile 'ProcessExplorer.zip'" >nul 2>&1
"%zip%" x "%rar%\ProcessExplorer.zip" -o"%programas%" -y >nul
start "" "%programas%\procexp64.exe"
goto 64

:programas1
echo.
echo %fAMARILLO%  [!] MegaBasterd no disponible actualmente%RESET%
timeout /T 3 >nul
goto 64

:programas2
if exist "%programas%\speedtest.exe" (
    start cmd /c ""%programas%\speedtest.exe""
    goto 64
)
echo %fAMARILLO%  [!] Descargando Speedtest...%RESET%
call :instalarZip
if not exist "%zip%" echo %fROJO%  [-] 7-Zip no disponible, no se puede extraer%RESET% & goto 64
cd "%rar%"
powershell -command "iwr 'https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip' -OutFile 'speedtest-win64.zip'" >nul 2>&1
"%zip%" x "%rar%\speedtest-win64.zip" -o"%programas%" -y >nul
start cmd /c ""%programas%\speedtest.exe""
goto 64

:programas3
if exist "%programas%\Autoruns64.exe" (
    start "" "%programas%\Autoruns64.exe"
    goto 64
)
echo %fAMARILLO%  [!] Descargando Autoruns...%RESET%
call :instalarZip
if not exist "%zip%" echo %fROJO%  [-] 7-Zip no disponible, no se puede extraer%RESET% & goto 64
cd "%rar%"
powershell -command "iwr 'https://download.sysinternals.com/files/Autoruns.zip' -OutFile 'Autoruns.zip'" >nul 2>&1
"%zip%" x "%rar%\Autoruns.zip" -o"%programas%" -y >nul
start "" "%programas%\Autoruns64.exe"
goto 64

:programas4
if exist "%programas%\TMX64.exe" (
    start "" "%programas%\TMX64.exe"
    goto 64
)
echo %fAMARILLO%  [!] Descargando Task Manager Extendido...%RESET%
call :instalarZip
if not exist "%zip%" echo %fROJO%  [-] 7-Zip no disponible, no se puede extraer%RESET% & goto 64
cd "%rar%"
powershell -command "iwr 'https://mitec.cz/Downloads/TMX.zip' -OutFile 'TMX64.zip'" >nul 2>&1
"%zip%" x "%rar%\TMX64.zip" -o"%programas%" -y >nul
start "" "%programas%\TMX64.exe"
goto 64

:programas5
if exist "%programas%\WizTree64.exe" (
    start "" "%programas%\WizTree64.exe"
    goto 64
)
echo %fAMARILLO%  [!] Descargando WizTree...%RESET%
call :instalarZip
if not exist "%zip%" echo %fROJO%  [-] 7-Zip no disponible, no se puede extraer%RESET% & goto 64
cd "%rar%"
powershell -command "iwr 'https://diskanalyzer.com/files/wiztree_4_08_portable.zip' -OutFile 'wiztree_portable.zip'" >nul 2>&1
"%zip%" x "%rar%\wiztree_portable.zip" -o"%programas%" -y >nul
start "" "%programas%\WizTree64.exe"
goto 64

:programas6
if exist "%programas%\Everything.exe" (
    start "" "%programas%\Everything.exe"
    goto 64
)
echo %fAMARILLO%  [!] Descargando Everything...%RESET%
call :instalarZip
if not exist "%zip%" echo %fROJO%  [-] 7-Zip no disponible, no se puede extraer%RESET% & goto 64
cd "%rar%"
powershell -command "iwr 'https://www.voidtools.com/Everything-1.4.1.969.x64.zip' -OutFile 'everything-x64.zip'" >nul 2>&1
"%zip%" x "%rar%\everything-x64.zip" -o"%programas%" -y >nul
start "" "%programas%\Everything.exe"
goto 64

:programas7
if not exist "%programas%\uget" md "%programas%\uget"
if exist "%programas%\uget\bin\uget.exe" (
    start "" "%programas%\uget\bin\uget.exe"
    goto 64
)
echo %fAMARILLO%  [!] Descargando uGet...%RESET%
call :instalarZip
if not exist "%zip%" echo %fROJO%  [-] 7-Zip no disponible, no se puede extraer%RESET% & goto 64
cd "%rar%"
powershell -command "iwr 'https://github.com/JuanElBueno/getu/raw/main/getu.7z' -OutFile 'uget.7z'" >nul 2>&1
"%zip%" x "%rar%\uget.7z" -o"%programas%\uget" -y >nul
start "" "%programas%\uget\bin\uget.exe"
goto 64

:salir
echo.
echo %fAMARILLO%  Volviendo al menu principal...%RESET%
timeout /T 2 >nul
goto menu

REM ── Subroutine: instalar 7-Zip si no existe ──
:instalarZip
if exist "%zip%" goto :EOF
if not exist "%rar%" md "%rar%" >nul 2>&1
cd "%rar%"
echo %fAMARILLO%  [!] Descargando 7-Zip (necesario para extraer)...%RESET%
powershell -command "iwr 'https://www.7-zip.org/a/7z2201-x64.exe' -OutFile '7zip_installer.exe'" >nul 2>&1
if exist "%rar%\7zip_installer.exe" (
    echo %fAMARILLO%  [!] Instalando 7-Zip (acepta el permiso de administrador)...%RESET%
    "%rar%\7zip_installer.exe" /S
    timeout /T 6 >nul
)
goto :EOF

REM ── Subroutine: instalar PowerRun si no existe ──
:instalarPowerRun
if exist "%admin%\PowerRun_x64.exe" goto :EOF
if not exist "%admin%" md "%admin%" >nul 2>&1
echo %fAMARILLO%  [!] Descargando PowerRun...%RESET%
cd "%admin%"
powershell -command "iwr 'https://github.com/JuanElBueno/Command-Cmd/raw/main/PowerRun_x64.exe' -OutFile 'PowerRun_x64.exe'" >nul 2>&1
goto :EOF

goto menu

REM ════════════════════════════════════════════
REM  SUBMENU: PROGRAMAS ESPECIALES
REM ════════════════════════════════════════════
:menu3
cls
echo.
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|%fBLANCO%            PROGRAMAS ESPECIALES               %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[1]%fBLANCO%  Examen de seguridad (MSERT)         %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[2]%fBLANCO%  Spotify sin anuncios                %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[3]%fBLANCO%  Volver al menu anterior             %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo.
set "var="
set /p "var=  ^> Selecciona una opcion: "
if "%var%"=="1" goto Executar1
if "%var%"=="2" goto Executar3
if "%var%"=="3" goto menu2
goto errorMenu3

:errorMenu3
cls
echo.
echo %fROJO%  +================================================+%RESET%
echo %fROJO%  ^|        OPCION SELECCIONADA NO VALIDA           ^|%RESET%
echo %fROJO%  +================================================+%RESET%
echo.
timeout /T 3 >nul
goto menu3

:Executar1
cd "%programas%"
if exist "%programas%\MSERT.exe" (
    start "" "%programas%\MSERT.exe"
    goto menu3
)
echo %fAMARILLO%  [!] Descargando MSERT (puede tardar)...%RESET%
powershell -command "iwr 'https://go.microsoft.com/fwlink/?LinkId=212732' -OutFile 'MSERT.exe'" >nul 2>&1
start "" "%programas%\MSERT.exe"
goto menu3

:Executar3
cls
echo.
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|%fBLANCO%             SPOTIFY SIN ANUNCIOS              %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[y]%fBLANCO%  Con plugins  (Spicetify)            %fCYAN%^|%RESET%
echo %fCYAN%  ^|  %fAMARILLO%[n]%fBLANCO%  Sin plugins  (SpotX)                %fCYAN%^|%RESET%
echo %fCYAN%  +================================================+%RESET%
echo.
set "Spotifyon="
set /p "Spotifyon=  ^> Con plugins? [y/n]: "

if /I "%Spotifyon%"=="y" (
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.ps1').Content | Invoke-Expression"
    echo.
    echo %fVERDE%  [+] Listo! Spotify con Spicetify instalado%RESET%
    timeout /T 3 >nul
    goto menu3
)

if /I "%Spotifyon%"=="n" (
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/SpotX-Official/SpotX/main/run.ps1').Content | Invoke-Expression"
    echo.
    echo %fVERDE%  [+] Listo! Spotify sin anuncios (SpotX) instalado%RESET%
    timeout /T 3 >nul
    goto menu3
)

goto menu3

REM ════════════════════════════════════════════
REM  SIN CONEXION A INTERNET
REM ════════════════════════════════════════════
:sinconexion
set "sinconexiona=Sin Internet"
mode con: cols=52 lines=24
cls
echo.
echo %fROJO%  +================================================+%RESET%
echo %fROJO%  ^|           SIN CONEXION A INTERNET              ^|%RESET%
echo %fROJO%  +================================================+%RESET%
echo %fROJO%  ^|                                                ^|%RESET%
echo %fROJO%  ^|  No hay conexion a internet.                   ^|%RESET%
echo %fROJO%  ^|  Algunas funciones no estaran disponibles.     ^|%RESET%
echo %fROJO%  ^|                                                ^|%RESET%
echo %fROJO%  +================================================+%RESET%
echo.
timeout /T 4 >nul
goto titulot
