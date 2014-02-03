Welcome to the Penetration Testing Execution Standard (PTES) Automation Framework by Rick Flores. 
=================================================================================================
This is an interactive application that can be used as a quick reference, & help automate certain phases of an engagement & align it to the PTES methodology (database support coming soon if I have time).

![Screenshot](http://img62.imageshack.us/img62/8607/cnij.png)

## Pre Reqs

You *MUST install the rainbow gem for the pretty colorized output seen above:

	gem install rainbow
	
	require 'rainbow'

## Usage
	./ptes.rb
	

## Features
* Shell / Commandline (CLI) application allowing:
	* The creation/tracking of new engagements via flat-file (.txt). Database support coming soon (time permits).
        * Helps automate certain phases of the PTES methodology.
	* Can be used as a local reference for PTES. Most information is stored locally in the application.
	* Pre-engagement Interactions
	* Intelligence Gathering
	* Threat Modeling
	* Vulnerability Analysis
	* Exploitation
	* Post Exploitation
	* Reporting

## Requirements
* Tested on ruby version/s:
	* ruby 2.0.0p0 (2013-02-24 revision 39474)
	
	* ruby 1.9.3

## History
* 09/25/2013 - Simple code updates
* 09/25/2013 - Updated README.md 

## To Do
* Update Pre-engagement Interactions phase (validate IP ranges, and domains / integrated whois).
* Update the adding/listing engagements process (make it prettier).
* Possible Rails UI in the future.
* Automate repetitive aspects of the Intelligence Gathering phase via OSINT (External/Active footprinting, Internal footprinting/Passive Recon)!
* Automate repetitive aspects of the Threat Modeling phase!
* Automate repetitive aspects of the Vulnerability Analysis phase!
* Automate repetitive aspects of the Exploitation phase!
* Automate repetitive aspects of the Post Exploitation phase!
* Automate the entire reporting process of the Reporting phase (Rails application upgrade)!
* Export Pen Test report to the following file formats: word, xml, and pdf.

## Credits
* Rick Flores (nanotechz9l) -- 0xnanoquetz9l[--at--]gmail.com

## License
This code is free software; you can redistribute it and/or modify it under the
terms of the new BSD License.
