class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-darwin-arm64"
      sha256 "c5c52ec882719fe2980e5690546fdcd8ed680b3f556799c61b7b112e5db01ecf"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-linux-arm64"
      sha256 "f0018e477e4b6236a9bd4bcc15e9b82f89bb3c098053fdbe3500289ac9cc82c2"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-linux-amd64"
      sha256 "3408726072ed5580ee8aa152e2565071a7e0bfec775385685fd80b608e0ee1e7"
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
