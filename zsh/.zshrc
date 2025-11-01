# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

notes() {
    local course notes_file pdf_file
    local do_compile=false do_open=false

    if [[ -z "$1" ]]; then
        echo "Usage: notes <course> [--compile] [--open]"
        return 1
    fi

    course="$1"
    notes_file="$HOME/skolni/$course/notes.tex"
    pdf_file="${notes_file%.tex}.pdf"

    shift

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -c|--compile)
                do_compile=true; shift ;;
            -o|--open)
                do_open=true; shift ;;
            -h|--help)
                echo "Usage: notes <course> [-c|--compile] [-o|--open]"
                return 0 ;;
            *)
                echo "Unknown option: $1"
                return 1 ;;
        esac
    done

    if [[ ! -f "$notes_file" ]]; then
        echo "notes.tex not found for '$course'."
        return 1
    fi

    if [[ "$do_compile" = false && "$do_open" = false ]]; then
        vim "$notes_file"
        return 0
    fi

    if [[ "$do_compile" = true ]]; then
        pdflatex -halt-on-error -output-directory "$(dirname "$notes_file")" "$notes_file"
        open "$pdf_file"
        if [[ $? -ne 0 ]]; then
            echo "pdflatex compilation failed."
            return 1
        fi
    fi

    if [[ "$do_open" = true ]]; then
        if [[ ! -f "$pdf_file" ]]; then
            echo "Expected PDF not found: $pdf_file"
            return 1
        fi
        open "$pdf_file"
    fi
}

todo() {
    local original_dir=$PWD
    local do_show=false

    # flag parsing
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -s|--show)
                do_show=true
                ;;
        esac
        shift
    done

    cd ~/projects/agenda || return
    rm -f "git.log"
    (git pull origin main > /dev/null 2> "git.log" &)

    if [ "$do_show" = true ]; then
        cat ~/projects/agenda/TODO.txt
    else
        vim ~/projects/agenda/TODO.txt
    fi

    cd "$original_dir"
}

export UID="$(id -u)"
export XDG_RUNTIME_DIR="/run/user/${UID}"
export DISPLAY=":0"

export DYLD_LIBRARY_PATH="/usr/local/opt/sqlite/lib"

if [[ -z "$OS_ROADMAP_SHOWN" ]]; then
    cat ~/projects/agenda/TODO.txt
    export OS_ROADMAP_SHOWN=1
fi

PATH=$(go env GOPATH)/bin:$PATH 
