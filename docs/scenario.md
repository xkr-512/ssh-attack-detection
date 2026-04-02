# Scenario

## Objective

The objective of the scenario is to show how a password-based SSH attack can be:

- exposed during an audit phase
- detected at event level
- monitored through a dedicated metric
- mitigated through SSH hardening
- validated after remediation

## Phase 1 - Exposure Assessment

The Linux target was scanned with OpenVAS using the `Full and fast` configuration.

The scan identified the target host and exposed services, including SSH on `22/tcp`.  
The findings remained low severity, but they provided useful information about the host exposure and SSH configuration.

Relevant exported artifacts:

- `exports/openvas/linux-target-initial-scan.xml`
- `exports/openvas/linux-target-initial-scan.txt`
- `evidence/openvas-summary.log`

## Phase 2 - Attack Simulation

A controlled wave of failed SSH login attempts was generated against `linux-target`.

The script used for this phase is:

- `scripts/failed_ssh_wave.sh`

The attack targeted the `audituser` account from `monitoring-server`.

## Phase 3 - Detection

Wazuh detected the attack through Linux authentication events.

Two exported events were kept as representative evidence:

- `exports/wazuh/linux-pam-user-login-failed.json`
- `exports/wazuh/linux-sshd-authentication-failed.json`

These events show both PAM-level authentication failure and SSH daemon authentication failure.

## Phase 4 - Monitoring

Zabbix collected the number of failed SSH password attempts from `/var/log/auth.log` using a dedicated log-based item.

The corresponding configuration is stored in:

- `configs/zabbix/failed-ssh-logins.conf`

The collected values are exported in:

- `exports/zabbix/failed-ssh-logins-history.csv`

Grafana visualized the metric through the dashboard export stored in:

- `exports/grafana/linux-target-overview.json`

## Phase 5 - Remediation

SSH was hardened by disabling password-based authentication and reducing the allowed number of authentication attempts.

Before remediation:

- `PasswordAuthentication yes`
- `PermitRootLogin prohibit-password`
- `PubkeyAuthentication yes`
- `MaxAuthTries 6`

After remediation:

- `PasswordAuthentication no`
- `PermitRootLogin no`
- `PubkeyAuthentication yes`
- `MaxAuthTries 2`
- `LogLevel VERBOSE`

Relevant files:

- `configs/ssh/sshd_config.before.conf`
- `configs/ssh/sshd_config.after.conf`
- `evidence/linux-target-ssh-effective.log`

## Phase 6 - Post-Remediation Validation

After remediation, the same password-based SSH attempts no longer produced the same behavior.

Before remediation, the attack generated `Failed password` events visible in:

- Linux authentication logs
- Wazuh alerts
- Zabbix history
- Grafana dashboard

After remediation, the same attempts were rejected before password authentication completed, which reduced the usefulness of the original failed-password metric.

This change in behavior confirmed that the SSH surface had been reduced.