require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "<Esc>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Gerneral Escape terminal mode" })

-- MarkdownPreview
map("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", { desc = "Markdown Preview: Toggle" })

-- Telekasten
map("n", "<leader>zp", function()
	require("telekasten").panel()
end, { desc = "Telekasten: Open Panel", nowait = true })
map("n", "<leader>zc", function()
	require("telekasten").show_calendar()
end, { desc = "Telekasten: Open Calendar", nowait = true })
map("n", "<leader>zn", function()
	require("telekasten").new_note()
end, { desc = "Telekasten: Create New Note", nowait = true })
map("n", "<leader>zi", function()
	require("telekasten").insert_link()
end, { desc = "Telekasten: Insert Link in Nonte", nowait = true })
map("n", "<leader>zv", function()
	require("telekasten").paste_img_and_link()
end, { desc = "Telekasten: Paste Image in Note", nowait = true })
map("n", "<leader>zf", function()
	require("telekasten").find_notes()
end, { desc = "Telekasten: Find Notes", nowait = true })
map("n", "<leader>zt", function()
	require("telekasten").goto_today()
end, { desc = "Telekasten: Goto Today's Note", nowait = true })
map("n", "<leader>zz", function()
	require("telekasten").find_friends()
end, { desc = "Telekasten: List Linking Notes", nowait = true })
map("n", "<leader>zs", function()
	local subject_path = vim.fn.expand("~/school/zettelkasten/school/")
	local p, d, i = io.popen('find "' .. subject_path .. '" -maxdepth 1 -type d -printf "%f\n"'), {}, 0

	if p == nil then
		return
	end

	for file in p:lines() do --Loop through all files
		i = i + 1
		d[i] = file
	end

	table.remove(d, 1)

	local choices = { "Select Subject:" }
	for k, v in pairs(d) do
		table.insert(choices, k .. ". " .. v:gsub("^%l", string.upper))
	end

	local subject = vim.fn.inputlist(choices)
	if subject == nil or subject == "" then
		return
	end
	local fname = vim.fn.input("Name: ", "")
	if fname == "" then
		fname = os.date("%Y-%m-%d-%H")
	end
	local note_name = "school/" .. d[subject] .. "/" .. fname
	require("telekasten").new_note_with_title({}, note_name)
end, { desc = "Telekasten: New School Note", nowait = true })

-- other
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
