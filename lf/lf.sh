{{#if (eq dotter.os "unix")}}
set shell zsh
{{else}}
set shell powershell
{{/if}}

set dircounts
set hidden
set icons
set incfilter
set incsearch
set info 'size'
set promptfmt "\033[34;1m%d\033[0m\033[1m%f\033[0m  Filter: %F"
set scrolloff 10
set wrapscroll

set nodrawbox
set nohistory

map a updir
map d open
map f filter
map F setfilter ''
map s down
map w up
