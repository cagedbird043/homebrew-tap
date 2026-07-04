class OmpZen < Formula
  desc "Downstream Oh My Pi distribution for resilient coding agents"
  homepage "https://github.com/cagedbird043/oh-my-pi"
  version "16.3.6-zen.1"
  license "MIT"

  on_macos do
    odie "omp-zen currently publishes Linux binaries only"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cagedbird043/oh-my-pi/releases/download/zen/v16.3.6-1/omp-zen-linux-arm64"
      sha256 "cb646af15b68b72de23610a6260207afc01bfc0f4e44a935e73917cf1a8f9ebe"
    else
      url "https://github.com/cagedbird043/oh-my-pi/releases/download/zen/v16.3.6-1/omp-zen-linux-x64"
      sha256 "9b9b6575f966ee47bfa5dab5f9d4919120702b79438f77785eefd133de71f638"
    end
  end

  conflicts_with "omp", because: "omp-zen installs the omp compatibility binary"

  def install
    binary = Dir["omp-zen-linux-*"].first
    bin.install binary => "omp"
    bin.install_symlink bin/"omp" => "omp-zen"
  end

  test do
    assert_match "16.3.6+zen.1", shell_output("#{bin}/omp --version")
    assert_match "16.3.6+zen.1", shell_output("#{bin}/omp-zen --version")
  end
end
