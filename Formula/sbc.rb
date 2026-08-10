class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.5.0/sbc-darwin-arm64"
      sha256 "62aa2c29acfa849957985ea7bbfa98fe6574be42f56b15026102225d7cec4bd9"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.5.0/sbc-linux-arm64"
      sha256 "be2ccde6c3d38a1dced75bae6a9ef9c84f8346faa057b320dccc42f81f09fcd5"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.5.0/sbc-linux-amd64"
      sha256 "d4d03d6157b19ea54389d1f90d2bc96152f97261df502e77f72bc0f55e243ffc"
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
