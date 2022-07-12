## Homework 19


### Задание 1. Развертывание кластера в yandex cloud

Скриншоты развернутого кластера:

Сервисы кластера из dev namespace:
<img src="reports/hw19_kubernetes2/services.png">

Instances:
<img src="reports/hw19_kubernetes2/instances.png">

Интерфейс приложения на NodePort
<img src="reports/hw19_kubernetes2/reddit.png">

### Доп задание 1. Развертывание кластера с помощью terraform

Конфигурация terraform [terraform_cluster](kubernetes/terraform_cluster):

```terraform
provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_kubernetes_cluster" "reddit_cluster" {
  name        = "reddit"
  description = "Kubernetes cluser for reddit app"

  network_id = var.network_id

  master {
    version = "1.21"

    zonal {
      zone      = var.zone
      subnet_id = var.subnet_id
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = true
    }
  }

  service_account_id      = var.service_account_id
  node_service_account_id = var.service_account_id

  release_channel = "RAPID"
  network_policy_provider = "CALICO"
}

resource "yandex_kubernetes_node_group" "reddit_node_group" {
  cluster_id  = yandex_kubernetes_cluster.reddit_cluster.id
  name        = "reddit"
  description = "Node group for reddit cluster"
  version     = "1.21"

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [ var.subnet_id ]
    }

    resources {
      memory = 8
      cores  = 4
    }

    boot_disk {
      type = "network-ssd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "docker"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
  }
}
```
