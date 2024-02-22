local opts = {}

local on_attach = function()
    local function set_keymap(...) vim.api.nvim_set_keymap(...) end

    local function set_option(...) vim.api.nvim_set_option(...) end

    -- Enable completion triggered by <c-x><c-o>
    set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local function optsWithDesc(desc)
        return { silent = true, desc = desc }
    end

    --setup leader-l prefix in whitch-key
    local wk = require("which-key")
    wk.register {
        ["<leader>l"]={
            name="+lsp"
        }
    }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    set_keymap('', '<leader>lc', '<cmd>lua vim.lsp.buf.declaration()<CR>', optsWithDesc("jump to declaration"))
    set_keymap('', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', optsWithDesc("jump to definition"))
    set_keymap('', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', optsWithDesc("show lsp hover info"))
    set_keymap('', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', optsWithDesc("show implementations"))
    set_keymap('', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', optsWithDesc("show signature help"))
    set_keymap('', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', optsWithDesc("add workspace folder"))
    set_keymap('', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
        optsWithDesc("remove workspace folder"))
    set_keymap('', '<leader>lw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
        optsWithDesc("show workspace folders"))
    set_keymap('', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', optsWithDesc("rename symbol"))
    set_keymap('', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', optsWithDesc("lsp code action"))
    set_keymap('', '<leader>le', '<cmd>lua vim.lsp.buf.references()<CR>', optsWithDesc("list references"))
    set_keymap('', '<leader>lo', '<cmd>lua vim.diagnostic.open_float()<CR>',
        optsWithDesc("show diagnostic in floating window"))
    set_keymap('', '<leader>ln', '<cmd>lua vim.diagnostic.goto_next()<CR>', optsWithDesc("next lsp diagnostic"))
    set_keymap('', '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', optsWithDesc("prev lsp diagnostic"))
    set_keymap('', '<leader>lm', '<cmd>lua vim.lsp.buf.format {async=true}<CR>', optsWithDesc("format buffer"))
    set_keymap('', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', optsWithDesc("next lsp diagnostic"))
    set_keymap('', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', optsWithDesc("prev lsp diagnostic"))
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
