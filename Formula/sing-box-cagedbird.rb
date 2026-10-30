class SingBoxCagedbird < Formula
  desc "Universal proxy platform with native Clash subscription support"
  homepage "https://github.com/cagedbird043/sing-box"
  version "1.15.0-alpha.13-cagedbird.20261030204403.b481393b2"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261030204403.b481393b2/sing-box-cagedbird-darwin-arm64.tar.gz"
      sha256 "b7b51d4f9616850bc4990ad41c34f96d57178e9229afcb8777805dca8ee7271f"
    end

    on_intel do
      odie "sing-box-cagedbird currently publishes macOS arm64 binaries only"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261030204403.b481393b2/sing-box-cagedbird-linux-amd64.tar.gz"
      sha256 "e05431d99bc231f25f3629ea41ec8795f7d2f8a912bf8dea446c8944423d9a2b"
    end

    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261030204403.b481393b2/sing-box-cagedbird-linux-arm64.tar.gz"
      sha256 "3afccf59659c2b864eedfad65dce5b6b7ca5a892031b5115360252fffe52dcf7"
    end
  end

  conflicts_with "sing-box", because: "both install the sing-box binary"

  resource "config-pull" do
    url "https://raw.githubusercontent.com/cagedbird043/sing-box/v1.15.0-alpha.13-cagedbird.20261030204403.b481393b2/release/config/sing-box-config-pull"
    sha256 "1b790f92bb0fdb2e911cf5c02e1ba6029ce1bfb27f3319b5158c305f28693b47"
  end

  resource "update" do
    url "https://raw.githubusercontent.com/cagedbird043/sing-box/v1.15.0-alpha.13-cagedbird.20261030204403.b481393b2/release/config/sing-box-update"
    sha256 "41a8bd7e2968e85101b3057dc46b356583ee528df5595700acc4290dd492c993"
  end

  def install
    bin.install "sing-box"
    prefix.install "BUILD-INFO.txt"
    pkgshare.install "LICENSE"
    resource("config-pull").stage { libexec.install "sing-box-config-pull" }
    chmod 0755, libexec/"sing-box-config-pull"
    resource("update").stage { libexec.install "sing-box-update" }
    chmod 0755, libexec/"sing-box-update"
    (bin/"sing-box-update").write <<~SH
      #!/bin/sh
      exec env SING_BOX_CONFIG_DIR="${SING_BOX_CONFIG_DIR:-#{etc}/sing-box}" SING_BOX_BIN="${SING_BOX_BIN:-#{opt_bin}/sing-box}" SING_BOX_CONFIG_PULL="${SING_BOX_CONFIG_PULL:-#{opt_libexec}/sing-box-config-pull}" "#{opt_libexec}/sing-box-update" "$@"
    SH
    chmod 0755, bin/"sing-box-update"
    (etc/"sing-box").mkpath
    (var/"lib/sing-box").mkpath
    (pkgshare/"cn.cagedbird.sing-box-config-pull.plist").write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0"><dict>
        <key>Label</key><string>cn.cagedbird.sing-box-config-pull</string>
        <key>ProgramArguments</key><array><string>#{opt_libexec}/sing-box-config-pull</string></array>
        <key>EnvironmentVariables</key><dict>
          <key>SING_BOX_CONFIG_DIR</key><string>#{etc}/sing-box</string>
          <key>SING_BOX_BIN</key><string>#{opt_bin}/sing-box</string>
        </dict>
        <key>RunAtLoad</key><true/>
        <key>StartInterval</key><integer>1800</integer>
        <key>StandardOutPath</key><string>#{var}/log/sing-box-config-pull.log</string>
        <key>StandardErrorPath</key><string>#{var}/log/sing-box-config-pull.log</string>
      </dict></plist>
    PLIST

    generate_completions_from_executable(bin/"sing-box", "completion")
  end

  service do
    run [opt_bin/"sing-box", "-D", var/"lib/sing-box", "-C", etc/"sing-box", "run"]
    keep_alive true
    require_root true
    log_path var/"log/sing-box.log"
    error_log_path var/"log/sing-box.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sing-box version")
    assert_match "with_clash_api", shell_output("#{bin}/sing-box version")
  end
end
