@echo off

REM Aktiviruem virtualnoe okruzhenie
call venv\Scripts\activate

REM Perekhodim v papku s Python-skriptami
cd app

echo Vyberite skript dlya zapuska:
echo [1] restart_goroskop.py
echo [2] restart_kopir_postov_s_tg_v_vk.py
echo [3] restart_kopir_postov_s_tg_gruppy_ejdailyru.py
echo [4] restart_podpiska_bot.py
set /p choice=Vvedite nomer skripta (1-4):

REM Opredelyaem, kakoy skript zapustit
if "%choice%"=="1" (
    python restart_goroskop.py
) else if "%choice%"=="2" (
    python restart_kopir_postov_s_tg_v_vk.py
) else if "%choice%"=="3" (
    python restart_kopir_postov_s_tg_gruppy_ejdailyru.py
) else if "%choice%"=="4" (
    python restart_podpiska_bot.py
) else (
    echo Nevernyy vybor! Vyhod.
    exit /b 1
)

REM Vozvrashchaemsya v iskhodnuyu direktoriyu
cd ..

echo Skript vypolnen.
pause
