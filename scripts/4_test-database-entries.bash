#!/usr/bin/env bash
set -o xtrace

docker-compose exec mongodb mongo product-db --quiet --eval "db.products.find()"

docker-compose exec mysql mysql -uuser -ppwd review-db -e "select * from reviews"