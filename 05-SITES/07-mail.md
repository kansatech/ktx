# Site Mail

> **Purpose:** Send outbound application mail through the KTX relay.

Application points at `ktx-mail-01`; it does not store external provider details unless unavoidable.

If using internal SMTP auth, give each site a unique credential. Restrict permitted sender domains where practical.

Test end-to-end: site connects -> relay logs message ID -> upstream accepts -> recipient receives.

If site is compromised and sending spam, revoke its relay access immediately before broader cleanup.
