" Out of the box vim-diminactive is already on by default. But if multiple
" buffers are opened at startup, e.g. via vim-session, all buffers appear
" focused (unchanged). And when focus changes, the buffers are dimmed
" individually as they lose focus, rather than all inactive buffers being
" dimmed at once.
"
" This redundant call causes all inactive buffers to be dimmed at startup.
"
" It is called here, instead in .vimrc, because plugins loaded after .vimrc is
" processed.
"
" Known issues with this approach:
" - flicker at startup
DimInactiveOn
