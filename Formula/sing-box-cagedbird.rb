class SingBoxCagedbird < Formula
  desc "Universal proxy platform with native Clash subscription support"
  homepage "https://github.com/cagedbird043/sing-box"
  version "1.15.0-alpha.13-cagedbird.20261125135229.80173bd8c"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261125135229.80173bd8c/sing-box-cagedbird-darwin-arm64.tar.gz"
      sha256 "5642b450dddfa7e407dd49d33f52cbf136cb26927152db6da8bdf698dbd6b51d"
    end

    on_intel do
      odie "sing-box-cagedbird currently publishes macOS arm64 binaries only"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261125135229.80173bd8c/sing-box-cagedbird-linux-amd64.tar.gz"
      sha256 "9257ab01d5836d7d02ddc2a9a92a7dc2da9dac4d82368f9eee07964b16f3915d"
    end

    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261125135229.80173bd8c/sing-box-cagedbird-linux-arm64.tar.gz"
      sha256 "af357629e064bf6fb11b979dcf6cec4e2ad1619e1fc9f8e3c905c6087f7f4b5d"
    end
  end

  conflicts_with "sing-box", because: "both install the sing-box binary"

  def install
    bin.install "sing-box"
    prefix.install "BUILD-INFO.txt"
    pkgshare.install "LICENSE"
    generate_completions_from_executable(bin/"sing-box", "completion")
  end

  def caveats
    <<~EOS
      从远程配置安装系统服务：
        sudo sing-box service install --config-url <URL>
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sing-box version")
    assert_match "with_clash_api", shell_output("#{bin}/sing-box version")
  end
end
