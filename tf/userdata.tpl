#cloud-config
groups:
  - docker
users:
  - name: ${user}
    groups: users, admin
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    groups: docker
    ssh_authorized_keys:
      - ${ssh-pub}
package_update: true
package_upgrade: true
packages:
  - haveged
  - zsh
  - unzip
  - curl
  - apt-transport-https
  - ca-certificates
  - curl
  - gnupg-agent
  - software-properties-common
  - git