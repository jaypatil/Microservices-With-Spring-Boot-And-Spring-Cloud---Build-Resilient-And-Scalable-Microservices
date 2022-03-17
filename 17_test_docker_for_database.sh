#!/usr/bin/env bash
set -o xtrace

#data stored in MongoDB with a command like the following:
docker-compose exec mongodb mongo product-db --quiet --eval "db.products.find()"

#data stored in MySQL, we will be able to access it with a command like this:
docker-compose exec mysql mysql -uuser -p review-db -e "select * from reviews"