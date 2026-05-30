class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "abb92bef84e09c73ae82916aeffcf066f4df1ba796c19b5bfad9c665693b3a32"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "b360f474470b9378582f76f71b22c16e3fa06b9a93dbcbb26a5b057f5ddfafa0"
  end

  resource "completion" do
    url "https://github.com/cagedbird043/skills/releases/download/v0.5.3/_skills"
    sha256 "PLACEHOLDER_COMPLETION_SHA"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
    (zsh_completion/"_skills").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
