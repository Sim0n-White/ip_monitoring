# README

[![Hanami](https://img.shields.io/badge/Hanami-2.2.1-brightgreen)](https://hanamirb.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.2.6-red)](https://www.ruby-lang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-%3E%3D%2015-blue)](https://www.postgresql.org/)

## Описание

Тестовое [задание.pdf](https://github.com/user-attachments/files/18563058/default.pdf)

## Начало работы

Эти инструкции помогут вам запустить копию проекта на вашем локальном компьютере.

### Установка и запуск

1. Клонируйте репозиторий
2. Выполните `make setup` в папке проекта. Запустится сборка, настройка БД и запуск проекта через docker compose
3. Создайте пользователя для БД:
4. Для запуска тестов выполните `docker-compose run app bundle exec rspec`
5. (Optional) в Makefile добавлены еще некоторые возможности для работы с контейнерами (просмотр логов и т.д.).

### Что было сделано

1. Полностью выполнены базовые условия задания
2. Не использовался activesupport и Active Record
3. Запуск проекта с помощью docker compose
4. Добавлена поддержка IPv6 IP-адресов
