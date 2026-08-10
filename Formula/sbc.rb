class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.5.1/sbc-darwin-arm64"
      sha256 "390f308890e2beaa7cd221bf0540ee23cba93d76b77a6c0225ab882ba592b34f"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.5.1/sbc-linux-arm64"
      sha256 "9a00f6bd9b8a886736ddc2d9f06bc5698ab8c5935c80505e74ee955eb46098b0"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.5.1/sbc-linux-amd64"
      sha256 "2d715974ff015ce16aa69d21c2481aab98346805740fba95261631762735c26c"
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
