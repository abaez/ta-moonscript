--- the Textadept initializer for the Moonscript module.
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module init

textadept.file_types.extensions.moon = 'moonscript'
textadept.editing.comment_string.moonscript = '--'

textadept.run.compile_commands.moonscript = 'moonc %f'
textadept.run.run_commands.moonscript = 'lua %d%e.lua'

if type(snippets) == 'table' then
  snippets.moonscript = require("moonscript.snippets")
end

events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'moonscript' then return end

  buffer.tab_width = 2
  buffer.use_tabs = false
end)

return { moonscript = 'moonscript' }
