local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('', ';lc', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('', ';lf', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('', ';lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('', ';li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('', ';ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('', ';lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('', ';lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('', ';lw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('', ';lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('', ';lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('', ';la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('', ';lc', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('', ';lo', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('', ';ln', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('', ';lp', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('', ';lm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'texlab'}
for _, lsp in ipairs(servers) do
	on_attach()
	nvim_lsp[lsp].setup {
		flags = {
			debounce_text_changes = 150,
		}
	}
end

--lua-language-server needs seperate config.
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
on_attach()
require'lspconfig'.sumneko_lua.setup {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}