class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.4.1/sbc-darwin-arm64"
      sha256 "c1a3cd23719f073b3f11e0598e434290b573ab361d2e9e7342e7a8ecbd8476ad"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.4.1/sbc-linux-arm64"
      sha256 "4ddd23c173609edec9fceab2c561db6718aac9c451fdde5c57c65c6aa4bdd33e"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.4.1/sbc-linux-amd64"
      sha256 "dfda347a8018f2dd43f4ddb40505706842819c81001e8641ea00e08569b1c31d"
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
