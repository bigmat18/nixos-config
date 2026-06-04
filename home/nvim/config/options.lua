local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4

-- Tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.colorcolumn = "80"

--line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

--cursir line
opt.cursorline = true

--theme
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--backspace
opt.backspace = "indent,eol,start"

--clipborad
opt.clipboard:append("unnamedplus")

--split windows
opt.splitright = true
opt.splitbelow = true

-- long undoo
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- search
opt.incsearch = true

-- better scroll
opt.scrolloff = 8
opt.signcolumn = 'yes'

-- faster update time
opt.updatetime = 50

opt.iskeyword:append("-")
