" syntax hilighting for haskell
"
" Heavily modified version of the haskell syntax
" hilighter to support haskell.
"
" author: raichoo (raichoo@googlemail.com)

if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

syn spell notoplevel
syn match haskellRecordField contained containedin=haskellBlock
  \ "[_a-z][a-zA-Z0-9_']*\(,\s*[_a-z][a-zA-Z0-9_']*\)*\(\s*::\|\n\s\+::\)"
  \ contains=
  \ haskellIdentifier,
  \ haskellOperators,
  \ haskellSeparator,
  \ haskellParens
syn match haskellTypeSig
  \ "^\s*\(where\s\+\|let\s\+\|default\s\+\)\?[_a-z][a-zA-Z0-9_']*\(,\s*[_a-z][a-zA-Z0-9_']*\)*\(\s*::\|\n\s\+::\)"
  \ contains=
  \ haskellWhere,
  \ haskellLet,
  \ haskellDefault,
  \ haskellIdentifier,
  \ haskellOperators,
  \ haskellSeparator,
  \ haskellParens
syn keyword haskellWhere where
syn keyword haskellLet let
syn keyword haskellDeclKeyword module class instance newtype deriving in
syn match haskellDecl "\<\(type\|data\)\>\s\+\(\<family\>\)\?"
syn keyword haskellDefault default
syn keyword haskellImportKeywords import qualified safe as hiding contained
syn keyword haskellForeignKeywords foreign export import ccall safe unsafe interruptible capi prim contained
syn region haskellForeignImport start="\<foreign\>" end="::" keepend
  \ contains=
  \ haskellString,
  \ haskellOperators,
  \ haskellForeignKeywords,
  \ haskellIdentifier
syn match haskellImport "^\<import\>\s\+\(\<safe\>\s\+\)\?\(\<qualified\>\s\+\)\?.\+\(\s\+\<as\>\s\+.\+\)\?\(\s\+\<hiding\>\)\?"
  \ contains=
  \ haskellParens,
  \ haskellOperators,
  \ haskellImportKeywords,
  \ haskellType,
  \ haskellLineComment,
  \ haskellBlockComment,
  \ haskellPragma
syn keyword haskellKeyword do case of
if exists('g:haskell_enable_static_pointers') && g:haskell_enable_static_pointers == 1
  syn keyword haskellStatic static
endif
syn keyword haskellConditional if then else
syn match haskellNumber "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>\|\<0[bB][10]\+\>"
syn match haskellFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
syn match haskellSeparator  "[,;]"
syn region haskellParens matchgroup=haskellDelimiter start="(" end=")" contains=TOP,haskellTypeSig,@Spell
syn region haskellBrackets matchgroup=haskellDelimiter start="\[" end="]" contains=TOP,haskellTypeSig,@Spell
syn region haskellBlock matchgroup=haskellDelimiter start="{" end="}" contains=TOP,@Spell
syn keyword haskellInfix infix infixl infixr
syn keyword haskellBottom undefined error
syn match haskellOperators "[-!#$%&\*\+/<=>\?@\\^|~:.]\+\|\<_\>"
syn match haskellQuote "\<'\+" contained
syn match haskellQuotedType "[A-Z][a-zA-Z0-9_']*\>" contained
syn region haskellQuoted start="\<'\+" end="\>"
  \ contains=
  \ haskellType,
  \ haskellQuote,
  \ haskellQuotedType,
  \ haskellSeparator,
  \ haskellParens,
  \ haskellOperators,
  \ haskellIdentifier
syn match haskellLineComment "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$"
  \ contains=
  \ haskellTodo,
  \ @Spell
syn match haskellBacktick "`[A-Za-z_][A-Za-z0-9_\.']*`"
syn region haskellString start=+"+ skip=+\\\\\|\\"+ end=+"+
  \ contains=@Spell
syn match haskellIdentifier "[_a-z][a-zA-z0-9_']*" contained
syn match haskellChar "\<'[^'\\]'\|'\\.'\|'\\u[0-9a-fA-F]\{4}'\>"
syn match haskellType "\<[A-Z][a-zA-Z0-9_']*\>"
syn region haskellBlockComment start="{-" end="-}"
  \ contains=
  \ haskellBlockComment,
  \ haskellTodo,
  \ @Spell
syn region haskellPragma start="{-#" end="#-}"
syn match haskellQuasiQuoted "." containedin=haskellQuasiQuote contained
syn region haskellQuasiQuote matchgroup=haskellTH start="\[[_a-z][a-zA-z0-9_']*|" end="|\]"
syn region haskellTHBlock matchgroup=haskellTH start="\[\(d\|t\|p\)\?|" end="|]" contains=TOP
syn region haskellTHDoubleBlock matchgroup=haskellTH start="\[||" end="||]" contains=TOP
syn match haskellPreProc "^#.*$"
syn keyword haskellTodo TODO FIXME contained
" Treat a shebang line at the start of the file as a comment
syn match haskellShebang "\%^#!.*$"
if exists('g:haskell_enable_typeroles') && g:haskell_enable_typeroles == 1
  syn keyword haskellTypeRoles phantom representational nominal contained
  syn region haskellTypeRoleBlock matchgroup=haskellTypeRoles start="type\s\+role" end="$" keepend
    \ contains=
    \ haskellType,
    \ haskellTypeRoles
endif
if exists('g:haskell_enable_quantification') && g:haskell_enable_quantification == 1
  syn keyword haskellForall forall
endif
if exists('g:haskell_enable_recursivedo') && g:haskell_enable_recursivedo == 1
  syn keyword haskellRecursiveDo mdo rec
endif
if exists('g:haskell_enable_arrowsyntax') && g:haskell_enable_arrowsyntax == 1
  syn keyword haskellArrowSyntax proc
endif
if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
  syn keyword haskellPatternKeyword pattern
endif

hi def link haskellBottom Macro
hi def link haskellTH Boolean
hi def link haskellIdentifier Identifier
hi def link haskellForeignKeywords Structure
hi def link haskellKeyword Keyword
hi def link haskellDefault Keyword
hi def link haskellConditional Conditional
hi def link haskellNumber Number
hi def link haskellFloat Float
hi def link haskellInfix Keyword
hi def link haskellOperators Operator
hi def link haskellQuote Operator
hi def link haskellShebang Comment
hi def link haskellLineComment Comment
hi def link haskellBlockComment Comment
hi def link haskellPragma SpecialComment
hi def link haskellString String
hi def link haskellChar String
hi def link haskellBacktick Operator
hi def link haskellQuasiQuoted String
hi def link haskellTodo Todo
hi def link haskellPreProc PreProc
hi def link haskellAssocType Type
hi def link haskellImportKeywords Include
hi def link haskellDeclKeyword Keyword
hi def link haskellDecl Keyword
hi def link haskellWhere PreProc
hi def link haskellLet Keyword
hi def link haskellQuotedType Type
hi def link haskellType Type

if exists('g:haskell_enable_quantification') && g:haskell_enable_quantification == 1
  hi def link haskellForall Operator
endif
if exists('g:haskell_enable_recursivedo') && g:haskell_enable_recursivedo == 1
  hi def link haskellRecursiveDo Keyword
endif
if exists('g:haskell_enable_arrowsyntax') && g:haskell_enable_arrowsyntax == 1
  hi def link haskellArrowSyntax Keyword
endif
if exists('g:haskell_enable_static_pointers') && g:haskell_enable_static_pointers == 1
  hi def link haskellStatic Keyword
endif
if exists('g:haskell_classic_highlighting') && g:haskell_classic_highlighting == 1
  if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
    hi def link haskellPatternKeyword Keyword
  endif
  if exists('g:haskell_enable_typeroles') && g:haskell_enable_typeroles == 1
    hi def link haskellTypeRoles Keyword
  endif
else
  if exists('g:haskell_enable_pattern_synonyms') && g:haskell_enable_pattern_synonyms == 1
    hi def link haskellPatternKeyword Structure
  endif
  if exists('g:haskell_enable_typeroles') && g:haskell_enable_typeroles == 1
    hi def link haskellTypeRoles Structure
  endif
endif

let b:current_syntax = "haskell"
