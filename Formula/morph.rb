class Morph < Formula
  desc "Behavioral version control for AI-assisted development"
  homepage "https://github.com/r/morph"
  version "0.48.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.48.0/morph-aarch64-apple-darwin.tar.gz"
      sha256 "3840db22e5c355b6ad1147cca9113d73ce8c5aacf4b2773b4d6380b9b09c0374"
    else
      odie "morph does not currently ship Intel macOS binaries; install from source via 'cargo install --path morph-cli && cargo install --path morph-mcp'."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.48.0/morph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "95c1be231b52ce42f954b3a345e69abd8fd825581ae931e0d09607e54ba1562f"
    else
      url "https://github.com/r/morph/releases/download/v0.48.0/morph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "82dc3cea0ed009083d3cc38f49812e2711eaa52370c12758783c49dad8521151"
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
