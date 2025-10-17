-- https://neovim.io/doc/user/treesitter.html

local c = require("colors/colors")
local u = require("colors/utilities")

-- @markup.strong: bold text
u.setHL(0, "@markup.strong", { fg = c.markdown.strong, bold = true })

-- @markup.italic: italic text
u.setHL(0, "@markup.italic", { fg = c.markdown.italic, italic = true })

-- -- @markup.strikethrough: struck-through text
-- @markup.strikethrough
--
-- -- @markup.underline: underlined text (only for literal underline markup!)
-- @markup.underline

-- @markup.heading: headings, titles (including markers)
u.setHL(0, "@markup.heading", { fg = c.markdown.heading, bold = true })

-- @markup.heading.1: top-level heading
u.setHL(0, "@markup.heading.1", { fg = c.markdown.heading1, bold = true })

-- @markup.heading.2: section heading
u.setHL(0, "@markup.heading.2", { fg = c.markdown.heading2, bold = true })

-- @markup.heading.3: subsection heading
u.setHL(0, "@markup.heading.3", { fg = c.markdown.heading3, bold = true })

-- @markup.heading.4: and so on
u.setHL(0, "@markup.heading.4", { fg = c.markdown.heading4, bold = true })

-- @markup.heading.5: and so forth
u.setHL(0, "@markup.heading.5", { fg = c.markdown.heading5, bold = true })

-- @markup.heading.6: six levels ought to be enough for anybody
u.setHL(0, "@markup.heading.6", { fg = c.markdown.heading6, bold = true })

-- @markup.quote: block quotes
u.setHL(0, "@markup.quote", { fg = c.markdown.quote, italic = true })

-- -- @markup.math: math environments (e.g. $ ... $ in LaTeX)
-- @markup.math

-- @markup.link: text references, footnotes, citations, etc.
u.setHL(0, "@markup.link", { fg = c.markdown.link, bold = true })

-- @markup.link.label: link, reference descriptions
u.cmd("hi! link @markup.link.label @markup.link")

-- NOTE: codeblocks language
u.setHL(0, "@label.markdown", { fg = c.markdown.label, bold = false })

-- INFO: For when the LSP might overwrite the treesitter link highlight
u.cmd("hi! link @lsp.type.class.markdown @markup.link")

-- -- @markup.link.url: URL-style links
-- @markup.link.url

-- @markup.raw: literal or verbatim text (e.g. inline code)
u.setHL(0, "@markup.raw", { fg = c.markdown.raw })

-- @markup.raw.block: literal or verbatim text as a stand-alone block
u.setHL(0, "@markup.raw.block", { fg = c.markdown.raw })

-- @markup.list: list markers
u.setHL(0, "@markup.list", { fg = c.markdown.fg })

-- @markup.list.checked: checked todo-style list markers
u.setHL(0, "@markup.list.checked", { fg = c.markdown.fg })

-- @markup.list.unchecked: unchecked todo-style list markers
u.setHL(0, "@markup.list.unchecked", { fg = c.markdown.fg })

-- INFO: Punctiuation
u.setHL(0, "@punctuation.special.markdown", { fg = c.markdown.fg })

-- INFO: Link
u.setHL(0, "@lsp.type.decorator.markdown", { fg = c.markdown.link })
