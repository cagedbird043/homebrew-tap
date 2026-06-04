class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.2/sbc-darwin-arm64"
      sha256 "2735a531c54d7e3042ad7238607eaf0683b1030c01f0b410430127c167fbf5f9"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.2/sbc-linux-arm64"
      sha256 "3138db057e6b5d665031ea82c8cd2ec7adba4fb25f6de5b2814a35dace9e446a"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.2/sbc-linux-amd64"
      sha256 "cc2ba57665cfdd310662e8eaf3f2860d682c6860a66c222331f45877899860d9"
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
