# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Tdengine < Formula
  desc "An open-source big data platform designed and optimized for the Internet of Things (IoT)."
  homepage "https://github.com/taosdata/TDengine"
  url "https://raw.githubusercontent.com/hyy1223/homebrew-tdengine/main/TDengine-2.2.0.0.tar.gz"
  sha256 "e76be497ea4e62e1efc5e29236477e463f685e7fceac4936a3b604975ea0d1e3"
  license "AGPL-3.0"

 depends_on "cmake" => :build

 def install
     system "cmake",".",*std_cmake_args
     system "cmake","--build","."
     system "make"
     system "make","install"
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
       <string>${bin_link_dir}/taosd</string>
     </array>
     <key>RunAtLoad</key>
     <true/>
     <key>WorkingDirectory</key>
     <string>$(data_dir)</string>
   </dict>
   </plist>
   EOS
   end
 end
