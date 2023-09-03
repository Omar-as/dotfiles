local opt = vim.opt
local g = vim.g

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.cmd [[ 
    set nowrap
    set ignorecase
    set noswapfile
    set noerrorbells
    set backspace=indent,eol,start

    colorscheme dracula
    let g:mkdp_auto_start=1
    set signcolumn=yes

    map ; :
]]


g.mapleader = ' '

opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.number = true

opt.smartcase = true
opt.ttimeoutlen = 5
opt.compatible = false
opt.autoread = true
opt.incsearch = true
opt.hidden = true
opt.shortmess = "A"

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

require('neogit').setup{}

require('lualine').setup{
    options = {theme = "dracula"}
}

-- require("bufferline").setup{}

require('nvim_comment').setup({
      marker_mapping = true

    , comment_empty_trim_whitespace = false
    , create_mappings = true
    , comment_empty = false
    , line_mapping = "<leader>lc", operator_mapping = "<leader>c", comment_chunk_text_object = "ic"
})


require('gitsigns').setup {
	signs = {
		add = { text = '+' },
		change = { text = '~' },
        	delete = { text = '_' },
        	topdelete = { text = '‾' },
        	changedelete = { text = '~' },
	},
}


require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}


-- require'nvim-treesitter.configs'.setup{
--     enable = true
-- }

require('telescope').setup{}

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fo', builtin.oldfiles, {})

-- Declare the vim global (for LSP)
_G.vim = vim

-- { Execution }

_G.exec = {}
-- Executes an ex-command
_G.exec.command = vim.api.nvim_command
-- Executes VimScript code
_G.exec.vimscript = vim.cmd
-- Invokes a Vim function or a user function
_G.fn = vim.fn

-- { Options }

_G.options = {}
_G.options.global = vim.go
_G.options.window = vim.wo
_G.options.buffer = vim.bo
_G.options.object = vim.opt

-- { Variables }

_G.variables = {}
_G.variables.global = vim.g
_G.variables.environment = vim.env
-- require "globals"
local lsp_config = require "lspconfig"
local cmp = require "cmp_nvim_lsp" -- auto completion capabilities

-- NOTE: Both Java and Kotlin language servers do not support single files.
local servers = {
	-- "bashls", -- Bash
	"ccls", -- C/C++
	-- "html", -- HTML
	-- "cssls", -- CSS
	-- "tsserver", -- JavaScript/TypeScript
	-- "jsonls", -- JSON
	"pyright", -- Python
	-- "yamlls", -- YAML
	-- "vimls", -- VimScript
	"lua_ls", -- Lua
	-- "diagnosticls", -- Diagnostics
	-- "rust_analyzer", -- Rust
	"rnix", -- Nix
	-- "racket_langserver", -- Racket/Scheme
	-- "texlab" -- LaTeX
}

local create_auto_group = function(name, autoCommands, isLocalToBuffer)
	isLocalToBuffer = isLocalToBuffer or false
	exec.vimscript ("augroup " .. name)

	-- Clear previous auto groups with this name
	if isLocalToBuffer then
		exec.vimscript "autocmd! * <buffer>"
	else
		exec.vimscript "autocmd!"
	end

	for _, autoCommand in ipairs(autoCommands) do
        exec.vimscript ("autocmd " .. autoCommand)
	end
	exec.vimscript "augroup end"
end

-- local customize_server_options = {
-- 	diagnosticls = require "plugins.lsp.diagnostic"
-- }

local get_diagnostics_options = function()
	local options = {
		underline = true,
		virtual_text = false,
		signs = true,
		update_in_insert = false
	}

	return vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, options)
end

local on_attach = function(client, buffer_num)
    -- Enable 'omnifunc' compatible LSP completion
	vim.api.nvim_buf_set_option(buffer_num, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Diagnostics custom configuration
	vim.lsp.handlers["textDocument/publishDiagnostics"] = get_diagnostics_options()

    exec.vimscript ("autocmd " .. "CursorHold,CursorHoldI * lua vim.diagnostic.open_float({ focusable = false })")

	-- Set highlighting autocommand if server supports that
	if client.server_capabilities.document_highlight then
		create_auto_group("LSPDocumentHighlight", {
			"CursorHold <buffer> lua vim.lsp.buf.document_highlight()",
			"CursorMoved <buffer> lua vim.lsp.buf.clear_references()"
		})
	end
end

local get_default_server_config = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- Enable snippet support
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	-- nvim-cmp supports more LSP capabilities
	capabilities = cmp.default_capabilities(capabilities)

	return {
		capabilities = capabilities,
		on_attach = on_attach
	}
end

local setup_servers = function()
	for _, server in ipairs(servers) do
		local config = get_default_server_config()

		-- if customize_server_options[server] then
		-- 	-- Apply the custom options to the default ones
		-- 	customize_server_options[server](config)
		-- end

		lsp_config[server].setup(config)
	end
end

setup_servers()
variables.global.UltiSnipsExpandTrigger = "<plug>(ultisnips_expand)"
variables.global.UltiSnipsJumpForwardTrigger = "<plug>(ultisnips_jump_forward)"
variables.global.UltiSnipsJumpBackwardTrigger = "<plug>(ultisnips_jump_backward)"
variables.global.UltiSnipsListSnippets = "<c-x><c-s>"
variables.global.UltiSnipsRemoveSelectModeMappings = 0

local cmp = require "cmp"
local types = require "cmp.types"

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup {
	completion = { autocomplete = { types.cmp.TriggerEvent.TextChanged } },
	snippet = {
		expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end
	},
	mapping = {
		["<tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					return cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				end
				cmp.complete()
			end,
			i = function(fallback)
				if cmp.visible() then
					return cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
					return vim.api.nvim_feedkeys(t("<plug>(ultisnips_jump_forward)"), "m", true)
				end
				fallback()
			end,
			s = function(fallback)
				if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
					return vim.api.nvim_feedkeys(t("<plug>(ultisnips_jump_forward)"), "m", true)
				end
				fallback()
			end
		}),
		["<s-tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					return cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				end
				cmp.complete()
			end,
			i = function(fallback)
				if cmp.visible() then
					return cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
					return vim.api.nvim_feedkeys(t("<plug>(ultisnips_jump_backward)"), "m", true)
				end
				fallback()
			end,
			s = function(fallback)
				if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
					return vim.api.nvim_feedkeys(t("<plug>(ultisnips_jump_backward)"), "m", true)
				end
				fallback()
			end
		}),
		["<c-n>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					return cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				end
				vim.api.nvim_feedkeys(t("<down>"), "n", true)
			end,
			i = function(fallback)
				if cmp.visible() then
					return cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				end
				fallback()
			end
		}),
		["<c-p>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					return cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				end
				vim.api.nvim_feedkeys(t("<up>"), "n", true)
			end,
			i = function(fallback)
				if cmp.visible() then
					return cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				end
				fallback()
			end
		}),
		["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
		["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
		["<c-e>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() then
					return cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				end
				fallback()
			end
		})
	},
	sources = {
		{ name = "ultisnips" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "path" }
	}
}

-- Configure autocompletion for searches
cmp.setup.cmdline("/", {
	completion = { autocomplete = { types.cmp.TriggerEvent.TextChanged } },
	sources = {
		{ name = "buffer" }
	}
})

-- Configure autocompletion for commands
cmp.setup.cmdline(":", {
	completion = { autocomplete = { types.cmp.TriggerEvent.TextChanged } },
	sources = {
		{ name = "path" },
		{ name = "cmdline" }
	}
})
