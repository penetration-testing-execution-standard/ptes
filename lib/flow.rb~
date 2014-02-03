require 'phases'
class Flow
  class Config
    @@actions = [ 'a', 'l', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'x', 'quit', 'exit' ]
    def self.actions; @@actions; end # Reader method that will read the actions above
  end

#### Automated Penetration Testing Toolkit written by Rick Flores (nanotechz9l)
  
=begin
The initialize path below is nil because I dont want to hardcode the pentest file location. 
To make Flow class more reusable, and flexible in the future we can pass in the 
path location as an ARGV. That will allow us to use numerous pentest files 
for multiple different engagements at some point. Of-course once I implement database 
support this will go away, or I might still keep it as an option for users wishing to use non 
database support and just write to a flat-file.

=end
	def initialize(path=nil)
	# locate the pentest text file at path
	Phases.filepath = path
	if Phases.file_usable?
	  puts "Using existing engagements file."
	 
# Banner
	def banner()
 print """
@@@@@@@   @@@@@@@  @@@@@@@@   @@@@@@   
@@@@@@@@  @@@@@@@  @@@@@@@@  @@@@@@@   
@@!  @@@    @@!    @@!       !@@       
!@!  @!@    !@!    !@!       !@!       
@!@@!@!     @!!    @!!!:!    !!@@!!    
!!@!!!      !!!    !!!!!:     !!@!!!   
!!:         !!:    !!:            !:!  
:!:         :!:    :!:           !:!   
 ::          ::     :: ::::  :::: ::   
 :           :     : :: ::   :: : :   

[ptes v0.0.1, Rick Flores (@nanotechz9l)]
\n""".foreground(:blue).bright 
end
banner()

		
	# or create a new file if one does not exist
	elsif Phases.create_file
	  puts "Created new engagements file."

	# exit if create fails ... permission issue maybe?
	else
	  puts "Exiting.\n\n"
	  exit!
     end
end

	def launch!
	introduction
	# action loop // ask for user input
	result = nil
	until result == :quit
	    action = get_action         # Input validation stage
	    result = do_action(action)  # Validation passed, run the command
	end
	conclusion
    end
	
def get_action
  
	action = nil # Initialize with default value
	# Keeps asking for user unput until a valid command/action is given!
	# Inside a loop to enforce imput validations on commands that are being accepted when ran.
	until Flow::Config.actions.include?(action) # Does it inclde the valid action above? If so return it below!
		puts "\nInvalid selection! Available options are: ".foreground(:blue).bright.blink << Flow::Config.actions.join(", ") if action
		puts "\nStep 1: If this is a new engagement start with 'a' below to create a new engagement.".foreground(:blue).bright
		puts "Step 2: List engagements using 'l'.".foreground(:blue).bright
		puts "Step 3: Select which PTES phase you would like to start with?\n".foreground(:blue).bright
		puts "A".foreground(:red).bright << ")" << " Add".foreground(:green).bright << " a new engagement to flatfile (database/web UI coming soon (time permits)"
		puts "L".foreground(:red).bright << ")" << " List".foreground(:green).bright << " engagements"
		puts "1".foreground(:red).bright << ") Pre-engagement Interactions"
		puts "2".foreground(:red).bright << ") Intelligence Gathering"
		puts "3".foreground(:red).bright << ") Threat Modeling"
		puts "4".foreground(:red).bright << ") Vulnerability Analysis"
		puts "5".foreground(:red).bright << ") Exploitation"
		puts "6".foreground(:red).bright << ") Post Exploitation"
		puts "7".foreground(:red).bright << ") Reporting"
		puts "8".foreground(:red).bright << ") PTES Technical Guidelines"
		puts "9".foreground(:red).bright << ") Additional methodologies planned for future release (OWASP, WAHH 2nd ed.)"
		puts "\nX".foreground(:red).bright << ") Exit PTES Framework"
		print "ptes".foreground(:red).bright.underline() <<"> "
	user_response = gets.chomp # .chomp drops the line return from user input "\n"
	action = user_response.downcase.strip # strip white space
	end
	return action # If the action is valid, it gets received, downcased, stripped, and returned here!
end

def do_action(action)
	case action
	when 'a'
	  add
	when 'l'
	  list
	when '1'
	  pre
	when '2'
				puts "\nStarting Intelligence Gathering phase...\n"
	when '3'
				puts "\nStarting Threat Modeling phase...\n"
	when '4'
				puts "\nStarting Vulnerability Analysis phase...\n"
	when '5'
				puts "\nStarting Exploitation phase...\n"
	when '6'
				puts "\nStarting Post Exploitation phase...\n"
	when '7'
				puts "\nStarting Reporting phase...\n"
	when '8'
				puts "\nLooking Up Technical Guidelines documentation/reference...\n"
	when '9'
				puts "\nThis is a planned new feature that has not been developed yet...\n\n"
	when 'x'
		return :quit
				puts "Quitting Application..."
	when 'quit'
		return :quit
				puts "Quitting Application..."
	when 'exit'
		return :quit
				puts "Quitting Application..."
	#else 
				#puts "[!] That command is not available.".foreground(:yellow).bright
    end
end

def list
  output_action_header("Listing Engagements")
  engagements = Phases.saved_phases
  output_engagement_table(engagements)
end

# Created a new instance attribute, and added its values below
def add
  puts "\nadd new engagement to flatfile.\n\n".upcase
  engagement = Phases.build_using_questions
  if engagement.save # instance method in the Phases class to save data to the flatfile
    puts "\nEngagement added to flatfile.\n\n".foreground(:white).bright
  else
    puts "\nSave error: Engagement unable to be added to flatfile.\n\n".foreground(:red).bright
  end
  
end

def pre
				puts "\nPre-engagement Interactions consist of the following phases:\n"
				puts "1 Scoping"
				puts "2 How to Scope"
				puts "3 Metrics for Time Estimation"
				puts "4 Scoping Meeting"
				puts "5 Additional Support Based on Hourly Rate"
				puts "6 Questionnaires"
				puts "7 General Questions"
				puts "8 Scope Creep"
				puts "9 Specify IP Ranges and Domains"
				puts "10 Dealing with Third Parties"
				puts "11 Define Acceptable Social Engineering Pretexts"
				puts "12 DoS Testing"
				puts "13 Payment Terms"
				puts "14 Goals"
				puts "15 Establish Lines of Communication"
				puts "16 Emergency Contact Information"
				puts "17 Rules of Engagement"
				puts "18 Capabilities and Technology in Place"
				puts "\nPlease visit the following URL to view the details of this phase"
				puts "http://www.pentest-standard.org/index.php/Pre-engagement\n".foreground(:red).bright

end

	def introduction
	  puts "\nWelcome to the Penetration Testing Execution Standard (PTES) Automation Framework.".foreground(:white).bright
	  puts "I can be used as a quick reference, and help automate certain phases of an engagement & align it to the PTES methodology.".foreground(:white).bright
#	  	  `say Welcome. Kiss kiss`
	end
	
	def conclusion
	  puts "\nThanks for testing with us, happy bug hunting!\n\n".foreground(:white).bright
#	  `say Goodbye`
	 end

	 private
	 def output_action_header(text)
	   puts "\n#{text.upcase.center(60)}\n\n"
  end
  
	def output_engagement_table(phases=[])
	  print " " << "Name".ljust(20)
	  print " " << "Type".ljust(8)
	  print " " << "Contact".ljust(20)
	  print " " << "Email".ljust(20)
	  print " " << "Phone".ljust(15)
	  print " " << "Length".ljust(8)
	  print " " << "IP's".ljust(5)
	  print " " << "Price".rjust(3)
	  puts 
	  puts "-" * 135
	  phases.each do |phas|
	    line = " " << phas.name.ljust(20)
	    line << " " << phas.type.ljust(8)
	    line << " " << phas.contact.ljust(20)
	    line << " " << phas.email.ljust(20)
	    line << " " << phas.phone.ljust(15)
	    line << " " << phas.length.ljust(8)
	    line << " " << phas.ips.ljust(5)
	    line << " " << phas.price.rjust(3)
	    puts line
	  end
	  puts "No engagements found" if phases.empty?
	  puts "-" * 135
	end
	
end
  
