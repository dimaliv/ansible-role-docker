target = override

override container-name-app = molecule
override docker-compose = docker compose -f docker-compose.yml -f docker-compose.$(target).yml

local: build up down
test: up down

# Docker

ps: FORCE ; $(docker-compose) ps
images: FORCE ; $(docker-compose) images
build: FORCE ; $(docker-compose) build --pull --progress=plain
up: FORCE ; $(docker-compose) up --remove-orphans --no-build --exit-code-from $(container-name-app)
down: FORCE ; $(docker-compose) down --remove-orphans
push: FORCE ; $(docker-compose) push
pull: FORCE ; $(docker-compose) pull --ignore-pull-failures
logs: FORCE ; $(docker-compose) logs -f
exec: FORCE ; $(docker-compose) exec $(c) sh
remove-all: FORCE ; $(docker-compose) rm -f -s -v

# Cheat

FORCE:
