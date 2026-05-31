class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.0/sbc-darwin-arm64"
      sha256 "cfd83099ba4b2263f3e35d6ac2e2d0704ea196c7259bf2e77cde70f7533b7277"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.0/sbc-linux-arm64"
      sha256 "d83ea339fc8539f994e56673dd6c81344b586cc8900e812b1a56f366cd75e5cd"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.3.0/sbc-linux-amd64"
      sha256 "cd494734e156dc83c6605c51f7bd5a949f88ba8c88c29346704ca7e292c354bf"
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
