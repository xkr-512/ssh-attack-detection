# SSH Attack Detection

## Overview

This repository documents a small SOC-oriented lab focused on the audit, detection, monitoring, and remediation of password-based SSH attack activity against a Linux target.

The project combines four complementary components:

- OpenVAS for attack surface assessment
- Wazuh for security event collection and detection
- Zabbix for metric collection
- Grafana for dashboard visualization

A Windows endpoint monitored with Sysmon and Wazuh is also included to demonstrate multi-platform visibility in the same environment.

## Main Goal

The main goal of the project is to show how a Linux SSH attack path can be:

- assessed during a vulnerability scanning phase
- detected through security events
- monitored through a dedicated metric
- reduced through SSH hardening
- validated after remediation

## Environment

- `linux-target`: main protected Linux target
- `monitoring-server`: Zabbix and Grafana host
- `wazuh-server`: security monitoring platform
- `scanner-openvas`: OpenVAS scanning host
- `windows-endpoint`: Windows endpoint with Sysmon telemetry

## Repository Content

### `configs/`
Configuration artifacts used in the lab.

- `configs/ssh/sshd_config.before.conf`
- `configs/ssh/sshd_config.after.conf`
- `configs/wazuh/windows-sysmon-localfile.xml`
- `configs/zabbix/failed-ssh-logins.conf`

### `scripts/`
Shell scripts used to generate the SSH attack and the post-remediation retest.

- `scripts/failed_ssh_wave.sh`
- `scripts/post_remediation_retest.sh`

### `exports/`
Raw exported artifacts collected from the tools used in the project.

- OpenVAS scan exports
- Wazuh alert exports
- Zabbix metric export
- Grafana dashboard export

### `evidence/`
Short supporting logs and summaries extracted from the lab.

## Scenario Summary

1. OpenVAS scans the Linux target
2. A controlled wave of failed SSH logins is generated
3. Wazuh detects the SSH authentication failures
4. Zabbix counts failed SSH logins from `auth.log`
5. Grafana visualizes the metric
6. SSH hardening is applied
7. Post-remediation validation confirms a change in behavior

## Key Results

- SSH exposure identified through OpenVAS
- Linux authentication failures detected in Wazuh
- Failed SSH login activity measured in Zabbix
- Visualization of the metric in Grafana
- Reduced password-based SSH attack surface after remediation

## Notes

The Linux SSH scenario is the main use case of the project.  
The Windows endpoint is included as an additional telemetry source to extend the monitoring scope beyond a single operating system.