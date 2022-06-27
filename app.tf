resource "yandex_compute_instance" "knives-gitlab" {
  name        = "knives-gitlab"
  description = "Gitlab instance knives project"

  resources {
    cores  = 4
    memory = 8
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.knives-subnet-a.id
    nat       = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd83nikl07rd12b7c94t"
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/yc.pub")}"
  }

}
