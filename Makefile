.PHONY: build run up test logs down clean

build:
	docker compose build

run:
	docker compose up

up:
	docker compose up --build

test:
	bundle exec rspec

logs:
	docker compose logs -f

down:
	docker compose down

clean:
	docker compose down --rmi local --volumes --remove-orphans
