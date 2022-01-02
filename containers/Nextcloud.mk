###############################################################
# Nextcloud Container Configuration File
###############################################################
NEXTCLOUD=nextcloud
DATABASE=next_db
NEXTCLOUD_PORT=8000
DATABASE_PORT=3306

# Pass names
NEXTCLOUD_PASS=nextcloud_admin
NEXTCLOUD_DB=next_db
NEXTCLOUD_DB_ROOT=next_db_root

container:
	@echo "Making nextcloud"
	@echo "IP_ADDRESS = $(IP_ADDRESS)"

name:
	@echo "$(NEXTCLOUD)/$(DATABASE)"

port:
	@echo "$(NEXTCLOUD_PORT)/$(DATABASE_PORT)"

password:
	@printf '%s:\t%s\n' "$(NEXTCLOUD)" "$(NEXTCLOUD_PASS)" | expand -t 15
	@printf '%s:\t%s, %s\n' "$(DATABASE)" "$(NEXTCLOUD_DB_ROOT)" "$(NEXTCLOUD_DB)" | expand -t 15

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