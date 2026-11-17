resource "proxmox_vm_qemu" "setup_vm" {
  name        = "Study2-k8s-setup"
  vmid        = var.bastion_config.vmid
  target_node = var.target_node
  clone       = var.template_name

  agent   = 1
  os_type = "cloud-init"
  memory  = var.bastion_config.memory
  scsihw  = "virtio-scsi-pci"

  cpu {
    cores   = var.bastion_config.cores
    sockets = 1
    type    = "host"
  }

  disk {
    slot    = "scsi0"
    size    = "20G"
    type    = "disk"
    storage = var.storage_pool
    format  = "qcow2"
  }

  disk {
    slot    = "ide2"
    type    = "cloudinit"
    storage = var.storage_pool
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0  = "ip=${var.bastion_config.ip}/24,gw=192.168.5.1"
  nameserver = "8.8.8.8 1.1.1.1"

  ciuser     = "student"
  cipassword = "student"
}