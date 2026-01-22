#!/usr/bin/env -S just --justfile

set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

mod kube "kubernetes"
mod ans "ansible"

export KUBECONFIG := "$(pwd)/kubeconfig"

ansible_dir := '$(pwd)/ansible'
kubernetes_dir := '$(pwd)/kubernetes'

[private]
default:
    just -l
