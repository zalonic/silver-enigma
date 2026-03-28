#!/usr/bin/env bash
set -euo pipefail

# Configuration: Use environment variables if set, otherwise use defaults
NAME="Silver-Enigma"
VERSION="${CLEAN_VERSION:-error}"
ID="silver-enigma"
ID_LIKE="centos fedora"
VERSION_ID="10"
PLATFORM_ID="platform:el10"
PRETTY_NAME="${NAME} (${VERSION})"
ANSI_COLOR="0;31"
LOGO="fedora-logo-icon"
CPE_NAME="cpe:/o:zalonic:silver-enigma:${VERSION}"
HOME_URL="https://github.com/zalonic/silver-enigma"
VENDOR_NAME="Zalonic"
VENDOR_URL="https://github.com/zalonic/silver-enigma"
BUG_REPORT_URL="https://github.com/zalonic/silver-enigma/issues/new"

echo "Configuring os-release branding..."

sed -i -f - /usr/lib/os-release <<EOF
s#^NAME=.*#NAME="${NAME}"#
s#^VERSION=.*#VERSION="${VERSION}"#
s#^ID=.*#ID="${ID}"#
s#^ID_LIKE=.*#ID_LIKE="${ID_LIKE}"#
s#^VERSION_ID=.*#VERSION_ID="${VERSION_ID}"#
s#^PLATFORM_ID=.*#PLATFORM_ID="${PLATFORM_ID}"#
s#^PRETTY_NAME=.*#PRETTY_NAME="${PRETTY_NAME}"#
s#^ANSI_COLOR=.*#ANSI_COLOR="${ANSI_COLOR}"#
s#^LOGO=.*#LOGO="${LOGO}"#
s#^CPE_NAME=.*#CPE_NAME="${CPE_NAME}"#
s#^HOME_URL=.*#HOME_URL="${HOME_URL}"#
s#^VENDOR_NAME=.*#VENDOR_NAME="${VENDOR_NAME}"#
s#^VENDOR_URL=.*#VENDOR_URL="${VENDOR_URL}"#
s#^BUG_REPORT_URL=.*#BUG_REPORT_URL="${BUG_REPORT_URL}"#
/^REDHAT_BUGZILLA_PRODUCT=/d
/^REDHAT_BUGZILLA_PRODUCT_VERSION=/d
/^REDHAT_SUPPORT_PRODUCT=/d
/^REDHAT_SUPPORT_PRODUCT_VERSION=/d
s#^BUILD_ID=.*#BUILD_ID="${BUILD_VERSION})"#
s#^BOOTLOADER_NAME=.*#BOOTLOADER_NAME="${NAME} (${BUILD_VERSION})"#
s#^IMAGE_ID=.*#IMAGE_ID="${ID}-${BUILD_VERSION}"#
s#^DEFAULT_HOSTNAME=.*#DEFAULT_HOSTNAME="${NAME}"#
EOF

# Ensure fields exist if they weren't already in the file (fallback append)
for field in BUILD_ID BOOTLOADER_NAME IMAGE_ID DEFAULT_HOSTNAME; do
    if ! grep -q "^$field=" /usr/lib/os-release; then
        case $field in
            BUILD_ID) echo "BUILD_ID=\"${BUILD_VERSION})\"" >> /usr/lib/os-release ;;
            BOOTLOADER_NAME) echo "BOOTLOADER_NAME=\"${NAME} (${BUILD_VERSION})\"" >> /usr/lib/os-release ;;
            IMAGE_ID) echo "IMAGE_ID=\"${ID}-${BUILD_VERSION}\"" >> /usr/lib/os-release ;;
            DEFAULT_HOSTNAME) echo "DEFAULT_HOSTNAME=\"${NAME}\"" >> /usr/lib/os-release ;;
        esac
    fi
done

echo "$NAME ${BUILD_VERSION^})" > /etc/system-release

echo "os-release updated to version."
