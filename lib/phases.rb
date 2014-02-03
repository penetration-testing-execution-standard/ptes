#require 'config/output'
class Phases
 #include Output
  
  
#-------------------------------------------------------------
     # Class methods 
#-------------------------------------------------------------

  @@filepath = nil		# class variable
  def self.filepath=(path=nil)	# class method
    @@filepath = File.join(APP_ROOT, path)
  end
  
  attr_accessor :name, :type, :contact, :email, :phone, :length, :ips, :price # read/write instances
  
  def self.file_exists?		# class method
	# class should know if the pentest file exists
	  if @@filepath && File.exists?(@@filepath)
	    return true
	  else
	    return false
	  end
	end
  
  # Common way to write boolean tests vs having to write if/then statements
  def self.file_usable?		# class method
	  return false unless @@filepath
	  return false unless File.exists?(@@filepath)
	  return false unless File.readable?(@@filepath)
	  return false unless File.writable?(@@filepath)
	  return true
	end
	  
  def self.create_file		# class method
	# create the pentest file
	  File.open(@@filepath, 'w') unless file_exists?
	  return file_usable?
	end
  
  def self.saved_phases		# class method
    phases = [] # read the pentest file
    if file_usable? # return instances of the pentest file
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
	phases << Phases.new.import_line(line.chomp)
      end
      file.close
  end
  return phases
end

  def self.build_using_questions
    args = {} # initialize to an empty array
  print "Engagement name: "
  args[:name] = gets.chomp.strip

  print "Engagement type: "
  args[:type] = gets.chomp.strip

  print "Engagement primary/emergency contact: "
  args[:contact] = gets.chomp.strip
  
  print "Contact email address: "
  args[:email] = gets.chomp.strip
  
  print "Contact phone number: "
  args[:phone]  = gets.chomp.strip

  print "Engagement length: "
  args[:length] = gets.chomp.strip
  
  print "How many IP's under scope: "
  args[:ips] = gets.chomp.strip
  
  print "Engagement price: "
  args[:price] = gets.chomp.strip
  
  return self.new(args) # Create a new instance of the engagements object in 'pentest.txt'.
end

#-------------------------------------------------------------
     # Instance methods 
#-------------------------------------------------------------

  def initialize(args={})
    @name 	= args[:name]		|| "" 
    @type 	= args[:type]		|| "" 
    @contact 	= args[:contact]	|| "" 
    @email 	= args[:email] 		|| "" 
    @phone 	= args[:phone] 		|| ""
    @length	= args[:length] 	|| ""
    @ips	= args[:ips]		|| ""
    @price	= args[:price]		|| ""
  end
  
  def import_line(line)
    line_array = line.split("\t")
    @name, @type, @contact, @email, @phone, @length, @ips, @price = line_array
    return self
  end
  
  def save
    
    # check to see if the file exists, and is readable/writeable as shown above in the class method
    return false unless Phases.file_usable? # look for the class method file.usable not instance
    
    # if the file is writeable/readable/usable
    File.open(@@filepath, 'a') do |file| #= block variable, open file, and append a new line
    
    # save/append a line to the file by creating a tab delimeted array
    file.puts "#{[@name, @type, @contact, @email, @phone, @length, @ips, @price].join("\t")}\n"
  end
  return true # to show we succeeded!
  end

  def formatted
    number_to_currency(@price)
  end
  
end
