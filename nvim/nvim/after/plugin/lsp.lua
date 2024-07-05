

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}

    -- goto definition
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    -- show quick info on item under hover
    vim.keymap.set('n', '<leader>I', function() vim.lsp.buf.hover() end, opts)
    -- this is a way that the LSP can detect symbols across your entire curr workspace, 
    -- instead of just curr file. But some LSPs can't do this or need some sort of setup
    -- file to do this  (eg: JS has a package.json which allows the LSP to detect the curr
    -- "workspace" and all files/symbols in it
    vim.keymap.set('n', '<leader>vw', function() vim.lsp.buf.workspace_symbol() end, opts)
    -- open a quick diagnostic info on error/warning under the cursor
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    -- goto next diagnostic in file
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    -- goto prev diagnostic in file
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    -- see which code-actions the LSP server offers for the item under the cursor
    -- some LSPs do not provide any code actions
    vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
    -- show all refs to the item under the cursor in this file
    vim.keymap.set('n', '<leader>vr', function() vim.lsp.buf.references() end, opts)
    -- rename the var under the cursor everywhere it occurs in the file
    vim.keymap.set('n', '<leader>vn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()



-- incorporate Mason for easy LS installing
-- see lang servers by typing in:    :Mason
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              }
            }
          }
        }
      })
    end,
  }
})


-- incorporate cmp for code completion
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}


-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  -- these are for the dropdown menu that appears for code completion suggestions
  -- the cmp.mapping.complete shows the entire list of possibilities
  mapping = cmp.mapping.preset.insert({
    ['<D-l>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<D-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<D-i>'] = cmp.mapping.confirm({ select = true }),
    ['<D-f>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})



