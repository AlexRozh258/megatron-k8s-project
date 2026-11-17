resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "ubuntu-k8s-node-151"
  node_name = "pve"
  pool_id   = "team-2"
  vm_id     = 151

  clone {
    vm_id = 100
    full  = true
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.5.151/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      username = "ubuntu"
      keys     = [trimspace(file("~/.ssh/id_ed25519.pub"))]
    }
  }
}

output "vm_ipv4_addresses" {
  value = proxmox_virtual_environment_vm.ubuntu_vm.ipv4_addresses
}
