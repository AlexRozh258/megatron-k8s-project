# Декларативна конфігурація вузла Proxmox Backup Server (PBS) для пулу team-2.
# Примітка: створення окремої VM та підключення зовнішнього PBS до Datacenter Storage
# вимкнено (count = 0) через обмеження прав облікового запису l.poremska@pve у стенді
# (відсутні привілеї Sys.Modify на /storage та VM.Backup).
# Резервне копіювання конфігурації кластера реалізовано на рівні вузла (/home/ubuntu/k8s-backups/).

resource "proxmox_virtual_environment_vm" "pbs_server" {
  count     = 0
  name      = "pbs-team-2"
  node_name = "pve"
  pool_id   = "team-2"
  vm_id     = 152

  clone {
    vm_id = 100
    full  = true
  }

  cpu {
    cores = 1
  }

  memory {
    dedicated = 1024
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.5.152/24"
        gateway = "192.168.5.1"
      }
    }
    user_account {
      username = "ubuntu"
      keys     = [trimspace(file("~/.ssh/id_ed25519.pub"))]
    }
  }
}
