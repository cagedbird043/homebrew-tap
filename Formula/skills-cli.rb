class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "1a4862c7dd621f922da3b83778e958f5acd5a90bf446077e1f5e9068e837b6f6"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "5888a721d89655e35f34d5bbdaa33b19908cea98e0300d368ce3bb695f9c21b0"
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
