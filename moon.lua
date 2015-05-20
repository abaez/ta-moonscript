-- Copyright 2006-2011 Mitchell mitchell<att>caladbolg.net. See LICENSE.
-- Moonscript lexer by leaf corcoran <http://leafo.net>

local l = require("lexer")
local token, word_match = l.token, l.word_match
local P, S, R = lpeg.P, lpeg.S, lpeg.R

local M = { _NAME = 'moonscript' }

-- Whitespace.
local ws = token(l.WHITESPACE, l.space^1)

local longstring = lpeg.Cmt('[' * lpeg.C(P('=')^0) * '[',
                            function(input, index, eq)
                              local _, e = input:find(']'..eq..']', index, true)
                              return (e or #input) + 1
                            end)

-- Comments.
local line_comment = '--' * l.nonnewline^0
local block_comment = '--' * longstring
local comment = token(l.COMMENT, block_comment + line_comment)

-- Strings.
local sq_str = l.delimited_range("'", '\\', true)
local dq_str = l.delimited_range('"', '\\', true)
local string = token(l.STRING, sq_str + dq_str) +
  token('longstring', longstring)

-- Numbers.
local number = token(l.NUMBER, l.float + l.integer)

-- Keywords.
local keyword = token(l.KEYWORD, word_match {
  -- lua
  'and', 'break', 'do', 'else', 'elseif', 'false', 'for',
  'if', 'in', 'local', 'nil', 'not', 'or', 'return', 'self', 'then',
  'true', 'while',
  -- moonscript
  'continue', 'class', 'export', 'extends', 'from', 'import', 'super',
  'switch', 'unless', 'using', 'when', 'with'
})

-- Constants.
local constant = token(l.CONSTANT, word_match{
  '_G', '_VERSION',
  -- Added in 5.2.
  '_ENV'
})

-- Functions.
local func = token(l.FUNCTION, word_match{
  'assert', 'collectgarbage', 'dofile', 'error', 'getmetatable', 'ipairs',
  'load', 'loadfile', 'next', 'pairs', 'pcall', 'print', 'rawequal', 'rawget',
  'rawset', 'require', 'select', 'setmetatable', 'tonumber', 'tostring', 'type',
  'xpcall',
  -- Added in 5.2.
  'rawlen'
})


-- Libraries.
local library = token('library', word_match({
  -- Coroutine.
  'coroutine', 'coroutine.create', 'coroutine.resume', 'coroutine.running',
  'coroutine.status', 'coroutine.wrap', 'coroutine.yield',
  -- Coroutine added in 5.3.
  'coroutine.isyieldable',
  -- Module.
  'package', 'package.cpath', 'package.loaded', 'package.loadlib',
  'package.path', 'package.preload',
  -- Module added in 5.2.
  'package.config', 'package.searchers', 'package.searchpath',
  -- UTF-8 added in 5.3.
  'utf8', 'utf8.char', 'utf8.charpattern', 'utf8.codepoint', 'utf8.codes',
  'utf8.len', 'utf8.offset',
  -- String.
  'string', 'string.byte', 'string.char', 'string.dump', 'string.find',
  'string.format', 'string.gmatch', 'string.gsub', 'string.len', 'string.lower',
  'string.match', 'string.rep', 'string.reverse', 'string.sub', 'string.upper',
  -- String added in 5.3.
  'string.pack', 'string.packsize', 'string.unpack',
  -- Table.
  'table', 'table.concat', 'table.insert', 'table.remove', 'table.sort',
  -- Table added in 5.2.
  'table.pack', 'table.unpack',
  -- Table added in 5.3.
  'table.move',
  -- Math.
  'math', 'math.abs', 'math.acos', 'math.asin', 'math.atan', 'math.ceil',
  'math.cos', 'math.deg', 'math.exp', 'math.floor', 'math.fmod', 'math.huge',
  'math.log', 'math.max', 'math.min', 'math.modf', 'math.pi', 'math.rad',
  'math.random', 'math.randomseed', 'math.sin', 'math.sqrt', 'math.tan',
  -- Math added in 5.3.
  'math.maxinteger', 'math.mininteger', 'math.tointeger', 'math.type',
  'math.ult',
  -- IO.
  'io', 'io.close', 'io.flush', 'io.input', 'io.lines', 'io.open', 'io.output',
  'io.popen', 'io.read', 'io.stderr', 'io.stdin', 'io.stdout', 'io.tmpfile',
  'io.type', 'io.write',
  -- OS.
  'os', 'os.clock', 'os.date', 'os.difftime', 'os.execute', 'os.exit',
  'os.getenv', 'os.remove', 'os.rename', 'os.setlocale', 'os.time',
  'os.tmpname',
  -- Debug.
  'debug', 'debug.debug', 'debug.gethook', 'debug.getinfo', 'debug.getlocal',
  'debug.getmetatable', 'debug.getregistry', 'debug.getupvalue',
  'debug.sethook', 'debug.setlocal', 'debug.setmetatable', 'debug.setupvalue',
  'debug.traceback',
  -- Debug added in 5.2.
  'debug.getuservalue', 'debug.setuservalue', 'debug.upvalueid',
  'debug.upvaluejoin',
}, '.'))

-- Identifiers.
local identifier = token(l.IDENTIFIER, l.word)

local fndef = token("fndef", P"->" + P"=>")
local err = token(l.ERROR, word_match { "function", "end" })

-- Operators.
local symbol = token("symbol", S("(){}[]"))
local operator = token(l.OPERATOR, '~=' + S('+-*!\\/%^#=<>;:,.'))

-- self ref
local self_var = token("self_ref", "@" * l.word + "self")

local proper_ident = token("proper_ident", R("AZ") * l.word)

local tbl_key = token("tbl_key", l.word * ":" + ":" * l.word )

M._rules = {
  { 'whitespace', ws },
  { 'error', err },
  { 'self', self_var },
  { 'keyword', keyword },
  { 'function', func},
  { 'constant', constant},
  { 'library', library },
  { 'identifier', proper_ident + tbl_key + identifier },
  { 'comment', comment },
  { 'number', number },
  { 'string', string },
  { 'fndef', fndef },
  { 'symbol', symbol },
  { 'operator', operator },
  { 'any_char', l.any_char },
}

local style_special = { fore = l.colors.light_blue }
local style_fndef = { fore = l.colors.green }

M._tokenstyles = {
  { 'self_ref', style_special },
  { 'proper_ident', l.style_class },
  { 'fndef', style_fndef },
  { 'symbol', style_fndef },
  { 'special', style_special },
  { 'tbl_key', { fore = l.colors.red } },
}

return M
