" NOTE:  the following do NOT exist in this Code Mirror version of Vim
" <leader>
" <silent>
" xnoremap

" use Space for leader key
" but there is no <leader> var for this Code Mirror version of Vim, so just
" manually map it for each cmd where needed
unmap <Space>

" Have j and k navigate visual lines rather than logical ones
nnoremap j gj
nnoremap k gk

" Yank to system clipboard
" could not get the clipboards separated here
set clipboard=unnamed

" split vert tab
exmap vert obcommand workspace:split-vertical
nnoremap <Space>bv :vert

" split horiz tab
exmap horiz obcommand workspace:split-horizontal
nnoremap <Space>bh :horiz

" change file title name
exmap title obcommand workspace:edit-file-title
nnoremap <Space>t :title

" after a search, just press enter again to make highlights go away
nnoremap <CR> :nohl<CR><CR>  

" Remap jump-to-end-of-line
nnoremap <Space>nd $
vnoremap <Space>nd $

" Remap jump-to-start-of-line
nnoremap <Space>st ^
vnoremap <Space>st ^

" Remap redo key to "r"
nnoremap r :redo<CR>

" Remap Ctrl-w buffer switcher
" nnoremap <Space>w <C-w>

" Remapping for Visual Block mode
nnoremap <Space>vv <C-v>
vnoremap <Space>vv <C-v>

" When highlighting in visual mode, move the highlighted sections with capital J, K, L, H
" these first two need to be replaced cuz they only work with the built-in
" obcommands
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

" these J and K are also broken, so you mapped these within Obisidian settings
" to cmd-shift-J and cmd-shift-K
"exmap movedown obcommand editor:swap-line-down
"vnoremap J :movedown
"exmap moveup obcommand editor:swap-line-up
"vnoremap K :moveup
vnoremap L >gv
vnoremap H <gv

exmap focustop obcommand editor:focus-top
nnoremap <Space>wk :focustop
exmap focusbottom obcommand editor:focus-bottom
nnoremap <Space>wj :focusbottom
exmap focusleft obcommand editor:focus-left
nnoremap <Space>wh :focusleft
exmap focusright obcommand editor:focus-right
nnoremap <Space>wl :focusright

" open the quick switcher for fuzzy find
exmap switch obcommand switcher:open
nnoremap <Space>f :switch

" close the curr buffer/tab
exmap close obcommand workspace:close
nnoremap <Space>q :close

" Append the line below the current line to the current line with a space in between
nnoremap J mzJ`z

" Ctrl-d and Ctrl-u for half-page jumping down/up, keep cursor in the middle
nnoremap <Space>l <C-d>zz
nnoremap <Space>h <C-u>zz

" Keep cursor in the middle when jumping between search terms
nnoremap n nzzzv
nnoremap N Nzzzv

" Paste current yanked item and replace another item without changing the
" yanked item in the register
vnoremap <Space>p "_dP

" y will yank only to Vim but <Space>y will yank to system clipboard
nnoremap <Space>y "+y
vnoremap <Space>y "+y
nnoremap <Space>Y "+Y

" Don't allow Q to be pressed with "no press"
nnoremap Q <Nop>

" Replace all instances of the word under the cursor
"nnoremap <Space>r :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
exmap replace obcommand editor:open-search-replace
nnoremap <Space>r :replace

