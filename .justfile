#!/usr/bin/env -S just --justfile

set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

mod ansible "ansible"
mod kube "kubernetes"

export KUBECONFIG := "$(pwd)/kubeconfig"

[private]
default:
    just -l
