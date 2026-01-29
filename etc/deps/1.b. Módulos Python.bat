@ECHO OFF
COLOR 80
CHCP 65001 >nul
CLS
SETLOCAL EnableExtensions EnableDelayedExpansion

ECHO #####################################################
ECHO ##      Instalador de Dependências Python          ##
ECHO ##      Desenvolvido por: Bruno Costa - 2026       ##
ECHO #####################################################
ECHO.

SET PYTHON_DIR=C:\Program Files (x86)\Python311

REM =====================================================
REM Verifica Python
REM =====================================================
python --version >nul 2>&1

IF %ERRORLEVEL% NEQ 0 (
    COLOR 40
    ECHO Python não está instalado no sistema.
    ECHO.
    PAUSE
    EXIT /B 1
)

REM =====================================================
REM Verifica pip
REM =====================================================
python -m pip --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO Instalando pip...
    python -m ensurepip
)

ECHO.
ECHO Atualizando pip...
python -m pip install --upgrade pip

python -c "import pefile" >nul 2>&1

IF %ERRORLEVEL% EQU 0 (
    ECHO pefile já está instalado.
) ELSE (
    ECHO Instalando pefile...
    python -m pip install pefile
    python -c "import pefile; print('pefile instalado com sucesso')"
)

python -c "import unlicense" >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO unlicense já está instalado.
) ELSE (
    ECHO Instalando unlicense...
    python -m pip install git+https://github.com/ergrelet/unlicense.git
    python -c "import unlicense; print('unlicense instalado com sucesso')"
)

ECHO.
python --version
ECHO.
python -c "import pefile; print('> pefile OK')"
python -c "import unlicense; print('> unlicense OK')"

COLOR 20
CLS
ECHO #########################################
ECHO ## Dependências instaladas com sucesso ##
ECHO #########################################
ECHO.
PAUSE