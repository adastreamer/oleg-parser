# ПАРСЕР ДЛЯ ОЛЕГА

Для работы нужен `ruby` версии `2.3.7`

# НАСТРОЙКА

```
gem install bundler
bundle
```

# ЗАПУСК

Предварительно выставить переменные окружения:

1. `PARSER_BASE` - базовый эндпоинт, например, *https://0.0.0.0*
1. `PARSER_VIEW_JSP_PAGE` - путь до jsp, начиная с */*
1. `PARSER_USERNAME` - имя пользователя
1. `PARSER_PASSWORD` - пароль

```

ruby parse.rb
```
