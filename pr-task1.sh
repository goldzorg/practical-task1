#!/bin/bash
#Проверяем наличие репозитория backports в списке репозиториев, если нет - то добавляем в список
if cat /etc/apt/sources.list | grep http | grep -v "#" | grep backports
then
echo "репозиторий backports для релиза $(lsb_release -cs) уже есть в списке репозиториев"
else
add-apt-repository -u "deb http://ru.archive.ubuntu.com/ubuntu $(lsb_release -cs)-backports main restricted universe multiverse"
echo "репозиторий backports для релиза $(lsb_release -cs) добавлен в список репозиториев"
fi

# Создаем пользователя
adduser skilluser

# Добавим созданного пользователя в группу администраторов
usermod -aG sudo skilluser

# Обновляем списки пакетов и обновляем пакеты до последних версий
apt update -y
apt upgrade -y

# Устанавливаем веб сервер Apache2. После установки сервер запускается автоматически
apt install -y apache2

# Устанавливаем python 3.11
add-apt-repository -y ppa:deadsnakes/ppa
apt install -y python3.11

# Устанавливаем и запускаем OpenSSH 
apt install -y openssh-server
systemctl enable --now ssh

# Разрешаем доступ по SSH и HTTP
ufw allow Apache
ufw allow OpenSSH

# Активируем брандмауэр и проверяем статус разрешения подключений.
ufw enable
ufw status

# выводим текущую дату и текущий часовой пояс
date
timedatectl
