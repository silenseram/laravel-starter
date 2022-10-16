up:
	docker compose up -d --force-recreate

down:
	docker compose down

init:
	[ -f .env ] && echo ".env already exists" || cp .env.example .env
	echo .env
	echo "# Overridden by Makefile" >> .env
	echo "UID=$$(id -u)" >> .env

phpsh:
	docker compose exec starter_php_backend bash
