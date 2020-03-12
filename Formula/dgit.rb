require 'yaml'

class Dgit < Formula
  dgit = YAML.load(File.read("#{__dir__}/dgit.yml"))

  desc "Decentralized Git powered by Tupelo"
  homepage "https://github.com/quorumcontrol/dgit"
  url dgit['url']
  sha256 dgit['sha256']
  head "https://github.com/quorumcontrol/dgit.git"

  depends_on "go" => :build

  def install
    (buildpath/"go/bin").mkpath
    ENV["GOPATH"] = "#{buildpath}/go"

    system "make", "install"

    bin.install "#{ENV["GOPATH"]}/bin/dgit"
    bin.install "#{ENV["GOPATH"]}/bin/git-remote-dgit"
  end

  test do
    system "#{bin}/dgit"
  end
end
