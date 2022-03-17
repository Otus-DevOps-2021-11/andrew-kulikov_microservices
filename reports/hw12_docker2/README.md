## Homework 12

### Доп задание 1. Сравнение docker inspect для image и container

Вывод для контейнера и образа отличаются по следующим параметрам:
1. image содержит иформацию о слоях, размере образа, когфигурацию образа и контейнеров
2. container содержит HostConfig, в котором содержится большое количество инофрмации о запущенной ос/ядре. Также HostConfig содержит настройки сети - NetworkSettings
3. container информацию о состоянии в State

### Доп задание 2. Автоматизация инфраструктуры

Все образы и инстансы делаем на основе ubuntu-18.04, так как docker уже не поддерживает 16.04.
1. Инстансы создаем с помощью terraform аналогично прошлым заданиям (без модулей, все в одном файле) - [main.tf](infra/terraform/main.tf)
```terraform
provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app-${var.environment}"

  labels = {
    tags = "reddit-app"
    env  = var.environment
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

}
```
2. Конфигурацию ansible разбиваем по 3 плейбукам:
    * [install_docker.yml](infra/ansible/playbooks/install_docker.yml) - установка docker, использует тег install
    * [deploy.yml](infra/ansible/playbooks/deploy.yml) - развертывание приложения, использует тег deploy
    * [app.yml](infra/ansible/playbooks/app.yml) - совмещает 2 предыдущих плейбука
3. Создаем конфигурацию для docker environment, создаем там [inventory](infra/ansible/environments/docker/inventory)
4. В шаблоне пакера указываем плейбук для установки docker
```json
"provisioners": [
    {
      "type": "ansible",
      "user": "ubuntu",
      "extra_arguments": ["--tags", "install"],
      "playbook_file": "ansible/playbooks/install_docker.yml"
    }
  ]
```
