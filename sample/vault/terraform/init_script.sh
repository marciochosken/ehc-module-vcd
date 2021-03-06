#!/bin/bash
if [ "$1" != "postcustomization" ]; then exit 0; fi
apt update && apt upgrade -y
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
zerotier-cli join ${ztnetwork}
export VAULT_SKIP_VERIFY=true
export VAULT_INIT_ARGS='-root-token-pgp-key=keybase:marciohosken'
wget https://raw.githubusercontent.com/marciochosken/ehc-module-vcd/main/sample/vault/scripts/vault-install.sh
bash -x ./vault-install.sh