 #!/usr/bin/env ruby

=begin
quite simple connect scanner in ruby
     
Shows open (reliable), close and filtered. But the reliablity
of the last two states depends of course on firewalling and the timeout
interval you can set down. Uncomment or comment states you want or don't
want to get printed on the screen.

*supports scanning mutiple hosts/IPs (like www.heise.de,www.gulli.com)
*supports multiple ports(like 12,45,53,165),ranges(like 20..85) or one single
port(like 80)
*support a ports file like http://insecure.org/nmap/data/nmap-services (just
clean it with | grep /tcp ..)

ZGlnaXRhbGJ5dGU=
=end

require 'socket'
require 'timeout'

  class Scanner

     def initialize
        @hosts,@ports = Array($*)
     end

     def portarrange
        case @ports
          when /^.+[..]/
             @ports = @ports.split("..")
             @ports = @ports[0].to_i..@ports[1].to_i
          when /^.+[,]/
             @ports = @ports.split(",")
          else
             @ports = Array(@ports)
          end
     end

     def hostarrange
        case @hosts
          when /^.+[,]/
             @hosts = @hosts.split(",")
          else
             @hosts = Array(@hosts)
          end
     end

    def output(state,port)
       printed = false
       portsfile = File.new("ports", "r")
       scanpat = "^.+ #{port}/tcp"
       begin
         portsfile.each_line do |line|
           if line =~ Regexp.new(scanpat)
             puts "#{state}    : #{line}"
             printed = true
           end
          end
          puts "#{state}    : #{port}" if printed == false
       ensure
       portsfile.close
       end
    end

    def scanning(hosts,ports)
      hosts.each do |host|
        begin
          puts "scanning #{host}:"
          ports.each do |port|
            begin
              Timeout::timeout(10){TCPSocket.new(host, port)}
            rescue Timeout::Error
              output("filtered",port)
            rescue
             # output("closed",port)
            else
              output("open",port)
            end
          end
        end
      end
    end
end

#####################  code  start  #####################

puts "no arguments past,correct usage:\nruby #{$0} [hosts] [ports]\n" if
!ARGV[1]

my_scanner = Scanner.new

hosts = my_scanner.hostarrange
ports = my_scanner.portarrange

my_scanner.scanning(hosts,ports)

#####################      eof      ##################### 