#!/usr/bin/env bash

deb_bin_version() {
    local os="$1"
    local pkg="$2"
    local arch="${3:-amd64}"

    case "$os" in
        13) os="trixie" ;;
        12) os="bookworm" ;;
        11) os="bullseye" ;;
    esac

    local base="https://deb.debian.org/debian/dists/${os}/main/binary-${arch}/Packages"

    (
        curl -fsSL "${base}.xz" 2>/dev/null | xz -dc 2>/dev/null ||
        curl -fsSL "${base}.gz" 2>/dev/null | gzip -dc 2>/dev/null ||
        curl -fsSL "${base}" 2>/dev/null
    ) | awk -v pkg="$pkg" '
        $1 == "Package:" && $2 == pkg {
            found=1
        }

        found && $1 == "Version:" {
            print $2
            exit
        }

        /^$/ {
            found=0
        }
    '
}

deb_bin_version "$@"

