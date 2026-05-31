class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-darwin-arm64"
      sha256 ""
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-Linux-arm64"
      sha256 "7456cc3826555f451afda2be0a80dcdb05246b9c5ee4b585712b3251c516d15f"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-Linux-amd64"
      sha256 "574e857960e13a7c08613ae7595d0ff65851d5e458817c288a8adb7232459891"
    end
  end

  resource "completion" do
    url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/_sbc"
    sha256 "9605e701e09b93feb35680c895131a650ad6179d8adf43ebe1bf9e6a7c9e2334"
  end

  def install
    if OS.mac?
      bin.install "sbc-darwin-arm64" => "sbc"
    elsif OS.linux?
      bin.install "sbc-linux-#{Hardware::CPU.arch}" => "sbc"
    end
    (zsh_completion/"_sbc").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sbc --version")
  end
end
