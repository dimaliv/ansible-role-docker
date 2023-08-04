target = override

override container-name-app = molecule
override docker-compose = docker-compose -f docker-compose.yml -f docker-compose.$(target).yml

local: init-env-file build up down
ci: fill-env-example-yml init-env-yml-file up down

# Helpers
fill-env-example-yml: FORCE ; echo "CI_REGISTRY_USER: \"${CI_REGISTRY_USER}\"" >> .env.example.yml && echo "CI_REGISTRY_PASSWORD: \"${CI_REGISTRY_PASSWORD}\"" >> .env.example.yml && echo "KAFKA_IMAGE_NAME: \"${KAFKA_IMAGE_NAME}\"" >> .env.example.yml && echo "KAFKA_IMAGE_VERSION: \"${KAFKA_IMAGE_VERSION}\"" >> .env.example.yml && echo "KAFKA_TESTER_IMAGE_NAME: \"${KAFKA_TESTER_IMAGE_NAME}\"" >> .env.example.yml && echo "KAFKA_TESTER_IMAGE_VERSION: \"${KAFKA_TESTER_IMAGE_VERSION}\"" >> .env.example.yml
init-env-yml-file: FORCE ; sh -c "if [ ! -f .env.yml ] && [ -f .env.example.yml ]; then cp .env.example.yml .env.yml; fi;"
init-env-file: FORCE ; sh -c "if [ ! -f .env ] && [ -f .env.example ]; then cp .env.example .env; fi;"

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
