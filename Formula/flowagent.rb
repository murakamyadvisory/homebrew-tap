class Flowagent < Formula
  desc "Command-line client for the Flow Agent MCP server"
  homepage "https://github.com/murakamyadvisory/flowagent-cli"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.14.0/flowagent-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ee3feb8e8a9181a31d7a1ce8eeb8f8b1a38703003066e64b94490cbe193a53bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.14.0/flowagent-cli-x86_64-apple-darwin.tar.xz"
      sha256 "714cd727b699bcc1dedcb5b6d05bf4a13abb21f9017e746201fbc0b322b34e5b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.14.0/flowagent-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "21b4d053cf09d5f09623d5ddf606cb32c829288bb046b0a01c03c679d4dd03cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.14.0/flowagent-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "457d4e53ea6c8bf37520c4e920e88ab75ea87117907025b4f548a65a595a43b6"
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
