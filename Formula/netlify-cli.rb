require "language/node"

class NetlifyCli < Formula
  desc "Netlify command-line tool"
  homepage "https://www.netlify.com/docs/cli"
  url "https://registry.npmjs.org/netlify-cli/-/netlify-cli-2.19.3.tgz"
  sha256 "9b887add37a5493cbe5834946c1ba56c0e774e854e8fe4ee6508a6980bc54e1d"
  head "https://github.com/netlify/cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "dded02ed76c8be5f6713b68b722d83a0e9b3abbb62b5f1fbadde4cbf2827431b" => :catalina
    sha256 "7fe2d4ca2bc0af9f411ac8027ffb3b37cf328f885dfa6263d917799136a52a7a" => :mojave
    sha256 "76cd7ef2e16a4766e47768b1b7252720d1475f9f7f7d35a8cfdb99a1156bd857" => :high_sierra
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.exp").write <<~EOS
      spawn #{bin}/netlify login
      expect "Opening"
    EOS
    assert_match "Logging in", shell_output("expect -f test.exp")
  end
end
