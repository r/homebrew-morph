class Morph < Formula
  desc "Behavioral version control for AI-assisted development"
  homepage "https://github.com/r/morph"
  version "0.37.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.37.0/morph-aarch64-apple-darwin.tar.gz"
      sha256 "bd2672fb0c9c65cbe1fee88110aef9e2fa161e7b7834674d525d201509771a50"
    else
      odie "morph does not currently ship Intel macOS binaries; install from source via 'cargo install --path morph-cli && cargo install --path morph-mcp'."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/r/morph/releases/download/v0.37.0/morph-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "72e825f3b1d9d3d4986e49a5c8cd21456fa6bce44dc652681c9ae30aa309cec4"
    else
      url "https://github.com/r/morph/releases/download/v0.37.0/morph-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8d93a34ad95acea6f4b67314d7f6daf8121a7fa9d540f0ed0c27f8001220ba90"
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

    json = shell_output("#{bin}/morph version --json")
    assert_match version.to_s, json
    assert_match "supported_repo_versions", json
  end
end
