class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "eb2ec9694bd584f1eca852ff60fcc3927db7925c523bea205479f4b7e0904beb"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "022fefe67ed29d0a68d63fa22527ab7382025a0b58f6450238290258335ad5b8"
  end

  resource "completion" do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/_skills"
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
