class Cxf < Formula
  desc "Codex / Claude provider pointer manager"
  homepage "https://github.com/cagedbird043/cxf"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-darwin-arm64"
      sha256 "30c5caedd85747689bdcc697fa9f1a6ba14dde9eb136af7e42ce75996cf08f0e"
    end
    on_intel do
      odie "cxf currently publishes darwin arm64 binaries only"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/cxf/releases/download/v#{version}/cxf-linux-amd64"
    sha256 "b6d4cf649740f196d221f7bea2d3a4f8652f3fbefa02c076ccc3cd6fae233a9f"
  end

  def install
    bin.install "cxf"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cxf --version")
  end
end
