require "yaml"

class Dgit < Formula
  @@dgit = YAML.safe_load(File.read("#{__dir__}/dgit.yml"))

  def self.dgit
    @@dgit
  end

  desc "Decentralized Git powered by Tupelo"
  homepage "https://github.com/quorumcontrol/dgit"
  url dgit["url"]
  sha256 dgit["sha256"]
  head "https://github.com/quorumcontrol/dgit.git"

  klass = self
  bottle do
    bottles = klass.dgit["bottles"]
    root_url bottles["root_url"]
    bottle_shas = bottles["sha256"]
    if bottle_shas && bottle_shas.count > 0
      bottles["sha256"].each do |sha, platform|
        sha256 sha => platform.to_sym
      end
    end
  end

  depends_on "go" => :build

  def install
    (buildpath/"go/bin").mkpath
    ENV["GOPATH"] = "#{buildpath}/go"

    ENV["VERSION"] = self.class.dgit["version"]

    system "make", "install"

    bin.install "#{ENV["GOPATH"]}/bin/git-dg"
    bin.install "#{ENV["GOPATH"]}/bin/git-remote-dgit"

    ohai "dgit has been renamed decentragit and is now invoked via git with `git dg [command]`."
  end

  test do
    system "#{bin}/git-dg"
  end
end
