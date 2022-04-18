"=============================================================================
" ginit.vim --- Entry file for neovim-qt
"=============================================================================

set mouse=a

" if exists(':GuiFont')
"   GuiFont VictorMono\ NF:h18
" endif

if exists(':GuiPopupmenu')
  GuiPopupmenu 1
endif

if exists(':GuiTabline')
  GuiTabline 0
endif

if exists(':GuiScrollbar')
  GuiScrollbar 1
endif

if exists(':GuiAdaptiveFont')
  GuiAdaptiveFont 1
endif

if exists(':GuiRenderLigatures')
  GuiRenderLigatures 1
endif

if exists(':GuiWindowOpacity')
  GuiWindowOpacity 0.96
endif
