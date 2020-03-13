require "yaml"

class Dgit < Formula

  dgit = YAML.safe_load(File.read(__FILE__).split("\n__END__\n", 2)[1])

  desc "Decentralized Git powered by Tupelo"
  homepage "https://github.com/quorumcontrol/dgit"
  url dgit["url"]
  sha256 dgit["sha256"]
  head "https://github.com/quorumcontrol/dgit.git"

  bottle do
    bottles = dgit["bottles"]
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

    system "make", "install"

    bin.install "#{ENV["GOPATH"]}/bin/dgit"
    bin.install "#{ENV["GOPATH"]}/bin/git-remote-dgit"
  end

  test do
    system "#{bin}/dgit"
  end
end

__END__
url: "https://api.github.com/repos/quorumcontrol/dgit/tarball/v0.0.2-alpha"
sha256: "3143f1824664c03efbfa11f7c6ea8a9de4d98919a019626feb76c3804be362b7"
bottles:
  root_url: "https://api.github.com/repos/quorumcontrol/dgit/releases/24511535/assets"
url: "https://api.github.com/repos/quorumcontrol/dgit/tarball/v0.0.2-alpha"
sha256: "18db56e1f13a9bd65128b7ed4ab4e1f567e377d7eb27415318fc5e9726283d1b"
bottles:
  root_url: "https://api.github.com/repos/quorumcontrol/dgit/releases/24512980/assets"
  sha256:
url: "https://api.github.com/repos/quorumcontrol/dgit/tarball/v0.0.2-alpha"
sha256: "3f9c0e6e2df05d61b2d97aef0a5e04e4538c39c35787354c7afa6ab9a3d379dc"
bottles:
  root_url: "https://api.github.com/repos/quorumcontrol/dgit/releases/24513180/assets"
  sha256:
