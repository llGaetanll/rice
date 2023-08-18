local M = {}

M.lazy_require = function(module_name)
	vim.defer_fn(function()
		local ok, module = pcall(require, module_name)

		if not ok then
			return
		end

		return module
	end, 0)
end

return M
