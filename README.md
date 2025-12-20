
# HttpServer

Учебный HTTP‑сервер на C# (.NET).
## Запуск проекта локально

### 1. Клонирование репозитория
```
git clone https://github.com/g1mberg/oris_semestry
```

### 2. Восстановление зависимостей
```
dotnet restore
```
### 3. Сборка проекта
```
dotnet build
```
### 4. Запуск сервера
```
dotnet run
```
### 5. Запуск БД
sql скрипт для восстановления базы данных находится по пути `oris_semestry\HttpServer\db\init.sql`, нужно зайти в dbeaver и нажать инструменты -> восстановление и указать на место 
После запуска сервер будет доступен по адресу:
```
http://localhost:1234/Turismo
```
---

## Конфигурация

Файл настроек находится по пути:

Settings/settings.json

Важно: папка Settings должна находиться рядом с исполняемым файлом.

```
{
  "StaticDirectoryPath": "static",
  "Domain": "http://localhost",
  "Port": "1234",
  "ConnectionString": "Host=localhost;Port=5432;Database=oris;Username=user_owner;Password=123456;Pooling=true"
}
```

Для Docker используется `settings.docker.json`. Какой файл читать, решается по переменной окружения `APP_ENV`:

- если `APP_ENV=Docker` и файл `settings.docker.json` существует — используется он;
- иначе берётся обычный `settings.json`.

Строка подключения может быть переопределена переменной окружения `CONNECTION_STRING`.


## Главная страница

- `http://domain:port/turismo` 

## Сборка Docker‑образа

В корне решения (где лежит `Dockerfile`):

```
docker-compose down -v
docker-compose up --build
```
и все должно заработать


