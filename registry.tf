resource "yandex_container_registry" "knives-registry" {
  name = "knives-registry"
    folder_id = var.yc_folder
    
}