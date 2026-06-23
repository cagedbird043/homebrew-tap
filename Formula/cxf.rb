class Cxf < Formula
  desc "Codex / Claude provider pointer manager"
  homepage "https://github.com/cagedbird043/cxf"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-darwin-arm64"
      sha256 "df0127f7e93b7d786e1789e18d9438f5d44bc7c36d8cc06c7d7e36ba7039ab3c"
    end
    on_intel do
      odie "cxf currently publishes darwin arm64 binaries only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-linux-arm64"
      sha256 "0abc73b736d70ab3d48cab0c5def1c84c1e6d4ed5474b964a08dc4f01ca82a6f"
    else
      url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-linux-amd64"
      sha256 "670c3cf733298470ed406234e1605f6936d023e771529f1bf87fcb95eb56f421"
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
