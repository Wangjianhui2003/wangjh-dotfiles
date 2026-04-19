return {
	"stevearc/conform.nvim",
	lazy = false,
	opts = function()
		return {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially.
				-- python = { "isort", "black" },
				-- You can customize some of the format options for the filetype.
				-- rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter.
				javascript = { "prettierd", "prettier", stop_after_first = true },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},

			notify_no_formatters = true,
			notify_on_error = true,
		}
	end,
}
