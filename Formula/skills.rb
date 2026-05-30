class Skills < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "23298d5dbe25417ed5bce179b408e9d122d127d06ae256a5dd59c45ea5ab3645"
    end
    on_intel do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-amd64"
      sha256 "55be0c55a1960ebe16651d1ee5b63d0c6361b58bedbb39c5a5411315e6c7ad14"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "29a7b7afcf6d6fec6800885c0a1fb90aae8b6b073f0cd408ffcc24efa2c509f8"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
