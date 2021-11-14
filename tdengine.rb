class Tdengine < Formula
  env :std
  desc "An open-source big data platform designed and optimized for the Internet of Things (IoT)."
  homepage "https://github.com/taosdata/TDengine"
  url "https://github.com/taosdata/TDengine/archive/refs/tags/ver-2.3.1.0.tar.gz"
  sha256 "20e7a52b81acd2bcd1aca671e9fbf8024917c862d0a1fd7fa3ae210d21b5d455"
  license "AGPL-3.0"

 depends_on "cmake" => :build
 
 def datadir
    var/"lib/taos"
 end
 
 def install
    system "cmake", ".",*std_cmake_args
    system "make"
    system "make", "install"
 end
 
 def post_install
    #fix link
    rm_rf HOMEBREW_PREFIX/"lib/libtaos.1.dylib"
    rm_rf HOMEBREW_PREFIX/"lib/libtaos.dylib"
    ln_sf prefix/"driver/libtaos.1.dylib", HOMEBREW_PREFIX/"lib/libtaos.1.dylib"
    ln_sf HOMEBREW_PREFIX/"lib/libtaos.1.dylib", HOMEBREW_PREFIX/"lib/libtaos.dylib"
 end
 
 plist_options :manual => "taosd"
 
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
       <string>#{opt_bin}/taosd</string>
       <string>--datadir=#{datadir}</string>
     </array>
     <key>RunAtLoad</key>
     <true/>
     <key>WorkingDirectory</key>
     <string>#{datadir}</string>
   </dict>
   </plist>
   EOS
   end
 end
