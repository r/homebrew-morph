class Morph < Formula
  desc "Behavioral version control for AI-assisted development"
  homepage "https://github.com/r/morph"
  version "0.48.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.48.3/morph-aarch64-apple-darwin.tar.gz"
      sha256 "136bb914e471728a17ba2101a296bed3f259fb52bf1ceaae53da0a980b7b5f6d"
    else
      odie "morph does not currently ship Intel macOS binaries; install from source via 'cargo install --path morph-cli && cargo install --path morph-mcp'."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.48.3/morph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "df8a6066d0295e51cea484cede403b2029b1fe4cafd26be6ad49695f99ff1b52"
    else
      url "https://github.com/r/morph/releases/download/v0.48.3/morph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "009ea6719da6f4d6b2d704f6173bc4fd8b807e6f65694c026b6a686c6406c46c"
    end
  end

  head "https://github.com/r/morph.git", branch: "main"

  def install
    bin.install "morph", "morph-mcp"
  end

  test do
    version_line = shell_output("#{bin}/morph --version")
    assert_match "morph #{version}", version_line
    assert_match "morph-mcp #{version}",
      shell_output("#{bin}/morph-mcp --version")

    # `morph version --json` is a documented contract
    # exercised by the upstream release pipeline. If this
    # round-trips on the user's machine the tarball was
    # not corrupted in transit.
    json = shell_output("#{bin}/morph version --json")
    assert_match version.to_s, json
    assert_match "supported_repo_versions", json
  end
end
