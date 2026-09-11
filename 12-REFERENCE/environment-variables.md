# Common Configuration Names
| Name | Meaning |
|---|---|
| `KTX_ENV` | build/dev/prod |
| `KTX_SITE` | site slug |
| `KTX_RELEASE` | runtime release |
| `DB_HOST` | normally `ktx-percona-01` |
| `DB_PORT` | normally 3306 |
| `DB_NAME` | site DB |
| `DB_USER` | site DB user |
| `SMTP_HOST` | normally `ktx-mail-01` |
| `TZ` | normally UTC |

Prefer mounted secret files under `/run/ktx-secrets` where the application supports them.
