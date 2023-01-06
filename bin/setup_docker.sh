#!/usr/bin/env bash

rm -rf .env && cp -f .env.template .env &&
docker-compose pull &&
docker-compose build web &&
docker-compose run --rm web bash -c '
  (bundle check || bundle install) &&
  bundle exec rails db:drop &&
  bundle exec rails db:create &&
  bundle exec rails db:migrate &&
  bundle exec rails db:seed
'