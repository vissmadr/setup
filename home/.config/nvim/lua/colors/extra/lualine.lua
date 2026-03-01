local p = require("colors.palette")

local M = {}

M.theme = {
  normal = {
    a = { bg = p.boatYellow1,  fg = p.background },
    b = { bg = p.background,     fg = p.boatYellow1 },
    c = { bg = p.background,     fg = p.vissWhite2 },
  },
  insert = {
    a = { bg = p.autumnGreen,  fg = p.background },
    b = { bg = p.background,     fg = p.springGreen },
  },
  visual = {
    a = { bg = p.oniViolet,    fg = p.background },
    b = { bg = p.background,     fg = p.oniViolet },
  },
  command = {
    a = { bg = p.dragonBlue2,  fg = p.background },
    b = { bg = p.winterBlue,   fg = p.dragonBlue2 },
    c = { bg = p.background,     fg = p.fujiWhite },
  },
  replace = {
    a = { bg = p.waveAqua1, fg = p.background },
    b = { bg = p.background,     fg = p.waveAqua1 },
  },
  inactive = {
    a = { bg = p.dragonBlack0,     fg = p.oldWhite },
    b = { bg = p.dragonBlack0,     fg = p.oldWhite, gui = "bold" },
    c = { bg = p.dragonBlack0,     fg = p.oldWhite },
  },
}

return M
