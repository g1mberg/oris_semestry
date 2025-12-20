
# HttpServer

Учебный HTTP‑сервер на C# (.NET).

## Настройки

Основные настройки берутся из JSON‑файла `settings.json`:

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


