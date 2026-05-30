class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "fe63408723c1b0047858f442d6cf64c4672255a8dc9be8a8f80dc37cd5d951d7"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "5bb4592d6d18bd8ab24568abbd41acb673d9ead47e56c1e7ff5adb5cdaf4d97a"
  end

  resource "completion" do
    url "https://github.com/cagedbird043/skills/releases/download/v0.5.3/_skills"
    sha256 "490254635f729449ada238dfbd9a7179c0b192baa3023862be5b2c426b40cc8f"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
    (zsh_completion/"_skills").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
