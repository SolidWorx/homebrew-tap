class Solidinvoice < Formula
  desc "Simple and elegant invoicing solution"
  homepage "https://solidinvoice.co"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/3.1.2/solidinvoice-mac-amd64"
      sha256  "69f9045691a0869215b636f54e1c0f1ec33b9bb58bef50168d2227eefe7e796b"
    end
    if Hardware::CPU.arm?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/3.1.2/solidinvoice-mac-arm64"
      sha256  "0e7d4b97b517a89d3762fc7ca0dae698d5b939fd91c7564cbf86bdd107a78f64"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/3.1.2/solidinvoice-linux-amd64"
      sha256  "8b3a395d9794455f0b364ea44343775a902c2e539924dde6a00e39fd85277925"
    end
    if Hardware::CPU.arm?
      url     "https://github.com/solidinvoice/solidinvoice/releases/download/3.1.2/solidinvoice-linux-arm64"
      sha256  "2369b913c103dd84840c5e015ee25bc09897c0f0f86766b4be93b99c9902b2d2"
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
