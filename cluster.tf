resource "yandex_kubernetes_cluster" "knives-k8s-cluster" {

  name        = "knives-k8s-cluster"
  description = "Cluster k8s knives project"

  network_id = yandex_vpc_network.knives-network.id

  master {
    version = "1.20"

    zonal {
      zone      = yandex_vpc_subnet.knives-subnet-a.zone
      subnet_id = yandex_vpc_subnet.knives-subnet-a.id
    }

    public_ip = true
  }

  labels = {
    app = "knives"
  }

  service_account_id      = yandex_iam_service_account.k8s-account.id
  node_service_account_id = yandex_iam_service_account.k8s-node-account.id

  kms_provider {
    key_id = yandex_kms_symmetric_key.k8s-key.id
  }

#   depends_on = [
#     yandex_resourcemanager_folder_iam_binding.editor,
#     yandex_resourcemanager_folder_iam_binding.images-puller
#   ]

}


resource "yandex_kubernetes_node_group" "knives-nodes" {
  cluster_id = yandex_kubernetes_cluster.knives-k8s-cluster.id

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat = true
      subnet_ids = ["${yandex_vpc_subnet.knives-subnet-c.id}"]
    }

    resources {
      memory = 8
      cores = 4
    }

  }

  scale_policy {
    auto_scale {
      min     = 4
      max     = 8
      initial = 4
    }
  }
}