locals {
  vm_names = {
    web = "${var.project_name}-${var.vpc_name}-platform-web"
    db  = "${var.project_name}-${var.vpc_name}-platform-db"
  }
}
