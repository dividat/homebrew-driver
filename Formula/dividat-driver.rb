class DividatDriver < Formula
  desc "Dividat Driver"
  homepage "https://dividat.com"
  url "https://github.com/dividat/driver.git", :tag => "2.1.0"
  head "https://github.com/dividat/driver.git", :branch => "develop"

  plist_options :manual => "dividat-driver"

  def plist; <<-EOS
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>ProgramArguments</key>
    <array>
      <string>#{opt_bin}/dividat-driver</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>#{var}/log/dividat-driver.log</string>
    <key>StandardOutPath</key>
    <string>#{var}/log/dividat-driver.log</string>
  </dict>
</plist>
EOS
  end

  depends_on "go" => :build
  depends_on "dep" => :build

  def install
    # TODO Revert to invoking make for driver 2.2.0 and up
    ENV["GOPATH"] = buildpath
    ENV["CC"] = "gcc"
    ENV["CXX"] = "g++"
    cd "src/dividat-driver" do
      system "dep", "ensure"
    end
    system "go", "build", "-ldflags", "-X dividat-driver/server.channel=master -X dividat-driver/server.version=2.1.0 -X dividat-driver/update.releaseUrl=https://dist.dividat.com/releases/driver2/", "-o", "bin/dividat-driver", "./src/dividat-driver/main.go"
    bin.install "bin/dividat-driver"
  end

end
