#!/bin/bash

for i in $(seq 1 5); do
  sshpass -p 'WrongPass-SSH-2026!' ssh \
    -o PreferredAuthentications=password \
    -o PubkeyAuthentication=no \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    -o ConnectTimeout=5 \
    audituser@192.168.175.30 'exit'
done