## Homework 18


### Доп задание 1. Развертывание кластера kubernetes с помощью terraform и ansible

Детали можно увидеть в папках kubernetes/terraform и kubernetes/ansible.

Создаем кластер из одной мастер-ноды и одной воркер-ноды. terraform манифест:
```terraform
provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "kuber-master" {
  name = "kuber-master-${var.environment}"

  labels = {
    tags = "kubernetes"
    env  = var.environment
  }

  resources {
     cores  = 4
    memory = 4
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

resource "yandex_compute_instance" "kuber-node" {
  name = "kuber-node-1"

  labels = {
    tags = "kubernetes"
  }

  resources {
    cores  = 4
    memory = 4
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

Конфигурация ansible для начала была офомлена в виде плейбуков (без ролей, по-хорошему можно было переиспользовать роль для установки docker). Конфигурация кластера состоит из следующих шагов:
1. Устанавливаем docker на все ноды
2. Создаем юзера `kube` на всех нодах. Под ним будет устанавливаться и работать kubernetes
3. Устанавливаем на всех нодах kubeadm
4. Инициализируем кластер на master ноде. Команду для добавления воркер-нод сохраняем в локальный файл
5. Подключаем все воркер ноды к кластеру
