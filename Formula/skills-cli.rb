class SkillsCli < Formula
  desc "Agent skill manager — manifest + lock + mirrors for multi-agent skill governance"
  homepage "https://github.com/cagedbird043/skills"
  version "0.5.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-arm64"
      sha256 "abb92bef84e09c73ae82916aeffcf066f4df1ba796c19b5bfad9c665693b3a32"
    end
    on_intel do
      url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-darwin-amd64"
      sha256 "019356b1fa469e9a385e92b8e7bdd161c7510b1c895093f721b74ef0a46f35dd"
    end
  end

  on_linux do
    url "https://github.com/cagedbird043/skills/releases/download/v#{version}/skills-linux-amd64"
    sha256 "b360f474470b9378582f76f71b22c16e3fa06b9a93dbcbb26a5b057f5ddfafa0"
  end

  def install
    bin.install Dir["skills-*"].first => "skills"
    (zsh_completion/"_skills").write <<~ZSH
      #compdef skills

      _skills() {
        local -a cmds
        cmds=(
          'list:list all skills with status'
          'install:install from lock (fast, no remote check)'
          'update:audit and update skills'
          'remove:remove a skill from manifest and disk'
          'verify:(deprecated) use skills update --dry-run'
          'info:show skill details'
          'completion:generate shell completion'
        )
        _describe -t commands 'skills command' cmds

        case "$words[2]" in
          update)
            _alternative \\
              'args::(--dry-run -n --yes -y)'
            ;;
          remove)
            _alternative \\
              'args::(--dry-run -n --keep-manifest -k)'
            ;;
        esac
      }

      _skills "$@"
    ZSH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skills --version")
  end
end
