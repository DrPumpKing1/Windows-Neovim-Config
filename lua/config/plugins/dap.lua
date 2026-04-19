return {
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        config = function()
            local dap = require("dap")

            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = 'C:\\Users\\salva\\AppData\\Local\\nvim-data\\mason\\bin\\OpenDebugAD7.cmd',
                options = {
                    detached = false
                }
            }

            dap.set_log_level("DEBUG")

            vim.keymap.set("n", "<F1>", dap.continue, { desc = "Debug: Continue" })
            vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F3>", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Debug: Step Back" })
            vim.keymap.set("n", "<F6>", function() 
                dap.terminate({ terminateDebuggee = true }) 
                require("dapui").close()
            end, { desc = "Debug: Termninate" })
            vim.keymap.set("n", "<F13>", dap.restart, { desc = "Debug: Restart" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set Conditional Breakpoint" })
            vim.keymap.set("n", "<space>gb", dap.run_to_cursor, { desc = "Debug: Run to cursor" })
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")
            ui.setup()

            -- Eval var under cursor
            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            local widgets = require("dap.ui.widgets")

            local scopes = widgets.sidebar(widgets.scopes, {}, "vsplit")
            local frames = widgets.sidebar(widgets.frames, { height = 10 }, "belowright split")
            local repl = require("dap.repl")

            vim.keymap.set("n", "<leader>da", function()
                return repl.toggle({}, "belowright split")
            end)

            vim.keymap.set("n", "<leader>ds", scopes.toggle)
            vim.keymap.set("n", "<leader>du", frames.toggle)
            vim.keymap.set("n", "<leader>dh", widgets.hover)

            dap.listeners.before.attach.dapui_config = function() ui.open() end
            dap.listeners.before.launch.dapui_config = function() ui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
            dap.listeners.before.event_exited.dapui_config = function() ui.close() end
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "delve",
                },
                automatic_installation = true,
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                    delve = function(config)
                        table.insert(config.configurations, 1, {
                            args = function() return vim.split(vim.fn.input("args> "), " ") end,
                            type = "delve",
                            name = "file",
                            request = "launch",
                            program = "${file}",
                            outputMode = "remote",
                        })
                        table.insert(config.configurations, 1, {
                            args = function() return vim.split(vim.fn.input("args> "), " ") end,
                            type = "delve",
                            name = "file args",
                            request = "launch",
                            program = "${file}",
                            outputMode = "remote",
                        })
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
            })
        end,
    },
}
