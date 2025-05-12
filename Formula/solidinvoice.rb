class Solidinvoice < Formula
  desc "Simple and elegant invoicing solution"
  homepage "https://solidinvoice.co"
  version "2.3.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/#{version}/solidinvoice-mac-x86_64"
      sha256  "0ad69bc4ec992e8ddeebc9d77c7e20ccf9d8493e571a6fc440fc29a17c336a91"
    end
    if Hardware::CPU.arm?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/#{version}/solidinvoice-mac-arm64"
      sha256  "fac7b0b89dcdb269aeceee08bd42ca8613ef6d93ef9bc519a2836896246b0b52"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/#{version}/solidinvoice-linux-aarch64"
      sha256  "6f6633251ecdd43470ea385cd264b3f1516ef55fc57273af4615300184273912"
    end
    if Hardware::CPU.arm?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/#{version}/solidinvoice-linux-arm64"
      sha256  "2c4d31de3b51d4439828f894401dc7c044be301a457229c59f98718e4a3b0a26"
    end
  end

  def install
    bin_file = Dir["solidinvoice*"].first
    raise "binary not found" unless bin_file

    bin.install bin_file => "solidinvoice"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/solidinvoice --version")
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test solidinvoice`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    # system "false"
  end
end
