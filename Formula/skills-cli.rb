class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.21"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "30320fc30ec0fd4268abf86d09e33250d9f6d72fbe9df04e2bf2814095553f87"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
      sha256 "282b0b2ef42d08eaa81d4e740a01119f40ff8867307aa755807385985380abe6"
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
