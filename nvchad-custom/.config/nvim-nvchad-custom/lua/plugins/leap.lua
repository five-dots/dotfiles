return {
  "ggandor/leap.nvim",
  event = "VeryLazy",
  config = function()
    require("leap").create_default_mappings()
  end,
  dependencies = {
    -- flit.nvim for f/F/t/T movements
    {
      "ggandor/flit.nvim",
      config = function()
        require("flit").setup()
      end,
    },
  },
}
