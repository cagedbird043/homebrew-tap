class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "8b5c1c21f8bb30a296dbb9c34a7d38b365e2f77638a0195a398c485a5a43e249"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "7e4607f25113e0a53591c463f55d926352a91a5d45c74033d8ba113d471bee86"
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
