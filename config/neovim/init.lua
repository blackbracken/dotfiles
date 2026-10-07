vim.g.lightline = { colorscheme = 'iceberg' }

vim.pack.add({
  { src = 'https://github.com/cocopon/iceberg.vim', version = '23835d5ed696436f716cbfdb56a93a7850fe3b18' },
  { src = 'https://github.com/itchyny/lightline.vim', version = '255f61db1a4cc36ee11eb479261d6bc471ed0819' },
})

vim.cmd.colorscheme('iceberg')

-- display
vim.o.number = true
vim.o.cursorline = true
vim.o.title = true
vim.o.showmode = false

-- search
vim.o.ignorecase = true
vim.o.smartcase = true

-- indent
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- etc
vim.o.swapfile = false
vim.o.clipboard = 'unnamed'
