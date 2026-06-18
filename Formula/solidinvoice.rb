class Solidinvoice < Formula
  desc "Simple and elegant invoicing solution"
  homepage "https://solidinvoice.co"
  version "3.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/#{version}/solidinvoice-mac-amd64"
      sha256  "7b1cc8b1c49d65074a69ba09ce3ec426ae451148f987b372ae988fee912ec0c8"
    end
    if Hardware::CPU.arm?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/#{version}/solidinvoice-mac-arm64"
      sha256  "ab093d0530549c6b1adfd685231534158853bd7aa9d50aaf69267e621cdc1b68"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/#{version}/solidinvoice-linux-amd64"
      sha256  "c6d5d195e54d3dc2208ff439ed728e97cc21912cda9f94cacf3f3ad465a7ceff"
    end
    if Hardware::CPU.arm?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/#{version}/solidinvoice-linux-arm64"
      sha256  "944635f03de5b38592c157e6dd1b07f1109d8899ea9f2d758c834a898250c57a"
    end
  end

  def install
    bin_file = Dir["solidinvoice*"].first
    raise "binary not found" unless bin_file

    bin.install bin_file => "solidinvoice"
  end

  service do
    run [opt_bin/"solidinvoice", "run"]
    keep_alive true
    log_path var/"log/solidinvoice.log"
    error_log_path var/"log/solidinvoice.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/solidinvoice version")
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
