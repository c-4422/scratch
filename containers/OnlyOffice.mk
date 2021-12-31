###############################################################
# Only Office Container Configuration File
###############################################################
CONTAINER_NAME=onlyoffice
PORT=8001

container:
	@echo "Making Only Office"

name:
	@echo "$(CONTAINER_NAME)"

port:
	@echo "$(PORT)"

start:
	@echo "Starting $(CONTAINER_NAME) container"

stop:
	@echo "Stopping $(CONTAINER_NAME) container"

install:
	@echo "Installing $(CONTAINER_NAME)"

enable:
	@echo "Enabling $(CONTAINER_NAME)"

disable:
	@echo "Disabling $(CONTAINER_NAME)"

clean:
	@echo "Cleaning $(CONTAINER_NAME)"