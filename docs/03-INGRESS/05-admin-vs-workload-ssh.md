# Administrator SSH vs Workload SSH

There are deliberately two different SSH entry paths.

## Administrator

```text
ssh -p 2222 admin@host
```

- Ubuntu OpenSSH
- host account
- sudo according to host policy
- restricted firewall source
- independent of Docker/SSHPiper

## Workload/customer

```text
ssh customer-login@host
```

- TCP 22
- native SSHPiper
- route selected by external username
- upstream target is a private Docker IP
- no host shell

Do not create a special SSHPiper route that points your normal administrator username back to host sshd. It saves one port number while making recovery depend on the very proxy you may need to repair.
