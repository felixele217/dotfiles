source /Users/felix/code/clockin/shared_functions.zsh

export ZSH="$HOME/.oh-my-zsh"

bindkey '^I' forward-char
bindkey '^H' vi-backward-word


ZSH_THEME="robbyrussell"

plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export PATH=/opt/homebrew/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin

export PATH="$HOME/.cargo/bin:$PATH"

# add tmuxifier to path
export PATH="$HOME/.tmuxifier/bin:$PATH"
export EDITOR=nvim
# eval "$(tmuxifier init -)"

# Herd injected PHP binary.
# export PATH="/Users/felix/Library/Application Support/Herd/bin/":$PATH

# Herd injected PHP 8.2 configuration.
# export HERD_PHP_82_INI_SCAN_DIR="/Users/felix/Library/Application Support/Herd/config/php/82/"

# Herd injected PHP binary.
export PATH="/Users/felix/Library/Application Support/Herd/bin/":$PATH

# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/felix/Library/Application Support/Herd/config/php/82/"

# Herd injected PHP 8.1 configuration.
export HERD_PHP_81_INI_SCAN_DIR="/Users/felix/Library/Application Support/Herd/config/php/81/"

# Herd injected PHP binary.
export PATH="/Users/felix/Library/Application Support/Herd/bin/":$PATH

# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/felix/Library/Application Support/Herd/config/php/83/"
export PATH="/opt/homebrew/opt/mariadb@10.5/bin:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=1

# nice prompt
FIRST_PROMPT=1
LAST_COMMAND=""

precmd() {
  # Skip adding a newline for the first prompt or after the `clear` command
  if [ "$FIRST_PROMPT" -eq 0 ] && [ "$LAST_COMMAND" != "clear" ]; then
    echo ""
  fi
  FIRST_PROMPT=0
}

preexec() {
  # Capture the last executed command
  LAST_COMMAND=$1
}

PROMPT=$'%F{cyan}%B%~%b%f $(git_prompt_info)\n%F{green}%B->%b%f '


# Added by Windsurf
export PATH="/Users/felix/.codeium/windsurf/bin:$PATH"
