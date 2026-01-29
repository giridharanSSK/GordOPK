@ECHO OFF
COLOR 80
CHCP 65001 >nul
CLS
SETLOCAL EnableExtensions EnableDelayedExpansion

ECHO #####################################################
ECHO ##        Instalador Python 3.11 x86               ##
ECHO ##        Desenvolvido por: Bruno Costa - 2026     ##
ECHO #####################################################
ECHO.

SET PYTHON_VERSION=3.11.9
SET PYTHON_EXE=python-3.11.9.exe
SET PYTHON_URL=https://www.python.org/ftp/python/3.11.9/python-3.11.9.exe
SET PYTHON_DIR=C:\Program Files (x86)\Python311

REM =====================================================
REM Verifica se Python já está instalado
REM =====================================================
python --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    COLOR 20
    ECHO Python já está instalado no sistema.
    python --version
    ECHO.
    PAUSE
    EXIT /B 0
)

IF EXIST "%PYTHON_DIR%\python.exe" (
    ECHO Python encontrado em "%PYTHON_DIR%"
    SET PATH=%PATH%;%PYTHON_DIR%;%PYTHON_DIR%\Scripts\
    PAUSE
    EXIT /B 0
)

REM =====================================================
REM Download do instalador
REM =====================================================
ECHO Baixando Python %PYTHON_VERSION% (32 bits)...
ECHO.

powershell -Command ^
 "Try { Invoke-WebRequest -Uri '%PYTHON_URL%' -OutFile '%PYTHON_EXE%' -UseBasicParsing } Catch { Exit 1 }"

IF NOT EXIST "%PYTHON_EXE%" (
    COLOR 40
    ECHO [ERRO] Falha ao baixar o Python.
    PAUSE
    EXIT /B 1
)

REM =====================================================
REM Instalação silenciosa
REM =====================================================
ECHO Instalando Python %PYTHON_VERSION%...
ECHO.

"%PYTHON_EXE%" /quiet ^
 InstallAllUsers=1 ^
 PrependPath=1 ^
 Include_test=0

IF %ERRORLEVEL% NEQ 0 (
    COLOR 40
    ECHO [ERRO] Falha na instalação do Python.
    PAUSE
    EXIT /B 1
)

REM =====================================================
REM Atualiza PATH da sessão atual
REM =====================================================
SET PATH=%PATH%;%PYTHON_DIR%;%PYTHON_DIR%\Scripts\

ECHO.
python --version

COLOR 20
CLS
ECHO ##############################################
ECHO ## Python 3.11 (x86) instalado com sucesso! ##
ECHO ##############################################
ECHO.
PAUSE
