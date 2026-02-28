-- Semantic color mapping.
-- Maps palette colors to their roles in the editor.
-- Change what color a role uses here; change the hex value in palette.lua.

local p = require("colors.palette")

return {
  ui = {
    -- Foregrounds
    fg         = p.oldWhite,       -- Default text (Normal)
    fg_bright  = p.fujiWhite,      -- Brighter text (variables, pmenu items)
    fg_reverse = p.waveBlue1,      -- Dark fg for light backgrounds

    -- Backgrounds
    bg_dark    = p.sumiInk0,       -- Darkest: floats, sidebars
    bg_dim     = p.sumiInk1,       -- Dim background
    bg         = p.sumiInk3,       -- Main editor background
    bg_gutter  = p.sumiInk4,       -- Gutter, status line
    bg_cursorline = p.sumiInk5,    -- Cursor line, column highlights

    -- Selection & search
    bg_search  = p.waveBlue2,
    bg_visual  = p.winterYellow,

    -- UI elements
    special    = p.springViolet1,   -- Folded text, conceal, titles
    nontext    = p.sumiInk6,        -- Non-text chars, borders, whitespace
    directory  = p.crystalBlue,
    more_msg   = p.dragonBlue,
    mode_msg   = p.roninYellow,     -- Also used for MatchParen, IncSearch

    -- Floating windows
    float = {
      fg     = p.oldWhite,
      bg     = p.sumiInk0,
      border = p.sumiInk6,
      title  = p.springViolet1,
    },

    -- Popup menu
    pmenu = {
      fg       = p.fujiWhite,
      bg       = p.waveBlue1,
      bg_sel   = p.waveBlue2,
      bg_sbar  = p.waveBlue1,
      bg_thumb = p.waveBlue2,
    },
  },

  syntax = {
    -- Identifiers
    variable    = p.fujiWhite,
    constant    = p.fujiWhite,
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
    fg       = p.oldWhite,
    heading  = p.roninYellow,
    heading1 = p.roninYellow,
    heading2 = p.roninYellow,
    heading3 = p.surimiOrange,
    heading4 = p.surimiOrange,
    heading5 = p.surimiOrange,
    heading6 = p.surimiOrange,
    strong   = p.carpYellow,
    italic   = p.carpYellow,
    raw      = p.oniViolet2,
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
