# cagedbird043 Homebrew Tap

Homebrew tap for cagedbird-maintained packages.

## sing-box-cagedbird

`sing-box-cagedbird` packages the cagedbird fork of sing-box, which keeps upstream sing-box behavior and adds native Clash subscription support.

Install on Apple Silicon macOS:

```bash
brew install cagedbird043/tap/sing-box-cagedbird
```

Or:

```bash
brew tap cagedbird043/tap
brew install sing-box-cagedbird
```

Upgrade:

```bash
brew update
brew upgrade sing-box-cagedbird
```

This formula installs `/opt/homebrew/bin/sing-box` and conflicts with the official `sing-box` formula because both install the same binary name.

Source releases: <https://github.com/cagedbird043/sing-box/releases>
