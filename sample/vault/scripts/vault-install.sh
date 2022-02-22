#!/bin/bash 

CURL="curl -fsSL"
VAULT_REPO="https://apt.releases.hashicorp.com"

update_system()
{
    apt update
    apt upgrade -y
}

install_vault()
{
    $CURL $VAULT_REPO/gpg | apt-key add -
    apt-add-repository "deb [arch=amd64] $VAULT_REPO $(lsb_release -cs) main"
    apt update
    apt install -y vault jq
}

enable_vault()
{
    systemctl enable vault
    systemctl start vault
    sleep 30
}

unseal_vault()
{
    for i in $(seq 3)
    do 
        vault operator unseal $(echo $resp | jq -r .unseal_keys_b64[$i])
    done
}

active_vault()
{
    if [ ! -z "$VAULT_INIT_ARGS" ]; then
        resp=$(vault operator init $VAULT_INIT_ARGS -format=json)
        echo $resp | jq .root_token > ~/.vault_root_token.json
        unseal_vault
    else
        resp=$(vault operator init -format=json)
        unseal_vault
        vault login $(echo $resp | jq -r .root_token)
        resp=$(vault token create -period=6h -format=json)
        echo $resp > ~/.vault_token.json
    fi
}

update_system
install_vault
enable_vault
active_vault