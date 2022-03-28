## Homework 15

### Задание 1.


### Доп задание. Деплой контейнера

1. Запускаем гитлаб
2. Запускаем сервер приложения (с установленным docker)
3. Запускаем runner
```
```
4. На сервере приложения добавляем юзера
5. Создаем ssh ключ и добавляем его в переменные
6. Добавляем переменные с логином юзера и адресом сервера для деплоя
7. Поднимаем registry
8. Прописываем на всех серверах insecure registry config и перезапускаем докер демон. Также добавляем в FILE - переменную DAEMON_CONFIG
```json
{
  "insecure-registries" : ["51.250.105.23:5000", "10.129.0.29:5000"]
}
```
9. Регистрируем runner (важно, чтобы запускался privileged)
```bash
sudo gitlab-runner register \
--url http://51.250.101.126/ \
--non-interactive \
--locked=false \
--name DockerRunner \
--executor docker \
--docker-privileged \
--docker-image docker:19-dind \
--registration-token GR13489419-iNSU2_sxGZBqsPiZvW \
--tag-list "linux,xenial,ubuntu,docker" \
--run-untagged
```
10. Прописываем CI_REGISTRY_IMAGE и CI_REGISTRY c адресом registry
11.
