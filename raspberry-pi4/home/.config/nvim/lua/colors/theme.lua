-- Semantic color mapping.
-- Maps palette colors to their roles in the editor.
-- Change what color a role uses here; change the hex value in palette.lua.

local p = require("colors.palette")

return {
  ui = {
    -- Foregrounds
    fg         = p.vissWhite,      -- Default text (Normal)
    fg_bright  = p.vissWhite2,     -- Brighter text (variables, pmenu items)
    fg_reverse = p.waveBlue1,      -- Dark fg for light backgrounds

    -- Backgrounds
    bg_dark       = p.dragonBlack0,    -- Darkest: floats, sidebars
    bg_dim        = p.dragonBlack1,    -- Dim background
    bg            = p.dragonBlack3,    -- Main editor background
    bg_gutter     = p.dragonBlack4,    -- Gutter, status line
    bg_cursorline = p.dragonBlack5,    -- Cursor line, column highlights

    -- Selection & search
    bg_search  = p.waveBlue2,
    bg_visual  = p.winterYellow,

    -- UI elements
    special    = p.springViolet1,   -- Folded text, conceal, titles
    nontext    = p.dragonBlack6,        -- Non-text chars, borders, whitespace
    directory  = p.crystalBlue,
    more_msg   = p.dragonBlue,
    mode_msg   = p.roninYellow,     -- Also used for MatchParen, IncSearch

    -- Floating windows
    float = {
      fg     = p.vissWhite,
      bg     = p.dragonBlack0,
      border = p.dragonBlack6,
      title  = p.springViolet1,
    },

    -- Popup menu
    pmenu = {
      fg       = p.vissWhite,
      bg       = p.waveBlue1,
      bg_sel   = p.waveBlue2,
      bg_sbar  = p.waveBlue1,
      bg_thumb = p.waveBlue2,
    },
  },

  syntax = {
    -- Identifiers
    variable    = p.vissWhite2,
    constant    = p.vissWhite2,
    identifier  = p.carpYellow,
    property    = p.carpYellow,
    parameter   = p.oniViolet2,

    -- Functions
    procedure   = p.crystalBlue,

    -- Literals
    string      = p.springGreen,
    specialchar = p.autumnGreen,
    number      = p.surimiOrange,

    -- Types & modules
    type        = p.waveAqua2,
    module      = p.waveAqua2,

    -- Operators & delimiters
    operator    = p.boatYellow2,
    regexp      = p.boatYellow2,
    delimiter   = p.springViolet2,

    -- Keywords
    keyword     = p.oniViolet,
    exception   = p.waveRed,
    preproc     = p.sakuraPink,

    -- Specials & builtins
    special     = p.springBlue,
    builtin     = p.springBlue,

    -- Comments & deprecated
    comment     = p.fujiGray,
    deprecated  = p.katanaGray,
  },

  markdown = {
    fg       = p.vissWhite,
    heading  = p.carpYellow,
    heading1 = p.carpYellow,
    heading2 = p.carpYellow,
    heading3 = p.carpYellow,
    heading4 = p.carpYellow,
    heading5 = p.carpYellow,
    heading6 = p.carpYellow,
    strong   = p.oldWhite,
    italic   = p.oniViolet2,
    raw      = p.boatYellow2,
    label    = p.oniViolet,
    link     = p.sakuraPink,
    quote    = p.springViolet2,
  },

  vcs = {
    added   = p.autumnGreen,
    removed = p.autumnRed,
    changed = p.autumnYellow,
  },

  diff = {
    add    = p.winterGreen,
    delete = p.winterRed,
    change = p.winterBlue,
    text   = p.winterYellow,
  },

  diag = {
    ok      = p.springGreen,
    error   = p.samuraiRed,
    warning = p.roninYellow,
    info    = p.crystalBlue,
    hint    = p.waveAqua1,
  },
}
