chcp 65001
@echo off
REM Проверка, установлен ли Python
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python не найден. Установите Python и добавьте его в PATH.
    pause
    exit /b 1
)

REM Создание виртуального окружения
echo Создаём виртуальное окружение...
python -m venv venv

REM Активация виртуального окружения
call venv\Scripts\activate

REM Установка зависимостей из requirements.txt
if exist requirements.txt (
    echo Устанавливаем зависимости из requirements.txt...
    pip install -r requirements.txt
) else (
    echo Файл requirements.txt не найден.
)

echo Установка завершена. Виртуальное окружение готово.
pause
