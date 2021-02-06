hook global ModuleLoaded powerline %{ require-module powerline_indent }

provide-module powerline_indent %§

declare-option -hidden bool powerline_module_indent true
set-option -add global powerline_modules 'indent'


define-command -hidden powerline-update-indent %{ evaluate-commands %sh{ (
    if [ $kak_opt_indentwidth -eq 0 ]; then
        indent=''
    else
        indent="$kak_opt_indentwidth"'␣'
    fi
    printf "%s\n" "try %{ evaluate-commands -client $kak_client %{ set-option window powerline_indent $indent } }"
}

define-command -hidden powerline-indent %{ evaluate-commands %sh{
    default=$kak_opt_powerline_base_bg
    next_bg=$kak_opt_powerline_next_bg
    normal=$kak_opt_powerline_separator
    thin=$kak_opt_powerline_separator_thin
    if [ "$kak_opt_powerline_module_indent" = "true" ]; then
        fg=$kak_opt_powerline_color10
        bg=$kak_opt_powerline_color11
        if [ ! -z "$kak_opt_indent" ]; then
            [ "$next_bg" = "$bg" ] && separator="{$fg,$bg}$thin" || separator="{$bg,${next_bg:-$default}}$normal"
            printf "%s\n" "set-option -add global powerlinefmt %{$separator{$fg,$bg} %opt{powerline_indent} }"
            printf "%s\n" "set-option global powerline_next_bg $bg"
        fi
    fi
}}

define-command -hidden powerline-toggle-indent -params ..1 %{ evaluate-commands %sh{
    [ "$kak_opt_powerline_module_indent" = "true" ] && value=false || value=true
    if [ -n "$1" ]; then
        [ "$1" = "on" ] && value=true || value=false
    fi
    printf "%s\n" "set-option global powerline_module_indent $value"
}}

§
