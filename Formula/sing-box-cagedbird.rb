class SingBoxCagedbird < Formula
  desc "Universal proxy platform with native Clash subscription support"
  homepage "https://github.com/cagedbird043/sing-box"
  version "1.14.0-beta.12-cagedbird.20260811085045.2fef69722"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.14.0-beta.12-cagedbird.20260811085045.2fef69722/sing-box-cagedbird-darwin-arm64.tar.gz"
      sha256 "824f00df5a796d8b5f8fc4d9d4b3ab124d4f1adc8694e127841826491e06f0dd"
    end

    on_intel do
      odie "sing-box-cagedbird currently publishes macOS arm64 binaries only"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.14.0-beta.12-cagedbird.20260811085045.2fef69722/sing-box-cagedbird-linux-amd64.tar.gz"
      sha256 "cc4d94c12d3942b6f0fdaab5ad88ca1ca193774d3d384fd4253a49f003ed8263"
    end

    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.14.0-beta.12-cagedbird.20260811085045.2fef69722/sing-box-cagedbird-linux-arm64.tar.gz"
      sha256 "fc3aa9dc6563925954f4a29bc7f478dd8edf9fdbd2889cf92d16340db2efce11"
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
