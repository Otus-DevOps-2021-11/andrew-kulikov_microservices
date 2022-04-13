## Homework 15


### Доп задание 1. Деплой GitLab с помощью ansible

Конфигурация была разбита на роли, результаты можно увидеть в [roles](../../infra/ansible/roles) и [playbooks](../../infra/ansible/playbooks)



### Доп задание 2. Деплой reddit

Для экономии в учебных целях имеем 2 сервера:
1. gitlab ci
2. runner, registry, app

Схема деплоя выглядит следующим образом:
1. Собираем образ приложения и пушим его в приватный registry
2. На стадии деплоя подключаемся по ssh к серверу приложения, стягиваем нужный образ и запускаем контейнер с приложением

Выполняем следующие шаги:

1. Запускаем gitlab, получаем пароль root юзера с помощью
```bash
sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```
2. На сервере приложения поднимаем runner
```bash
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh > script.deb.sh
sudo bash script.deb.sh
sudo apt install gitlab-runner
systemctl status gitlab-runner
```
3. На сервере приложения добавляем юзера
```bash
sudo adduser deployer
sudo usermod -aG docker deployer
su deployer
```
4. Создаем ssh ключ и добавляем его в переменную ID_RSA
```bash
ssh-keygen -b 4096
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/id_rsa
```
5. Поднимаем registry
```bash
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```
6. Добавляем конфигурацию для доступа к registry по http (/etc/docker/daemon.json):
```json
{
  "insecure-registries" : ["51.250.97.2:5000"]
}
```
7. Регистрируем runner (важно, чтобы запускался privileged):
```bash
sudo gitlab-runner register \
--url http://51.250.100.20/ \
--non-interactive \
--locked=false \
--name DockerRunner \
--executor docker \
--docker-privileged \
--docker-image docker:19-dind \
--registration-token GR1348941aD3Q3MtZuejz6kxjwREu \
--tag-list "linux,xenial,ubuntu,docker" \
--run-untagged
```
8. В конфигурации репозитория добавляем CI variables:
```
ID_RSA [File] - приватный ключ deployer
SERVER_ADDRESS [Variable] - адрес сервера приложения (51.250.100.20)
SERVER_USER [Variable] - юзер для подключения по ssh deployer
DAEMON_CONFIG [File] - конфигурация докер демона для подключения к unsecure registry
CI_REGISTRY [Variable] - адрес registry (51.250.100.20:5000)
CI_REGISTRY_IMAGE [Variable] - имя образа в registry (51.250.100.20:5000/homework/example)
```
9. Запускаем пайплайн, после успешного деплоя переходим по ссылке в environment


### Доп задание 3. Ansible роли для runner

Конфигурация была разбита на роли, результаты можно увидеть в [roles](../../infra/ansible/roles) и [playbooks](../../infra/ansible/playbooks)
