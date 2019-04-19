web: bundle exec rails server -p $PORT
worker: bundle exec sidekiq -t 25 -C config/sidekiq.yml
clock: bundle exec clockwork clock.rb
