call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'echasnovski/mini.completion'
Plug 'justinmk/vim-sneak'
Plug 'Pocco81/auto-save.nvim'
Plug 'RRethy/base16-nvim'
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }
call plug#end()

colorscheme base16-gruvbox-dark-soft
set number
set relativenumber
set scrolloff=5
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

let NERDTreeMinimalUI=1
let NERDTreeStatusline = '%#NonText#'
let NERDTreeShowHidden=1
let NERDTreeWinSize = 25

augroup nerdtreehidecwd
  autocmd!
  autocmd FileType nerdtree setlocal conceallevel=3
          \ | syntax match NERDTreeHideCWD #^[</].*$# conceal
          \ | setlocal concealcursor=n
augroup end


lua << END
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
  function (server_name)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    require("lspconfig")[server_name].setup {
	capabilities = capabilities,
    }
    end,
}
require('mini.completion').setup()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
require("fidget").setup {}
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'base16',
    component_separators = { left = '\\', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {
        },
      winbar = {
        'nerdtree',
      },
    },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {{'mode',separator = { left = '', right = ''}}},
    lualine_b = {{'branch',separator = { left = '', right = ''}},{'diff',separator = { left = '', right = ''}},
    {
        'diagnostics', symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
    }
    },
    lualine_c = {'filename'},
    lualine_x = {{'encoding', separator = "󰿟"}, {'fileformat', separator = "󰿟"}, {'filetype', separator = "󰿟"}},
    lualine_y = {{'progress', separator = { left = '', right = ''}}},
    lualine_z = {{'location', separator = { left = '', right = ''}}}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {
    lualine_a = {{'buffers', hide_filename_extension = true, max_length = vim.o.columns, separator = { left = '', right = ''}, symbols = {modified = ' ●', alternate_file = '', directory = ''}}},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {'filename'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {}
}
require("auto-save").setup{}
vim.diagnostic.config({
  underline = {
    severity = { max = vim.diagnostic.severity.INFO }
  },
  signs = {
    severity = vim.diagnostic.severity.ERROR
  },
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR },
    spacing = 0
  },
  update_in_insert = true
})
-- Set the leader key to "`"
vim.api.nvim_set_var('mapleader', '`')
-- Toggle NvimTree with <leader>t
vim.api.nvim_set_keymap('n', '<leader>t', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true })
END

