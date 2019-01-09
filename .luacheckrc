-- luacheck: ignore
globals = {
	-- global variables
	"script",
	
	-- global functions
	"unpack",

	-- math library
	"math.random", "math.sqrt", "math.log", 
	"math.cos", "math.min", "math.max",
	"math.ceil", "math.pi", "math.huge",

	-- table library
	"table.sort",

	-- test functions
	"it", "expect",
}

-- prevent max line lengths
max_line_length = false
max_code_line_length = false
max_string_line_length = false
max_comment_line_length = false