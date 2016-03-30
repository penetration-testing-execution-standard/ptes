#!/usr/bin/env ruby
# Koded by Rick Flores
require 'rainbow/ext/string'

puts "\nNSLookup (wordlist):".foreground(:yellow).bright
puts "============================="

def banner()
print """
Reverse DNS hostname lookup.
"""
end
banner()

 unless ARGV.length == 1
	puts "\nCorrect usage: #{$0} ips.txt\n".foreground(:yellow).bright
 exit
 end
   
   file = ARGV[0]                  # declare runtime arguments
   File.open(ARGV[0], "r") do |x|  # open file, read, and assign to x code block for iteration
       x.each_line do |y|          # call each_line method, & iterate thru file like an array
       
       z = y.chomp                 # strip /n from array
       zz = `nslookup #{z}`
       puts "#{zz}".foreground(:cyan).bright
   end
 end