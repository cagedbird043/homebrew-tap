class Cxf < Formula
  desc "Codex / Claude provider pointer manager"
  homepage "https://github.com/cagedbird043/cxf"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-darwin-arm64"
      sha256 "a43df120776933e706d6948f029385e4328b0d5a3244288c765c4c563576bd88"
    end
    on_intel do
      odie "cxf currently publishes darwin arm64 binaries only"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-linux-amd64"
    sha256 "f67628da73882644f54001a94ac5ebd61c106eaa9b0c52aea21a13b839d71447"
  end

  resource "completion" do
    url "https://github.com/cagedbird043/cxf/releases/download/v0.1.1/_cxf"
    sha256 "a53c14b5eea01c638ae65aa1ae594f284b67105dde7fad7ce401c4c961d1c963"
  end

  def install
    bin.install Dir["cxf-*"].first => "cxf"
    (zsh_completion/"_cxf").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cxf --version")
  end
end
