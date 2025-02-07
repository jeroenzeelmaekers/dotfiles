return {
	"lukas-reineke/indent-blankline.nvim",
	enabled = false,
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = { char = "│" },
		scope = { show_start = false, show_end = false },
	},
}
