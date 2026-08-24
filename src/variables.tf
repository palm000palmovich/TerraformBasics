variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_yandex_compute_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "project_name" {
  type        = string
  default     = "netology"
  description = "Префикс имени проекта, используется при генерации имён ресурсов"
}

variable "test" {
  type = list(map(list(string)))
  description = "Список мап с парой 'Наименование стенда' -> кортеж с ssh-командой и приватным IP"
}