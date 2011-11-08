require 'rubygems'
require 'highline'
require 'lib/runner'

USAGE_STRING = <<-eos
Usage:
  To run a file:
  ruby mindfudge.rb somefile.bf

  To run a string of code:
  ruby mindfudge.rb -c "<your code here>"
eos

def error! error_string
	puts "**Error: #{error_string}\n"
	puts USAGE_STRING
	exit
end

code = ""
if ARGV.count == 2 and ARGV[0] == "-c"
	code = ARGV[1]
elsif ARGV.count == 1
	begin
		f = File.new(ARGV[0], "r")
		while (str = f.gets)
			code << str
		end
		f.close
	rescue => exception
		error! exception.to_s
	end
end

runner = MindFudge::Runner.new(code) { HighLine::SystemExtensions::get_character }
runner.run
