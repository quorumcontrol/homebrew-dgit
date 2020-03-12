class Dgit < Formula
  desc "Decentralized Git powered by Tupelo"
  homepage "https://github.com/quorumcontrol/dgit"
  url "https://api.github.com/repos/quorumcontrol/dgit/tarball/v0.0.2-alpha"
  sha256 ""
  head "https://github.com/quorumcontrol/dgit.git"


  depends_on "go" => :build
  depends_on "make" => :build

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
