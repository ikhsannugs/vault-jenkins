#!/bin/bash
### Install Vault ###

### RUN WITH ROOT ###

### Install Vault ###
wget https://releases.hashicorp.com/vault/1.5.4/vault_1.5.4_linux_amd64.zip
apt-get install unzip
unzip vault_1.5.4_linux_amd64.zip
mv vault /usr/local/bin

### Create User Vault ###
useradd --system --home /etc/vault/ --shell /bin/false vault

### Config Vault ###
mkdir -p /etc/vault/data
chown -R vault:vault /etc/vault/

tee /etc/vault/config.hcl << EOF
ui = true
disable_mlock = true

storage "raft" {
  path    = "/etc/vault/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
EOF

tee /etc/systemd/system/vault.service << EOF
[Unit]
Description=Vault
Documentation=https://www.vault.io/

[Service]
User=vault
Group=vault
ExecStart=/usr/local/bin/vault server -config=/etc/vault/config.hcl
ExecReload=/usr/bin/kill --signal HUP $MAINPID
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

tee -a /etc/environment << EOF
export VAULT_ADDR='http://127.0.0.1:8200'
EOF

systemctl daemon-reload
systemctl enable vault
systemctl start vault
