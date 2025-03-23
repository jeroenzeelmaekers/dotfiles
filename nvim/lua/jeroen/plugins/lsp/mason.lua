return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")

		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({})

		mason_lspconfig.setup({
			ensure_installed = {
				-- lua
				"lua_ls",
				-- javascript/typescript
				"ts_ls",
				"emmet_ls",
				-- html
				"html",
				-- css
				"cssls",
				"tailwindcss",
				-- c#
				"csharp_ls",
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- lua
				"stylua",
				-- web dev
				"prettier",
				"eslint_d",
				-- c#
				"csharpier",
			},
		})
	end,
}
