# Routine Site Maintenance

> **Purpose:** Know when a change is site-level versus platform-level.

Site-level: WordPress/plugin/theme updates, Composer app dependencies, Symfony migrations/cache, customer SSH keys, content restores.

Before risky changes, take a targeted DB dump/file snapshot and record current image/app version.

Use PHP/Composer inside the container, not random host runtimes.

If the fix changes Apache/PHP packages, base OS packages, Supervisor, standard extensions, or global runtime config, it is **platform image maintenance** and follows build -> dev -> prod.
