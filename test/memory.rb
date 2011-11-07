require 'lib/memory'
require 'test/unit'

module MindFudge

class TestMemory < Test::Unit::TestCase
	
	def test_increment
		mem = Memory.new
		mem.increment
		assert_equal(1, mem.current_value)
	end
	
	def test_increment_wrapping
		mem = Memory.new
		mem.current_value = 255
		mem.increment
		assert_equal(0, mem.current_value)
	end
	
	def test_decrement
		mem = Memory.new
		mem.current_value = 230
		mem.decrement
		assert_equal(229, mem.current_value)
	end

	def test_decrement_wrapping
		mem = Memory.new
		mem.decrement
		assert_equal(255, mem.current_value)
	end

	def test_navigation
		mem = Memory.new
		
		mem.current_value = 1
		mem.move_forward
		assert_equal(0, mem.current_value)

		mem.move_backward
		assert_equal(1, mem.current_value)
	end

	def test_argument_checking
		mem = Memory.new

		assert_raise( ArgumentError ) { mem.current_value = 300 }
		assert_raise( ArgumentError ) { mem.current_value = -44 }
		assert_raise( ArgumentError ) { mem.current_value = '22' }
	end

end

end
