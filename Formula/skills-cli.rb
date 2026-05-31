class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "db3a1d526e70b13b442d1d6e8d8618979f11f312787b7c05de6a762fa9665130"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "37da548e081a70a4447fba129437cf6830b9685708d49dbbbf98f4188c03665c"
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
