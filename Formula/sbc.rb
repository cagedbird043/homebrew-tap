class Sbc < Formula
  desc "sing-box commander — 管理 sing-box 服务、配置、代理、面板"
  homepage "https://github.com/cagedbird043/sbc"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.2.0/sbc-darwin-arm64"
      sha256 "694c157871785cd6818c68fa06be55946c6eff22251d6227bac20713718efc92"
    end
    on_intel do
      odie "sbc: Intel Mac is not supported."
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.2.0/sbc-linux-arm64"
      sha256 "bcc7b88066f2af038c1cb3530e27f09d4b199d77910faad62d844a358498da5d"
    end
    on_intel do
      url "https://github.com/cagedbird043/sbc/releases/download/v0.2.0/sbc-linux-amd64"
      sha256 "d83ddf3887ddcd1278c86552a5e51757e07fb18bece3fb630d92424dbacacbed"
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
