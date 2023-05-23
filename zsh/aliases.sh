alias ca='cargo add'
alias cb='cargo build -q'
alias ci='cargo binstall'
alias ck='cargo check'
alias cn='cargo new'
alias cr='cargo run -q'
alias ct='cargo test'
alias cu='cargo uninstall'

alias dots='cd ~/dots && nvim'
alias dots2='cd ~/dots2 && nvim'
alias ls='lsd -lA'
alias v='nvim'
alias vc='cd ~/.config/nvim/ && nvim'
alias zc='cd ~/dots/zsh/ && nvim'
alias rustinstall='curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh'

function pacs(){
    for p in $(yay -Slq)
    do
        yay -Si $p | awk '/^(Description|Name)/' | choose -f ':' 1 | sd '\n ' ' --> ' | tee ~/archpaks.txt
    done
}

e () {
    tmp="$(mktemp)"
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
