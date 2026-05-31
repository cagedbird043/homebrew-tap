class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.1/sbc-darwin-arm64"
      sha256 "20f11d758eaaf75aa0587836d856017c56e6dff0cd2eb9926e39bc38ae48290a"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.1/sbc-linux-arm64"
      sha256 "e4d63ce1cbcd5f27b49ea4c4f23b85ee5f3f2b4ec7f0c6758db97369dda1179c"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.1/sbc-linux-amd64"
      sha256 "4981ea5cf9d03c45e505821f9892d66d1631deeb4fbc878405a4b99f23877500"
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
