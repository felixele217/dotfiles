export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export PATH=/opt/homebrew/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin

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
