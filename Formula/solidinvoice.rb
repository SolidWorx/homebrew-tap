class Solidinvoice < Formula
  desc "Simple and elegant invoicing solution"
  homepage "https://solidinvoice.co"
  version "3.0.0"
  license "MIT"

  bottle do
    root_url "https://github.com/SolidWorx/homebrew-tap/releases/download/solidinvoice-3.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c74ef7dd5554f436108de0cd9ed40c1c8fe5dc220c0e1307fc3619f80d221896"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3fa9e0e201ad82df0749f7b784d9cdacf6f14c3ebe9f354ba794ec3cb765c645"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f16de38e47011bf78240c044a1074f289927a49d311dff5bec90f6c7c14d9de6"
    sha256 cellar: :any_skip_relocation, tahoe:         "069d2b0be5d83bb13d12b4c9a49a992e77359f73dd22c79080e800ac466f3ad7"
    sha256 cellar: :any_skip_relocation, sequoia:       "e3654e44bb49ec964f6796c7153228a6074d6b7eef0c0b749ee9bd618f1610bf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "12a91da1d88fc4819c5b483ca4fc37152c35f345b32ebb1eda228353c080823c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8696d856fc915f38f56e96c9547670fe5d68e58864819b5bde5d16e6bc2daa06"
  end

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
