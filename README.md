# Ansible

My personal Ansible recipes

## Quick install

```sh
wget -q -O - https://raw.githubusercontent.com/PedroRossi/ansible/main/bin/update-fresh-install.sh | sh
wget -q -O - https://raw.githubusercontent.com/PedroRossi/ansible/main/bin/auto-install.sh | sh
```

## HOW TO USE

Run `make` for help and usage

## Profiles

- `make ansible/popos` — Pop!_OS desktop
- `make ansible/m1` — macOS (Apple Silicon)
- `make ansible/debian` — Debian k3s/ArgoCD server
- `make ansible/nas` — headless Debian NAS (Docker, Portainer CE, smartd, daily volume backups)
