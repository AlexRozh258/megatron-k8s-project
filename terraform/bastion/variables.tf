variable "proxmox_api_url" {
  description = "URL до API Proxmox"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "ID токена Proxmox"
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "Секретний ключ токена Proxmox"
  type        = string
  sensitive   = true
}

variable "target_node" {
  type    = string
  default = "pve"
}

variable "template_name" {
  type    = string
  default = "ubuntu-24.04"
}

variable "storage_pool" {
  type    = string
  default = "local-2TB"
}

variable "bastion_config" {
  description = "Параметри керуючого хоста"
  type = object({
    vmid   = number
    cores  = number
    memory = number
    ip     = string
  })
  default = {
    vmid   = 220
    cores  = 1
    memory = 1024
    ip     = "192.168.5.220"
  }
}