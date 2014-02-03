#!/usr/bin/env ruby
require 'socket'; require 'timeout'; require 'net/ping' #require 'ping' <- old

iprange = Range.new(200,254)
iprange.each {|x|
              address = "192.168.15.#{x}"
              if Ping.ping(address) then puts "Reply from #{address}"
               else puts "#{address} timed out" 
             end
             }