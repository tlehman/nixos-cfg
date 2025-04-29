#!/bin/sh

for host in $(awk '{print $1}' < hosts.txt); do
  scp "$host:/etc/nixos/configuration.nix" "$host-configuration.nix"
  scp "$host:/etc/nixos/hardware-configuration.nix" "$host-hardware-configuration.nix"
done
