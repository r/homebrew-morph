class Morph < Formula
  desc "Behavioral version control for AI-assisted development"
  homepage "https://github.com/r/morph"
  version "0.37.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.37.7/morph-aarch64-apple-darwin.tar.gz"
      sha256 "4599bc7fc164acbc64b6c005f9bad17ba78552d3da99bcdbe05d5618b4822071"
    else
      odie "morph does not currently ship Intel macOS binaries; install from source via 'cargo install --path morph-cli && cargo install --path morph-mcp'."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.37.7/morph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f3fca60ada78cd6edb50a5045eeb8ac630aef6a6f0fd47208f6960cae648b903"
    else
      url "https://github.com/r/morph/releases/download/v0.37.7/morph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b5517c4087a1439f98ccf517629aab7642030be8a74075a4fcd9ae0d0586494"
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
