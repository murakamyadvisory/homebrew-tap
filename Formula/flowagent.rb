class Flowagent < Formula
  desc "Command-line client for the Flow Agent MCP server"
  homepage "https://github.com/murakamyadvisory/flowagent-cli"
  version "0.25.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.25.1/flowagent-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8d3791ca0dd3dc38015fe5efa14d7a91b409a9a141f860f7804fc72babb5df02"
    end
    if Hardware::CPU.intel?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.25.1/flowagent-cli-x86_64-apple-darwin.tar.xz"
      sha256 "377667ad73945af54b2fe8bd40fd460692402b54e1b9a6ffd1fbce004a2eee30"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.25.1/flowagent-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "600f060ea8bcd1834b6e6317fc5d9ad80ec6204b5538d1094b9011401218dea9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.25.1/flowagent-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5e273be08ac45261449bf833504272039e5e16da16858f85b4d7d64f674b77ad"
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
