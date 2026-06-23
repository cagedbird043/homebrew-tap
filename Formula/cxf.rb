class Cxf < Formula
  desc "Codex / Claude provider pointer manager"
  homepage "https://github.com/cagedbird043/cxf"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-darwin-arm64"
      sha256 "1e220139a9077f2d3db8f670c548787303af68b00899aed0fcebd194e3ed820a"
    end
    on_intel do
      odie "cxf currently publishes darwin arm64 binaries only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-linux-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-linux-amd64"
      sha256 "ff2f311555e1d6623e828694e4bac803478bc4b82bb905210d94efd8a6485858"
    end
  end

  resource "completion" do
    url "https://github.com/cagedbird043/cxf/releases/download/v0.1.1/_cxf"
    sha256 "25526002f26cae08e0ad46b065c442ae9e6dd14865e405359ecbb5c33cbaf893"
  end

  def install
    bin.install Dir["cxf-*"].first => "cxf"
    (zsh_completion/"_cxf").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cxf --version")
  end
end
