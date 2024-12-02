local spec = {
  "mattn/vim-gist",
  dependencies = {
    "mattn/webapi-vim"
  },
  init = function()
    vim.g.gist_clip_command = 'xclip -selection clipboard'
    vim.g.gist_show_privates = 1
    vim.g.gist_post_private = 1
  end,
}

return spec
