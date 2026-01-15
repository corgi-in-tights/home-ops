set positional-arguments := true
set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

ansible_dir := justfile_dir() + '/ansible'
kubernetes_dir := justfile_dir() + '/kubernetes'

[private]
default:
    just -l ansible

[private]
playbook name:
    @if [ ! -f {{ansible_dir}}/inventory.yaml ]; then \
        echo "Error: Inventory not found at {{ansible_dir}}/inventory.yaml."; \
        exit 1; \
    fi
    ansible-playbook {{ansible_dir}}/playbooks/{{name}}.yaml -i {{ansible_dir}}/inventory.yaml

# Bootstrap required resoources, namespaces, CRDs and sync apps
bootstrap-apps:
    @just ansible playbook bootstrap

# Install K3s cluster-wide and get kubeconfig
install-cluster:
    @just ansible playbook site

# Reboot the K3s cluster nodes
reboot-cluster:
    @just ansible playbook reboot

# Delete and reset the K3s cluster
reset-cluster:
    @echo "This will DELETE your K3s cluster and configurations."
    @printf "Are you sure? [y/N] " && read ans && [ ${ans:-N} = y ]
    @just ansible playbook reset

# Upgrade the K3s cluster
upgrade-cluster:
    @just ansible playbook upgrade
