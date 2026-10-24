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
  description = "Параметри трьох вузлів: Control Plane та 2 Workers"
  type = map(object({
    vmid   = number
    cores  = number
    memory = number
    ip     = string
  }))
  default = {
    "k8s-master" = {
      vmid   = 201
      cores  = 2
      memory = 2048
      ip     = "192.168.5.201"
    }
    "k8s-worker-1" = {
      vmid   = 202
      cores  = 2
      memory = 2048
      ip     = "192.168.5.202"
    }
    "k8s-worker-2" = {
      vmid   = 203
      cores  = 2
      memory = 2048
      ip     = "192.168.5.203"
    }
  }
}
