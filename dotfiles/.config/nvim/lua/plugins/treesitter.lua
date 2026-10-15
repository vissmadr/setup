return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")
    local parsers = {
      "bash",
      "c",
      "cpp",
      "css",
      "diff",
      "glsl",
      "hlsl",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "query",
      "sql",
      "toml",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
      "zig",
    }
    local supported = {}
    for _, parser in ipairs(parsers) do
      supported[parser] = true
    end

    treesitter.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })
    vim.treesitter.language.register("bash", "sh")
    vim.treesitter.language.register("json", "jsonc")
    vim.treesitter.language.register("vimdoc", "help")

    local function highlight(buffer)
      if not vim.api.nvim_buf_is_loaded(buffer) or vim.bo[buffer].buftype ~= "" then
        return
      end
      local language = vim.treesitter.language.get_lang(vim.bo[buffer].filetype)
      if not supported[language] then
        return
      end
      -- A missing parser is expected while the first asynchronous install runs.
      if #vim.api.nvim_get_runtime_file("parser/" .. language .. ".so", false) == 0 then
        return
      end
      local ok, message = pcall(vim.treesitter.start, buffer, language)
      if not ok then
        vim.notify_once(tostring(message), vim.log.levels.WARN)
        return
      end
      for _, window in ipairs(vim.fn.win_findbuf(buffer)) do
        -- Set only this window/buffer pair; keep diff folds and window defaults.
        if not vim.wo[window].diff then
          vim.wo[window][0].foldmethod = "expr"
          vim.wo[window][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
      end
    end

    vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
      group = vim.api.nvim_create_augroup("SetupTreesitter", { clear = true }),
      callback = function(args)
        highlight(args.buf)
      end,
    })

    treesitter.install(parsers):await(function(error)
      vim.schedule(function()
        if error then
          vim.notify("Parser installation failed: " .. tostring(error), vim.log.levels.ERROR)
        end
        for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
          highlight(buffer)
        end
      end)
    end)
  end,
}
