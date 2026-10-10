class Flowagent < Formula
  desc "Command-line client for the Flow Agent MCP server"
  homepage "https://github.com/murakamyadvisory/flowagent-cli"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.13.0/flowagent-cli-aarch64-apple-darwin.tar.xz"
      sha256 "aaeaa0f8d9dcb478366087dd8125b57de9d98b5dbe22a2e1f6b6fd768419603f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.13.0/flowagent-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e77983d31c65a19120b14dde1c00bbb081c5206e467d4f3cb6d913b1bb9f4bb6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.13.0/flowagent-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ed574918b01781e5f1a2ccb1e646596dd3ee01a9c5010dcfc8c9d017f972f71e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/murakamyadvisory/flowagent-cli/releases/download/cli/v0.13.0/flowagent-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f892ea58faa578c358491eedca2550fd413d6ad8457ec5b579b15efd35f12d06"
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
