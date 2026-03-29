#!/bin/bash

set -xeuo pipefail

dnf -y install \
	-x gnome-extensions-app \
	NetworkManager-openconnect-gnome \
	NetworkManager-openvpn-gnome \
    wireguard-tools
