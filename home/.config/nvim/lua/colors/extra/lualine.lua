local p = require("colors.palette")

local M = {}

M.theme = {
  normal = {
    a = { bg = p.crystalBlue,  fg = p.sumiInk0 },
    b = { bg = p.winterBlue,   fg = p.crystalBlue },
    c = { bg = p.sumiInk4,     fg = p.fujiWhite },
  },
  insert = {
    a = { bg = p.springGreen,  fg = p.sumiInk3 },
    b = { bg = p.sumiInk3,     fg = p.springGreen },
  },
  command = {
    a = { bg = p.boatYellow2,  fg = p.sumiInk3 },
    b = { bg = p.sumiInk3,     fg = p.boatYellow2 },
  },
  visual = {
    a = { bg = p.oniViolet,    fg = p.sumiInk3 },
    b = { bg = p.sumiInk3,     fg = p.oniViolet },
  },
  replace = {
    a = { bg = p.surimiOrange, fg = p.sumiInk3 },
    b = { bg = p.sumiInk3,     fg = p.surimiOrange },
  },
  inactive = {
    a = { bg = p.sumiInk0,     fg = p.oldWhite },
    b = { bg = p.sumiInk0,     fg = p.oldWhite, gui = "bold" },
    c = { bg = p.sumiInk0,     fg = p.oldWhite },
  },
}

return M
