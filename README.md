# README

[![Hanami](https://img.shields.io/badge/Hanami-2.2.1-brightgreen)](https://hanamirb.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.2.6-red)](https://www.ruby-lang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-%3E%3D%2015-blue)](https://www.postgresql.org/)

## Описание

Тестовое [задание.pdf](https://github.com/user-attachments/files/18563058/default.pdf)

### Установка и запуск

1. Клонируйте репозиторий
2. Для подключения возможности пинговать IPv6 IP-адреса мне понадобилось `sudo ip6tables -t nat -A POSTROUTING -s fd00::/64 ! -o docker0 -j MASQUERADE`
3. Выполните `make setup` в папке проекта. Запустится сборка, настройка БД и запуск проекта через docker compose
4. Создайте пользователя для БД:
5. Для запуска тестов выполните `docker-compose run app bundle exec rspec`
6. (Optional) в Makefile добавлены еще некоторые возможности для работы с контейнерами (просмотр логов и т.д.).

### Что было сделано

1. Полностью выполнены базовые условия задания
2. Не использовался activesupport и Active Record
3. Запуск проекта с помощью docker compose
4. Добавлена поддержка IPv6 IP-адресов
