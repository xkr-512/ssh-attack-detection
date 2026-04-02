# Validation

## Linux SSH Attack Evidence

The Linux target generated explicit authentication failure entries during the attack phase.

Relevant file:

- `evidence/linux-target-auth-failed.log`

These lines confirm that failed password attempts against `audituser` were recorded on the target system.

## Wazuh Detection Validation

Wazuh successfully detected Linux authentication failures through exported events:

- `exports/wazuh/linux-pam-user-login-failed.json`
- `exports/wazuh/linux-sshd-authentication-failed.json`

These exports confirm that the platform detected both PAM-related failures and SSH daemon authentication failures.

## Zabbix and Grafana Validation

Zabbix successfully collected failed SSH login counts through a dedicated active agent item based on `/var/log/auth.log`.

Relevant files:

- `configs/zabbix/failed-ssh-logins.conf`
- `exports/zabbix/failed-ssh-logins-history.csv`
- `exports/grafana/linux-target-overview.json`

The exported metric values show a short spike during the attack phase, followed by a return to zero after the activity stopped.

## OpenVAS Validation

OpenVAS successfully scanned the Linux target and identified SSH exposure together with low-severity findings.

Relevant files:

- `exports/openvas/linux-target-initial-scan.xml`
- `exports/openvas/linux-target-initial-scan.txt`
- `evidence/openvas-summary.log`

The retained findings include:

- Weak MAC Algorithm(s) Supported (SSH)
- TCP Timestamps Information Disclosure
- ICMP Timestamp Reply Information Disclosure

## Windows Telemetry Validation

The lab also includes a Windows endpoint monitored through Wazuh and Sysmon.

Relevant files:

- `configs/wazuh/windows-sysmon-localfile.xml`
- `exports/wazuh/windows-sysmon-discovery-net-user.json`
- `exports/wazuh/windows-sysmon-cmd-abnormal-process.json`
- `evidence/wazuh-agents.log`

These artifacts demonstrate that the monitoring environment is not limited to Linux and includes Windows telemetry as well.

## Conclusion

The project validates a complete workflow built around a Linux SSH security scenario:

- exposure assessment
- attack simulation
- event detection
- metric monitoring
- remediation
- post-remediation verification

The Windows endpoint extends the lab with multi-platform visibility, but the main scenario remains the Linux SSH attack path.