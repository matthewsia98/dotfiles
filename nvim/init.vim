" plugins
call plug#begin()
Plug 'https://github.com/preservim/nerdtree'
"Plug 'https://github.com/vim-airline/vim-airline'
"Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/nvim-lualine/lualine.nvim'
Plug 'https://github.com/kyazdani42/nvim-web-devicons'
Plug 'https://github.com/catppuccin/nvim', {'as': 'catppuccin'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
    set t_ut=
endif

" get powerline effect
"let g:airline_powerline_fonts = 1

" set airline theme
"let g:airline_theme='luna'

" catppuccin configuration
lua << EOF
local cp = require('catppuccin')
local colors = require('catppuccin.palettes').get_palette()
cp.setup({transparent_background = false,
          integrations = {},
          custom_highlights = {Comment = {fg = colors.blue}
                              }

                          }
        )

local line = require('lualine')
line.setup({options = {theme = 'dracula',
                       icons_enabled = true,
                       -- powerline    
                       section_separators = {left = '', right = ''},
                       component_separators = {left = '', right = ''}
                      },
            -- a b c                x y z
            sections = {lualine_a = {'mode'},
                        lualine_b = {'branch', 'diff', 'diagnostics'},
                        lualine_c = {'filename'},
                        lualine_x = {'encoding', 'fileformat', 'filetype'},
                        lualine_y = {'progress'},
                        lualine_z = {'location'}
                       }
           }
          )
EOF

let g:catppuccin_flavour = 'macchiato'
colorscheme catppuccin

" syntax highlighting
syntax on

" autoindent
filetype plugin indent on

" show line numbers
set number
highlight LineNr guifg=#00ffff

" highlight search
set hlsearch

hi MatchParen guibg=#ff00ff 

" enable mouse
set mouse=a

" tab behaviour
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

" search casing
set ignorecase
set smartcase

" prevent newline from starting with comment
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" key bindings
nnoremap <C-t> :NERDTreeToggle<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <c-space>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<c-space>" :
      \ coc#refresh()
