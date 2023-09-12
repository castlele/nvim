require("cluautils.table_utils")

local lspconfig = require("lspconfig")
local qoc = require("coq")

---@MARK - Mobile Development

lspconfig.sourcekit.setup(qoc.lsp_ensure_capabilities({
    filetypes = {
        "swift", "c", "cpp", "objective-c", "objective-cpp", "objc", "objcpp"
    }
}))

-- lspconfig.clangd.setup(qoc.lsp_ensure_capabilities({}))

lspconfig.kotlin_language_server.setup(qoc.lsp_ensure_capabilities({}))

---@MARK - Lua development

local packages = {
    "/Users/castlelecs/.luaver/lua/5.1/",
    "/Users/castlelecs/.luaver/luarocks/2.3.0_5.1/share/lua/5.1"
}

lspconfig.lua_ls.setup(qoc.lsp_ensure_capabilities({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                library = table.concat_tables(vim.api.nvim_get_runtime_file("", true), packages),
                checkThirdParty = false
            },
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
}))

---@MARK - General configuration

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),

    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf, silent = true }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
    end,
})
