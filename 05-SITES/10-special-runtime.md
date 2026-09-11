# Legacy or Special Runtime

> **Purpose:** Keep odd sites isolated without poisoning the standard runtime.

Build a separate family such as `ktx/web-php83:<release>` or `ktx/web-client-special:<release>`.

Preserve the same operational contract where possible: Apache 8080, sshd 2222, `/var/www/html`, cron, logging, Traefik labels, SSHPiper routing, private site network.

Record the exception prominently in the site manifest. One archaeological application does not get to drag every other site back in time with it.
