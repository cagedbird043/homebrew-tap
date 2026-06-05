class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.3.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.3/sbc-darwin-arm64"
      sha256 "ff25628b63fea77a24e5a8aa595bad52482fbf7acb3ef9555e03e5bf5f2a6296"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.3/sbc-linux-arm64"
      sha256 "a7374303489f22b4d0f8b0bbe6d1d9544384c109f5b82d561f05c0d66b9f3b4c"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.3/sbc-linux-amd64"
      sha256 "9a5ed117e723737fb279e4d84d305b6c67c253d69e0c932a145bc437764895c2"
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
