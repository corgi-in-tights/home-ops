set positional-arguments := true
set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

ansible_dir := justfile_dir() + '/ansible'
kubernetes_dir := justfile_dir() + '/kubernetes'

export KUBERNETES_DIR := kubernetes_dir
export ANSIBLE_CONFIG := justfile_dir() + '/ansible.cfg'


[private]
default:
    just -l ans

playbook name:
    ansible-playbook {{ansible_dir}}/playbooks/{{name}}.yaml -i {{ansible_dir}}/inventory/

# Install K3s, bootstrap required resoources, namespaces, CRDs and sync apps
bootstrap:
    @just ans playbook bootstrap
