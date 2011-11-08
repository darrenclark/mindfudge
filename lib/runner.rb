require 'lib/memory'

module MindFudge

class Runner
	
	def initialize
		@memory = Memory.new
	end
	
	def run(code)
		@code = clean_code(code)
		@ip = 0
		
		while @ip < @code.length
			instruction = @code[@ip,1]
			
			case instruction
			when '>'
				@memory.move_forward
			when '<'
				@memory.move_backward
			when '+'
				@memory.increment
			when '-'
				@memory.decrement
			when '.'
				print "" << @memory.current_value
			when '['
				if @memory.current_value == 0
					jump_to_closing_bracket
				end
			when ']'
				if @memory.current_value != 0
					jump_to_opening_bracket
				end
			end

			@ip += 1
		end
	end
	
	def clean_code(code)
		valid_chars = ['<', '>', '+', '-', '.', ',', '[', ']']	
		output = ""
		code.each_char { |str| output << str if valid_chars.include? str }
		output
	end

	def jump_to_closing_bracket
		nested_level = 0
		while @ip < @code.length
			@ip += 1
			if @code[@ip,1] == '['
				nested_level += 1
			elsif @code[@ip,1] == ']' and nested_level == 0
				return
			elsif @code[@ip,1] == ']'
				nested_level -= 1
			end
		end
	end

	def jump_to_opening_bracket
		nested_level = 0
		while @ip > 0 
			@ip -= 1
			if @code[@ip,1] == ']'
				nested_level += 1
			elsif @code[@ip,1] == '[' and nested_level == 0
				return
			elsif @code[@ip,1] == '['
				nested_level -= 1
			end
		end
	end

end

end
