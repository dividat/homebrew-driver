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
    ENV["GOPATH"] = buildpath
    cd "src/dividat-driver" do
      system "dep", "ensure"
    end
    system "make"
    bin.install "bin/dividat-driver"
  end

end
