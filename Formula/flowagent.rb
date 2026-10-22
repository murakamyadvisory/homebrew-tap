class Flowagent < Formula
  desc "Command-line client for the Flow Agent MCP server"
  homepage "https://github.com/murakamyadvisory/flowagent-cli"
  version "0.25.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.25.0/flowagent-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e002fb24eeaa4eb9722d85861ce50544037a2ab41ee5ac16572b4037069c0cf0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.25.0/flowagent-cli-x86_64-apple-darwin.tar.xz"
      sha256 "de433f20408485779af4654387f9c585210d51269d43d8a04abd39b6fa44054c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.25.0/flowagent-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3a8cb65620447383955e4d30ff54afb95b3ec34a49e88b4325d57b10fd03e90f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.25.0/flowagent-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ac3b1ea7b9dce44d9589b967d157071f0cc0cc5675a98ac0b84a0e9ba6615f65"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-pc-windows-gnu":             {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "flowagent"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "flowagent"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "flowagent"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "flowagent"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
