class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "10224e5d66b4e24ceeb82a45d82ffd74bb5e375718d8119c1111789c14856815"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "36bb22f51c39df75bb7a251e730c454a0065acfd02a7588d781a1f3506a7c148"
  end

  ver = version
  resource "completion" do
    url "https://github.com/cagedbird043/skills/releases/download/v#{ver}/_skills"
    sha256 "b9ebe21d327fd80b5334fd3cc3625df95da7ab85e949afcd63b0e5dcf194aef7"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
    (zsh_completion/"_skills").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
