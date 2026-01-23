#!/usr/bin/env -S just --justfile

set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

mod kube "kubernetes"
mod ans "ansible"

export KUBECONFIG := justfile_dir() + "/kubeconfig"

ansible_dir := justfile_dir() + '/ansible'
kubernetes_dir := justfile_dir() + '/kubernetes'

[private]
default:
    just -l
