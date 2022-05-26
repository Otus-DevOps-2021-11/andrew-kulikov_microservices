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
