local opts = {}

local on_attach = function()
	local function set_keymap(...) vim.api.nvim_set_keymap(...) end

	local function set_option(...) vim.api.nvim_set_option(...) end

	-- Enable completion triggered by <c-x><c-o>
	set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	set_keymap('', '<leader>lc', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	set_keymap('', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	set_keymap('', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	set_keymap('', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	set_keymap('', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	set_keymap('', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	set_keymap('', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	set_keymap('', '<leader>lw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	set_keymap('', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	set_keymap('', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	set_keymap('', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	set_keymap('', '<leader>le', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	set_keymap('', '<leader>lo', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	set_keymap('', '<leader>ln', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	set_keymap('', '<leader>lp', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	set_keymap('', '<leader>lm', '<cmd>lua vim.lsp.buf.format {async=true}<CR>', opts)
end
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup {}
		on_attach()
	end,
	["rust_analyzer"] = function()
		require('rust-tools-setup')
		on_attach()
	end,
	["lua_ls"] = function()
		require('lspconfig').lua_ls.setup {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }
					}
				}
			}
		}
		on_attach()
	end,
})
