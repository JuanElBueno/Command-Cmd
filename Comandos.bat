@echo off
@shift
Setlocal EnableDelayedExpansion

REM chcp 65001
REM Colores
set cnegron=[30m
set crojo=[31m
set cverde=[32m
set camarillo=[33m
set cazul=[34m
set clila=[35m
set ccyan=[36m
set cblancop=[37m
 
set fnegro=[90m
set frojo=[91m
set fverde=[92m
set famarillo=[93m
set fazul=[94m
set flila=[95m
set fcyan=[96m
set fblanco=[97m

REM Ruta general
echo %fblanco%
set Beta=Alfa
set Version=2.16.1.9
set ruta=C:\Juanelbuenocopiadelosarcivos
set programas=%ruta%\programas
set admin=%ruta%\admin
set rar=%programas%\rar
set zip="C:\Program Files\7-Zip\7z.exe"
set titulo1=Juan El Bueno
set modo=on
set wifi=

REM ===== VARIABLES DE ARQUITECTURA =====
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
	set ARCH=32
	set ARCH_NAME=32 bits
) else (
	set ARCH=64
	set ARCH_NAME=64 bits
)

REM ===== URLs CENTRALIZADAS =====
REM Herramientas principales
set url_7zip=https://www.7-zip.org/a/7z2408-x64.exe
set url_powerrun=https://github.com/JuanElBueno/Command-Cmd/raw/main/PowerRun_x64.exe
set url_wgetcmd=https://raw.githubusercontent.com/JuanElBueno/Command-Cmd/main/WgetCmd.bat

REM Wget (x32 y x64)
set url_wget_32=https://eternallybored.org/misc/wget/1.21.3/32/wget.exe
set url_wget_64=https://eternallybored.org/misc/wget/1.21.3/64/wget.exe
if "%ARCH%"=="32" (
	set url_wget=%url_wget_32%
) else (
	set url_wget=%url_wget_64%
)

REM Programas del menú 64
set url_procexp=https://download.sysinternals.com/files/ProcessExplorer.zip
set url_speedtest=https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip
set url_autoruns=https://download.sysinternals.com/files/Autoruns.zip
set url_tmx=https://mitec.cz/Downloads/TMX.zip
set url_everything=https://www.voidtools.com/Everything-1.4.1.969.x64.zip
set url_wiztree=https://diskanalyzer.com/files/wiztree_4_08_portable.zip
set url_uget=https://github.com/JuanElBueno/getu/raw/main/getu.7z
set url_msert=https://definitionupdates.microsoft.com/download/DefinitionUpdates/VersionedSignatures/AM/1.381.1451.0/amd64/MSERT.exe

REM URLs de actualización
set url_updater=https://raw.githubusercontent.com/JuanElBueno/Command-Cmd/main/Update
set url_comandos=https://raw.githubusercontent.com/JuanElBueno/Command-Cmd/main/Comandos.bat

REM Spotify (RCE crítico)
set url_spotify_con_plugins=https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.ps1
set url_spotify_sin_plugins=https://raw.githubusercontent.com/SpotX-Official/SpotX/main/run.ps1

REM ===== FUNCIONES REUTILIZABLES =====
REM Función InstallProgram PROGRAM_NAME PROGRAM_PATH URL_ZIP ZIP_FILENAME EXTRACT_PATH RETURN_LABEL
REM Ejemplo: call :InstallProgram "procexp64" "%programas%" "https://example.com/prog.zip" "prog.zip" "%programas%" "menu64"
:InstallProgram
setlocal
set "PROG_NAME=%1"
set "PROG_PATH=%2\%PROG_NAME%.exe"
set "URL=%3"
set "ZIP_NAME=%4"
set "EXTRACT_PATH=%5"
set "RETURN_LABEL=%6"

IF EXIST "%PROG_PATH%" (
	echo %cverde%[+] %PROG_NAME% ya instalado%fblanco%
	timeout /T 2 >nul
	endlocal & goto %RETURN_LABEL%
) else if "%wifi%"=="true" (
	echo %camarillo%[*] Descargando %PROG_NAME%...%fblanco%
	cd %rar%
	powershell -command iwr '%URL%' -OutFile '%ZIP_NAME%' >nul 2>&1
	if !ERRORLEVEL! neq 0 (
		echo %crojo%[!] Error descargando %PROG_NAME%%fblanco%
		timeout /T 3 >nul
		endlocal & goto %RETURN_LABEL%
	)
	echo %camarillo%[*] Extrayendo %PROG_NAME%...%fblanco%
	%zip% x %rar%\%ZIP_NAME% -o%EXTRACT_PATH% -y >nul 2>&1
	timeout /T 2 >nul
	cd %EXTRACT_PATH%
	if exist "%PROG_PATH%" (
		start %PROG_NAME%.exe
		echo %cverde%[+] %PROG_NAME% iniciado%fblanco%
	) else (
		echo %crojo%[!] Error: %PROG_NAME%.exe no encontrado%fblanco%
	)
	timeout /T 2 >nul
	endlocal & goto %RETURN_LABEL%
) else (
	echo %camarillo%[!] Sin conexión. No se puede descargar %PROG_NAME%%fblanco%
	timeout /T 3 >nul
	endlocal & goto %RETURN_LABEL%
)

echo Comprobando conectividad ...
ping -n 1 juanelbueno.github.io

if %ERRORLEVEL%==0 ( 
set wifi=true
goto CheckForUpdates
) else ( 
set wifi=false
goto sinconexioni
) 

:CheckForUpdates
set Versiontwo=%Version%
if exist "%ruta%\Updater.bat" DEL /S /Q /F "%ruta%\Updater.bat" >nul 2>&1
"%SystemRoot%\System32\curl.exe" -g -L -# -o "%ruta%\Updater.bat" "%url_updater%" >nul 2>&1
if %ERRORLEVEL% neq 0 (
	echo %camarillo%[!] Advertencia: Descarga de actualización falló. Continuando sin actualizar.%fblanco%
	timeout /T 3 >nul
	goto titulot
)
if not exist "%ruta%\Updater.bat" goto titulot
call "%ruta%\Updater.bat"
if "%Version%" gtr "%Versiontwo%" (
	cls
	echo.
	echo %camarillo% --------------------------------------------------------------
	echo                             Actualizacion Encontrada
	echo %camarillo% --------------------------------------------------------------
	echo.
	echo %camarillo%                         Mi version: %Versiontwo%
	echo.
	echo %camarillo%                         Nueva version: %Version%
	echo.
	echo.
	echo.
	echo %camarillo%     [Y] Yes, Update
	echo %camarillo%     [N] No
	echo %fblanco%
	"%SystemRoot%\System32\choice.exe" /c:YN /n /m "%DEL%                                >:"
	set "choice=!errorlevel!"
	if !choice! == 1 (
		echo %camarillo%[*] Descargando actualización...%fblanco%
		"%SystemRoot%\System32\curl.exe" -L -o %USERPROFILE%\Desktop\Comandos.bat "%url_comandos%" >nul 2>&1
		if %ERRORLEVEL% neq 0 (
			echo %crojo%[!] Error: No se pudo descargar la actualización. Intenta de nuevo más tarde.%fblanco%
			timeout /T 3 >nul
			goto menu
		)
		if not exist %USERPROFILE%\Desktop\Comandos.bat (
			echo %crojo%[!] Error: Archivo descargado no encontrado.%fblanco%
			timeout /T 3 >nul
			goto menu
		)
		call %USERPROFILE%\Desktop\Comandos.bat
		exit /b
	)
)

:titulot
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
  set Titulo=%titulo1% %Version% %sinconexiona% (32 bits)
  title %Titulo%
) else (
  set Titulo=%titulo1% %Version% %sinconexiona% (64 bits)
  title %Titulo%
)

REM Modos de iniciar
:general
mode con: cols=52 lines=18  
IF NOT EXIST "%ruta%" md "%ruta%"
IF NOT EXIST "%programas%" md "%programas%"
IF NOT EXIST "%admin%" md "%admin%"
IF NOT EXIST "%rar%" md "%rar%"
cls
cd %ruta%
echo ==================================================
echo.
echo                  Para Win 10 Y 11 
echo.
echo        Version %Beta% De la Aplicacion %Version%
echo.
echo ==================================================
timeout /T 3 >nul

REM Programas necesarios para iniciar

IF EXIST %zip% (
echo %cverde%[+]Progama Istalado Exitosa 7zip & timeout /T 2 >nul
goto admin
) else if "%wifi%"=="true" (
echo %crojo%[+]Programas Necesarios 7zip & timeout /T 2 >nul
goto desrar
) else (
echo %camarillo%[+]Estas sin conexion de internet & timeout /T 2 >nul
goto admin
)

:desrar
if exist %zip% (
goto admin
) else if "%wifi%"=="true" (
cd %programas%
powershell -command iwr '%url_7zip%' -OutFile 'zip.exe'
zip.exe /S /D="C:\Program Files\7-Zip"
goto admin
)

REM IF EXIST %zip% (
REM goto admin
REM ) else (
REM cd %Ruta%\winrar 
REM powershell -command iwr 'https://github.com/JuanElBueno/Winrar-cmd/archive/refs/heads/main.zip' -OutFile 'WinRAR_6.2.zip' 
REM powershell Expand-Archive -LiteralPath '%Ruta%\winrar\WinRAR_6.2.zip' -DestinationPath %Ruta%\winrar 
REM goto admin
REM )

:admin
IF EXIST %admin%\PowerRun_x64.exe (
echo %cverde%[+]Progama Istalado Exitosa PowerRun & timeout /T 2 >nul
goto wget1
) else if "%wifi%"=="true" (
echo %crojo%[+]Programas Necesarios PowerRun & timeout /T 2 >nul
goto admindes
) else (
echo %camarillo%[+]Estas sin conexion de internet & timeout /T 2 >nul
goto wget1
)

:admindes
:: si exite se pone en admin
IF EXIST %admin%\PowerRun_x64.exe ( 
goto wget1
) else (
:: si no exite se descarga
cd %admin%
powershell -command iwr '%url_powerrun%' -OutFile 'PowerRun_x64.exe' 
goto wget1
)


:wget1
openfiles >nul 2>&1
if %ErrorLevel% equ 0 ( 
set wgetvof=y
) else ( 
set wgetvof=n
)

if "%wgetvof%"=="y" (
IF EXIST C:\Windows\System32\wget.exe (
echo %cverde%[+]Progama Istalado Exitosa Wget [administracion] & timeout /T 2 >nul
goto menu
) else if "%wifi%"=="true" (
echo %crojo%[+]Programas Necesarios Wget [administracion] & timeout /T 2 >nul
goto wgetinstalar
) else (
echo %camarillo%[+]Estas sin conexion de internet & timeout /T 2 >nul
goto menu
))
 
if "%wgetvof%"=="n" (
IF EXIST %Ruta%\wget.exe (
echo %cverde%[+]Progama Istalado Exitosa Wget [No administracion] & timeout /T 2 >nul
goto menu
) else if "%wifi%"=="true" (
echo %crojo%[+]Programas Necesarios Wget [No administracion] & timeout /T 2 >nul
goto wgetsinad
) else (
echo [+]Estas sin conexion de internet & timeout /T 2 >nul
goto menu
))

:wgetsinad
set rutaw=%ruta%\wget.exe

IF EXIST %Ruta%\wget.exe ( 
echo %cverde%[+]Progama Istalado Exitosa Wget [No administracion]
timeout /T 5 >nul
goto menu
) else if "%PROCESSOR_ARCHITECTURE%"=="x86" (
cd %ruta%
powershell -command iwr '%url_wget_32%' -OutFile 'wget.exe'
echo.
timeout /T 3 >nul
goto menu
) else (
cd %ruta%
powershell -command iwr '%url_wget_64%' -OutFile 'wget.exe' 
echo. 
timeout /T 3 >nul 
goto menu
)

:wgetinstalar
set rutaw=C:\Windows\System32\wget.exe

IF EXIST %Ruta%\WgetCmd.bat (
goto menu
) else (
cd %ruta% 
powershell -command iwr '%url_wgetcmd%' -OutFile 'WgetCmd.bat'
call WgetCmd.bat
mode con: cols=50 lines=18 
timeout /T 7 >nul
goto menu
)

REM 						Menu de inicio
:menu                                                    
echo %fblanco%
	cls
	echo ==================================================
	echo =                       MENU                     =
	echo ==================================================
	echo * 1) Limpiar archivos temporales                 *
	echo * 2) Ip                                          *
	echo * 3) Finalizar programas congelados              *
	echo * 4) Informacion del equipo                      *
	echo * 5) Comandos para ejecutar rapidamente          *
	echo * 6) Informacion del wifi                        *
	echo * 7) Explore no funciona nada                    *
	echo * 8) Administracion                              *
	echo * 9) Salir                                       *
	echo ==================================================
		set /p var=Seleccione una opcion [1-9]: 
		if "%var%"=="1" goto deltemp
		if "%var%"=="2" goto ip
		if "%var%"=="3" goto noresponde
		if "%var%"=="4" goto informaciondelequipo
		if "%var%"=="5" goto admintareas
		if "%var%"=="6" goto informaciondelwifi
		if "%var%"=="7" goto norespondeexplore
		if "%var%"=="8" goto Administradorcmd
		if "%var%"=="9" echo [+] Saliendo... & timeout /T 2 >nul & Exit
		REM modo de ingeneria
		if "%modo%"=="on" (
		if "%var%"=="o" goto menu2
		if "%var%"=="r" goto general
		)

		REM Si llegó aquí, opción es inválida
		cls
		echo %camarillo%==================================================
		echo.
		echo %camarillo%=        OPCION SELECCIONADA NO VALIDA!          =
		echo.
		echo %camarillo%==================================================
		timeout /T 3 >nul
		%fblanco%
		goto menu
		
:: Error de comandos
:error
cls
echo %camarillo%==================================================
echo.
echo %camarillo%=        OPCION SELECCIONADA NO VALIDA!          =
echo.
echo %camarillo%==================================================
timeout /T 3 >nul
%fblanco%
goto menu


:informaciondelequipo
cls
cd %ruta%
systeminfo > "Informacion Del Equipo.txt"
goto menu

:informaciondelwifi
:: nombre de wifi y la contraseña
mode con: cols=65 lines=15
echo ===============
echo Nombre del wifi
echo ===============
netsh wlan show profile
set /p nombredewifi=Nombre del wifi:
netsh wlan show profile name=%nombredewifi% key=clear 
pause
mode con: cols=50 lines=18  
goto menu

:: Achivos borrados tempoales
:deltemp
cls
cd %temp%
@echo on
mode con: cols=65 lines=15
del *.* /f /S /q >> %Ruta%\achivos_borrados.txt
rmdir /s /q "%UserProfile%\AppData\Local\Temp" >> %Ruta%\achivos_borrados.txt
@echo off
timeout /T 5
mode con: cols=50 lines=18
cls
goto menu

::powershell -command iwr 'https://www.sordum.org/files/download/power-run/PowerRun.zip' -OutFile 'PowerRun.zip'

:Administradorcmd
"%admin%\PowerRun_x64.exe" "%UserProfile%\Desktop\Comandos.bat" 
echo [+] Salendo...
timeout /T 2 >nul 
Exit 

:: Ip cuando estas sin intertet
:ip
cls
mode con: cols=70 lines=18
title Ip De Google (Acuedate de N para salir)
ping google.es -t
cls
mode con: cols=50 lines=18
title %Titulo%
goto menu

:: No responde los porgramas
:noresponde
cls
taskkill.exe /f /fi "status eq Not Responding" & timeout /T 5 & goto menu

:: No Responde Explore 
:norespondeexplore
cls
TASKKILL /F /IM explorer.exe & timeout /nobreak 10 & start explorer.exe
goto menu

REM :Istalador_de_paquetes
REM IF EXIST %programas%\Progamas.bat ( 
REM echo %cverde%[+]Progama Istalado Exitosamente & timeout /T 5 >nul
REM goto menu
REM ) else (
REM :: si no exite se descarga
REM cd %programas%
REM powershell -command iwr '' -OutFile '' 
REM goto menu
REM )

:admintareas
	cls
	echo ================================================= 
	echo =                      MENU                     =
	echo =================================================
	echo = 1) Administrador de tareas                    =
	echo = 2) Calculadora                                =
	echo = 3) Teclado en pantalla                        =
	echo = 4) Panel de control                           =
	echo = 5) Atualizar el windows                       =
	echo = 6) Explorer                                   =
	echo = 7) Recorte de pantalla                        =
	echo = 10) Administracion de equipos                 =
	echo = s) Salir del menu volver a anterior.          =
	echo =================================================
		set /p var=Seleccione una opcion [1-7, 10, s]: 
		if "%var%"=="1" call "taskmgr" & goto admintareas
		if "%var%"=="2" call "calc" & goto admintareas
		if "%var%"=="3" call "osk" & goto admintareas
		if "%var%"=="4" call "control" & goto admintareas
		if "%var%"=="5" start ms-settings:windowsupdate & goto admintareas
		if "%var%"=="6" call "explorer" & goto admintareas
		if "%var%"=="7" call "SnippingTool" & goto admintareas
		REM Opciones 8 y 9 no existen en el menú
		if "%var%"=="10" call compmgmt & goto admintareas
		if "%var%"=="s" goto menu

		REM Si llegó aquí, opción es inválida
		goto errorAdmintareas
		

	:: Error de comandos
	:errorAdmintareas
	cls
	echo %camarillo%==================================================
	echo.
	echo %camarillo%=        OPCION SELECCIONADA NO VALIDA!          =
	echo.
	echo %camarillo%==================================================
	timeout /T 3 >nul
	%fblanco%
	goto admintareas

:: menu2 de programas de descagar
:menu2
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
  echo Programa no compatible de 32 bits & timeout /T 5 >nul & goto menu
) else (
  goto 64
)

REM 32
REM :32
	REM cls
	REM echo =================================================
	REM echo =           Progama desatualizado               =
	REM echo =================================================
	REM echo =================================================
	REM echo =                      MENU                     =
	REM echo =================================================
	REM echo = 1) programas procexp64                         =
	REM echo = 2) programas MegaBasterd                       =
	REM echo = 3) Salir del menu volver a anterior.          =
	REM echo =================================================
		REM set /p var=Seleccione una opcion [1-3]: 
		REM if "%var%"=="1" goto programasm3
		REM if "%var%"=="2" goto programas1m3
		REM if "%var%"=="3" goto menu
		
REM :: error de comandos
REM :error
REM cls
REM echo =================================================
REM echo.
REM echo =        OPCION SELECCIONADA NO VALIDA!         =
REM echo.
REM echo =================================================
REM timeout /T 5 >nul
REM goto 32

REM :programasm3
REM cd C:\Juanelbuenocopiadelosarcivos\programas
REM :: si exite se pone la aplicacion
REM IF EXIST C:\Juanelbuenocopiadelosarcivos\programas\procexp64.exe start procexp.exe
REM :: si no exite se descarga
REM IF NOT EXIST C:\Juanelbuenocopiadelosarcivos\programas\procexp64.exe wget https://download.sysinternals.com/files/ProcessExplorer.zip & title Juan El Bueno & start procexp.exe
REM title Juan El Bueno
REM %zip% x C:\Juanelbuenocopiadelosarcivos\programas\rar\ProcessExplorer.zip C:\Juanelbuenocopiadelosarcivos\programas 
REM cd C:\Juanelbuenocopiadelosarcivos\programas 
REM start procexp64.exe
REM goto 64

REM :programas1m3
REM cd C:\Juanelbuenocopiadelosarcivos\programas
REM :: si exite se pone la aplicacion
REM IF EXIST C:\Juanelbuenocopiadelosarcivos\programas\MegaBasterd.jar start MegaBasterd.jar
REM :: si no exite se descarga
REM IF NOT EXIST C:\Juanelbuenocopiadelosarcivos\programas\MegaBasterd.jar wget https://github.com/tonikelope/megabasterd/releases/download/v7.24/MegaBasterd_7.24.jar & title Juan El Bueno & start MegaBasterd.jar
REM title Juan El Bueno
REM goto m3


::64
:64
	cls
	echo =================================================
	echo =                      MENU                     =
	echo =================================================
	echo = 1) Programas procexp64                        =
	echo = 2) Programas MegaBasterd                      =
	echo = 3) Programas Test de velocidad               =
	echo = 4) Programas Autoruns64                       =
	echo = 5) Programas Task Manager                     =
	echo = 6) Administrador de archivos                   =
	echo = 7) Programas Buscador achivos                 =
	echo = 8) Programas Descargar_Achivos                =
	echo = 9) Salir del menu volver a anterior           =
	echo = o) Continuacion del programa                  =	
	echo =================================================
		set /p var=Seleccione una opcion [1-9, o]: 
		:: programas de equipo de wifi
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

		REM Si llegó aquí, opción es inválida
		goto error64
		
:: error de comandos
:error64
cls
echo %camarillo%==================================================
echo.
echo %camarillo%=        OPCION SELECCIONADA NO VALIDA!          =
echo.
echo %camarillo%==================================================
timeout /T 3 >nul
%fblanco%
goto 64

:programas
:: si exite se pone la aplicacion
IF EXIST %programas%\procexp64.exe (
start procexp64.exe
goto 64
) else ( 
:: si no exite se descarga
cd %rar% 
powershell -command iwr '%url_procexp%' -OutFile 'ProcessExplorer.zip' 
goto procexp64
)
:: Extraer en winrar
:procexp64
REM 7z x <path to>\duane.zip -oc:\duane
%zip% x %rar%\ProcessExplorer.zip -o%programas% -y
cd %programas% 
start procexp64.exe
goto 64

:programas1
goto 64
REM IF NOT EXIST "%programas%\mega" md "%programas%\mega"
REM cd "%programas%\mega"
REM IF NOT EXIST "C:\Program Files\Java\jre1.8.0_301\bin\java.exe" echo %crojo%[+]Programas Necesarios Java & timeout /T 5 >nul & goto 64

REM :: si exite se pone la aplicacion
REM IF EXIST "%programas%\mega\MegaBasterdWINDOWS\MegaBasterd.bat" (
REM start "%programas%\mega\MegaBasterd.bat"
REM goto 64
REM ) else (
REM :: si no exite se descarga
REM powershell -command iwr 'https://github.com/tonikelope/megabasterd/releases/download/v7.76/MegaBasterdWINDOWS_7.76_portable.zip' -OutFile 'MegaBasterdWINDOWSportable.zip' 
REM goto megarar
REM )

REM :megarar
REM %zip% x MegaBasterdWINDOWSportable.zip -o%programas%\mega -y
REM cd %programas%\mega\MegaBasterdWINDOWS
REM start "%programas%\mega\MegaBasterdWINDOWS\MegaBasterd.bat"
REM pause
REM goto 64


REM IF NOT EXIST "C:\Program Files\Java\jre1.8.0_301\bin\java.exe" echo %crojo%[+]Programas Necesarios Java & timeout /T 5 >nul & goto 64

REM :: si exite se pone la aplicacion
REM IF EXIST %programas%\MegaBasterd.jar (
REM start cmd /c java -jar MegaBasterd.jar
REM goto 64
REM ) else (
REM :: si no exite se descarga
REM powershell -command iwr 'https://github.com/tonikelope/megabasterd/releases/download/v7.50/MegaBasterd_7.50.jar' -OutFile 'MegaBasterd.jar' 
REM cd %programas% 
REM start cmd /c java -jar MegaBasterd.jar
REM goto 64
REM )

:programas2
cd %programas%
:: si exite se pone la aplicacion
IF EXIST %programas%\speedtest.exe (
start cmd /c speedtest.exe
goto 64
) else (
:: si no exite se descarga
cd %rar% 
powershell -command iwr '%url_speedtest%' -OutFile 'speedtest-win64.zip'
goto speed
)
:speed
cd %rar%
%zip% x speedtest-win64.zip -o%programas% -y
cd C:\Juanelbuenocopiadelosarcivos\programas
start speedtest.exe
goto 64


:programas3
cd %programas%
IF EXIST %programas%\Autoruns64.exe (
start Autoruns64.exe 
goto 64
) else (
cd C:\Juanelbuenocopiadelosarcivos\programas\rar 
powershell.exe -command iwr '%url_autoruns%' -OutFile 'Autoruns.zip'
goto Autoruns1 
)
:Autoruns1
%zip% x %rar%\Autoruns.zip -o%programas% -y
cd C:\Juanelbuenocopiadelosarcivos\programas 
start Autoruns64.exe
goto 64

:programas4
cd %programas%
IF EXIST %programas%\TMX64.exe (
start TMX64.exe
goto 64
) else (
cd %rar%
powershell -command iwr '%url_tmx%' -OutFile 'TMX64.zip'
goto TMX64
)
:TMX64
%zip% x %rar%\TMX64.zip -o%programas% -y
cd %programas%
start TMX64.exe 
goto 64

:programas5
cd %programas%
:: si exite se pone la aplicacion
IF EXIST %programas%\Everything.exe (
start Everything.exe
goto 64 
) else (
:: si no exite se descarga
cd %rar%
powershell -command iwr '%url_everything%' -OutFile 'everything-1.4.1.969.x64.zip' 
goto Everythingin
)
:Everythingin
:: Extraer en winrar
%zip% x %rar%\everything-1.4.1.969.x64.zip -o%programas% -y
cd %programas%
start Everything.exe
goto 64

:programas6
cd %programas%
:: si exite se pone la aplicacion
IF EXIST %programas%\WizTree64.exe (
start WizTree64.exe 
goto 64
) else (
:: si no exite se descarga
cd %rar%
powershell -command iwr '%url_wiztree%' -OutFile 'wiztree_3_39_portable.zip'
goto wiztreeportable 
)
:: Extraer en winrar
:wiztreeportable
%zip% x %rar%\wiztree_3_39_portable.zip -o%programas% -y
cd %programas%
start WizTree64.exe
goto 64

:programas7
IF NOT EXIST "%programas%\uget" md "%programas%\uget"
IF EXIST %programas%\uget\bin\uget.exe (
start %programas%\uget\bin\uget.exe
goto 64
) else (
cd %rar%
powershell -command iwr '%url_uget%' -OutFile 'uget.7z'
goto uget
)
:: Extraer en winrar
:uget
%zip% x %rar%\uget.7z -o%programas%\uget -y
cd %programas%\uget\bin
start uget.exe
goto 64


:menu3
%fblanco%
	cls
	echo =================================================
	echo =                      MENU                     =
	echo =================================================
	echo = 1) Programas Examen de seguridad de Microsoft =
	REM echo = 2) Programas Optimizar el windows 100%        =
	echo = 2) Programas Spotify 100%                     =
	::echo = 4) Programas=
	::echo = 5) Programas=
	::echo = 6) Programas=
	::echo = 7) Programas=
	::echo = 8) Programas=
	echo = 3) Salir del menu volver a anterior           =
	echo =================================================
		set /p var=Seleccione una opcion [1-3]: 
		:: programas de equipo de wifi
		if "%var%"=="1" goto Executar1
		REM if "%var%"=="2" goto Executar2
		if "%var%"=="2" goto Executar3
		if "%var%"=="3" goto menu2

		REM Si llegó aquí, opción es inválida
		goto error3 
		
:: error de comandos para menu3
:error3
cls
echo %camarillo%==================================================
echo.
echo %camarillo%=        OPCION SELECCIONADA NO VALIDA!          =
echo.
echo %camarillo%==================================================
timeout /T 3 >nul
%fblanco%
goto menu3

:: error de comandos general
:error
cls
echo %camarillo%==================================================
echo.
echo %camarillo%*        OPCION SELECCIONADA NO VALIDA!          *
echo.
echo %camarillo%==================================================
timeout /T 3 >nul
goto menu

:Executar1
cd %programas%
:: si exite se pone la aplicacion
IF EXIST %programas%\MSERT.exe ( 
start MSERT.exe
goto menu3
)
:: si no exite se descarga
powershell -command iwr '%url_msert%' -OutFile 'MSERT.exe'
start MSERT.exe
goto menu3

REM :Executar2
REM ::
REM IF NOT EXIST "%programas%\master" md "%programas%\master"
REM ::
REM cd %programas%
REM :: si exite se pone la aplicacion
REM IF EXIST %programas%\master\win10script-master\win10debloat.ps1 (
REM powershell.exe -Command %programas%\master\win10script-master\win10debloat.ps1
REM goto menu3
REM ) else (
REM :: si no exite se descarga 
REM cd C:\Juanelbuenocopiadelosarcivos\programas\rar  
REM powershell -command iwr 'https://github.com/ChrisTitusTech/win10script/archive/refs/heads/master.zip' -OutFile 'master.zip' 
REM goto Programon
REM )

REM :: Extraer en winrar
REM :Programon
REM %zip% x %rar%\master.zip %programas%\master
REM cd %programas%\master\win10script-master
REM powershell.exe %programas%\master\win10debloat.ps1
REM pause
REM goto menu3

:Executar3
cls
echo %camarillo%==================================================
echo %crojo%[!] ADVERTENCIA DE SEGURIDAD
echo %camarillo%==================================================
echo %fblanco%
echo Este programa descargara y ejecutara scripts de internet.
echo Asegúrate de confiar en las fuentes antes de continuar.
echo.
echo %crojo%Riesgo: Ejecución de código remoto (RCE)%fblanco%
echo.
echo %camarillo%==================================================
echo.
pause
echo.
set /p Spotifyon=Deseas continuar? Quieres con Plugins o sin Plugin y/n=

if "%Spotifyon%"=="y" (
echo %camarillo%[*] Descargando e instalando con plugins...%fblanco%
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12}"; "& {(Invoke-WebRequest -UseBasicParsing '%url_spotify_con_plugins%').Content | Invoke-Expression}"
echo %cverde%[+] Listo Spotify Full Sin Anuncios%fblanco% & timeout /T 3 >nul
)

if "%Spotifyon%"=="n" (
echo %camarillo%[*] Descargando e instalando sin plugins...%fblanco%
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12}"; "& {(Invoke-WebRequest -UseBasicParsing '%url_spotify_sin_plugins%').Content | Invoke-Expression}"
echo %cverde%[+] Listo Spotify Full Sin Anuncios%fblanco% & timeout /T 3 >nul
goto menu3
)

goto menu3

:sinconexioni
set sinconexiona=No tienes internet
mode con: cols=52 lines=18 
cls
echo %camarillo%=================================================
echo.
echo = %crojo%No tienes internet vuelve intentalo mas tarde%camarillo% =
echo.
echo =================================================
timeout /T 5 >nul
goto titulot

:salir
::del %ruta% /f /s /q
echo [+] Salendo... & timeout /T 2 >nul
goto menu
