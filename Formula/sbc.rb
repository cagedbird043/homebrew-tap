class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-darwin-arm64"
      sha256 "acce9e2e44407730ad29d7e9bf7c1949e3f5d07ba01c22b18891e89e845c5ece"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-linux-arm64"
      sha256 "64f61f26ed8af0e0ba166adc47b8a00406836a1224eba85d2400ad58541e2e08"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.1.0/sbc-linux-amd64"
      sha256 "8c68072fbec9df8e3edb6152d59200a66469ab26019d3511e8bc4a67ef187e2a"
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
