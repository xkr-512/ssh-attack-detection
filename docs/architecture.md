# Architecture

## Scope

This repository documents a small security monitoring lab focused on SSH attack detection and remediation on a Linux target.

The environment combines vulnerability assessment, security event analysis, metric collection, and dashboard visualization.

## Systems

### linux-target

Main Linux system used as the protected target.

It exposes SSH and generates the authentication logs used during the scenario.  
It is the central system of the project.

### monitoring-server

Hosts Zabbix and Grafana.

It is used to collect and visualize the failed SSH login metric and to observe the effect of the attack and the remediation over time.

### wazuh-server

Central security monitoring platform.

It collects and analyzes Linux SSH events and Windows Sysmon events.

### scanner-openvas

Dedicated vulnerability assessment host.

It is used to scan the Linux target and identify exposed services and low-severity findings related to the SSH-exposed host.

### windows-endpoint

Windows endpoint integrated into Wazuh with Sysmon telemetry.

It is included to demonstrate that the lab covers both Linux and Windows systems, even though the main scenario is centered on Linux SSH activity.

## Functional Roles

- OpenVAS: attack surface assessment
- Wazuh: event detection and security analysis
- Zabbix: metric collection
- Grafana: metric visualization

## Main Focus

The main focus of the project is the Linux SSH scenario.

The Windows endpoint is included as an additional telemetry source to demonstrate multi-platform visibility inside the same monitoring environment.