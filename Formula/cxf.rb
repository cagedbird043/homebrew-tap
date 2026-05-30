class Cxf < Formula
  desc "Codex / Claude provider pointer manager"
  homepage "https://github.com/cagedbird043/cxf"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-darwin-arm64"
      sha256 "82ca3f40c5749c34001555903b3d3f877efbd4c3b44de0cefa6bf5f4288b738d"
    end
    on_intel do
      odie "cxf currently publishes darwin arm64 binaries only"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-linux-amd64"
    sha256 "82ef25f44f338edbc2eacac92ea15e5301a39e27bb097e0b3f3e9261180a87c9"
  end

  resource "completion" do
    url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/_cxf"
    sha256 "PLACEHOLDER_CXF_COMPLETION_SHA"
  end

  def install
    bin.install Dir["cxf-*"].first => "cxf"
    (zsh_completion/"_cxf").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cxf --version")
  end
end
