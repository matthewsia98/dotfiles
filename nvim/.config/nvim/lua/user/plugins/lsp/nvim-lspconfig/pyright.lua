local M = {}

M.setup = function(opts)
    local lspconfig = require("lspconfig")
    lspconfig["pyright"].setup({
        capabilities = opts.capabilities,
        flags = opts.flags,
        handlers = opts.handlers,
        on_attach = opts.on_attach,

        settings = {
            python = {
                -- Path to Python interpreter
                -- pythonPath = "",

                -- Path to folder with subdirectories that contain virtual environments.
                -- venvPath = "",
                analysis = {
                    -- Determines whether pyright offers auto-import completions.
                    autoImportCompletions = true,

                    -- Determines whether pyright automatically adds common search paths like "src" if there are no execution environments defined in the config file.
                    autoSearchPaths = false,

                    --[[
                    Determines whether pyright analyzes (and reports errors for) all files in the workspace, as indicated by the config file.
                    If this option is set to "openFilesOnly", pyright analyzes only open files.
                    ]]
                    diagnosticMode = "workspace", -- "openFilesOnly" | "workspace"

                    -- Paths to add to the default execution environment extra paths if there are no execution environments defined in the config file.
                    extraPaths = {},

                    -- Level of logging for Output panel. The default value for this option is "Information".
                    logLevel = "Information", -- "Error", "Warning", "Information", "Trace"

                    -- Path to directory containing custom type stub files.
                    -- stubPath = "",

                    -- Determines the default type-checking level used by pyright. This can be overridden in the configuration file.
                    typeCheckingMode = "strict", -- "off" | "basic" | "strict"

                    -- Paths to look for typeshed modules. Pyright currently honors only the first path in the array.
                    typeshedPaths = {},

                    --[[
                    Determines whether pyright reads, parses and analyzes library code to extract type information in the absence of type stub files.
                    Type information will typically be incomplete.
                    We recommend using type stubs where possible. The default value for this option is false.
                    ]]
                    useLibraryCodeForTypes = false,
                },
            },
            pyright = {
                --[[
                Disables all language services except for “hover”.
                This includes type completion, signature completion, find definition, find references, and find symbols in file.
                This option is useful if you want to use pyright only as a type checker but want to run another Python language server for language service features.
                ]]
                disableLanguageServices = false,

                --[[
                Disables the “Organize Imports” command.
                This is useful if you are using another extension that provides similar functionality and you don’t want the two extensions to fight each other.
                Accessible in Neovim with :PyrightOrganizeImports
                ]]
                disableOrganizeImports = true,
            },
        },
    })
end

return M
