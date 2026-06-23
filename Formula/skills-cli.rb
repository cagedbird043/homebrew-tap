class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.27"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "de60ff297a4a7de8a87ddc9d974994aaba0827062ec196075a57a23acda7d4fd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-arm64"
      sha256 "348d99e05fe0a86d48c5837a031f498ec23519a8210ed65e4251208e4d7d6aeb"
    else
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
      sha256 "c3f36143b72abc4a37134cbe5ff10c52e0930fa2d7ce5dcdb48e7e6a9cc0413b"
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
