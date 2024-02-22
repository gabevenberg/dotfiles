local opts = {
    tools = {
        autoSetHints = true,
        RustHoverActions = true,

        -- how to execute terminal commands
        executor = require("rust-tools/executors").termopen,
        inlay_hints = {
            auto=true,
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- whether to show variable name before type hints with the inlay hints or not
            show_variable_name = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = true,
            -- padding from the right if right_align is true
            right_align_padding = 1,
            -- The color of the hints
            highlight = "Comment",
        },
        hover_actions = {
            -- the border that is used for the hover window
            border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
            },
            -- whether the hover action window gets automatically focused
            auto_focus = false,
        },
        -- settings for showing the crate graph based on graphviz and the dot
        -- command
        crate_graph = {
            -- Backend used for displaying the graph
            backend = "x11",
            -- where to store the output, nil for no output stored (relative
            -- path from pwd)
            output = nil,
            -- true for all crates.io and external crates, false only the local
            -- crates
            full = true,
        },
    },
    -- all the opts to send to nvim-lspconfig
    server = {
        -- standalone file support
        -- setting it to false may improve startup time
        standalone = true,
        settings = {
            -- rust-analyer options
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
    -- debugging stuff
    dap = {
        adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
        },
    },
}
require('rust-tools').setup(opts)
