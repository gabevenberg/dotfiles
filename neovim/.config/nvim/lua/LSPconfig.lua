local lsp_installer = require("nvim-lsp-installer")


-- Include the servers you want to have installed by default below
local install_servers=function()
	local servers = {
		'pyright',
		'bashls',
		'rust_analyzer',
		'sumenko_lua',
		'ltex',
		'texlab',
	}

	local flag=false;
	for _, name in pairs(servers) do
		local server_is_found, server = lsp_installer.get_server(name)
		if server_is_found and not server:is_installed() then
			print("Installing " .. name)
			server:install()
			flag=true;
		end
	end
	if flag then
		print('All Servers Installed')
	end
end

lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "rust_analyzer" then
        -- Initialize the LSP via rust-tools instead
        require("rust-tools").setup {
            -- The "server" property provided in rust-tools setup function are the
            -- settings rust-tools will provide to lspconfig during init.
            -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
            -- with the user's own settings (opts).
            server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
        }
        server:attach_buffers()
        -- Only if standalone support is needed
        require("rust-tools").start_standalone_if_required()
    else
        server:setup(opts)
    end
end)

local on_attach = function()
	local function set_keymap(...) vim.api.nvim_set_keymap(...) end
	local function set_option(...) vim.api.nvim_set_option(...) end

	-- Enable completion triggered by <c-x><c-o>
	set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	set_keymap('', ';lc', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	set_keymap('', ';lf', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	set_keymap('', ';lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	set_keymap('', ';li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	set_keymap('', ';ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	set_keymap('', ';lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	set_keymap('', ';lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	set_keymap('', ';lw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	set_keymap('', ';lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	set_keymap('', ';lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	set_keymap('', ';la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	set_keymap('', ';le', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	set_keymap('', ';lo', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	set_keymap('', ';ln', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	set_keymap('', ';lp', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	set_keymap('', ';lm', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end
on_attach()
install_servers()
