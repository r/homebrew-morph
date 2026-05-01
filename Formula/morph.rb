class Morph < Formula
  desc "Behavioral version control for AI-assisted development"
  homepage "https://github.com/r/morph"
  version "0.39.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.39.2/morph-aarch64-apple-darwin.tar.gz"
      sha256 "f42dc02f215efcd56aded4ecdb3e294a1aafc7b6c96f5d80dfb10034163fcf70"
    else
      odie "morph does not currently ship Intel macOS binaries; install from source via 'cargo install --path morph-cli && cargo install --path morph-mcp'."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.39.2/morph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ad5ca81d37d4dd1a161d3923adeefbf8fbda3fe7aaa037b8bd237e6ca8883658"
    else
      url "https://github.com/r/morph/releases/download/v0.39.2/morph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "00e1f60333a61e903c854c26704907dea5c61abf7d1b87e67d5a1c45295634a8"
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
