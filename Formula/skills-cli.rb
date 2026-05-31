class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "3ed4320eedac4953eaf6a33f1a3a74621ad9f400ffa2234ad71647cde73101c7"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "4874ec55467511b7a19f35a336aee61fa891f730243bcb0f827a8cd167f463e8"
  end

  resource "completion" do
    url "https://github.com/cagedbird043/skills/releases/download/v0.5.4/_skills"
    sha256 "0230c2df2959e1a23932a3b85d09457d2cdd547da0db8625f4a07dca1bdaf7bb"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
    (zsh_completion/"_skills").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
