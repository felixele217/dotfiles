alias a='php artisan'

alias pest='./vendor/bin/pest'

alias mfs='php artisan migrate:fresh --seed'

alias pu='./vendor/bin/phpunit'
alias phpcs='./vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.dist.php -v'
alias ptest='php artisan test --parallel'

alias dev="npm run dev"

alias duskserve='php artisan serve --env=testing --port 8008'
alias duskdriver='sudo ./vendor/laravel/dusk/bin/chromedriver-mac-arm --port=9515'
alias dusktest='php artisan dusk --env=testing'

alias routes='php artisan routes:list'

alias ghd='function _gh_deploy() { current_branch=$(git rev-parse --abbrev-ref HEAD); gh workflow run deploy.yml --ref "$current_branch" -f environment=development-"$1"; }; _gh_deploy'

alias dev='npm run dev'

alias co='git checkout'

alias vim='nvim'

alias ...='cd ~'

alias startgotenberg="docker run -it --add-host=office.clockin.test:host-gateway --rm -p 3000:3000 gotenberg/gotenberg:8.14.1 /bin/bash"
