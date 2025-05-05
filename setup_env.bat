chcp 65001
@echo off
REM ��������, ���������� �� Python
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python �� ������. ���������� Python � �������� ��� � PATH.
    pause
    exit /b 1
)

REM �������� ������������ ���������
echo ������ ����������� ���������...
python -m venv venv

REM ��������� ������������ ���������
call venv\Scripts\activate

REM ��������� ������������ �� requirements.txt
if exist requirements.txt (
    echo ������������� ����������� �� requirements.txt...
    pip install -r requirements.txt
) else (
    echo ���� requirements.txt �� ������.
)

echo ��������� ���������. ����������� ��������� ������.
pause
