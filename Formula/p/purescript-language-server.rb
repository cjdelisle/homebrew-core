class PurescriptLanguageServer < Formula
  desc "Language Server Protocol server for PureScript"
  homepage "https://github.com/nwolverson/purescript-language-server"
  url "https://registry.npmjs.org/purescript-language-server/-/purescript-language-server-0.18.3.tgz"
  sha256 "e290576084f4984cde3a37a87e2ab3484a5964603d260544396db77018b8887a"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "5524c9941890b58cd897c4df1025c749543a725f8632e9ea7b624b88c5b4daba"
  end

  depends_on "node"
  depends_on "purescript"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    require "open3"

    json = <<~JSON
      {
        "jsonrpc": "2.0",
        "id": 1,
        "method": "initialize",
        "params": {
          "rootUri": null,
          "capabilities": {}
        }
      }
    JSON

    Open3.popen3(bin/"purescript-language-server", "--stdio") do |stdin, stdout|
      stdin.write "Content-Length: #{json.size}\r\n\r\n#{json}"
      assert_match(/^Content-Length: \d+/i, stdout.readline)
    end
  end
end
