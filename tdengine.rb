# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Tdengine < Formula
  desc "An open-source big data platform designed and optimized for the Internet of Things (IoT)."
  homepage "https://github.com/taosdata/TDengine"
  url "https://raw.githubusercontent.com/hyy1223/homebrew-tdengine/main/TDengine-2.2.0.0.tar.gz"
  sha256 "065ce90541307dd93f33d2b7104a83aa87b6b3cee7b6df1d6ee27736223764ad"
  license "AGPL-3.0"

 depends_on "cmake" => :build
 uses_from_macos "curl"
 uses_from_macos "cyrus-sasl"
 uses_from_macos "libedit"
 uses_from_macos "zlib"
 def install
     system "cmake",".",*std_cmake_args
     system "cmake","--build","."
     system "make"
     system "make","install"
     #system "./makelink.sh"
end
 
 plist_options :manual => "tdengine start"
 
 def plist; <<~EOS
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
     <key>KeepAlive</key>
     <true/>
     <key>Label</key>
     <string>#{plist_name}</string>
     <key>ProgramArguments</key>
     <array>
       <string>/usr/local/cellar/tdengine/2.2.0.0/bin/taosd</string>
     </array>
     <key>RunAtLoad</key>
     <true/>
     <key>WorkingDirectory</key>
     <string>/usr/local/cellar/tdengine/2.2.0.0/data</string>
   </dict>
   </plist>
   EOS
   end
 end
