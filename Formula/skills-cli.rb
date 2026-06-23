class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.24"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "0c4bf7e28c03718b2a44fe39e06609c4a3d3aa78c2461850a7c37de3eadf5968"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-arm64"
      sha256 "4d0f96a2871660a9dbc171467a9a557fef573fc5dbc69d8ca15ebf4c4ec562b6"
    else
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
      sha256 "6954ba4e42fc78eec0d74f1a019eccc39c26ff8812aa58a7db4b0bb124475eff"
    end
  end

  ver = version
  resource "completion" do
    url "https://github.com/cagedbird043/skills/releases/download/v#{ver}/_skills"
    sha256 "910be8b3a692388a9c5aaa16ed097fabf0d9fc9e225a77c70c66f74a0cfa8839"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
    (zsh_completion/"_skills").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
