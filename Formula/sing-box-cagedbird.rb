class SingBoxCagedbird < Formula
  desc "Universal proxy platform with native Clash subscription support"
  homepage "https://github.com/cagedbird043/sing-box"
  version "1.14.0-alpha.21-cagedbird.228304d3"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.14.0-alpha.21-cagedbird.228304d3/sing-box-cagedbird-darwin-arm64.tar.gz"
      sha256 "2dacc4510e840f5b59f297fc4d582f7f89c7077ad83ef155ec4a6c7ccedf8476"
    end

    on_intel do
      odie "sing-box-cagedbird currently publishes macOS arm64 binaries only"
    end
  end

  on_linux do
    odie "sing-box-cagedbird Homebrew formula currently supports macOS arm64 only; use AUR or GitHub release tarballs on Linux"
  end

  conflicts_with "sing-box", because: "both install the sing-box binary"
  conflicts_with "sing-box-ref1nd", because: "both install the sing-box binary"

  def install
    bin.install "sing-box"
    prefix.install "BUILD-INFO.txt"
    pkgshare.install "LICENSE"

    generate_completions_from_executable(bin/"sing-box", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sing-box version")
    assert_match "with_clash_api", shell_output("#{bin}/sing-box version")
  end
end
