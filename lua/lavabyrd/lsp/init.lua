local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("lavabyrd.lsp.lsp-installer")
require("lavabyrd.lsp.handlers").setup()
require("lavabyrd.lsp.null-ls")
