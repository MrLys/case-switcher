local M =  {}

local function from_camel_case_to_snake(camel)
    local snake_case_string = ""
    for i = 1, #camel do
	local char = camel:sub(i,i)
	if (string.match(char, "[A-Z]")) then
	    snake_case_string = snake_case_string .. "_" .. char:lower()
	else
	    snake_case_string = snake_case_string .. char:lower()
	end
    end
    return snake_case_string
end
local function to_snake_case(str)
    if #str > 1 then
	if (string.match(str, "[A-Z]")) then
	    if (string.find(str, "_")) then
		if (string.match(str, "[a-z]")) then
		    return from_camel_case_to_snake(str)
		end
		return str:lower()
	    else
		return from_camel_case_to_snake(str)
	    end
	end
    else
	return str:lower()
    end
    return str
end
local function snake_case_to_camel_case(snake)
    snake = snake:lower()
    local camel_case_str = ""
    local j = 1
    for _ = 1, #snake do
	local char = snake:sub(j,j)
	if (string.match(char, "_")) then
	    if (j < #snake) then
		camel_case_str = camel_case_str .. snake:sub(j+1,j+1):upper()
		j = j + 1
	    else
		-- last element of string, just return
		return camel_case_str
	    end
	else
	    camel_case_str = camel_case_str .. char
	end
	j = j + 1
    end
    return camel_case_str

end
local function to_camel_case(str)
    if #str > 1 then
	if (string.find(str, "_")) then
	    return snake_case_to_camel_case(str)
	end
    else
	return str:lower()
    end
    return str
end
print(to_camel_case("snake_case"))
M.to_snake_case = to_snake_case
M.to_camel_case = to_camel_case
local function snake_case()
    local current_word = vim.call('expand', '<cword>')
    local new_word = to_snake_case(current_word)
    vim.cmd("normal! diwi" .. new_word)
end
M.snake_case = snake_case
return M
