" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax") || exists("b:jsdoc")
  finish
endif

let b:jsdoc = "1"

runtime! syntax/javascript.vim

syntax case ignore

syntax region jsDocComment      matchgroup=jsComment start="/\*\*\s*"  end="\*/" contains=jsDocTags,jsCommentTodo,jsCvsTag,@jsHtml,@Spell fold

" tags containing a param
syntax match  jsDocTags         contained "@\(alias\|augments\|borrows\|class\|constructs\|default\|defaultvalue\|emits\|exception\|exports\|extends\|file\|fires\|kind\|listens\|member\|member[oO]f\|mixes\|module\|name\|namespace\|requires\|throws\|var\|variation\|version\)\>" nextgroup=jsDocParam skipwhite
" tags containing type and param
syntax match  jsDocTags         contained "@\(arg\|argument\|param\|property\)\>" nextgroup=jsDocType skipwhite
" tags containing type but no param
syntax match  jsDocTags         contained "@\(callback\|enum\|external\|this\|type\|typedef\|return\|returns\)\>" nextgroup=jsDocTypeNoParam skipwhite
" tags containing references
syntax match  jsDocTags         contained "@\(lends\|see\|tutorial\)\>" nextgroup=jsDocSeeTag skipwhite
" other tags (no extra syntax)
syntax match  jsDocTags         contained "@\(abstract\|access\|author\|classdesc\|constant\|const\|constructor\|copyright\|deprecated\|desc\|description\|event\|example\|file[oO]verview\|function\|global\|ignore\|inner\|instance\|license\|method\|mixin\|overview\|private\|protected\|public\|readonly\|since\|static\|todo\|summary\|undocumented\|virtual\)\>"

syntax region jsDocType         start="{" end="}" oneline contained nextgroup=jsDocParam skipwhite
syntax match  jsDocType         contained "\%(#\|\"\|\w\|\.\|:\|\/\)\+" nextgroup=jsDocParam skipwhite
syntax region jsDocTypeNoParam  start="{" end="}" oneline contained
syntax match  jsDocTypeNoParam  contained "\%(#\|\"\|\w\|\.\|:\|\/\)\+"
syntax match  jsDocParam        contained "\%(#\|\"\|{\|}\|\w\|\.\|:\|\/\)\+"
syntax region jsDocSeeTag       contained matchgroup=jsDocSeeTag start="{" end="}" contains=jsDocTags

syntax case match

command -nargs=+ HiLink hi def link <args>
HiLink jsDocComment           Comment
HiLink jsDocTags              Special
HiLink jsDocSeeTag            Function
HiLink jsDocType              Type
HiLink jsDocTypeNoParam       Type
HiLink jsDocParam             Label
delcommand HiLink
