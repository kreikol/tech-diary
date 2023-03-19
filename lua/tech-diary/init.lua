local M = {}

M.hello = function ()
	vim.ui.input({prompt = 'Dime como te llamas: ' }, function (name)
		print("Hola " .. name ..", soy Miriam saludandote desde mi primer pluging")
	end)
end

M.new_day = function ()
	local bufnum = vim.api.nvim_get_current_buf()
	local day = os.date('%d/%m/%Y')

	-- busco el inicio del roadmap
	local idx_roadmap = M.get_idx_roadmap()

	local day_lines = {
		'',
		"# "..day,
		'',
		'Aqui comienza mi nuevo día'
	}
	vim.api.nvim_buf_set_lines(bufnum, idx_roadmap-1, idx_roadmap-1, false, day_lines)

	local cursor = {
		idx_roadmap + #(day_lines) - 1,
		0
	}
	vim.api.nvim_win_set_cursor(0, cursor)

end

M.get_idx_roadmap = function ()
	local rows = vim.api.nvim_buf_line_count(0)
	-- print ('total rows ', rows)
	local idx_roadmap

	for i = rows, 1, -1 do
		local content = vim.api.nvim_buf_get_lines(0, i-1, i, false)
		-- print('i: ', i, content[1])
		local isRoadMap = content[1] == '# Roadmap Miriam Ruiz'
		if isRoadMap then
			idx_roadmap = i
		end
	end

	-- print('Inicio de ROADMAP: ', idx_roadmap)

	return idx_roadmap
end

return M

