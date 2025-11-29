local home = vim.fn.expand("~") .. '/school' .. '/zettelkasten'

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  		 "vim", "lua", "vimdoc",
       "html", "css", "nix", "javascript",
       "typescript", "tsx", "c", "yaml",
       "php", "python", "rust", "vala",
       "markdown_inline", "markdown",
  		},
  	},
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
      },

      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },  
    },
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_progname = "zathura"
    end,
  },

  {
    "pocco81/auto-save.nvim",
    lazy = false,
  },

  {
    "renerocksai/calendar-vim",
    lazy = false,
  },

  {
    "https://gitea.home.sdaqo.dev/sdaqo/telekasten.nvim.git",
    opts = {
      home = home,
      take_over_my_home = true,
      auto_set_filetype = true,
      dailies      = home .. '/' .. 'daily',
      weeklies     = home .. '/' .. 'weekly',
      templates    = home .. '/' .. 'templates',
      image_subdir = "img",
      extension    = ".md",
      follow_creates_nonexisting = true,
      dailies_create_nonexisting = true,
      weeklies_create_nonexisting = true,
      template_new_note = home .. '/' .. 'templates/new_note.md',
      template_new_daily = home .. '/' .. 'templates/daily.md',
      template_new_weekly= home .. '/' .. 'templates/weekly.md',
      image_link_style = "markdown",
      plug_into_calendar = true,
      calendar_opts = {
          weeknm = 4,
          calendar_monday = 1,
          calendar_mark = 'left-fit',
      },
      close_after_yanking = false,
      insert_after_inserting = true,
      tag_notation = "yaml-bare",
      command_palette_theme = "dropdown",
      show_tags_theme = "dropdown",
      subdirs_in_links = true,
      template_handling = "smart",
      new_note_location = "smart",
      rename_update_links = true,
    },
    lazy = false,
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = {"markdown"},
    build = "cd app && npm install && git restore .",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    event = { "BufReadPost *.rs" },
    opts = function()
      local ok, mason_registry = pcall(require, "mason-registry")
      local adapter ---@type any
      if ok then
        -- rust tools configuration for debugging support
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = ""
        if vim.loop.os_uname().sysname:find("Windows") then
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        elseif vim.fn.has("mac") == 1 then
          liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
        else
          liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        end
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      end
      return {
        dap = {
          adapter = adapter,
        },
        tools = {
          on_initialized = function()
            vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
          end,
        },
      }
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
       { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "danymat/neogen",
    config = true,
    keys = {
      { "<leader>nf", "<cmd>lua require('neogen').generate()<cr>", desc="Generate docstring" }
    }
  },
  {
      'goolord/alpha-nvim',
      config = function ()
          require'alpha'.setup(require'alpha.themes.dashboard'.config)
      end
  },

  {
    'Shatur/neovim-session-manager',
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
  },

  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
      "nvim-mini/mini.pick",           -- optional
      "folke/snacks.nvim",             -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
