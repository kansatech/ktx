#!/usr/bin/env bash
set -euo pipefail

cp /ktx-config/main.cf /etc/postfix/main.cf

if [[ -f /ktx-config/sender_relay ]]; then
  cp /ktx-config/sender_relay /etc/postfix/sender_relay
  postmap /etc/postfix/sender_relay
fi

if [[ -f /run/ktx-secrets/sasl_passwd ]]; then
  install -m 0600 /run/ktx-secrets/sasl_passwd /etc/postfix/sasl_passwd
  postmap /etc/postfix/sasl_passwd
fi

postfix check
exec postfix start-fg
