#!/usr/bin/env ruby
require 'socket'; require 'rainbow/ext/string'

unless ARGV.length == 4
  puts "\n[FTP client/server username / password authentication verification by Rick Flores (@nanotechz9l)]".foreground(:cyan).bright
  puts "Missing arguments. Correct useage below:\n".foreground(:yellow).bright
  puts "#{$0} <FTP SERVER IP> <PORT> <USERNAME> <PASSWORD>".foreground(:yellow).bright
  puts "#{$0} 192.168.86.187 21 test test".foreground(:green).bright

exit
end

ip, port, user, pass = ARGV[0..3]

begin
    s = TCPSocket.new(ARGV[0],ARGV[1])   # Create socket, connect to server + ip
    print s.recv(2048)                   # Receive banner
    s.puts "USER " + ARGV[2] + "\r\n"    # Verify username
    print s.recv(1024)                   # Receive result
    print s.recv(1024)                   # Receive result
    s.puts "PASS " + ARGV[3] + "\r\n"    # Verify user password
    print s.recv(1024)                   # Receive result
    s.close                              # Close socket
end
