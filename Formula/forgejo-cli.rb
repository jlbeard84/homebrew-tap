class ForgejoCli < Formula
  desc "CLI tool for Forgejo"
  homepage "https://codeberg.org/forgejo-contrib/forgejo-cli"
  url "https://codeberg.org/forgejo-contrib/forgejo-cli/archive/v0.6.0.tar.gz"
  sha256 "8b91194cb1886f253261a4567ee6f83aa34b05a9637644793f88b40b7110322a"
  license any_of: ["Apache-2.0", "MIT"]
  revision 1

  bottle do
    root_url "https://github.com/jlbeard84/homebrew-tap/releases/download/forgejo-cli-0.6.0_1"
    sha256 cellar: :any, arm64_tahoe:  "dfbecbf67fe6a2a85afb6fb96f0f96adbfb5a8be28b0ed2282303e891752e94e"
    sha256 cellar: :any, x86_64_linux: "78f944920f2b6ee3aa7458275600fe3aebc57178d92555f766fb80d9aec82bd4"
  end

  depends_on "rust" => :build
  depends_on "openssl@3"
  depends_on "zlib"

  def install
    ENV["OPENSSL_DIR"] = formula_opt_prefix("openssl@3")
    ENV["ZLIB_ROOT"] = formula_opt_prefix("zlib")
    system "cargo", "install", *std_cargo_args(path: ".")

    generate_completions_from_executable(bin/"fj", "completion")
  end

  test do
    assert_match "fj v#{version}", shell_output("#{bin}/fj version")
    assert_match "issue", shell_output("#{bin}/fj issue --help")
  end
end
