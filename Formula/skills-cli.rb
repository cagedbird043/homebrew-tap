class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.18"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "50d4974bb2f4868fb7481ca40ece798fad6aeb16f92c6d26a8c2dea1e10f4aa9"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "eff7dead79c2d25ff7139ff2c11e054d9d95b839c951085e9f3864f556ac3789"
  end

  ver = version
  resource "completion" do
    url "https://github.com/cagedbird043/skills/releases/download/v#{ver}/_skills"
    sha256 "74be199980afe06e196b5898374c528af91458abe4ddb9ec00bd7e0167985ab9"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
    (zsh_completion/"_skills").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
