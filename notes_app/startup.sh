source /etc/profile.d/rvm.sh
rm db/notes.sqlite3
rm log/unicorn.log
bundle exec rake db:migrate
unicorn -c unicorn.rb -D
service nginx start
