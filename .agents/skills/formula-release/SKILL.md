---
name: formula-release
description: SOP for publishing and updating Homebrew formulae in cagedbird043/homebrew-tap.
---

## Trigger

This skill is triggered when the agent needs to update or release a package formula in `cagedbird043/homebrew-tap` (e.g. `sing-box-cagedbird`).

## Entry Point

The entry point is updating a formula in `Formula/<formula>.rb`.

## Workflow

1. Calculate the new release package's sha256:
   ```bash
   tmp=$(mktemp -d)
   cd "$tmp"
   curl -L --fail -o pkg.tar.gz "<release_tarball_url>"
   sha256sum pkg.tar.gz
   rm -rf "$tmp"
   ```
2. Edit `Formula/<formula>.rb` to update `version`, `url`, and `sha256` together.
3. Check the Ruby syntax:
   ```bash
   ruby -c Formula/<formula>.rb
   ```
4. Commit and push the changes.

## Verification

- Local syntax verification:
  ```bash
  ruby -c Formula/<formula>.rb
  ```
- If running on macOS, verify by upgrading and testing the formula:
  ```bash
  brew update
  brew upgrade <formula>
  brew test cagedbird043/tap/<formula>
  ```

## Guardrails

- Never submit this forked binary formula to `homebrew/core`. It must remain in the personal tap `cagedbird043/tap`.
- Always update version, url, and sha256 together.
