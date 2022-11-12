NAME = inception
all:
	@printf "Launching configuration ${NAME}...\n"
	@bash srcs/requirements/wordpress/tools/check_dirs.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building configuration ${NAME}...\n"
	@bash srcs/requirements/wordpress/tools/check_dirs.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: down
	@printf "Rebuilding configuration ${NAME}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${NAME}...\n"
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

fclean:
	@printf "Full cleaning...\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY	: all build down re clean fclean
