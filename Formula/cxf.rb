class Cxf < Formula
  desc "Codex / Claude provider pointer manager"
  homepage "https://github.com/cagedbird043/cxf"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-darwin-arm64"
      sha256 "d94e9303bb764e48bfd682f5a92adba23e48325fe43087599224d40b12391161"
    end
    on_intel do
      odie "cxf currently publishes darwin arm64 binaries only"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-linux-amd64"
    sha256 "445630a42c7312528b639d9cbd296bafd0a7311055b1c5956779a0720c829909"
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
