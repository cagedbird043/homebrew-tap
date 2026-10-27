class SingBoxCagedbird < Formula
  desc "Universal proxy platform with native Clash subscription support"
  homepage "https://github.com/cagedbird043/sing-box"
  version "1.15.0-alpha.13-cagedbird.20261027172802.7a167bdff"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261027172802.7a167bdff/sing-box-cagedbird-darwin-arm64.tar.gz"
      sha256 "afd3302e110f6408c82b363ae9512e446be9595fc222c1b1c85647bc310827b4"
    end

    on_intel do
      odie "sing-box-cagedbird currently publishes macOS arm64 binaries only"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261027172802.7a167bdff/sing-box-cagedbird-linux-amd64.tar.gz"
      sha256 "9983e3e3a69bbbe025873b48b6423e180a1709f2671ccc51583e1f3acd3c85c8"
    end

    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261027172802.7a167bdff/sing-box-cagedbird-linux-arm64.tar.gz"
      sha256 "236d2f42c6a105b579511bd485453e9ee717002c79cda92c92e3959bd404532a"
    end
  end

  conflicts_with "sing-box", because: "both install the sing-box binary"

  def install
    bin.install "sing-box"
    prefix.install "BUILD-INFO.txt"
    pkgshare.install "LICENSE"

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
