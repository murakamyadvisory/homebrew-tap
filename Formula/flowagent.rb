class Flowagent < Formula
  desc "Command-line client for the Flow Agent MCP server"
  homepage "https://github.com/murakamyadvisory/flowagent-cli"
  version "0.23.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.23.0/flowagent-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f33fae17734f332b323c91ed61a4df5a01537b6502315eac46c559c95a32153a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.23.0/flowagent-cli-x86_64-apple-darwin.tar.xz"
      sha256 "51eb9d4db834a5f8a935d8b6e7ddddb5a57e1af7c6bc17ab69ab86e017f2df6d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.23.0/flowagent-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ef149fd793a7e165b3c079e0298d5ccaded6166561deed310e12b1d6cf0e814e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.23.0/flowagent-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "97822e0d551fd36e6f44bec040986efd71ec04f8d63c10ac6d60cb52adc54fc9"
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
