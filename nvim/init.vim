set termguicolors
set encoding=utf-8
inoremap jj <Esc>
set number relativenumber
syntax enable
set noswapfile
set scrolloff=4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set nohlsearch
set cursorline

let mapleader = ' '
let g:python3_host_prog='/Users/bombamishappy/.pyenv/shims/python3'

call plug#begin("~/.config/nvim/plugged")

Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'
Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
Plug 'psliwka/vim-smoothie'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'Shatur/neovim-ayu'
Plug 'tpope/vim-surround'
Plug 'phaazon/hop.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'

call plug#end()

let g:airline_theme='ayu_mirage'

autocmd ColorScheme * call Highlight()

function! Highlight() abort
  hi Conceal ctermfg=239 guifg=#504945
  hi CocSearch ctermfg=12 guifg=#18A3FF
endfunction

lua <<EOF
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#122D49 gui=nocombine]]
vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
    },
    show_current_context = true,
    show_current_context_start = true,
}
EOF

autocmd vimenter * ++nested colorscheme nightfly

" NERD COMMENTER
nmap <C-/> <plug>NERDCommenterToggle
vmap <C-/> <plug>NERDCommenterToggle<CR>gv
 
" NERDTREE
let NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
nmap <C-g> :NERDTreeToggle<CR>

" Tabs
"let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tablinefnamemode=':t'
nmap <leader>h :bp<CR>
nmap <leader>l :bn<CR>
nmap ∑ :bp<CR>

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
nmap <leader>n :term python3 
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

lua <<EOF
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<C-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\>><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\>><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\>><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\>><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\>><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\>><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
EOF

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D
nnoremap ˚ *   
let g:smoothie_speed_linear_factor=35
let g:smoothie_speed_exponentiation_factor=0.5


lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "python" },

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}
EOF

lua <<EOF
require'hop'.setup()
-- place this in one of your configuration file(s)
-- place this in one of your configuration file(s)
vim.api.nvim_set_keymap('', 's', "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.api.nvim_set_keymap('', '<leader><leader>', "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap('', 's', "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.api.nvim_set_keymap('', '<leader><leader>', "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({current_line_only = true })<cr>", {})
vim.cmd("hi HopNextKey guifg=#ff9900")
vim.cmd("hi HopNextKey1 guifg=#ff9900")
vim.cmd("hi HopNextKey2 guifg=#ff9900")
EOF
set mouse=a

noremap <Leader>y "*y



"NVIM DAP CONFIG
lua require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
lua require("dapui").setup()
lua <<EOF
vim.keymap.set('n', '<leader>0', "<cmd>lua require'dap'.continue()<CR>")
vim.keymap.set('n', '<leader>=', "<cmd>lua require('dapui').toggle()<CR>")
vim.keymap.set('n', '<leader>b', "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
EOF
