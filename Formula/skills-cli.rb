class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "29b65ecf9b7af58dba83a4cbf879f241448be9713e65ac069444f8b542e4bc12"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "8515deaeedc2e37952fe13d1b7c7b05d36f6af4859d18e9b42ba61f8bba145f5"
  end

  resource "completion" do
    url "https://github.com/cagedbird043/skills/releases/download/v0.5.4/_skills"
    sha256 "f0fa9be2b6e77b48a9ae7e6d062256d4c19cba26d35bb691f30c673d6b77018b"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
    (zsh_completion/"_skills").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
