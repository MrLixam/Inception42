COMPOSE_PATH = ./srcs/docker-compose.yml

all:
	@mkdir -p ~/data/mariadb
	@mkdir -p ~/data/wordpress
	docker compose -f ${COMPOSE_PATH} up -d --build

down:
	docker compose -f ${COMPOSE_PATH} down

clean:
	-docker rm -f `docker ps -aq`
	-docker volume rm -f `docker volume ls -q`
	-docker image rm -f `docker image ls -aq`
	-docker network rm -f `docker network ls -q`
	-docker builder prune --all --force
	@sudo rm -rf ~/data/wordpress/ ~/data/mariadb

clean-volumes:
	@docker volume rm -f ~/data/wordpress ~/data/mariadb

reset: clean all

restart: down all

.PHONY: all down clean reset restart
