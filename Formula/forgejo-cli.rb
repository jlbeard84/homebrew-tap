class ForgejoCli < Formula
  desc "CLI tool for Forgejo"
  homepage "https://codeberg.org/forgejo-contrib/forgejo-cli"
  url "https://codeberg.org/forgejo-contrib/forgejo-cli/archive/v0.6.0.tar.gz"
  sha256 "8b91194cb1886f253261a4567ee6f83aa34b05a9637644793f88b40b7110322a"
  license any_of: ["Apache-2.0", "MIT"]

  depends_on "rust" => :build
  depends_on "openssl@3"

  def install
    ENV["OPENSSL_DIR"] = formula_opt_prefix("openssl@3")
    system "cargo", "install", *std_cargo_args(path: ".")

    generate_completions_from_executable(bin/"fj", "completion")
  end

  test do
    assert_match "fj v#{version}", shell_output("#{bin}/fj version")
    assert_match "issue", shell_output("#{bin}/fj issue --help")
  end
end
