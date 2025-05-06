@echo off

REM Proverka, ustanovlen li Python
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python ne naiden. Ustanovite Python i dobav'te ego v PATH.
    pause
    exit /b 1
)

REM Sozdaem virtualnoe okruzhenie
echo Sozdanie virtualnogo okruzheniya...
python -m venv venv

REM Aktiviruem virtualnoe okruzhenie
call venv\Scripts\activate

REM Ustanavlivaem zavisimosti iz requirements.txt
if exist requirements.txt (
    echo Ustanovka zavisimostey iz requirements.txt...
    pip install -r requirements.txt
) else (
    echo File requirements.txt ne naiden.
)

echo Ustanovka zavershena. Zakryvayte okno.
pause