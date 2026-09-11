# PHP and Composer

> **Purpose:** Use the site runtime consistently.

Most sites use `ktx/web-php85:<release>`. Legacy/special sites use another image family; do not mutate the standard image in place.

Run Composer inside the site container so PHP/extensions match production:
```bash
docker exec -it -u site ktx-web-example-01 bash -lc 'cd /var/www/html && composer install'
```

Global PHP defaults live in the image. Site overrides live in the site's config and should be small/documented.

If an extension is broadly useful, add it to the next standard image release. If unusual/legacy, build a specialized web image.
