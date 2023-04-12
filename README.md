# :mortar_board: Курс [GeekBrains](https://go.redav.online/50829a86237ba651?erid=LdtCKEePH) по PostgreSQL

![nodejs](https://img.shields.io/badge/postgresql-v15-brightgreen)

## :hammer_and_wrench: Установка

### :whale: Запуск приложения в среде [Docker](https://docs.docker.com/engine/install/):
```shell
git clone https://github.com/primetz/gb-postgresql.git && \
cd gb-postgresql && \
make up
```

:closed_lock_with_key: Подключение к БД:
```textmate
Host: localhost
Port: 5432
User: gb_user
Password: secret
Database: test
```

## :pencil: Практические задания

> ### :one: Возможности объектно-реляционной СУБД PostgreSQL, установка рабочего окружения
>> :pencil2: 1. Установить PostgreSQL на виртуальную машину с Linux, настроить подключение консольным клиентом psql.
>>
>> :checkered_flag: Скриншот подключения к виртуальной машине с установленным PostgreSQL по ssh:
>> ![Console psql](./lesson_1/psql.png)
> 
>> :pencil2: 2. Установить программу pgAdmin на основную систему и настроить подключение к PostgreSQL на виртуальной машине через туннель SSH.
>>
>> :checkered_flag: Скриншот подключения к виртуальной машине с установленным PostgreSQL из PgAdmin:
>> ![Console psql](./lesson_1/pgAdmin.png)
