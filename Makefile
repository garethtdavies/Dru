appmake: build down run

block-engine: build-block-engine down-block-engine run-block-engine

prod: build-prod down-prod run-prod

build:
	docker-compose build


test:
	echo "NO TESTS"

run:
	docker-compose up

down:
	docker-compose down -v

build-prod:
	docker-compose -f docker-compose.prod.yml build

run-prod:
	grep changeme .env && { echo "YOU NEED TO SET PROPER DB PASSWORDS"; exit 1 ;} || true
	docker-compose -f docker-compose.prod.yml up -d

down-prod:
	docker-compose -f docker-compose.prod.yml down -v

build-block-engine:
	docker-compose -f docker-compose.block-engine.yml build

run-block-engine:
	docker-compose -f docker-compose.block-engine.yml up

down-block-engine:
	docker-compose -f docker-compose.block-engine.yml down -v

django-shell:
	docker-compose exec web python manage.py shell

maintainer-shell:
	docker-compose exec db_maintainer bash

## static code analysis
static_test: test-static-db_maintainer test-static-web_api test-static_tests test-static-usage_examples	

test-static-db_maintainer:
	docker run -v $(shell pwd):/code -ti puchtaw/pylinter:latest database_maintainer/src

test-static-web_api:
	docker run -v $(shell pwd):/code -ti puchtaw/pylinter:latest web_api/src

test-static_tests:
	docker run -v $(shell pwd):/code -ti puchtaw/pylinter:latest tests || true  ## don`t fail for now - TO BE FIXED

test-static-usage_examples:
	docker run -v $(shell pwd):/code -ti puchtaw/pylinter:latest usage_examples || true  ## don`t fail for now - TO BE FIXED
