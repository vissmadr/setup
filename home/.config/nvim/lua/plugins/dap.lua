return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.zig = {
      {
        name = "Debug Zig executable",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.getcwd() .. "/zig-out/bin/"
            .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
  end,
}
