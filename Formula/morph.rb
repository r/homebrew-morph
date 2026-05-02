class Morph < Formula
  desc "Behavioral version control for AI-assisted development"
  homepage "https://github.com/r/morph"
  version "0.48.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.48.1/morph-aarch64-apple-darwin.tar.gz"
      sha256 "430248faede19b563f1ffb1826363591cc00f52acb37f34e5d5dd99810f7d664"
    else
      odie "morph does not currently ship Intel macOS binaries; install from source via 'cargo install --path morph-cli && cargo install --path morph-mcp'."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.48.1/morph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "692df9c17f3110ea8787032136a1df2b48179d7a6f0373d96eebdca05945b05d"
    else
      url "https://github.com/r/morph/releases/download/v0.48.1/morph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e38dcc954627513e1e6d1ec2de6b1878bfcf77e7147db134af73b7db0ba386fb"
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
