#!/usr/bin/env ruby
require 'rainbow/ext/string'

 ## Coded by Rick Flores for the PTES framework
 #
 #
 unless ARGV.length == 1
 puts "\nMissing argument!".foreground(:red).bright
 puts "\nUsage: ".foreground(:white).bright + "#{$0} 74.125.224".foreground(:white).bright.blink
 puts "\nI perform rdns searches on a given range.".foreground(:yellow).bright
 puts "Only enter range up to the 3rd octet with no period after! (0..255 hardcoded into script).".foreground(:yellow).bright
 #puts "To start enter the range below. Example: 74.125.224".foreground(:yellow).bright
 #prompt  = "\nTarget range:~$ ".foreground(:cyan).bright
 exit
end

 #print prompt
 #range  = STDIN.gets.chomp()
 range   = ARGV[0]

 puts "\nReverse lookup brute force:".foreground(:yellow).bright
 puts "============================="

        #full_host = `dig +short #{range}` # returns 64.79.129.102
	#slash = full_host.chop.chop.chop.chop.chop # removes the 4th octet plus trailing period + needs refactoring!!
	#for ip in (0..255) do system 'dig +short -x' << " #{slash}.#{ip}" # (+short) Provide a short answer. The default is to print the answer in a verbose form.
	for ip in (0..255) do system 'host ' << " #{range}.#{ip} "
	#puts "#{range}.#{ip}"
end
