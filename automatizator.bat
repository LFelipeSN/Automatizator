@echo off
color 9
title Automatizator
mode 110,30
chcp 65001 

REM --------------------configurações:--------------------

REM diretorio do arquivo
set "pasta_fonte=C:\Users\local_do_arquivo\automatizador"

REM diretorio de executaveis:
set "diretorio=executaveis_padroes"

REM nome do arquivo de configurações da máquina:
set "informacoes_file=informacoes\%USERNAME%-%COMPUTERNAME%.txt"

REM -------------------------------------------------------

cd %pasta_fonte%
if errorlevel 1 (
    echo  [ERRO]: Pasta fonte não encontrada!, verifique o caminho do arquivo
    pause
    exit /b 1
)


:main
cls
echo.
echo         "=============================================================================================="
echo 	"   ___   _   _  _____  _____ ___  ___  ___   _____  _____  ______  ___   _____  _____ ______  "
echo         "  / _ \ | | | ||_   _||  _  ||  \/  | / _ \ |_   _||_   _||___  / / _ \ |_   _||  _  || ___ \ "
echo         " / /_\ \| | | |  | |  | | | || .  . |/ /_\ \  | |    | |     / / / /_\ \  | |  | | | || |_/ / "
echo         " |  _  || | | |  | |  | | | || |\/| ||  _  |  | |    | |    / /  |  _  |  | |  | | | ||    /  "
echo         " | | | || |_| |  | |  \ \_/ /| |  | || | | |  | |   _| |_ ./ /___| | | |  | |  \ \_/ /| |\ \  "
echo         " \_| |_/ \___/   \_/   \___/ \_|  |_/\_| |_/  \_/   \___/ \_____/\_| |_/  \_/   \___/ \_| \_| "
echo         -------------------------------------------------------------------------------------------------
REM modelo texto: doom
echo                                     "    ->Automação de Dowloads<-    "
echo                                             created by LUIZF
echo.

echo   1 - Instalar executáveis(.exe)
echo   2 - Listar configurações da máquina e salvar
echo   3 - Mostrar programas na máquina
echo   4 - Estilizar


choice /c 1234 /n /m "   Opcao:"
set opcao=%errorlevel%

if %opcao%==1 goto automatizaExecutaveis
if %opcao%==2 goto informacoesMaquina
if %opcao%==3 goto listagemProgramas
if %opcao%==4 goto estilizar
echo.


REM <---------------------------------------->
:automatizaExecutaveis
REM instala todos os programas na pasta informada

echo A instalação vai começar:
echo %diretorio%
pause

cd %diretorio%
if errorlevel 1 (
    echo  [ERRO]: Pasta 'executáveis não encontrada, certifique-se de incluir ela no caminho raiz
    pause
    exit /b 1
)


echo teste
pause

for %%i in (*.exe) do (
	echo "instalando" %%i".."
	pause
	start %%i
	timeout /t 5 /nobreak

)
echo.

pause
goto main


REM <---------------------------------------->
:informacoesMaquina
REM pega as informações de hardware da maquina e coloca em um formato escolhido

del %informacoes_file%

echo Data: %DATE%-%TIME:~0,5% >> %informacoes_file%

echo ___Serial Number:___ >> %informacoes_file%
wmic baseboard get serialnumber >> %informacoes_file%
echo.

echo ___Memorias:___ >> %informacoes_file%
wmic memorychip get speed, capacity >> %informacoes_file%
echo.

echo ___Dominio:___ >> %informacoes_file%
wmic computersystem get domain >> %informacoes_file%
echo.

echo ___Processador:___ >> %informacoes_file%
wmic cpu get name >> %informacoes_file%
echo.

echo ___Armazenamento:___ >> %informacoes_file%
wmic diskdrive get caption, size >> %informacoes_file%
echo.

echo ___Sistema Operacional:___ >> %informacoes_file%
wmic os get caption /format >> %informacoes_file%

if not errorlevel 1 (
	echo   Informações coletadas e enviadas para o caminho: %informacoes_file%
	start %informacoes_file%
)
echo.

pause
goto main


REM <---------------------------------------->
:listagemProgramas
REM mostra todos os programas atualmente instalados

wmic product get name

echo.

pause
goto main

REM <---------------------------------------->
:estilizar
REM me ajude com o feedback

echo Estilize o cmd
set /p bg_color=Digite um catacter alfanumérico(de 0-9 ou a-f) para o fundo
set /p fonte_color=Digite um catacter alfanumérico(de 0-9 ou a-f) para a fonte

color %bg_color%%fonte_color%
echo.

pause
goto main