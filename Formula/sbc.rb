class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.5.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.5.2/sbc-darwin-arm64"
      sha256 "3c7cc0fa698db0e653810b180238db2af07e586b13c5059f0b854935329287cb"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.5.2/sbc-linux-arm64"
      sha256 "78d90683cd0a452d8c5c6c92ea8a39c659ce2b7c276f64f68cde97b420912057"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.5.2/sbc-linux-amd64"
      sha256 "93d84bdb1b1487228a99c65d769aa6888e12cb188fcdd869677ac17076ecde18"
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
