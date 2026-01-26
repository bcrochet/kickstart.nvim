return {
  {
    'olimorris/codecompanion.nvim',
    keys = {
      { '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle CodeCompanion chat', noremap = true, silent = true },
      { '<C-a>', '<cmd>CodeCompanionActions<cr>', desc = 'Launch CodeCompanionActions', mode = { 'n', 'v' }, noremap = true, silent = true },
      { 'ga', '<cmd>CodeCompanionChat Add<cr>', desc = 'Add to CodeCompanion chat', mode = 'v' },
    },
    cmd = { 'CodeCompanion', 'CodeCompanionChat' },
    config = function(_, opts)
      require('codecompanion').setup(opts)
      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd [[cab cc CodeCompanion]]
    end,
    opts = {
      adapters = {
        http = {
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              env = {
                url = 'http://dredd.dragon-bushi.ts.net:11434',
              },
              parameters = {
                sync = true,
              },
            })
          end,
        },
        acp = {
          gemini_cli = function()
            return require('codecompanion.adapters').extend('gemini_cli', {
              defaults = {
                auth_method = 'gemini-api-key',
              },
              env = {
                GEMINI_API_KEY = 'cmd:bw get password 20af807c-45d4-4a61-b07c-b314013ce21b',
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = { name = 'ollama', model = 'granite4:small-h' },
          tools = {
            ['mcp'] = { -- Name this tool whatever you like
              -- Callback provides the necessary functions to CodeCompanion
              callback = function() return require 'mcphub.extensions.codecompanion' end,
              opts = {
                -- If true, CodeCompanion will ask for approval before executing the MCP tool call
                requires_approval = true,
                -- Optional: Pass parameters like temperature to the underlying LLM if the chat strategy supports it
                temperature = 0.7,
              },
            },
          },
        },
        inline = {
          adapter = { name = 'ollama', model = 'granite4:small-h' },
        },
        cmd = {
          adapter = { name = 'ollama', model = 'granite4:small-h' },
        },
      },
      opts = {
        -- Set debug logging
        -- log_level = 'DEBUG',
      },
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            make_tools = true,
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'ravitemer/mcphub.nvim',
        dependencies = {
          'nvim-lua/plenary.nvim',
        },
        build = 'bundled_build.lua', -- Bundles `mcp-hub` binary along with the neovim plugin
        opts = {
          use_bundled_binary = true,
        },
      },
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = '[Image]($FILE_PATH)',
              use_absolute_path = true,
            },
          },
        },
      },
      {
        'OXY2DEV/markview.nvim',
        lazy = true,
        opts = {
          preview = {
            filetypes = { 'markdown', 'codecompanion' },
            ignore_buftypes = {},
          },
        },
      },
      {
        'echasnovski/mini.diff',
        config = function()
          local diff = require 'mini.diff'
          diff.setup {
            -- Disabled by default
            source = diff.gen_source.none(),
          }
        end,
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown', 'codecompanion' },
      },
      {
        'saghen/blink.cmp',
        opts = {
          sources = {
            per_filetype = { codecompanion = { 'codecompanion' } },
            --            default = { 'codecompanion' },
            providers = {
              codecompanion = {
                name = 'CodeCompanion',
                module = 'codecompanion.providers.completion.blink',
                enabled = true,
              },
            },
          },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
