local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- enable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
		width = 60,
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		width = 60,
	})
end

local function lsp_highlight_document(client)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end

	illuminate.on_attach(client)
end

local function lsp_keymaps(bufnr)
	local ok, wk = pcall(require, "which-key")
	if not ok then
		return
	end

	wk.register({
		g = {
			name = "go to",
			["<S-d>"] = { vim.lsp.buf.declaration, "declaration" },
			d = { vim.lsp.buf.definition, "definition" },
			i = { vim.lsp.buf.implementation, "implementation" },
			r = { vim.lsp.buf.references, "references" },
			l = { vim.diagnostic.open_float, "open_float" },
		},
		["<S-k>"] = { vim.lsp.buf.hover },
		["<C-k>"] = { vim.lsp.buf.signature_help },
	}, { buffer = bufnr })

	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true}' ]])
end

M.on_attach = function(client, bufnr)
	if client.name == "sumneko_lua" or client.name == "solargraph" then
		client.resolved_capabilities.document_formatting = false
	end

	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
