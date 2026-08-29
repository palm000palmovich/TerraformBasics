# 1st VM
variable "vm_web_default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_web_default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_web_yandex_compute_instance_platform_id" {
  type    = string
  default = "standard-v2"
}

#2nd VM
variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_yandex_compute_instance_platform_id" {
  type    = string
  default = "standard-v3"
}

#resources:
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    disc_size     = number
    disc_type     = string
  }))
  description = "Параметры ресурсов ВМ (cores/memory/core_fraction/disc) по ключу web/db"
  default = {
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
}

variable vms_metadata {
  type = map(string)
  description = "Метадата для ВМ"
}