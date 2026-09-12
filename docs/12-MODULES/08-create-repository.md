# Create a New Module Repository

Example: `Kansatech/ktx-webphp85`.

## 1. Start from the Host Core skeleton

Use a temporary working location, not `/srv/ktx/images` yet:

```bash
mkdir -p ~/src/ktx-webphp85
cp -a /srv/ktx/module-template/. ~/src/ktx-webphp85/
cd ~/src/ktx-webphp85
```

Replace placeholder names in `MODULE.yml`, `README.md`, and `VERSION`.

## 2. Initialize Git

```bash
git init -b main
git add .
git commit -m "Initial KTX module skeleton"
```

Create `Kansatech/ktx-webphp85` on GitHub, then:

```bash
git remote add origin git@github.com:Kansatech/ktx-webphp85.git
git push -u origin main
```

Use HTTPS instead if that is your chosen GitHub authentication method.

## 3. Clone into the build workspace

Remove the temporary copy after it is safely pushed, then:

```bash
cd /srv/ktx/images
git clone git@github.com:Kansatech/ktx-webphp85.git
```

This is now the normal build checkout.

## 4. Build both reusable pieces in the module repo

The module repository owns:

```text
image/       Docker image build context
container/   reusable, secret-free instance templates
```

Actual generated container instances go to:

```text
/srv/ktx/containers/
```

and never become commits in `Kansatech/ktx`.

## 5. Lifecycle documentation

Before considering a module production-ready, document its build, config, dev test, prod deployment, update, backup, restore, monitoring, security, troubleshooting, and removal procedures under its own `docs/`.
