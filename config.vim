" coc config
function! CocTimerStart(timer)
    exec "CocStart"
endfunction

call timer_start(2000,'CocTimerStart',{'repeat':1})
