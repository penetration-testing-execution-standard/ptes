#!/usr/bin/env ruby
require 'rainbow'

#### Welcome to the Penetration Testing Execution Standard (PTES) Automation Framework! Written by Rick Flores (nanotechz9l)
# Where the goal is to help automate certain phases of a pen test...

# Set the explicit absoulte path & lib directory.
APP_ROOT = File.dirname(__FILE__) 

### The following methods will work to set the absolute path.
# require "#{APP_ROOT}/lib/flow"  # Require flow from the declared absoulte path...
# require File.join(APP_ROOT, 'lib', 'flow.rb')
# require File.join(APP_ROOT, 'lib', 'flow')

### An even better way to do it is with $: which works alot like (__FILE__)
# $: contains an array of all the folders that ruby will look in to load the files weve asked for 
# Versus giving it an absoulte path like above. We can also explicitly tell ruby where to look.

# Unshift = appends to the beginning:::
$:.unshift( File.join(APP_ROOT, 'lib') ) # The lib folder is where I want you to look...
require 'flow'

flow = Flow.new('pentest.txt')
flow.launch!
