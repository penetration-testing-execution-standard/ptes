#!/usr/bin/env ruby
require 'rainbow/ext/string';require "socket"

TwoOctets = "00.00"

def computer_exists?(computerip)
 system("ping -c 1 -W 1 #{computerip}")
end

def append_to_file(line)
 file   = File.open("output.txt", "a")
 file.puts(line)
 file.close
end


def getInfo(current_ip)
 begin
   if computer_exists?(current_ip)
     arp_output = `arp -v #{current_ip}`
     mac_addr = arp_output.to_s.match(/..:..:..:..:..:../)
     #host_name = Socket.gethostbyname(current_ip)
     #1 host_name = Socket.getaddrinfo(current_ip, 0, Socket::AF_UNSPEC, Socket::SOCK_STREAM, nil, Socket::AI_CANONNAME)[0][1]
     #1 append_to_file("#{host_name[0]} - #{current_ip} - #{mac_addr}\n")
     host_name = Socket.getaddrinfo(current_ip,nil)
     append_to_file("#{host_name[0][2]} - #{current_ip} - #{mac_addr}\n")
   end
 rescue SocketError => mySocketError
   append_to_file("unknown - #{current_ip} - #{mac_addr}")
 end
end


(000..000).each do |i|
 case i
   when 8
     for j in (1..10)
       current_ip = "#{TwoOctets}.#{i}.#{j}"
       getInfo(current_ip)
     end
   when 9
     for j in (1..10)
       current_ip = "#{TwoOctets}.#{i}.#{j}"
       getInfo(current_ip)
     end
   when 10
     for j in (1..10)
       current_ip = "#{TwoOctets}.#{i}.#{j}"
       getInfo(current_ip)
     end
    when 11
     for j in (1..10)
       current_ip = "#{TwoOctets}.#{i}.#{j}"
       getInfo(current_ip)
     end
    when 12
     for j in (1..10)
       current_ip = "#{TwoOctets}.#{i}.#{j}"
       getInfo(current_ip)
     end
    when 13
     for j in (1..10)
       current_ip = "#{TwoOctets}.#{i}.#{j}"
       getInfo(current_ip)
     end
    when 14
     for j in (1..10)
       current_ip = "#{TwoOctets}.#{i}.#{j}"
       getInfo(current_ip)
     end
    when 15
     for j in (1..10)
       current_ip = "#{TwoOctets}.#{i}.#{j}"
       getInfo(current_ip)
     end
 end
end