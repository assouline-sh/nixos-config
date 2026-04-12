return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.bg = "#0a0e14"
        colors.bg_dark = "#070a0f"
        colors.bg_float = "#0d1117"
        colors.bg_popup = "#0d1117"
        colors.bg_sidebar = "#070a0f"
        colors.blue = "#5ea1ff"
        colors.cyan = "#4ecdc4"
        colors.green = "#4ecdc4"
        colors.magenta = "#c678dd"
        colors.red = "#ff3366"
        colors.yellow = "#f0c674"
        colors.orange = "#f0c674"
      end,
    },
  },
}
