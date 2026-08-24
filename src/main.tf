# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }

data "yandex_vpc_network" "develop" {
  name = "default"
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "netology-develop-nat-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "nat_route_table" {
  name       = "netology-develop-nat-route-table"
  network_id = data.yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id          = yandex_vpc_gateway.nat_gateway.id
  }
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.vm_web_default_zone
  network_id     = data.yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_web_default_cidr
  route_table_id = yandex_vpc_route_table.nat_route_table.id
}

resource "yandex_vpc_subnet" "develop_db" {
  name           = "${var.vpc_name}-b"
  zone           = var.vm_db_default_zone
  network_id     = data.yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_default_cidr
  route_table_id = yandex_vpc_route_table.nat_route_table.id
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_yandex_compute_image_family
}

#1st VM
resource "yandex_compute_instance" "platform_web" {
  name        = local.vm_names.web
  platform_id = var.vm_web_yandex_compute_instance_platform_id
  resources {
    cores         = local.vms_resources.web.cores
    memory        = local.vms_resources.web.memory
    core_fraction = local.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = local.vms_resources.web.disc_size
      type     = local.vms_resources.web.disc_type
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = false
  }

  metadata = local.vms_metadata
}

#2nd VM
resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_names.db
  platform_id = var.vm_db_yandex_compute_instance_platform_id
  zone        = var.vm_db_default_zone
  resources {
    cores         = local.vms_resources.db.cores
    memory        = local.vms_resources.db.memory
    core_fraction = local.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = local.vms_resources.db.disc_size
      type     = local.vms_resources.db.disc_type
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = false
  }

  metadata = local.vms_metadata
}
