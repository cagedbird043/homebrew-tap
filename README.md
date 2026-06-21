# cagedbird043 Homebrew Tap

Homebrew tap for cagedbird-maintained packages.

## Packages

### sing-box-cagedbird

`sing-box-cagedbird` packages the cagedbird fork of sing-box, which keeps upstream sing-box behavior and adds native Clash subscription support.

```bash
brew install cagedbird043/tap/sing-box-cagedbird
```

### cxf

`cxf` is a Codex / Claude Code provider pointer manager — switch between API endpoints without losing codex history.

```bash
brew install cagedbird043/tap/cxf
```

### skills-cli

`skills-cli` is an agent skill manager — manifest + lock + mirrors for multi-agent skill governance.

```bash
brew install cagedbird043/tap/skills-cli
```

## Upgrade

```bash
brew update
brew upgrade sing-box-cagedbird cxf skills
```

Alternatively, tap once:

```bash
brew tap cagedbird043/tap
brew install sing-box-cagedbird
brew install cxf
brew install skills
```

## Source

- [sing-box fork](https://github.com/cagedbird043/sing-box)
- [cxf](https://github.com/cagedbird043/cxf)
- [skills](https://github.com/cagedbird043/skills)

## Agent-native Skills

### Start here

- 任务 = 发布/更新 Formula (如 `sing-box-cagedbird`) → 先读 [README.md](README.md) → 需要执行 SOP 时再读 [.agents/skills/formula-release/SKILL.md](.agents/skills/formula-release/SKILL.md) → 需要背景证据时再读 [docs/ops/homebrew-maintenance.md](docs/ops/homebrew-maintenance.md)

### Skills

- [formula-release](.agents/skills/formula-release/SKILL.md): Triggered when updating or releasing a package (formula) in this tap. Entry Point is formula-release SKILL.md.

### Deep docs

- [docs/ops/homebrew-maintenance.md](docs/ops/homebrew-maintenance.md): Homebrew tap maintenance guide for sing-box-cagedbird and others.

### Do not read everything

- Agent MUST start by reading [README.md](README.md) and [AGENTS.md](AGENTS.md). DO NOT scan the entire repository recursively.
