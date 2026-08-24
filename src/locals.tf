locals {
  vm_names = {
    web = "${var.project_name}-${var.vpc_name}-platform-web"
    db  = "${var.project_name}-${var.vpc_name}-platform-db"
  }

  vms_resources = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      disc_size     = 10
      disc_type     = "network-hdd"
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      disc_size     = 10
      disc_type     = "network-ssd"
    }
  }

  vms_metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:Ваш-ssh-ключ"
  }
}
