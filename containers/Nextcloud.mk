###############################################################
# Nextcloud Container Configuration File
###############################################################
NEXTCLOUD=nextcloud
DATABASE=next_db
NEXTCLOUD_PORT=8000
DATABASE_PORT=3306

container:
	@echo "Making nextcloud"
	@echo "IP_ADDRESS = $(IP_ADDRESS)"

name:
	@echo "$(NEXTCLOUD)/$(DATABASE)"

port:
	@echo "$(NEXTCLOUD_PORT)/$(DATABASE_PORT)"

start:
	@echo "Starting $(NEXTCLOUD) container"

stop:
	@echo "Stopping $(NEXTCLOUD) container"

install:
	@echo "Installing $(NEXTCLOUD)"

enable:
	@echo "Enabling $(NEXTCLOUD)"

disable:
	@echo "Disabling $(NEXTCLOUD)"

clean:
	@echo "Cleaning $(NEXTCLOUD)"