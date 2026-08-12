class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.29"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "b8604e41950855ec00c9b1464da8aa45ce4f2e024a8940b6290f9f017d13daf0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-arm64"
      sha256 "3ec5e865dc4493dd296806714ac2bf1f504a4e24cede38231555247f079286b7"
    else
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
      sha256 "7a7ed77be61922312abab514ea4b3caed901363747f3c023c74061a0afda48e6"
    end
  end

  ver = version
  resource "completion" do
    url "https://github.com/cagedbird043/skills/releases/download/v#{ver}/_skills"
    sha256 "83e79a2d1b3e511cd1f2fc5bf74fcc59ebece400db45866501bf08cbfc72d861"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
    (zsh_completion/"_skills").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
