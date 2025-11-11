alias a='php artisan'
alias gpdf='_gpdf'

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
alias ghdt='function _gh_deploy_test() { current_branch=$(git rev-parse --abbrev-ref HEAD); gh workflow run deploy.yml --ref "$current_branch" -f environment=testing; }; _gh_deploy_test'

alias gc='function _gc() { message=${1:-"wip"}; git add . && git commit -m "$message" && git push; }; _gc'

alias dev='npm run dev'

alias co='git checkout'

alias vim='nvim'

alias ...='cd ~'

alias startgotenberg='docker run -it --add-host=office.clockin.test:host-gateway --rm -p 3000:3000 gotenberg/gotenberg:8.22.0 /bin/bash -c "gotenberg --chromium-ignore-certificate-errors"'
alias phpstan="./vendor/bin/phpstan analyse"

alias ghpr="gh pr create -t '$(git rev-parse --abbrev-ref HEAD)'"

alias sl="stripe listen --forward-to https://office.clockin.test/stripe/webhook"

alias mm="git fetch origin && git merge origin/main"
