return {
  "navarasu/onedark.nvim",
  config = function(_, opts)
    require("onedark").setup(opts)
    require("onedark").load()
  end
}
