module MindFudge
	class Memory
		CELL_POINTER_MIN = 0
		CELL_POINTER_MAX = 29999
		
		CELL_VALUE_MIN = 0
		CELL_VALUE_MAX = 255

		def initialize
			@cells = [0] * 30000
			@cell_pointer = 0
		end

		def reset
			@cells = [0] * 30000
			@cell_pointer = 0
		end

		def move_forward
			@cell_pointer += 1
			@cell_pointer = CELL_POINTER_MIN if @cell_pointer > CELL_POINTER_MAX
		end

		def move_backward
			@cell_pointer -= 1
			@cell_pointer = CELL_POINTER_MAX if @cell_pointer < CELL_POINTER_MIN
		end

		def increment
			@cells[@cell_pointer] += 1
			@cells[@cell_pointer] = CELL_VALUE_MIN if @cells[@cell_pointer] > CELL_VALUE_MAX
		end

		def decrement
			@cells[@cell_pointer] -= 1
			@cells[@cell_pointer] = CELL_VALUE_MAX if @cells[@cell_pointer] < CELL_VALUE_MIN
		end

		def current_value
			@cells[@cell_pointer]
		end

		def current_value= new_value
			if !new_value.is_a? Numeric or new_value < CELL_VALUE_MIN or new_value > CELL_VALUE_MAX
				raise ArgumentError, 'Value needs to be numeric and between ' << CELL_VALUE_MIN.to_s << ' and ' << CELL_VALUE_MAX.to_s
			end
			@cells[@cell_pointer] = new_value
		end
	end
end
