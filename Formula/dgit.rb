class Dgit < Formula
  desc "Decentralized Git powered by Tupelo"
  homepage "https://github.com/quorumcontrol/dgit"
  url "https://github.com/quorumcontrol/dgit/archive/v0.0.1-alpha.tar.gz"
  sha256 "3390a7026b432e962078ec0cf8da09479909e00d0c6d41f09789cc216a7ea93b"
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
