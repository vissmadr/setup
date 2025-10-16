-- https://neovim.io/doc/user/syntax.html

local c = require("colors/colors")
local u = require("colors/utilities")

-- Normal: Normal text.
u.setHL(0, "Normal", { fg = c.ui.fg_dim })

-- NormalNC: Normal text in non-current windows.
u.cmd("hi! link NormalNC Normal");

-- -- ColorColumn: Used for the columns set with 'colorcolumn'.
-- ColorColumn

-- Conceal: Placeholder characters substituted for concealed
u.setHL(0, "Conceal", { fg = c.ui.conceal })

-- CurSearch: Current match for the last search pattern (see 'hlsearch'). Note: This is correct after a search, but may get outdated if changes are made or the screen is redrawn.
u.setHL(0, "CurSearch", { fg = c.ui.white, bg = c.ui.bg_search, bold = true })

-- -- Cursor: Character under the cursor.
-- Cursor

-- -- lCursor: Character under the cursor when language-mapping is used (see 'guicursor').
-- u.cmd("hi! link lCursor Cursor");

-- -- CursorIM: Like Cursor, but used when in IME mode. CursorIM
-- u.cmd("hi! link CursorIM Cursor");

-- CursorLine: Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
u.setHL(0, "CursorLine", { bg = c.ui.bg_p2 })

-- CursorColumn: Screen-column at the cursor, when 'cursorcolumn' is set. hl-CursorLine  
u.cmd("hi! link CursorColumn CursorLine");

-- Visual: Visual mode selection.
u.setHL(0, "Visual", { bg = c.ui.bg_visual })

-- VisualNOS: Visual mode selection when vim is "Not Owning the Selection".
u.cmd("hi! link VisualNOS Visual");

-- Search: Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
u.setHL(0, "Search", { bg = c.ui.bg_search })

-- IncSearch: 'incsearch' highlighting; also used for the text replaced with ":s///c".
u.setHL(0, "IncSearch", { fg = c.ui.black, bg = c.diag.warning, bold = true })

-- Directory: Directory names (and other special names in listings).
u.setHL(0, "Directory", { fg = c.ui.directory })

-- -- EndOfBuffer: Filler lines (~) after the last line in the buffer. By default, this is highlighted like hl-NonText.
-- EndOfBuffer

-- -- TermCursor: Cursor in a focused terminal.
-- TermCursor

-- ErrorMsg: Error messages on the command line.
u.setHL(0, "ErrorMsg", { fg = c.diag.error })

-- -- StderrMsg: Messages in stderr from shell commands.
-- StderrMsg

-- -- StdoutMsg: Messages in stdout from shell commands.
-- StdoutMsg

-- WinSeparator: Separators between window splits.
u.setHL(0, "WinSeparator", { fg = c.ui.win_separator, bg = "NONE" })

-- Folded: Line used for closed folds.
u.setHL(0, "Folded", { fg = c.ui.special, bg = "NONE" })

-- -- FoldColumn: 'foldcolumn'
-- FoldColumn

-- -- SignColumn: Column where signs are displayed.
-- SignColumn

-- -- Substitute: :substitute replacement text highlighting.
-- Substitute

-- -- LineNr: Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
-- LineNr

-- -- LineNrAbove: Line number for when the 'relativenumber' option is set, above the cursor line.
-- LineNrAbove

-- -- LineNrBelow: Line number for when the 'relativenumber' option is set, below the cursor line.
-- LineNrBelow

-- -- CursorLineNr: Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
-- CursorLineNr

-- -- CursorLineFold: Like FoldColumn when 'cursorline' is set for the cursor line.
-- CursorLineFold

-- -- CursorLineSign: Like SignColumn when 'cursorline' is set for the cursor line.
-- CursorLineSign

-- MatchParen: Character under the cursor or just before it, if it is a paired bracket, and its match. pi_paren.txt
u.setHL(0, "MatchParen", { fg = c.ui.mode_msg, bold = true })

-- ModeMsg: 'showmode' message (e.g., "-- INSERT --").
u.setHL(0, "ModeMsg", { fg = c.ui.mode_msg, bold = true })

-- -- MsgArea: Area for messages and command-line, see also 'cmdheight'.
-- MsgArea

-- -- MsgSeparator: Separator for scrolled messages msgsep.
-- MsgSeparator

-- MoreMsg: more-prompt  
u.setHL(0, "MoreMsg", { fg = c.ui.more_msg })

-- NonText: '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also hl-EndOfBuffer.
u.setHL(0, "NonText", { fg = c.ui.nontext })

-- NormalFloat: Normal text in floating windows.
u.setHL(0, "NormalFloat", { fg = c.ui.float.fg })

-- FloatBorder: Border of floating windows.
u.setHL(0, "FloatBorder", { fg = c.ui.float.border })

-- FloatTitle: Title of floating windows.
u.setHL(0, "FloatTitle", { fg = c.ui.float.title, bg = c.ui.float.bg, bold = true })

-- FloatFooter: Footer of floating windows.
u.setHL(0, "FloatFooter", { fg = c.ui.nontext, bg = c.ui.float.bg })

-- -- Pmenu: Popup menu: Normal item.
-- u.setHL(0, "Pmenu", { bg = c.ui.pmenu.bg })

-- -- PmenuSel: Popup menu: Selected item. Combined with hl-Pmenu.
-- u.setHL(0, "PmenuSel", { bg = c.ui.pmenu.bg_sel })

-- -- PmenuKind: Popup menu: Normal item "kind".
-- u.setHL(0, "PmenuKind", { fg = c.ui.fg_dim , bg = c.ui.pmenu.bg })

-- -- PmenuKindSel: Popup menu: Selected item "kind".
-- u.setHL(0, "PmenuKindSel", { fg = c.ui.fg_dim , bg = c.ui.pmenu.bg_sel })

-- -- PmenuExtra: Popup menu: Normal item "extra text".
-- u.setHL(0, "PmenuExtra", { fg = c.ui.special , bg = c.ui.pmenu.bg })

-- -- PmenuExtraSel: Popup menu: Selected item "extra text".
-- u.setHL(0, "PmenuExtraSel", { fg = c.ui.special , bg = c.ui.pmenu.bg_sel })

-- -- PmenuSbar: Popup menu: Scrollbar.
-- u.setHL(0, "PmenuSbar", { bg = c.ui.pmenu.bg_sbar })

-- -- PmenuThumb: Popup menu: Thumb of the scrollbar.
-- u.setHL(0, "PmenuThumb", { bg = c.ui.pmenu.bg_thumb })

-- -- PmenuMatch: Popup menu: Matched text in normal item. Combined with hl-Pmenu.
-- u.setHL(0, "PmenuMatch", { bold = true })

-- -- PmenuMatchSel: Popup menu: Matched text in selected item. Combined with hl-PmenuMatch and hl-PmenuSel.
-- u.setHL(0, "PmenuMatchSel", { bold = true })

-- -- ComplMatchIns: Matched text of the currently inserted completion.
-- ComplMatchIns

-- -- ComplHint: Virtual text of the currently selected completion.
-- ComplHint

-- -- ComplHintMore: The additional information of the virtual text.
-- ComplHintMore

-- -- Question: hit-enter prompt and yes/no questions.
u.cmd("hi! link Question MoreMsg")

-- -- QuickFixLine: Current quickfix item in the quickfix window. Combined with hl-CursorLine when the cursor is there.
-- QuickFixLine

-- -- SnippetTabstop: Tabstops in snippets. vim.snippet
-- SnippetTabstop

-- -- SnippetTabstopActive: The currently active tabstop. vim.snippet
-- SnippetTabstopActive

-- -- SpecialKey: Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. hl-Whitespace
-- SpecialKey

-- SpellBad: Word that is not recognized by the spellchecker. spell Combined with the highlighting used otherwise.
u.setHL(0, "SpellBad", { sp = c.diag.error, undercurl = true })

-- SpellCap: Word that should start with a capital. spell Combined with the highlighting used otherwise.
u.setHL(0, "SpellCap", { sp = c.diag.warning, undercurl = true })

-- SpellLocal: Word that is recognized by the spellchecker as one that is used in another region. spell Combined with the highlighting used otherwise.
u.setHL(0, "SpellLocal", { sp = c.diag.warning, undercurl = true })

-- SpellRare: Word that is recognized by the spellchecker as one that is hardly ever used. spell Combined with the highlighting used otherwise.
u.setHL(0, "SpellRare", { sp = c.diag.warning, undercurl = true })

-- StatusLine: Status line of current window.
u.setHL(0, "StatusLine", { fg = "NONE", bg = c.ui.bg_p1 })

-- StatusLineNC: Status lines of not-current windows.
u.cmd("hi! link StatusLineNC StatusLine");

-- StatusLineTerm: Status line of terminal window.
u.cmd("hi! link StatusLineTerm StatusLine");

-- StatusLineTermNC: Status line of non-current terminal windows.
u.cmd("hi! link StatusLineTermNC StatusLine");

-- -- TabLine: Tab pages line, not active tab page label.
-- TabLine

-- -- TabLineFill: Tab pages line, where there are no labels.
-- TabLineFill

-- -- TabLineSel: Tab pages line, active tab page label.
-- TabLineSel

-- Title: Titles for output from ":set all", ":autocmd" etc.
u.setHL(0, "Title", { fg = c.ui.title, bold = true })

-- WarningMsg: Warning messages.
u.setHL(0, "WarningMsg", { fg = c.diag.warning })

-- Whitespace: "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
u.setHL(0, "Whitespace", { fg = c.ui.whitespace })

-- WildMenu: Current match in 'wildmenu' completion.
u.cmd("hi! link WildMenu Pmenu");

u.setHL(0, "healthSuccess", { fg = c.diag.ok })
u.setHL(0, "healthWarning", { fg = c.diag.warning })
u.setHL(0, "healthError",   { fg = c.diag.error })

-- -- WinBar: Window bar of current window.
-- WinBar

-- -- WinBarNC: Window bar of not-current windows. hl-User1 hl-User1..9 hl-User9 The 'statusline' syntax allows the use of 9 different highlights in the statusline and ruler (via 'rulerformat').  The names are User1 to User9. For the GUI you can use the following groups to set the colors for the menu, scrollbars and tooltips.  They don't have defaults.  This doesn't work for the Win32 GUI.  Only three highlight arguments have any effect here: font, guibg, and guifg.
-- WinBarNC

-- -- Menu: Current font, background and foreground colors of the menus. Also used for the toolbar. Applicable highlight arguments: font, guibg, guifg.
-- Menu

-- -- Scrollbar: Current background and foreground of the main window's scrollbars. Applicable highlight arguments: guibg, guifg.
-- Scrollbar

-- -- Tooltip: Current font, background and foreground of the tooltips. Applicable highlight arguments: font, guibg, guifg.
-- Tooltip
