## Task 1: Infrastructure & Security Validation (LUKS + Terraform/Ansible)

- **LUKS Encryption — FAIL:**
  - `lsblk -f` / `blkid` show `/dev/sda2` (`ext4`, `/boot`) and `/dev/sda3` (`LVM2_member` -> `ubuntu--vg-ubuntu--lv` -> `ext4`, `/`). No `crypto_LUKS` layer found.
  - `/etc/crypttab` has no active mappings; `dm_crypt` module is not loaded.
- **Terraform / Ansible Deployment — PARTIAL / OBSERVED:**
  - `/dev/sr0` (`cidata` ISO) indicates cloud-init provisioning; `containerd` and `kubelet` are active on the node. Requires verification against `terraform/` and `ansible/` manifests for drift/compliance.

---

## Task 2: Monitoring & Alerting (End-to-End) — BLOCKED / IN PROGRESS

- **Metrics collection:** `prometheus-server` (`2/2 Running`) and `node_exporter` (`:9100`) are present, while `kube-state-metrics` and `prometheus-kube-state-metrics` are in `CrashLoopBackOff` (~1200 restarts) and `prometheus-prometheus-node-exporter-n4lbs` is `Pending`.
- **Alerting E2E:** `prometheus-alertmanager-0` is `0/2 Pending` because `storage-prometheus-alertmanager-0` PVC is unbound (no `StorageClass` in cluster).
- **Grafana:** Pod `grafana` is `Running` (with high restart count), E2E checks pending full stack stability.

---

## Task 3: Logging & K8s Logging Agents (5 SP) — BLOCKED / IN PROGRESS

- **StorageClass / PVC issue:** `kubectl get storageclass` returned no resources; `storage-loki-0` is `Pending`, keeping `loki-0` (`0/2`) in `Pending`.
- **Resource sizing issue on single-node VM:** Node `ubuntu-k8s-node-151` has high memory/request pressure (`loki-chunks-cache-0` requests `9830Mi` memory -> `Insufficient cpu, Insufficient memory`; `falco` requests `512Mi` / limit `1Gi` -> `Insufficient memory`).
- **DNS & Control-Plane instability:** CoreDNS pods are `0/1 Running` (readiness probe `503`), causing `loki-gateway` (`CrashLoopBackOff`) to fail resolving `kube-dns.kube-system.svc.cluster.local.` and delaying `fluent-bit` (`0/1 Running`, 1117 restarts). `promtail` (`0/1 Running`) logged `i/o timeout` to `10.96.0.1:443` during discovery windows.
- **Control-plane lease timeouts:** `kube-controller-manager` and `kube-scheduler` experienced `Leaderelection lost` (`context deadline exceeded` / `5s` timeout to `6443`) under node load/restarts.
- **Agent scope to clarify:** `promtail`, `fluent-bit`, and `falco` are all present; consolidate/align roles (log shipping to Loki vs. Falco runtime security events) and tune resources/storage.

---

## Task 4: Backups in PBS — PENDING / VERIFY ACCESS

- In Proxmox VE (`Snapshots` tab for VM `151`), taking new VM snapshots is unsupported by the current guest configuration (`The current guest configuration does not support taking new snapshots`).
- Need to verify PBS backup jobs/retention/verification status directly in PBS or via PVE storage/task history.
