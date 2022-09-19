" coc config
function! CocTimerStart(timer)
    exec "CocStart"
endfunction

call timer_start(2000,'CocTimerStart',{'repeat':1})

let g:trigger_size = 0.5 * 1048576

augroup hugefile
  autocmd!
  autocmd BufReadPre *
        \ let size = getfsize(expand('<afile>')) |
        \ if (size > g:trigger_size) || (size == -2) |
	      \   execute "lua vim.notify('WARNING: altering options for this huge file!', 'error', { title = 'Coc.nvim Status', timeout = 1000 })" |
        \   exec 'CocDisable' |
        \ else |
        \   exec 'CocEnable' |
        \ endif |
        \ unlet size
augroup END

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" format 格式化
xmap <leader>fo  <Plug>(coc-format-selected)
nmap <leader>fo  <Plug>(coc-format-selected)

augroup cocGroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap ga  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>cl  <Plug>(coc-codelens-action)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocActionAsync('format')

command! -nargs=? Fold :call CocAction('fold', <f-args>)

command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

nnoremap <silent><nowait> <space>q  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>ce  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>cc  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>co  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>cs  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>cj  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>ck  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>cp  :<C-u>CocListResume<CR>

function OverrideCocHighlights()
  hi! CocRustChainingHint NONE
  hi! link CocRustChainingHint Comment
endfunction

au Colorscheme * call OverrideCocHighlights()
autocmd FileType markdown let b:coc_pairs_disabled = ['`']

" nnoremap <silent><Leader>s :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" coc notify
function! s:DiagnosticNotify() abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info) | return '' | endif
  let l:msgs = []
  let l:level = 'info'
   if get(l:info, 'warning', 0)
    let l:level = 'warn'
  endif
  if get(l:info, 'error', 0)
    let l:level = 'error'
  endif

  if get(l:info, 'error', 0)
    call add(l:msgs, ' Errors: ' . l:info['error'])
  endif
  if get(l:info, 'warning', 0)
    call add(l:msgs, ' Warnings: ' . l:info['warning'])
  endif
  if get(l:info, 'information', 0)
    call add(l:msgs, ' Infos: ' . l:info['information'])
  endif
  if get(l:info, 'hint', 0)
    call add(l:msgs, ' Hints: ' . l:info['hint'])
  endif
  let l:msg = join(l:msgs, "\n")
  if empty(l:msg) | let l:msg = ' All OK' | endif
  call v:lua.coc_diag_notify(l:msg, l:level)
endfunction

" function! s:StatusNotify() abort
"   let l:status = get(g:, 'coc_status', '')
"   let l:level = 'info'
"   if empty(l:status) | return '' | endif
"   call v:lua.coc_status_notify(l:status, l:level)
" endfunction

" function! s:InitCoc() abort
"   execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Status', timeout = 100 })"
" endfunction

" " notifications
" autocmd User CocNvimInit call s:InitCoc()
autocmd User CocDiagnosticChange call s:DiagnosticNotify()
" autocmd User CocStatusChange call s:StatusNotify()
