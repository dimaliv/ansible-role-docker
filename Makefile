target = override

override container-name-app = molecule
override docker-compose = docker compose -f docker-compose.yml -f docker-compose.$(target).yml

default: init-env-file molecule-test
run-test-ci: init-env-file molecule-test

# Helpers

init-env-file: FORCE ; sh -c "if [ ! -f .env ] && [ -f .env.example ]; then cp .env.example .env; fi;"

# Docker

docker-ps: FORCE ; $(docker-compose) ps
docker-images: FORCE ; $(docker-compose) images
docker-build: FORCE ; $(docker-compose) build --pull
docker-up: FORCE ; $(docker-compose) up --remove-orphans --no-build --exit-code-from $(container-name-app)
docker-down: FORCE ; $(docker-compose) down --remove-orphans
docker-push: FORCE ; $(docker-compose) push
docker-pull: FORCE ; $(docker-compose) pull --ignore-pull-failures
docker-logs: FORCE ; $(docker-compose) logs -f
docker-exec: FORCE ; $(docker-compose) exec $(c) sh
docker-remove-all: FORCE ; $(docker-compose) rm -f -s -v

# Ansible

lint: FORCE lint-version ; $(docker-compose) run --rm $(container-name-app) ansible-lint
lint-version: FORCE ; $(docker-compose) run --rm $(container-name-app) ansible-lint --version

# Molecule

molecule: target=molecule
molecule: FORCE ; $(docker-compose) run --rm $(container-name-app) sh
molecule-test: target=molecule
molecule-test: FORCE ; $(docker-compose) run --rm $(container-name-app)

# Cheat

FORCE:
