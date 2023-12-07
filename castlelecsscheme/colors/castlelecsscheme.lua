-- You probably always want to set this in your vim file
vim.opt.background = 'dark'
vim.g.colors_name = 'castlelecsscheme'

package.loaded['lush_theme.castlelecsscheme'] = nil

require('lush')(require('lush_theme.castlelecsscheme'))

