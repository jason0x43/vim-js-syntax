" Vim syntax file
" Language:    JavaScript
" Maintainer:  Jason Cheatham
" Last Change: 2016 Apr 17
" Credits:     Based on Claudio Fleiner's javascript.vim from the standard
"              distribution

if !exists("main_syntax")
	if exists("b:current_syntax")
		finish
	endif
	let main_syntax = 'javascript'
elseif exists("b:current_syntax") && b:current_syntax == "javascript"
	finish
endif

" '$' is a valid identifier character
setlocal iskeyword+=$

syn keyword jsCommentTodo      TODO FIXME XXX TBD contained
syn match   jsLineComment      "\/\/.*" contains=@Spell,jsCommentTodo
syn match   jsCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  jsComment          start="/\*"  end="\*/" contains=@Spell,jsCommentTodo
syn match   jsSpecial          "\\\d\d\d\|\\."
syn region  jsStringDq          start=+"+ skip=+\\\\\|\\"+ end=+"\|$+
			\ contains=jsSpecial,@htmlPreproc
syn region  jsStringSq         start=+'+ skip=+\\\\\|\\'+ end=+'\|$+
			\ contains=jsSpecial,@htmlPreproc

syn match   jsSpecialCharacter "'\\.'"
syn match   jsNumber           "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  jsRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+
			\ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1
			\ contains=@htmlPreproc oneline

syn keyword jsConditional      if else switch
syn keyword jsRepeat           while for do in
syn keyword jsBranch           break continue
syn keyword jsOperator         new delete instanceof typeof
syn keyword jsType             Array Boolean Date Function Number Object
			\ String RegExp var let function
syn keyword jsStatement        return with
syn keyword jsBoolean          true false
syn keyword jsNull             null undefined
syn keyword jsIdentifier       arguments this
syn keyword jsLabel            case default
syn keyword jsException        try catch finally throw
syn keyword jsMessage          alert confirm prompt status console
syn keyword jsGlobal           self window top parent
syn keyword jsMember           document event location 
syn keyword jsDeprecated       escape unescape
syn keyword jsDebug            debugger
syn keyword jsReserved         abstract boolean byte char class const
			\ double enum export extends final float goto implements import
			\ int interface long native package private protected public short
			\ static super synchronized throws transient volatile 

syn match   jsBraces           "[{}\[\]]"
syn match   jsParens           "[()]"

" jsdoc

syntax case ignore

syntax region jsDocComment     matchgroup=jsComment start="/\*\*" end="\*/"
			\ contains=jsDocTags,jsCommentTodo,jsCvsTag,@jsHtml,@Spell

" tags containing a param
syntax match  jsDocTags        contained "@\(alias\|augments\|borrows\|class\|
			\constructs\|default\|defaultvalue\|emits\|exception\|exports\|
			\extends\|file\|fires\|kind\|listens\|member\|member[oO]f\|mixes\|
			\module\|name\|namespace\|requires\|throws\|var\|variation\|
			\version\)\>" nextgroup=jsDocParam skipwhite
" tags containing type and param
syntax match  jsDocTags        contained "@\(arg\|argument\|param\|
			\property\)\>" nextgroup=jsDocType skipwhite
" tags containing type but no param
syntax match  jsDocTags        contained "@\(callback\|enum\|external\|this\|
			\type\|typedef\|return\|returns\)\>"
			\ nextgroup=jsDocTypeNoParam skipwhite
" tags containing references
syntax match  jsDocTags        contained "@\(lends\|see\|tutorial\)\>"
			\ nextgroup=jsDocSeeTag skipwhite
" other tags (no extra syntax)
syntax match  jsDocTags        contained "@\(abstract\|access\|author\|
			\classdesc\|constant\|const\|constructor\|copyright\|\deprecated\|
			\desc\|description\|event\|example\|file[oO]verview\|function\|
			\global\|ignore\|inner\|instance\|license\|method\|mixin\|
			\overview\|private\|protected\|public\|readonly\|since\|static\|
			\todo\|summary\|undocumented\|virtual\)\>"

syntax region jsDocType        start="{" end="}" oneline contained 
			\ nextgroup=jsDocParam skipwhite
syntax match  jsDocType        contained "\%(#\|\"\|\w\|\.\|:\|\/\)\+"
			\ nextgroup=jsDocParam skipwhite
syntax region jsDocTypeNoParam start="{" end="}" oneline contained
syntax match  jsDocTypeNoParam contained "\%(#\|\"\|\w\|\.\|:\|\/\)\+"
syntax match  jsDocParam       contained "\%(#\|\"\|{\|}\|\w\|\.\|:\|\/\)\+"
syntax region jsDocSeeTag      contained matchgroup=jsDocSeeTag start="{"
			\ end="}" contains=jsDocTags

syntax case match

syn sync fromstart

if main_syntax == "javascript"
  syn sync ccomment jsComment
endif

command -nargs=+ HiLink hi def link <args>
HiLink jsBoolean          Boolean
HiLink jsBraces           Function
HiLink jsBranch           Conditional
HiLink jsCharacter        Character
HiLink jsComment          Comment
HiLink jsCommentTodo      Todo
HiLink jsConditional      Conditional
HiLink jsConstant         Label
HiLink jsDebug            Debug
HiLink jsDeprecated       Exception 
HiLink jsError            Error
HiLink jsException        Exception
HiLink jsGlobal           Keyword
HiLink jsIdentifier       Identifier
HiLink jsKeyword          Keyword
HiLink jsLabel            Label
HiLink jsLineComment      Comment
HiLink jsMember           Keyword
HiLink jsMessage          Keyword
HiLink jsNull             Keyword
HiLink jsNumber           Number
HiLink jsOperator         Operator
HiLink jsRegexpString     String
HiLink jsRepeat           Repeat
HiLink jsReserved         Keyword
HiLink jsSpecial          Special
HiLink jsSpecialCharacter Special
HiLink jsStatement        Statement
HiLink jsStringDq         String
HiLink jsStringSq         String
HiLink jsType             Type

HiLink jsDocComment       Comment
HiLink jsDocTags          Special
HiLink jsDocSeeTag        Function
HiLink jsDocType          Type
HiLink jsDocTypeNoParam   Type
HiLink jsDocParam         Label
delcommand HiLink

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
	unlet main_syntax
endif
