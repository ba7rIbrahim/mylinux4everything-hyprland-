# PATH
set -Ux PATH ~/.bun/bin $PATH

# -----------------------------
# Initialize zoxide only in interactive shells
# -----------------------------
#status --is-interactive; and source (zoxide init fish)

# STOP MAKO THEN RUN AGAIN
# if pgrep -x mako >/dev/null
#     killall -q mako
# end
# sleep 0.5
# mako >/dev/null 2>&1 &
# disown

# -----------------------------
# Aliases
# -----------------------------
alias .. 'z ..'
alias . z
alias l 'ls --color=auto'
alias ll 'ls -lh'
alias la 'ls -lha'
alias cls clear

# -----------------------------
# Git shortcuts
# -----------------------------
function add
    git add $argv
end

function commit
    git commit -m "$argv"
end

function pull
    git pull origin dev
end

function restore
    git restore $argv
end

function gs
    git status
end

function gl
    git log --oneline --graph --all
end

function push
    git push origin
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

#zoxide
zoxide init fish | source

# Fast Fetch
fastfetch
