class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.2.1/sbc-darwin-arm64"
      sha256 "6461c4267a354e70f06eacbcdeea888de0950a8458e7f6d8f04a2c18ae7c5910"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.2.1/sbc-linux-arm64"
      sha256 "347408326d8b3b9ccbf3b0666b875fa6a1400b4110b1731bff6482d828d60cfe"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.2.1/sbc-linux-amd64"
      sha256 "058ae54bb356efe563e14446c6fd10c7a3f4abf336cb7c79da3cb5364b16a587"
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
