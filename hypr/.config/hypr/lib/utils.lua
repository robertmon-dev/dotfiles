local M = {}

function M.apply_binds(binds, default_opts, bind_fn)
	default_opts = default_opts or {}
	for _, spec in ipairs(binds) do
		local combo, dispatcher, opts = spec[1], spec[2], spec[3] or {}
		local merged = {}
		for k, v in pairs(default_opts) do
			merged[k] = v
		end
		for k, v in pairs(opts) do
			merged[k] = v
		end
		bind_fn(combo, dispatcher, merged)
	end
end

function M.apply_each(list, fn)
	for _, item in ipairs(list) do
		fn(item)
	end
end

function M.apply_unpack(list, fn)
	for _, item in ipairs(list) do
		fn(table.unpack(item))
	end
end

return M
