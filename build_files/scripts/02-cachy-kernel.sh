#!/usr/bin/env bash

set -xeuo pipefail

# Install the CachyOS Kernel from boredzg/cachyos-kernel-el10
setsebool -P domain_kernel_load_modules on

# 1. Install DNF plugins to manage COPR repositories
dnf -y install 'dnf-command(copr)' && dnf -y clean all

# 2. Enable the CachyOS kernel repository 
dnf -y copr enable bieszczaders/kernel-cachyos 

# 3. Install the CachyOS kernel and its dependencies
dnf -y install kernel-cachyos kernel-cachyos-devel kernel-cachyos-core

# 4. Remove the standard CentOS kernel
dnf -y remove kernel kernel-core kernel-modules

# 5. Clean up to reduce image size
dnf clean all
