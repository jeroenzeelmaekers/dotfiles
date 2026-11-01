local home = os.getenv("HOME") or ""
local data = os.getenv("XDG_DATA_HOME") or (home .. "/.local/share")
local config = os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")
local plugin = data .. "/nvim/lazy/rex-navigator.nvim"

local ok, err = pcall(function()
	dofile(plugin .. "/rex/navigator.lua").setup()
end)

if not ok then
	rex.log("warn", "rex-navigator not loaded: " .. tostring(err))
end

local worktrunk = config .. "/rex/rex-worktrunk"
local worktree_ok, worktree_err = pcall(function()
	local worktree_root = home .. "/rex/worktrees/"
	local function session_label(path)
		local normalized = path:gsub("/+$", "")
		if normalized:sub(1, #worktree_root) == worktree_root then
			local project, worktree = normalized:sub(#worktree_root + 1):match("^([^/]+)/(.+)$")
			if project and worktree then
				return project .. "/" .. worktree:match("([^/]+)$")
			end
		end
		return normalized:match("([^/]+)$") or normalized
	end

	dofile(worktrunk .. "/init.lua").setup({
		base = "@",
		session_label = session_label,
	})
	rex.bind("ctrl+space>g", "worktree")
	rex.bind("ctrl+space>d", "worktree_remove")
end)

if not worktree_ok then
	rex.log("warn", "rex-worktrunk not loaded: " .. tostring(worktree_err))
end
