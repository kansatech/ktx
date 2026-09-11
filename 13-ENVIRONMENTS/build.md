# ktx-build-26

> **Purpose:** Everything special about the build host.

Expected: compilers/toolchains, source checkout, BuildKit, Go toolchain if building SSHPiper, package downloads, image tests, release creation.

Never: production customer data, production secrets, production hosting.

Output: immutable release directory containing image archives, checksums, manifest/version inventory, and change notes.
