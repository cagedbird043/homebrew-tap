# sing-box-cagedbird Homebrew Tap 维护指南

最后更新：2026-05-12

## 目标

macOS 侧现在通过 Homebrew tap 维护 `sing-box-cagedbird`，用于安装和升级我们 fork 的 sing-box。

- Tap 仓库：<https://github.com/cagedbird043/homebrew-tap>
- Formula：`Formula/sing-box-cagedbird.rb`
- 本地仓库：`/home/cagedbird/Projects/Homebrew/homebrew-tap`
- 源码/Release 仓库：<https://github.com/cagedbird043/sing-box>

安装命令：

```bash
brew install cagedbird043/tap/sing-box-cagedbird
```

更新命令：

```bash
brew update
brew upgrade sing-box-cagedbird
```

## 包语义

`sing-box-cagedbird` 是我们 fork 的 macOS binary formula。它安装的二进制仍叫：

```text
/opt/homebrew/bin/sing-box
```

所以 formula 里应保留：

```ruby
conflicts_with "sing-box", because: "both install the sing-box binary"
```

不要提交到 `homebrew/core`。我们这是 fork + binary release，应该留在个人 tap。

## 当前已验证状态

当前 Mac 已安装：

```text
cagedbird043/tap/sing-box-cagedbird: 1.14.0-alpha.21-cagedbird.228304d3
```

当前 symlink：

```text
/opt/homebrew/bin/sing-box -> ../Cellar/sing-box-cagedbird/1.14.0-alpha.21-cagedbird.228304d3/bin/sing-box
```

当前版本：

```text
sing-box version 1.14.0-alpha.21-cagedbird.228304d3
Revision: 228304d392c63502776999987c2b2de37f4b043c
Tags: with_gvisor,with_quic,with_dhcp,with_wireguard,with_utls,with_acme,with_clash_api,with_tailscale,...
```

`brew test` 已通过：

```bash
brew test cagedbird043/tap/sing-box-cagedbird
```

## Mac 后台服务与配置位置

MacBookAir 已迁移为单一 `sing-box-cagedbird` 后台服务：

```text
LaunchDaemon: /Library/LaunchDaemons/homebrew.mxcl.sing-box-cagedbird.plist
Binary:       /opt/homebrew/opt/sing-box-cagedbird/bin/sing-box
Config:       /opt/homebrew/etc/sing-box/config.json
Work dir:     /opt/homebrew/var/lib/sing-box
Tailnet dir:  /opt/homebrew/var/lib/sing-box/tailnet-mice-macbook-air-v2
Log:          /opt/homebrew/var/log/sing-box.log
```

服务启动/重启：

```bash
sudo brew services start cagedbird043/tap/sing-box-cagedbird
sudo brew services restart cagedbird043/tap/sing-box-cagedbird
```

注意：`sudo brew services start` 会把部分当前 keg/opt/link 路径改成 `root:admin`，这是 Homebrew root service 的常见警告。以后如果 `brew upgrade/reinstall/uninstall sing-box-cagedbird` 因这些路径所有权失败，先停服务，再按 Homebrew 提示用 `sudo rm` 清掉对应旧路径，随后重新 `brew install/upgrade`。

当前配置来自私有 truth 仓库：

```text
/home/cagedbird/Projects/Mice-Tailor-Infra/sing-box-private-prod/profiles/macos/config.template.json
```

macOS 侧需要把 Wi-Fi DNS 指到 sing-box 本机 DNS，否则系统 DNS 可能被路由器污染，导致 TUN 下 Google 等域名解析到错误 IP：

```bash
sudo networksetup -setdnsservers Wi-Fi 127.0.0.1
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

恢复 DHCP DNS：

```bash
sudo networksetup -setdnsservers Wi-Fi Empty
```

当前 tailnet 节点：

```text
mice-macbook-air -> 100.64.0.2
```

已验证：

```text
Mac -> laptop: ssh cagedbird@100.64.0.1 hostname
laptop -> Mac: ssh cagedbird@100.64.0.2 hostname
TUN 出国: curl -4 https://www.google.com/generate_204
国内直连: curl https://www.baidu.com
```

## 当前 Formula 资产

当前 release asset：

```text
https://github.com/cagedbird043/sing-box/releases/download/v1.14.0-alpha.21-cagedbird.228304d3/sing-box-cagedbird-darwin-arm64.tar.gz
```

当前 sha256：

```text
2dacc4510e840f5b59f297fc4d582f7f89c7077ad83ef155ec4a6c7ccedf8476
```

当前只支持 Apple Silicon macOS：

```ruby
on_macos do
  on_arm do
    url "...darwin-arm64.tar.gz"
    sha256 "..."
  end
end
```

如果以后要 Intel Mac，需要先让 sing-box CI 发布：

```text
sing-box-cagedbird-darwin-amd64.tar.gz
```

然后 formula 加 `on_intel` 分支。

## 发布新版步骤

进入 tap 仓库：

```bash
cd /home/cagedbird/Projects/Homebrew/homebrew-tap
```

修改：

```text
Formula/sing-box-cagedbird.rb
```

需要更新三处：

```ruby
version "新版本"
url "https://github.com/cagedbird043/sing-box/releases/download/v新版本/sing-box-cagedbird-darwin-arm64.tar.gz"
sha256 "新 tarball 的 sha256"
```

计算 sha256：

```bash
tmp=$(mktemp -d)
cd "$tmp"
curl -L --fail -o sing-box-darwin-arm64.tar.gz \
  "https://github.com/cagedbird043/sing-box/releases/download/v新版本/sing-box-cagedbird-darwin-arm64.tar.gz"
sha256sum sing-box-darwin-arm64.tar.gz
rm -rf "$tmp"
```

本地 Linux 侧至少做 Ruby 语法检查：

```bash
cd /home/cagedbird/Projects/Homebrew/homebrew-tap
ruby -c Formula/sing-box-cagedbird.rb
```

提交并推送：

```bash
git add Formula/sing-box-cagedbird.rb
git commit -m "Package the next cagedbird sing-box Homebrew release

Constraint: macOS users consume immutable darwin-arm64 tarballs from cagedbird043/sing-box releases.
Rejected: Submitting this forked binary formula to homebrew-core | a personal tap is the lower-maintenance and correct distribution surface.
Confidence: high
Scope-risk: narrow
Directive: Update version, url, and sha256 together after each sing-box release.
Tested: ruby -c Formula/sing-box-cagedbird.rb; brew install/test on macOS when available.
Not-tested: Intel macOS unless a darwin-amd64 asset exists."
git push
```

Mac 端验证：

```bash
brew update
brew upgrade sing-box-cagedbird
brew test cagedbird043/tap/sing-box-cagedbird
sing-box version
```

## Mac 上的历史遗留

Mac 之前有旧本地 formula：

```text
cagedbird/local/sing-box-ref1nd
```

它曾安装旧的 reF1nd 版本：

```text
1.13.1-beta.2-reF1nd-dev
```

该 tap/keg 已清理。当前保留的 tap 只有：

```text
cagedbird043/tap
```

Tailscale.app、Homebrew `tailscale`、`/Library/Tailscale`、Tailscale 网络服务、Clash Verge app/helper 也已清理。

macOS 的 Tailscale System Extension 卸载有一个系统限制：`systemextensionsctl uninstall` 在 SIP 开启时会拒绝执行。当前状态是 Tailscale 进程已杀掉，app/pkg/brew/network service 已清，但 `systemextensionsctl list` 仍可能显示：

```text
W5364U7YZB io.tailscale.ipn.macsys.network-extension ... [activated enabled]
```

这不是当前联网路径；当前只有 `sing-box-cagedbird` 进程在工作。如需彻底移除此 system extension，需要在 Mac 本机 GUI/恢复环境按 Apple 的 System Extension/SIP 流程处理。

## 总体分发矩阵

现在系统包入口是：

```text
Arch Linux: paru -S sing-box-cagedbird-bin
macOS arm64: brew install cagedbird043/tap/sing-box-cagedbird
Android: GitHub Release APK
Generic Linux/macOS tarball: GitHub Release assets
```

长期维护节奏：

```text
1. rebase/update sing-box fork
2. GitHub Actions 发布新 release
3. 更新 AUR PKGBUILD/.SRCINFO
4. 更新 Homebrew Formula version/url/sha256
5. Arch/macOS 分别验证 sing-box version
```
