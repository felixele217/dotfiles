alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias a='[ -f sail ] && sh sail || sh vendor/bin/sail artisan'

alias t='php artisan test'

alias mfs='[ -f sail ] && sh sail || sh vendor/bin/sail artisan migrate:fresh --seed'

alias routes='[ -f sail ] && sh sail || sh vendor/bin/sail artisan route:list'
alias dev='npm run dev'

alias co='git checkout'

