# BSEOA License Management

## Check if a license is active

```bash
black-seo-analyzer --is-license-valid
# Prints: YES  (licensed)
# Prints: NO   (trial mode — limited to 3 pages)
```

Always run this before starting a crawl if license status is unknown.

## Save a license key to persistent storage

```bash
black-seo-analyzer --store-license "XXXX-XXXX-XXXX-XXXX"
# Prints: License Key Saved Successfully to <path>
```

This saves the key to the platform-specific location so it is found automatically on every future run. The user does not need to pass `--license-key` again after this.

Platform storage locations:
| Platform | Path |
|----------|------|
| Windows | `%APPDATA%\com.sethserver.blackseoanalyzer\license.txt` |
| macOS | `~/Library/Application Support/com.sethserver.blackseoanalyzer/license.txt` |
| Linux | `~/.local/share/com.sethserver.blackseoanalyzer/license.txt` |

## Pass a key for a single run (without storing)

```bash
black-seo-analyzer --url-to-begin-crawl https://example.com --license-key "XXXX-XXXX-XXXX-XXXX"
```

## License check workflow

When the user asks about licensing or a crawl stops at 3 pages:
1. Run `black-seo-analyzer --is-license-valid`
2. If `NO`: ask the user for their license key
3. Run `black-seo-analyzer --store-license "<key>"` to persist it
4. Run `black-seo-analyzer --is-license-valid` again to confirm `YES`
5. Proceed with the crawl
