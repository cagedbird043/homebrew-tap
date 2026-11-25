class SingBoxCagedbird < Formula
  desc "Universal proxy platform with native Clash subscription support"
  homepage "https://github.com/cagedbird043/sing-box"
  version "1.15.0-alpha.13-cagedbird.20261125154022.9d135e899"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261125154022.9d135e899/sing-box-cagedbird-darwin-arm64.tar.gz"
      sha256 "5296bfe73c870f87ccb2e4a859d2b07ab1060239784d3874a596d3c1d3dda8c7"
    end

    on_intel do
      odie "sing-box-cagedbird currently publishes macOS arm64 binaries only"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261125154022.9d135e899/sing-box-cagedbird-linux-amd64.tar.gz"
      sha256 "1e48d3b39824e828024edcb67c418bf031e646fc10cce7b723b20c4b030601bd"
    end

    on_arm do
      url "https://github.com/cagedbird043/sing-box/releases/download/v1.15.0-alpha.13-cagedbird.20261125154022.9d135e899/sing-box-cagedbird-linux-arm64.tar.gz"
      sha256 "cacb911ed3ea14fa1bcf662ed9d1dcea2ce48d86d45c79b61b23e9d62511179e"
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
      系统服务须从仅管理员可写的固定路径运行。若 Homebrew 目录可被普通用户写入，
      请先把二进制部署到管理员管理的目录，再运行 service install。详见：
        https://github.com/cagedbird043/sing-box/blob/cagedbird/alpha/FORK.md#系统服务
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sing-box version")
    assert_match "with_clash_api", shell_output("#{bin}/sing-box version")
  end
end
