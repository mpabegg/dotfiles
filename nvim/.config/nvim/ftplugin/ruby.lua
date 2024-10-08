vim.keymap.set('n', '<localleader>rf', ':! bin/rubocop -A %<cr>', { noremap = true, silent = true })
