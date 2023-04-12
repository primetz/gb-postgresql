SHELL := /bin/bash
DOCKER_COMPOSE_FILE_PATH = ./docker/docker-compose.yaml
POSTGRES_CONTAINER_NAME = postgres

.PHONY: up down drop prune

up:
	@docker compose -f $(DOCKER_COMPOSE_FILE_PATH) up -d --build

down:
	@docker container rm -f $(shell docker container ls -qa)

drop:
	@docker image prune -af
	@docker network prune -f
	@docker volume prune -f --filter all=true

prune:
	@docker system prune -af --volumes
