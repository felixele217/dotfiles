alias ...='cd ~'
alias a='php artisan'
alias co='git checkout'
alias deploypages='npm run deploy-pages'
alias dev='npm run dev'
alias duskdriver='sudo ./vendor/laravel/dusk/bin/chromedriver-mac-arm --port=9515'
alias duskserve='php artisan serve --env=testing --port 8008'
alias dusktest='php artisan dusk --env=testing'
alias gc='function _gc() { message=${1:-"wip"}; git add . && git commit -m "$message" && git push; }; _gc'
alias ghd='function _gh_deploy() { current_branch=$(git rev-parse --abbrev-ref HEAD); gh workflow run deploy.yml --ref "$current_branch" -f environment=development-"$1"; }; _gh_deploy'
alias ghdt='function _gh_deploy_test() { current_branch=$(git rev-parse --abbrev-ref HEAD); gh workflow run deploy.yml --ref "$current_branch" -f environment=testing; }; _gh_deploy_test'
alias ghpr="gh pr create -t '$(git rev-parse --abbrev-ref HEAD)'"
alias gpdf='_gpdf'
alias load-company-dump='function _load_company_dump() { day_string=$(date +%Y-%m-%d); dump_name="dump_company_$1_$day_string.sql"; echo "Loading dump $dump_name"; gh workflow run transfer-company-dump.yml --ref main -f environment=development-d02 -f company_id=$1; php artisan clockin:load-database-dump-from-s3 clockin-development-transfer $dump_name; }; _load_company_dump'
alias mfs='php artisan migrate:fresh --seed'
alias mm="git fetch origin && git merge origin/main"
alias pest='./vendor/bin/pest'
alias phpcs='./vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.dist.php -v'
alias phpstan="./vendor/bin/phpstan analyse"
alias ptest='php artisan test --parallel'
alias pu='./vendor/bin/phpunit'
alias redis-production="ssh -L 127.0.0.1:6379:master.valkey-rep-group-1.tgbxwd.euc1.cache.amazonaws.com:6379 aws-production"
alias redis-testing="ssh -L 127.0.0.1:6379:master.valkey-rep-group-1.oxpzpo.euc1.cache.amazonaws.com:6379 aws-testing"
alias routes='php artisan routes:list'
alias sl="stripe listen --forward-to https://office.clockin.test/stripe/webhook"
alias startgotenberg='docker run -it --add-host=office.clockin.test:host-gateway --rm -p 3000:3000 gotenberg/gotenberg:8.22.0 /bin/bash -c "gotenberg --chromium-ignore-certificate-errors"'
alias vim='nvim'
