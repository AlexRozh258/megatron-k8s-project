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

variable "nodes" {
  type = map(object({
    vmid    = number
    cores   = number
    memory  = number
    ip      = string
    vm_name = string # Ось сюди пишемо красиву назву для Proxmox
  }))
  default = {
    "k8s-master" = {
      vmid    = 221
      cores   = 2
      memory  = 2048
      ip      = "192.168.5.221"
      vm_name = "Study2-k8s-master"
    }
    "k8s-worker-1" = {
      vmid    = 222
      cores   = 2
      memory  = 2048
      ip      = "192.168.5.222"
      vm_name = "Study2-k8s-worker-1"
    }
    "k8s-worker-2" = {
      vmid    = 223
      cores   = 2
      memory  = 2048
      ip      = "192.168.5.223"
      vm_name = "Study2-k8s-worker-2"
    }
  }
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
