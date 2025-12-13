Вот Markdown‑версия:

```markdown
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

## Основные эндпоинты

- `GET /turismo` – главная страница с турами, офферами, тегами и направлениями.

## Сборка Docker‑образа

В корне решения (где лежит `Dockerfile`):

```
docker build -t httpserver .
```

## Запуск с подключением к БД на хосте

Пример запуска, если PostgreSQL запущен на хост‑машине:

```
docker run --rm -p 1234:1234 --name httpserver \
  -e APP_ENV=Docker \
  -e CONNECTION_STRING="Host=host.docker.internal;Port=5432;Database=oris;Username=user_owner;Password=123456;Pooling=true" \
  httpserver
```

После запуска приложение будет доступно по адресу:

```
http://localhost:1234/
```
```
