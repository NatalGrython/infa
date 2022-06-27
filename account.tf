resource "yandex_iam_service_account" "k8s-account" {
  name        = "k8s-account"
  description = "Cluster service account"
}

resource "yandex_iam_service_account" "k8s-node-account" {
  name        = "k8s-node-account"
  description = "Cluster node service account"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.yc_folder
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-account.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  folder_id = var.yc_folder
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-node-account.id}"
  ]
}