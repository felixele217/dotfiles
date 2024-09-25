alias a='php artisan'

alias pest='./vendor/bin/pest'

alias mfs='php artisan migrate:fresh --seed'

alias pu='./vendor/bin/phpunit'
alias phpcs='./vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.dist.php -v'
alias ptest='php artisan test --parallel'

alias duskserve='php artisan serve --env=testing --port 8008'
alias duskdriver='sudo ./vendor/laravel/dusk/bin/chromedriver-mac-arm --port=9515'
alias dusktest='php artisan dusk --env=testing'

alias routes='php artisan routes:list'

alias dev='npm run dev'

alias co='git checkout'

alias ls='colorls'

alias n='nvim'
alias nconf='cd ~/.config/nvim/ && nvim .'

alias aconf='nvim ~/.oh-my-zsh/custom/aliases.zsh'
