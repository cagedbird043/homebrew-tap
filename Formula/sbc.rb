class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-darwin-arm64"
      sha256 "c71067bcd26db2bb1b45631a88fe68c250478ca645f9cbf79afafe9041d04672"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-linux-arm64"
      sha256 "8f07744bdb71002c542e0e10ff11a35e119c3449d968d3cab3a2c68d1cbea969"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-linux-amd64"
      sha256 "0dc13b93779b7a88a9e723493094893c19fbc3e8327c83b7201c2150a33b7fae"
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
      if Hardware::CPU.intel?
        bin.install "sbc-linux-amd64" => "sbc"
      else
        bin.install "sbc-linux-arm64" => "sbc"
      end
    end
    (zsh_completion/"_sbc").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sbc --version")
  end
end
