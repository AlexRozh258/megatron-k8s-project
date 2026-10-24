resource "proxmox_vm_qemu" "ubuntu_vm" {
  for_each    = var.nodes

  name        = each.key
  vmid        = each.value.vmid
  target_node = var.target_node
  clone       = var.template_name

  # Базові ресурси
  agent   = 1
  os_type = "cloud-init"
  memory  = each.value.memory
  scsihw  = "virtio-scsi-pci"

  cpu {
    cores   = each.value.cores
    sockets = 1
    type    = "host"
  }

  # Основний диск ОС (початковий розмір 20G)
  disk {
    slot    = "scsi0"
    size    = "20G"
    type    = "disk"
    storage = var.storage_pool
    format  = "qcow2"
  }

  # Диск Cloud-Init
  disk {
    slot    = "ide2"
    type    = "cloudinit"
    storage = var.storage_pool
  }

  # Мережевий адаптер
  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Мережеві налаштування та обліковий запис
  ipconfig0  = "ip=${each.value.ip}/24,gw=192.168.5.1"
  nameserver = "8.8.8.8 1.1.1.1"

  ciuser     = "student"
  cipassword = "student"
}
