class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.30"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "0a291c65c615261eb02fe50226114910e0585fad24b89408f7460851cadeec8c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-arm64"
      sha256 "72c3079b3fc0ac8dfa4e31067cede438878c4d185c8c518dbb111ba331524f73"
    else
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
      sha256 "ac02e54db85098742d4cfadc2bf8fb255912bde18f4ac6b6216fe26b8da3c4b5"
    end
  end

  ver = version
  resource "completion" do
    url "https://github.com/cagedbird043/skills/releases/download/v#{ver}/_skills"
    sha256 "372cf122613172618d2be7a2b9e0cd82292dea7dc62c79c2fec7afc37947e8e9"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
    (zsh_completion/"_skills").write resource("completion").cached_download.read
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
