return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- TERRAFORM LSP
      require("lspconfig").terraformls.setup({ filetypes = { "terraform", "hcl" } })
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = { "*.tf", "*.tfvars", "*.hcl" },
        callback = function()
          vim.lsp.buf.format()
        end,
      })
      -- GOLANG LSP
      require("lspconfig").gopls.setup({})
      -- GOIMPORT ON SAVE
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { "source.organizeImports" } }

          local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
          for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
              end
            end
          end
          vim.lsp.buf.format({ async = false })
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = "nvim-lspconfig",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = {
          "bashls",
          "gopls",
          "lua_ls",
          "terraformls",
          "yamlls",
        },
      })
    end,
  },
  {
    "folke/lsp-colors.nvim",
    config = true,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "hcl",
  --       "terraform",
  --     },
  --   },
  -- },
}
