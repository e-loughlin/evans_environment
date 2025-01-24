return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup {}

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local function create_finder()
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end
        return require("telescope.finders").new_table {
          results = file_paths,
        }
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = create_finder(),
          previewer = conf.file_previewer {},
          sorter = require("telescope.config").values.generic_sorter {},
          attach_mappings = function(prompt_bufnr, map)
            map("i", "<C-d>", function()
              local state = require "telescope.actions.state"
              local selected_entry = state.get_selected_entry()
              local current_picker = state.get_current_picker(prompt_bufnr)

              table.remove(harpoon_files.items, selected_entry.index)
              current_picker:refresh(create_finder())
            end)
            return true
          end,
        })
        :find()
    end

    -- Expose the toggle_telescope function globally
    _G.toggle_harpoon_telescope = function() toggle_telescope(harpoon:list()) end
  end,
}
