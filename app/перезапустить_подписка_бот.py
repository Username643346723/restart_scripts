import paramiko
import time
from config import settings


path_script = '/root/Python/moderator_bot_podpicka_1.0.0/'
process_name = 'moderator_chat_bot.py'
python3 = "venv/bin/python3"

server = settings.server_2

host = str(server.host.network_address)
username = server.username
password = server.password


# Функция для выполнения команды на удалённом сервере
def execute_ssh_command(ssh, command):
    stdin, stdout, stderr = ssh.exec_command(command)
    output = stdout.read().decode('utf-8')
    error = stderr.read().decode('utf-8')
    return output, error


# Подключение по SSH
def restart_python_process():
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(hostname=host, username=username, password=password)

        def kill_precess():
            # Поиск процесса по его имени
            find_process_cmd = f'ps aux | grep {process_name} | grep -v grep'
            _output, _error = execute_ssh_command(ssh, find_process_cmd)

            if _output:
                pid = _output.split()[1]
                print(f'Найден процесс с PID: {pid}, останавливаю его...')
                kill_cmd = f'kill -9 {pid}'
                _output, _error = execute_ssh_command(ssh, kill_cmd)
                if _error:
                    print(f'Ошибка при остановке процесса: {_error}')
                else:
                    print(f'Процесс с PID {pid} остановлен.')

                kill_precess()

            return _output, _error

        output, error = kill_precess()

        # Небольшая задержка, чтобы убедиться, что процесс завершён
        time.sleep(2)

        print('Перезапуск процесса')
        # Используем nohup и перенаправляем выводы в файл, чтобы избежать блокировок
        restart_cmd = (
            f'cd {path_script} && nohup {python3} {process_name} > /dev/null 2>&1 & disown'
        )
        ssh.exec_command(restart_cmd)  # Отправляем команду
        ssh.close()  # Закрываем SSH-сессию
        print('SSH-сессия закрыта, процесс запущен в фоне.')

        # Проверка на ошибки
        if error:
            print(f'Ошибка при перезапуске процесса: {error}')
        else:
            print('Процесс успешно перезапущен.')

        ssh.close()

    except Exception as e:
        print(f'Ошибка: {e}')


if __name__ == '__main__':
    restart_python_process()
