appmake: build down run

prod: build-prod down-prod run-prod

static_test:
	pycodestyle database_maintainer || true  ## don`t fail for now - TO BE FIXED
	pycodestyle web_api || true  ## don`t fail for now - TO BE FIXED
	pycodestyle tests || true  ## don`t fail for now - TO BE FIXED
	pycodestyle usage_examples || true  ## don`t fail for now - TO BE FIXED
	pylint database_maintainer || true  ## don`t fail for now - TO BE FIXED
	pylint web_api || true  ## don`t fail for now - TO BE FIXED
	pylint tests || true  ## don`t fail for now - TO BE FIXED
	pylint usage_examples || true  ## don`t fail for now - TO BE FIXED

build: static_test
	docker-compose build

test:
	echo "NO TESTS"

run:
	docker-compose up -d

down:
	docker-compose down -v

build-prod:
	docker-compose -f docker-compose.prod.yml build

run-prod:
	grep changeme .env && { echo "YOU NEED TO SET PROPER DB PASSWORDS"; exit 1 ;} || true
	docker-compose -f docker-compose.prod.yml up -d

down-prod:
	docker-compose -f docker-compose.prod.yml down -v
