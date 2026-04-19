return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "lua_ls",
            "rust_analyzer",
            "gopls",
            "vtsls",
            "tailwindcss",
            "clangd",
        },
    },
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    package_installed = "",
                    package_pending = "",
                    package_uninstalled = ""
                },
            },
        },
        "neovim/nvim-lspconfig",
    },
}
