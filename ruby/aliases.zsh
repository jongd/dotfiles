<<<<<<< HEAD
alias r='rbenv local 2.0.0-p195'

alias sc='script/console'
alias sg='script/generate'
alias sd='script/destroy'

alias migrate='rake db:migrate db:test:clone'

# Bundler
alias b="bundle"
alias be="bundle exec"
alias bake="bundle exec rake"

# Tests and Specs
alias t="ruby -I test"
alias s="bundle exec rspec"
alias cuc="bundle exec cucumber"

# Rubygems
alias gi="gem install"
alias giv="gem install -v"

# Rails
alias migrate="bundle exec rake db:migrate db:test:prepare"
alias remigrate="bundle exec rake db:migrate db:migrate:redo db:schema:dump db:test:prepare"
alias remongrate="bundle exec rake mongoid:migrate mongoid:migrate:redo"

# Heroku staging
alias staging='heroku run console --remote staging'
alias staging-name='echo `basename $PWD`-staging'
alias staging-process='watch heroku ps --remote staging'
alias staging-releases='heroku releases --remote staging'
alias staging-tail='heroku logs --tail --remote staging'

# Heroku production
alias production='heroku run console --remote production'
alias production-name='echo `basename $PWD`-production'
alias production-process='watch heroku ps --remote production'
alias production-releases='heroku releases --remote production'
alias production-tail='heroku logs --tail --remote production'

# Heroku databases
alias db-pull-staging='heroku db:pull --remote staging --confirm `staging-name`'
alias db-pull-production='heroku db:pull --remote production --confirm `production-name`'
alias db-copy-production-to-staging='heroku pgbackups:restore DATABASE `heroku pgbackups:url --app production-name` --app `staging-name` --confirm `staging-name`'
alias db-backup-production='heroku pgbackups:capture --remote production --expire'

# Forman
alias fd='foreman start -f Procfile.dev'
alias fz='foreman start -f Procfile.zeus'
alias f='foreman start Procfile'
alias fs='foreman run bundle exec rake spec'
alias fc='foreman run bundle exec rails console'
