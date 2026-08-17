class SingBoxCagedbird < Formula
  desc "Universal proxy platform with native Clash subscription support"
  homepage "https://github.com/cagedbird043/sing-box"
  version "1.14.0-beta.12-cagedbird.20260817085032.a27583d0b"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.14.0-beta.12-cagedbird.20260817085032.a27583d0b/sing-box-cagedbird-darwin-arm64.tar.gz"
      sha256 "b6a87614292fccdab7dfdc9f9c2f635a2db956d935a12c77c4ff22893b44d724"
    end

    on_intel do
      odie "sing-box-cagedbird currently publishes macOS arm64 binaries only"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.14.0-beta.12-cagedbird.20260817085032.a27583d0b/sing-box-cagedbird-linux-amd64.tar.gz"
      sha256 "e86118040ffc8af636473f06621ec07d35f1c9ea372b5313db7b331206fb565d"
    end

    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.14.0-beta.12-cagedbird.20260817085032.a27583d0b/sing-box-cagedbird-linux-arm64.tar.gz"
      sha256 "477e5fab0dcdb751ac92bf281a308061e26ac09003f0eafd98293220d57f7d18"
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
