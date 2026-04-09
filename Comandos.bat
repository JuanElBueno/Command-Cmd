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
"%SystemRoot%\System32\curl.exe" -g -L -# -o "%ruta%\Updater.bat" "https://raw.githubusercontent.com/JuanElBueno/Command-Cmd/main/Update" >nul 2>&1
if %ERRORLEVEL% neq 0 (
	echo %crojo%[!] Error descargando actualizaciones%fblanco%
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
	echo %camarillo%     [Y] Yes, Update
	echo %camarillo%     [N] No
	echo %fblanco%
	"%SystemRoot%\System32\choice.exe" /c:YN /n /m "Selecciona una opcion >:"
	if %ERRORLEVEL% equ 1 (
		"%SystemRoot%\System32\curl.exe" -L -o "%USERPROFILE%\Desktop\Comandos.bat" "https://raw.githubusercontent.com/JuanElBueno/Command-Cmd/main/Comandos.bat" >nul 2>&1
		if %ERRORLEVEL% equ 0 (
			call "%USERPROFILE%\Desktop\Comandos.bat"
			exit /b
		) else (
			echo %crojo%[!] Error descargando la actualizacion%fblanco%
			timeout /T 5 >nul
			goto titulot
		)
	) else (
		goto titulot
	)
) else (
	goto titulot
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
timeout /T 5 >nul

REM Programas necesarios para iniciar

IF EXIST %zip% (
echo %cverde%[+]Progama Istalado Exitosa 7zip & timeout /T 5 >nul
goto admin
) else if "%wifi%"=="true" (
echo %crojo%[+]Programas Necesarios 7zip & timeout /T 5 >nul
goto desrar
) else (
echo %camarillo%[+]Estas sin conexion de internet & timeout /T 5 >nul
goto admin
)

:desrar
if exist %zip% (
goto admin
) else if "%wifi%"=="true" (
cd %programas%
powershell -command iwr 'https://www.7-zip.org/a/7z2408-x64.exe' -OutFile 'zip.exe'
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
echo %cverde%[+]Progama Istalado Exitosa PowerRun & timeout /T 5 >nul
goto wget1
) else if "%wifi%"=="true" (
echo %crojo%[+]Programas Necesarios PowerRun & timeout /T 5 >nul
goto admindes
) else (
echo %camarillo%[+]Estas sin conexion de internet & timeout /T 5 >nul
goto wget1
)

:admindes
:: si exite se pone en admin
IF EXIST %admin%\PowerRun_x64.exe ( 
goto wget1
) else (
:: si no exite se descarga
cd %admin%
powershell -command iwr 'https://github.com/JuanElBueno/Command-Cmd/raw/main/PowerRun_x64.exe' -OutFile 'PowerRun_x64.exe' 
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
echo %cverde%[+]Progama Istalado Exitosa Wget [administracion] & timeout /T 5 >nul 
goto menu
) else if "%wifi%"=="true" (
echo %crojo%[+]Programas Necesarios Wget [administracion] & timeout /T 5 >nul
goto wgetinstalar
) else (
echo %camarillo%[+]Estas sin conexion de internet & timeout /T 5 >nul
goto menu
)
 
if "%wgetvof%"=="n" (
IF EXIST %Ruta%\wget.exe ( 
echo %cverde%[+]Progama Istalado Exitosa Wget [No administracion] & timeout /T 5 >nul 
goto menu
) else if "%wifi%"=="true" (
echo %crojo%[+]Programas Necesarios Wget [No administracion] & timeout /T 5 >nul
goto wgetsinad
) else (
echo [+]Estas sin conexion de internet & timeout /T 5 >nul
goto menu
)

:wgetsinad
set rutaw=%ruta%\wget.exe

IF EXIST %Ruta%\wget.exe ( 
echo %cverde%[+]Progama Istalado Exitosa Wget [No administracion]
timeout /T 5 >nul
goto menu
) else if "%PROCESSOR_ARCHITECTURE%"=="x86" (
cd %ruta%
powershell -command iwr 'https://eternallybored.org/misc/wget/1.21.3/32/wget.exe' -OutFile 'wget.exe'
echo.
timeout /T 6 >nul
goto menu
) else (
cd %ruta%
powershell -command iwr 'https://eternallybored.org/misc/wget/1.21.3/64/wget.exe' -OutFile 'wget.exe' 
echo. 
timeout /T 6 >nul 
goto menu
)

:wgetinstalar
set rutaw=C:\Windows\System32\wget.exe

IF EXIST %Ruta%\WgetCmd.bat (
goto menu
) else (
cd %ruta% 
powershell -command iwr 'https://raw.githubusercontent.com/JuanElBueno/Command-Cmd/main/WgetCmd.bat' -OutFile 'WgetCmd.bat'
call WgetCmd.bat
mode con: cols=50 lines=18 
timeout /T 17 >nul
goto menu
)

REM 						Menu de inicio
:menu                                                    
echo %fblanco%
cls
echo ==================================================
echo =                       MENU                     =
echo ==================================================
echo * 1) Eliminar archivos malos                     *
echo * 2) IP                                          *
echo * 3) Programas que no responden                  *
echo * 4) Informacion del equipo                      *
echo * 5) Comandos para ejecutar rapidamente          *
echo * 6) Informacion del wifi                        *
echo * 7) Explorer no funciona nada                   *
echo * 8) Administracion                              *
echo * 9) Salir                                       *
if "%modo%"=="on" (
	echo * o) Menu avanzado                              *
	echo * r) Reiniciar                                  *
)
echo ==================================================
set /p var=Seleccione una opcion: 

REM Validar entrada
if "%var%"=="" goto menuError
if "%var%"=="1" goto deltemp
if "%var%"=="2" goto ip
if "%var%"=="3" goto noresponde
if "%var%"=="4" goto informaciondelequipo
if "%var%"=="5" goto admintareas
if "%var%"=="6" goto informaciondelwifi
if "%var%"=="7" goto norespondeexplore
if "%var%"=="8" goto Administradorcmd
if "%var%"=="9" (
	cls
	echo [+] Saliendo...
	timeout /T 2 >nul
	exit /b 0
)

REM Modo de ingenieria
if "%modo%"=="on" (
	if "%var%"=="o" goto menu2
	if "%var%"=="r" goto general
)

REM Opcion no valida
goto menuError

REM Error de comandos
:menuError
cls
echo %camarillo%==================================================
echo.
echo %camarillo%=        OPCION SELECCIONADA NO VALIDA!          =
echo %camarillo%=        Por favor selecciona una opcion valida   =
echo.
echo %camarillo%==================================================
timeout /T 5 >nul
%fblanco%
goto menu

:informaciondelequipo
cls
cd %ruta%
systeminfo > "Informacion Del Equipo.txt"
goto menu

:informaciondelwifi
cls
mode con: cols=70 lines=20
echo ===============================================
echo           INFORMACION DEL WIFI
echo ===============================================
echo.
echo [*] Redes WiFi disponibles:
echo ===============================================
netsh wlan show profile
echo.
echo ===============================================
set /p nombredewifi=Nombre de la red WiFi: 

if "%nombredewifi%"=="" (
	echo %crojo%[!] Error: Debe ingresa un nombre de WiFi%fblanco%
	timeout /T 3 >nul
	goto informaciondelwifi
)

echo.
echo [*] Detalles de: %nombredewifi%
echo ===============================================
netsh wlan show profile name="%nombredewifi%" key=clear >nul 2>&1
if %ERRORLEVEL% neq 0 (
	echo %crojo%[!] Error: La red WiFi "%nombredewifi%" no existe o no se pudo acceder%fblanco%
	timeout /T 5 >nul
	goto informaciondelwifi
)
netsh wlan show profile name="%nombredewifi%" key=clear
echo.
pause
mode con: cols=52 lines=18
goto menu

:: Achivos borrados tempoales
:deltemp
cls
mode con: cols=65 lines=18
echo %camarillo%=================================================
echo.
echo  ADVERTENCIA: Se eliminaran archivos temporales
echo.
echo %crojo%=================================================
echo %fblanco%
echo [*] Esta accion no puede deshacerse
echo.
set /p confirmar=Deseas continuar (s/n): 

if /i NOT "%confirmar%"=="s" (
	echo [+] Operacion cancelada
	timeout /T 2 >nul
	goto menu
)

cls
echo [*] Eliminando archivos temporales...
echo [*] Por favor espera...
echo.

REM Eliminar archivos de temp del usuario
echo [+] Limpiando carpeta Temp del usuario...
cd /d "%temp%" >nul 2>&1
if %ERRORLEVEL% neq 0 (
	echo %crojo%[!] Error: No se pudo acceder a la carpeta Temp%fblanco%
	timeout /T 3 >nul
	goto menu
)

REM Usar PowerShell para forzar eliminacion
powershell -Command "Get-ChildItem -Path $env:TEMP -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue" >nul 2>&1

REM Eliminar carpeta AppData\Local\Temp si no esta en uso
echo [+] Limpiando carpeta AppData...
powershell -Command "Get-ChildItem -Path $env:APPDATA\..\..\Local\Temp -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue" >nul 2>&1

if %ERRORLEVEL% equ 0 (
	echo %cverde%[+] Archivos temporales eliminados exitosamente%fblanco%
) else (
	echo %camarillo%[!] Algunos archivos no pudieron eliminarse (posiblemente esten en uso)%fblanco%
)

echo.
echo [+] Operacion completada
timeout /T 5 >nul
mode con: cols=52 lines=18
cls
goto menu

::powershell -command iwr 'https://www.sordum.org/files/download/power-run/PowerRun.zip' -OutFile 'PowerRun.zip'

:Administradorcmd
cls
echo.
echo %camarillo%=================================================
echo  Ejecutando en modo Administrador
echo %camarillo%=================================================
echo %fblanco%

REM Validar que PowerRun existe
if not exist "%admin%\PowerRun_x64.exe" (
	echo %crojo%[!] Error: PowerRun_x64.exe no encontrado%fblanco%
	echo [*] Ubicacion esperada: %admin%\PowerRun_x64.exe
	timeout /T 5 >nul
	goto menu
)

echo [*] Iniciando aplicacion en modo administrador...
timeout /T 2 >nul

REM Ejecutar con privilegios elevados
"%admin%\PowerRun_x64.exe" "%UserProfile%\Desktop\Comandos.bat" >nul 2>&1
if %ERRORLEVEL% neq 0 (
	echo %crojo%[!] Error al ejecutar en modo administrador%fblanco%
	timeout /T 3 >nul
	goto menu
)

echo %cverde%[+] Saliendo...%fblanco%
timeout /T 2 >nul
exit /b 0 

REM Verificar conectividad - Ping continuo
:ip
cls
mode con: cols=70 lines=18
echo %camarillo%=================================================
echo  Verificando conectividad (Presiona Ctrl+C para salir)
echo %camarillo%=================================================
echo %fblanco%
title %Titulo% - Ping en progreso (Ctrl+C para salir)
ping google.es -t
cls
mode con: cols=50 lines=18
title %Titulo%
goto menu

REM Detener programas que no responden
:noresponde
cls
echo [*] Finalizando programas que no responden...
taskkill.exe /f /fi "status eq Not Responding" >nul 2>&1
if %ERRORLEVEL% equ 0 (
	echo %cverde%[+] Procesos finalizados exitosamente%fblanco%
) else (
	echo %camarillo%[!] No se encontraron procesos sin respuesta%fblanco%
)
echo.
echo [*] Esperando 10 segundos...
timeout /T 10 >nul
goto menu

REM Reiniciar Explorer.exe
:norespondeexplore
cls
echo [*] Reiniciando Explorer.exe...
echo.
TASKKILL /F /IM explorer.exe >nul 2>&1
if %ERRORLEVEL% equ 0 (
	echo %cverde%[+] Explorer.exe finalizado%fblanco%
) else (
	echo %camarillo%[!] Explorer.exe no estaba en ejecucion%fblanco%
)
echo [*] Esperando 10 segundos...
timeout /T 10 >nul
echo [*] Iniciando Explorer.exe...
start explorer.exe >nul 2>&1
if %ERRORLEVEL% equ 0 (
	echo %cverde%[+] Explorer.exe reiniciado%fblanco%
) else (
	echo %crojo%[!] Error al reiniciar Explorer.exe%fblanco%
)
timeout /T 3 >nul
goto menu


:admintareas
cls
echo ================================================= 
echo =                      MENU                     =
echo =================================================
echo = 1) Administrador de tareas                    =
echo = 2) Calculadora                                =
echo = 3) Teclado en pantalla                        =
echo = 4) Panel de control                           =
echo = 5) Actualizar el windows                      =
echo = 6) Explorer                                   =
echo = 7) Recorte de pantalla                        =
echo = 8) Descargar_Archivos_powershell              =
echo = 9) Descargar_Archivos                         =
echo = 10) Administracion de equipos                 =
echo = s) Salir al menu anterior                     =
echo =================================================
set /p var=Seleccione una opcion [1-10,s]: 

if "%var%"=="" goto adminError
if "%var%"=="1" call "taskmgr" & goto admintareas
if "%var%"=="2" call "calc" & goto admintareas
if "%var%"=="3" call "osk" & goto admintareas
if "%var%"=="4" call "control" & goto admintareas
if "%var%"=="5" start ms-settings:windowsupdate & goto admintareas
if "%var%"=="6" call "explorer" & goto admintareas
if "%var%"=="7" call "SnippingTool" & goto admintareas
if "%var%"=="8" goto descagar_archivos
if "%var%"=="9" goto descagar_archivos_lazamiento
if "%var%"=="10" call compmgmt & goto admintareas
if "%var%"=="s" goto menu
goto adminError

:adminError
cls
echo %camarillo%==================================================
echo.
echo %camarillo%=        OPCION SELECCIONADA NO VALIDA!          =
echo %camarillo%=        Selecciona un numero del 1 al 10         =
echo.
echo %camarillo%==================================================
timeout /T 5 >nul
%fblanco%
goto admintareas

REM :descagar_archivos
REM cd C:\Juanelbuenocopiadelosarcivos\programas
REM :: si exite se pone la aplicacion
REM IF EXIST C:\Juanelbuenocopiadelosarcivos\programas\wget.exe goto descagar_lazamiento 
REM :: si no exite se descarga
REM IF NOT EXIST C:\Juanelbuenocopiadelosarcivos\programas\wget.exe wget https://eternallybored.org/misc/wget/1.20.3/64/wget.exe & goto descagar_lazamiento

:descargar_archivos
echo.
echo [*] Descargar archivo con wget
echo ===============================================
set /p descargar=Ingresa la URL del archivo: 

if "%descargar%"=="" (
	echo %crojo%[!] Error: Debes ingresar una URL%fblanco%
	timeout /T 3 >nul
	goto admintareas
)

echo [*] Descargando archivo...
cd %programas%
%rutaw% "%descargar%" --no-check-certificate >nul 2>&1
if %ERRORLEVEL% equ 0 (
	echo %cverde%[+] Archivo descargado exitosamente%fblanco%
	timeout /T 3 >nul
) else (
	echo %crojo%[!] Error en la descarga%fblanco%
	timeout /T 3 >nul
)
title %Titulo%
cls
goto admintareas

:descargar_archivos_lanzamiento
echo.
echo [*] Descargar archivo con PowerShell
echo ===============================================
cd %programas%
set /p descagar1=Ingresa la URL del archivo: 

if "%descagar1%"=="" (
	echo %crojo%[!] Error: Debes ingresar una URL%fblanco%
	timeout /T 3 >nul
	goto admintareas
)

set /p nombre2=Nombre del archivo para guardar: 

if "%nombre2%"=="" (
	echo %crojo%[!] Error: Debes ingresar un nombre%fblanco%
	timeout /T 3 >nul
	goto admintareas
)

echo [*] Descargando archivo...
powershell -Command "try { Invoke-WebRequest -Uri '%descagar1%' -OutFile '%nombre2%' -ErrorAction Stop; exit 0 } catch { exit 1 }" >nul 2>&1

if %ERRORLEVEL% equ 0 (
	echo %cverde%[+] Archivo descargado exitosamente%fblanco%
	echo [*] Abriendo carpeta...
	explorer %programas% >nul 2>&1
	timeout /T 3 >nul
) else (
	echo %crojo%[!] Error en la descarga%fblanco%
	timeout /T 3 >nul
)
cls
goto admintareas	

REM :Combertidor_de_yt
REM cls
	REM echo ================================================= 
	REM echo =                     Menu                      =
	REM echo =================================================
	REM echo = 1)  Descargar yt                              =
	REM echo = 2)  Convertir a mp3 (Fase de pruebas)         =
	REM echo = 3)  Salir al menu                             =
	REM echo ================================================= 
		REM set /p var=Seleccione una opcion [1-3]: 
		REM if "%var%"=="1" goto Descargaryt
		REM if "%var%"=="2" goto mp3_combertidor
		REM if "%var%"=="3" goto menu
		
REM :error
REM cls
REM echo %camarillo%==================================================
REM echo.
REM echo %camarillo%*        OPCION SELECCIONADA NO VALIDA!          *
REM echo.
REM echo %camarillo%==================================================
REM timeout /T 5 >nul
REM goto Combertidor_de_yt

REM :Descargaryt
REM IF EXIST %programas%\youtube-dl.exe (
REM goto descagar_yt_programa
REM ) else (
REM cd %programas%
REM powershell -command iwr 'https://youtube-dl.org/downloads/latest/youtube-dl.exe' -OutFile 'youtube-dl.exe'
REM title %Titulo% 
REM goto descagar_yt_programa
REM )

REM :descagar_yt_programa
REM cd %programas%
REM set /p enlace=Enlace del yt y de todo:
REM @echo on
REM youtube-dl.exe %enlace%
REM @echo off
REM pause
REM goto Combertidor_de_yt

REM :mp3_combertidor
REM cd %programas%
REM IF EXIST %programas%\ffmpeg.exe (
REM goto mp3_combertidor_haciendo
REM ) else (
REM %rutaw% https://github.com/JuanElBueno/Command-Cmd/releases/download/publish/ffmpeg.exe
REM title %Titulo% 
REM goto mp3_combertidor_haciendo
REM )
REM :mp3_combertidor_haciendo
REM cd %programas%
REM set /p ORIGEN=Origen del achivo:
REM set /p DESTINO=Destino del achivo:
REM @echo on
REM ffmpeg.exe -i %ORIGEN% %DESTINO%
REM @echo off
REM pause
REM goto Combertidor_de_yt


:: menu2 de programas de descagar
:menu2
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
  echo Programa no compatible de 32 bits & timeout /T 10 >nul & goto menu
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
echo = 6) Programas Administrador de archivo         =
echo = 7) Programas Buscador achivos                 =
echo = 8) Programas Descargar_Achivos                =
echo = 9) Salir del menu volver a anterior           =
echo = o) Continuacion del programa                  =
echo =================================================
set /p var=Seleccione una opcion: 

if "%var%"=="" goto programas64Error
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
goto programas64Error

:programas64Error
cls
echo %camarillo%==================================================
echo.
echo %camarillo%=        OPCION SELECCIONADA NO VALIDA!          =
echo %camarillo%=        Selecciona un numero del 1 al 8           =
echo.
echo %camarillo%==================================================
timeout /T 5 >nul
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
powershell -command iwr 'https://download.sysinternals.com/files/ProcessExplorer.zip' -OutFile 'ProcessExplorer.zip' 
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
powershell -command iwr 'https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip' -OutFile 'speedtest-win64.zip'
goto speed
)
:speed
cd %rar%
%zip% x speedtest-win64.zip -o%programas% -y
cd C:\Juanelbuenocopiadelosarcivos\programas
start speedtest.exe
goto 64


:programas3
cd %porgramas%
IF EXIST %programas%\Autoruns64.exe (
start Autoruns64.exe 
goto 64
) else (
cd C:\Juanelbuenocopiadelosarcivos\programas\rar 
powershell.exe -command iwr 'https://download.sysinternals.com/files/Autoruns.zip' -OutFile 'Autoruns.zip'
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
powershell -command iwr 'https://mitec.cz/Downloads/TMX.zip' -OutFile 'TMX64.zip'
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
powershell -command iwr 'https://www.voidtools.com/Everything-1.4.1.969.x64.zip' -OutFile 'everything-1.4.1.969.x64.zip' 
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
powershell -command iwr 'https://diskanalyzer.com/files/wiztree_4_08_portable.zip' -OutFile 'wiztree_3_39_portable.zip'
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
powershell -command iwr 'https://github.com/JuanElBueno/getu/raw/main/getu.7z' -OutFile 'uget.7z'
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
echo = 2) Programas Spotify 100%                     =
echo = 3) Salir del menu volver a anterior           =
echo =================================================
set /p var=Seleccione una opcion [1-3]: 

if "%var%"=="" goto menu3Error
if "%var%"=="1" goto Executar1
if "%var%"=="2" goto Executar3
if "%var%"=="3" goto menu2
goto menu3Error

:menu3Error
cls
echo %camarillo%==================================================
echo.
echo %camarillo%=        OPCION SELECCIONADA NO VALIDA!          =
echo %camarillo%=        Selecciona un numero del 1 al 3           =
echo.
echo %camarillo%==================================================
timeout /T 5 >nul
%fblanco%
goto menu3

:Executar1
cd %programas%
:: si exite se pone la aplicacion
IF EXIST %programas%\MSERT.exe ( 
start MSERT.exe
goto menu3
)
:: si no exite se descarga
powershell -command iwr 'https://definitionupdates.microsoft.com/download/DefinitionUpdates/VersionedSignatures/AM/1.381.1451.0/amd64/MSERT.exe' -OutFile 'MSERT.exe'
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
set /p Spotifyon=Quieres con Plugins o sin Plugin y/n=

if "%Spotifyon%"=="y" ( 
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12}"; "& {(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.ps1').Content | Invoke-Expression}"
echo %cverde%[+] Listo Spotify Full Sin Anuncios%fblanco% & timeout /T 3 >nul
)
 
if "%Spotifyon%"=="n" ( 
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12}"; "& {(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/SpotX-Official/SpotX/main/run.ps1').Content | Invoke-Expression}"
echo %cverde%[+] Listo Spotify Full Sin Anuncios%fblanco% & timeout /T 3 >nul
goto menu 3
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
