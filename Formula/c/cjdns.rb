class Cjdns < Formula
  desc "Advanced mesh routing system with cryptographic addressing"
  homepage "https://github.com/cjdelisle/cjdns/"
  url "https://github.com/cjdelisle/cjdns/archive/refs/tags/cjdns-v22.1.tar.gz"
  license all_of: ["GPL-3.0-or-later", "GPL-2.0-or-later", "BSD-3-Clause", "MIT"]
  head "https://github.com/cjdelisle/cjdns.git", branch: "master"

  depends_on "node" => :build
  depends_on "rust" => :build

  def install
    system "./do"
    bin.install "cjdroute"
    bin.install "cjdnstool"

    man1.install "doc/man/cjdroute.1"
    man5.install "doc/man/cjdroute.conf.5"
  end

  test do
    sample_conf = JSON.parse(shell_output("#{bin}/cjdroute --genconf"))
    assert_equal "NONE", sample_conf["admin"]["password"]

    help_output = shell_output("#{bin}/cjdnstool --help")
    assert_match "cexec", help_output
  end
end
