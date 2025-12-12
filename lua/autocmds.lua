local autocmd = vim.api.nvim_create_autocmd

autocmd("VimEnter", {
  command = ":silent !alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID options 'window.padding.x=0' 'window.padding.y=0' 'window.dynamic_padding=false' 'font.offset.x=0' 'font.offset.y=1' 'decoration=None'",
})

autocmd("VimLeavePre", {
  command = ":silent !alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID -r",
})
