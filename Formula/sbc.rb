class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.4.0/sbc-darwin-arm64"
      sha256 "c97d3553d9336c2af3307c3f28350ec46e50cc6a63a647e2035feabda4f02530"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.4.0/sbc-linux-arm64"
      sha256 "b7b5315512b5be97e4266553c6fb7cc3cfd3f4588862607fe2f7d0900c6b4afe"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.4.0/sbc-linux-amd64"
      sha256 "f16e4c8396058f0a60d29b0a58529059de571b6f9832a394584d38c5a3faf0dd"
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
