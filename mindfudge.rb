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


runner = MindFudge::Runner.new

if ARGV.count == 2 and ARGV[0] == "-c"
	runner.run(ARGV[1])
elsif ARGV.count == 1
	begin
		contents = ""
		f = File.new(ARGV[0], "r")
		while (str = f.gets)
			contents << str
		end
		f.close

		runner.run(contents)
	rescue => exception
		error! exception.to_s
	end
end
