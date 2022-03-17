## Homework 12

### Задание 1. Изменение названия проекта

По умолчанию docker-compose использует в качестве названия проекта имя папки, в которой находится. Изменить можно с помощью переменной среды COMPOSE_PROJECT_NAME. Ее также можно задать в файле .env

### Доп задание. Переопределение настроек docker-compose

1. Чтобы иметь возможность изменять код приложения без ребилда контейнера, нам необходимо замапить локальную папку с кодом сервиса на директорию /app, из которой запускаются все сервисы. На примере сервиса ui это выглядит таким образом:
```yml
version: '3.3'
services:
  ui:
    volumes:
      - ./ui:/app
```

2. Изменить entrypoint можно с помощью command в docker-compose. Пример для ui сервиса:
```yml
version: '3.3'
services:
  ui:
    volumes:
      - ./ui:/app
    command: puma --debug -w 2
```

Полный override конфиг:
```yml
version: '3.3'
services:
  ui:
    volumes:
      - ./ui:/app
    command: puma --debug -w 2
  post:
    volumes:
      - ./post-py:/app
  comment:
    volumes:
      - ./comment:/app
    command: puma --debug -w 2

```
