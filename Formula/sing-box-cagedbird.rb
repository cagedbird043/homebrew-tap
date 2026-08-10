class SingBoxCagedbird < Formula
  desc "Universal proxy platform with native Clash subscription support"
  homepage "https://github.com/cagedbird043/sing-box"
  version "1.14.0-beta.12-cagedbird.37660be5c"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.14.0-beta.12-cagedbird.37660be5c/sing-box-cagedbird-darwin-arm64.tar.gz"
      sha256 "0b1e5b07d9d5d38be5116a0a821db6abfd486a191bb64a1a488048effce9255c"
    end

    on_intel do
      odie "sing-box-cagedbird currently publishes macOS arm64 binaries only"
    end
  end

  on_linux do
    odie "sing-box-cagedbird Homebrew formula currently supports macOS arm64 only; use AUR or GitHub release tarballs on Linux"
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
