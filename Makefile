
IMAGE_NAME := nitishespsetup
tag := 0.01
DOCKERFILE := Dockerfile
TIMEOUT := 15
DOCKER := docker
CONTAINER := espIdf

# RUN with sleep
container_sleep:
	sleep 5

# To build the docker container
build:
	$(DOCKER) image build -t $(IMAGE_NAME):$(tag) -f $(DOCKERFILE) .

# To clean the build docker image
clean:
	$(DOCKER) rmi $(IMAGE_NAME):$(tag)

# To stop all the running container and remove it
all_clean:
	$(DOCKER) stop $(CONTAINER)
	$(DOCKER) rm $(CONTAINER)
	make clean

# To start the docker compose
docker_compose_up:
	$(DOCKER) compose up -d 

docker_compose_restart:
	$(DOCKER) compose stop
	$(DOCKER) compose start 

run:
	$(DOCKER) exec -it $(CONTAINER) /bin/bash


# To enter inside the docker container and execute
execute:
	make all_clean || echo "No existing docker container"
	make build
	#-timeout -k 1 $(TIMEOUT) make docker_compose_up || { echo "docker_compose_up failed"; exit 1; } 
	make docker_compose_up || { echo "docker_compose_up failed"; exit 1; } 
	#@echo "Sleeping for 5 second"
	#make container_sleep
	#make docker_compose_restart
	make run

# Display all th epossible command
help:
	@echo "Available targets:"
	@echo "  make build       		- Build Docker image"
	@echo "  make clean       		- Remove Docker image"
	@echo "  make help        		- Show this help message"
	@echo "  make execute     		- stop container, remove, rebuild image, and enter inside the docker container "
	@echo "  make docker_compose_up        	- start the docker compost file"
	@echo "  make docker_compose_restart    - if docker compose file crash it will restart the container with all other mounting"
	@echo ""
.DEFAULT_GOAL := help
