# Update PHP

> **Purpose:** Patch or upgrade PHP without changing every site by hand.

For PHP 8.5 patch/minor package updates:
1. new immutable release on build
2. rebuild base if required
3. rebuild `ktx/web-php85`
4. capture exact PHP/extensions versions
5. test `php -v`, `php -m`, FPM config, Apache/FPM request, Composer
6. export release
7. import/recreate representative dev sites
8. test actual apps and logs/memory
9. promote same artifact
10. recreate prod sites in batches

For PHP 8.5 -> 8.6, first create a separate `ktx/web-php86` family and migrate sites individually. Keep 8.5 until compatibility and rollback windows are satisfied.

Never upgrade PHP and Percona major versions in the same change.
