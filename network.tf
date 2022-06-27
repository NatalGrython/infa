resource "yandex_vpc_network" "knives-network" {
  name        = "knives-network"
  description = "Network knives project"
}

resource "yandex_vpc_subnet" "knives-subnet-a" {
  name           = "knives-subnet-a"
  description    = "Subnet Central A sector knives project"
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.knives-network.id
}

resource "yandex_vpc_subnet" "knives-subnet-b" {
  name           = "knives-subnet-b"
  description    = "Subnet Central B sector knives project"
  v4_cidr_blocks = ["10.3.0.0/16"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.knives-network.id
}

resource "yandex_vpc_subnet" "knives-subnet-c" {
  name           = "knives-subnet-c"
  description    = "Subnet Central C sector knives project"
  v4_cidr_blocks = ["10.4.0.0/16"]
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.knives-network.id
}