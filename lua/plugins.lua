-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()
--
function Get_color_mode() -- 1: dark mode, 0: light mode
  local res = vim.fn.system([[defaults read -g AppleInterfaceStyle 2>/dev/null]])
  if res == 'Dark\n' then return 'dark' end
  return 'light'
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Apperance {{{
  use {
    'thallium/nordic.nvim',
    -- '~/programming/nordic.nvim',
    branch = 'thallium',
    config = function()
        vim.g.nord_underline_option = 'underline'
        vim.g.nord_italic = false
        vim.g.nord_italic_comments = false
        vim.g.nord_minimal_mode = false
        vim.g.nord_alternate_backgrounds = false
        if Get_color_mode() == 'dark' then
          vim.o.background='light'
          vim.cmd[[colorscheme nordic]]
        end
    end
  }
  use {
    'Th3Whit3Wolf/one-nvim',
    -- cond = function () return Get_color_mode() == 'light' end,
    config = function ()
      if Get_color_mode() == 'light' then
        vim.o.background='light'
        vim.cmd[[colorscheme one-nvim]]
      end
    end
  }
  use {
    'marko-cerovac/material.nvim',
    disable = 1,
    setup = function () vim.g.material_style = "lighter" end,
    config = function ()
      require'material'.setup({
        contrast = {
          sidebars = true,
          floating_windows = true,
        },
        contrast_filetypes = {
          "packer",
          "qf",
          "nnn"
        },
        disable = {
          borders = true,
          eob_lines = true
        }
      })
      vim.cmd 'colorscheme material'
    end
  }
  use {
    'kyazdani42/nvim-web-devicons',
    config = function() require 'icons' end
  }
  --}}}

  -- Program{{{
  use {
    'nvim-lua/popup.nvim',
  }
  use {
    'mcchrish/nnn.vim',
    cmd = 'NnnPicker',
    config=function()
      vim.g['nnn#layout']={left='~35%'}
      vim.g['nnn#command']='nnn -e'
    end
  }
  use {
    'jreybert/vimagit',
    cmd = 'Magit'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    },
    config = function() require'my_telescope' end
  }
  use {
    'mfussenegger/nvim-dap',
    config = function() require'dap-config' end
  }
  --}}}
  -- Enhance{{{
  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end,
    cmd = {'HopChar2'}
  }

  use {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = function()
        require('nvim-autopairs').setup{}
        require('my_autopairs')
    end
  }

  use {
      "akinsho/toggleterm.nvim",
      config = function () require'toggleterm_config' end
  }

  use { 'tyru/caw.vim' }
  use {
    'machakann/vim-sandwich',
    setup = function ()
      vim.g.sandwich_no_default_key_mappings = true
      vim.g.operator_sandwich_no_default_key_mappings = true
    end,
  }
  use {
      'SirVer/ultisnips',
      config = function() vim.g.UltiSnipsExpandTrigger="<tab>" end
  }
  use {
      'norcalli/nvim-colorizer.lua',
      config = function ()
          require'colorizer'.setup({
              yaml = { names=false },
              javascript = { names=false },
              conf = { names=false },
              kitty = { hsl_fn = true, names = false }
          })
      end

  }
  use {
    'romgrk/barbar.nvim',
    config = function () require 'barbar_config' end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function () require'lualine_config' end
  }
  --}}}

    -- nvim-cmp{{{
    use {
        'hrsh7th/nvim-cmp',
        config = function() require'completion' end
    }
    use {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'quangnguyen30192/cmp-nvim-ultisnips',
        'hrsh7th/cmp-omni',
        'hrsh7th/cmp-path'
    }
    --}}}
  -- Language {{{
  use { 'cespare/vim-toml', ft = 'toml' }
  use { 'bfrg/vim-cpp-modern', ft = { 'c','cpp' } }
  use { 'arzg/vim-sh', ft= { 'sh','zsh' } }
  use { 'fatih/vim-go', ft = {'go','gomod'} }
  use {
    'lervag/vimtex',
    setup = function ()
      vim.g.vimtex_view_method='skim'
    end,
  }
  use {
    'iamcco/markdown-preview.nvim',
    ft={'markdown', 'md'},
    run = "cd app && yarn install",
    cmd = 'MarkdownPreview',
    setup = function () vim.g.mkdp_auto_close = false end
  }--}}}

  -- LSP/treesitter {{{
  use {
      'neovim/nvim-lspconfig',
      config = function() require 'lsp' end
  }
  use { 'ray-x/lsp_signature.nvim' }
  use {
    'glepnir/lspsaga.nvim',
    disable = true,
    config = function ()
      require'lspsaga'.init_lsp_saga({
        use_saga_diagnostic_sign = false
      })
    end
  }

  -- use {
  --   'ray-x/navigator.lua',
  --   requires = {
  --     'ray-x/guihua.lua',
  --     run = 'cd lua/fzy && make'
  --   },
  --   config = function ()
  --     require'navigator'.setup({
  --       icons = {
  --         icons = false
  --       }
  --     })
  --   end
  -- }

  use {
      'nvim-treesitter/nvim-treesitter',
      disable = true,
      run = ':TSUpdate',
      config = function() require'treesitter' end
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
  }
  use {
    'simrat39/symbols-outline.nvim',
    config = function ()
      vim.g.symbols_outline = {
        width = 40
      }
    end
  }
  --}}}

end)

-- vim:shiftwidth=2:ts=2
