# Module Repository Layout

Recommended repository:

```text
ktx-<module>/
├── .git/
├── .gitignore
├── README.md
├── VERSION
├── CHANGELOG.md
├── MODULE.yml
├── docs/
├── image/
│   ├── Dockerfile
│   └── ...
├── container/
│   ├── compose.yml.template
│   └── ...
├── bin/
│   ├── build
│   ├── validate
│   ├── instantiate
│   └── ...
└── tests/
```

A starting skeleton is tracked in:

```text
/srv/ktx/module-template
```

Create a new repository from that skeleton; do not copy it into the Host Core Git history.

## Build-host checkout

Example:

```bash
cd /srv/ktx/images
git clone git@github.com:Kansatech/ktx-webphp85.git
cd ktx-webphp85
```

`/srv/ktx/images` is ignored by the parent repository, so this child `.git` remains independent.

## Source vs instance

Tracked source/template:

```text
/srv/ktx/images/ktx-webphp85/container/
```

Generated server instance:

```text
/srv/ktx/containers/ktx-web-clienta-01/
```

Never edit the module's reusable container template to store one customer's password, IP, or hostname.
