###############################################################
# PODMAN MAKEFILE
#
# A place to store all of your application configurations
# and batch commands
###############################################################

SRV_LOCATION = /srv/$(shell whoami)
STORAGE_LOCATION = /mnt/storage/$(shell whoami)

###############################################################
# Container Names
###############################################################
DATABASE 	= database
NEXTCLOUD 	= nextcloud
ONLYOFFICE 	= onlyoffice
PROXY 		= proxy

###############################################################
# Container Ports
###############################################################
DATABASE_PORT		= 3306
NEXTCLOUD_PORT		= 8000
ONLYOFFICE_PORT		= 8001
PROXY_PORT		= 8181

SERVICE_DIR = ~/.config/systemd/user

all: database nextcloud onlyoffice proxy

list:
	@printf '%s:\tport: %s\n' "$(DATABASE)" "$(DATABASE_PORT)" | expand -t 20
	@printf '%s:\tport: %s\n' "$(NEXTCLOUD)" "$(NEXTCLOUD_PORT)" | expand -t 20
	@printf '%s:\tport: %s\n' "$(ONLYOFFICE)" "$(ONLYOFFICE_PORT)" | expand -t 20
	@printf '%s:\tport: %s\n' "$(PROXY)" "$(PROXY_PORT)" | expand -t 20

database:
	mkdir -p -- "$(SRV_LOCATION)/$(DATABASE)"
	podman create --name $(DATABASE) \
		--label "io.containers.autoupdate=image" \
		-p $(DATABASE_PORT):3306 \
		-v $(SRV_LOCATION)/$(DATABASE):/var/lib/mysql:z \
		-e MYSQL_ROOT_PASSWORD="$(shell pass mysql)" \
		-e MYSQL_PASSWORD="$(shell pass nextcloud_db)" \
		-e MYSQL_DATABASE=nextcloud \
		-e MYSQL_USER=nextcloud \
		-e --character-set-server=utf8mb4 \
		-e --transaction-isolation=READ-COMMITTED \
		-e --binlog-format=ROW \
		docker.io/library/mariadb:latest

nextcloud:
	mkdir -p -- "$(SRV_LOCATION)/$(NEXTCLOUD)"
	mkdir -p -- "$(STORAGE_LOCATION)/$(NEXTCLOUD)"
	podman create --name $(NEXTCLOUD) \
		--label "io.containers.autoupdate=image" \
		-p $(NEXTCLOUD_PORT):80 \
		-v $(SRV_LOCATION)/$(NEXTCLOUD):/var/www/html:z \
		-v $(STORAGE_LOCATION)/$(NEXTCLOUD):/var/www/html/data:z \
		-e NEXTCLOUD_ADMIN_USER="ncadmin" \
		-e NEXTCLOUD_ADMIN_PASSWORD="$(shell pass nextcloud_admin)" \
		-e MYSQL_HOST=$(shell hostname -i) \
		-e MYSQL_DATABASE=nextcloud \
		-e MYSQL_USER=nextcloud \
		-e MYSQL_PASSWORD="$(shell pass nextcloud_db)" \
		-e NEXTCLOUD_TRUSTED_DOMAINS="$(shell hostname -i)" \
		docker.io/library/nextcloud:stable

onlyoffice:
	podman create --name $(ONLYOFFICE) \
		-i -t -p 8001:80 \
		-e JWT_ENABLED=true \
		-e JWT_SECRET=$(shell pass OfficeSecret) \
		docker.io/onlyoffice/documentserver:latest

proxy:
	mkdir -p -- "$(SRV_LOCATION)/$(PROXY)"
	podman create --name $(PROXY) \
		-p 8181:8181 \
		-p 80:8080 \
		-p 443:4443 \
		-v $(SRV_LOCATION)/$(PROXY):/config:z \
		docker.io/jlesage/nginx-proxy-manager


start:
	podman start $(DATABASE)
	podman start $(NEXTCLOUD)
	podman start $(ONLYOFFICE)
	podman start $(PROXY)

stop:
	-podman stop $(DATABASE)
	-podman stop $(NEXTCLOUD)
	-podman stop $(ONLYOFFICE)
	-podman stop $(PROXY)

install:
	podman generate systemd --new --name $(DATABASE) > $(SERVICE_DIR)/$(DATABASE).service
	podman generate systemd --new --name $(NEXTCLOUD) > $(SERVICE_DIR)/$(NEXTCLOUD).service
	podman generate systemd --new --name $(ONLYOFFICE) > $(SERVICE_DIR)/$(ONLYOFFICE).service
	podman generate systemd --new --name $(PROXY) > $(SERVICE_DIR)/$(PROXY).service

enable:
	systemctl --user enable $(DATABASE).service
	systemctl --user enable $(NEXTCLOUD).service
	systemctl --user enable $(ONLYOFFICE).service
	systemctl --user enable $(PROXY).service

disable:
	-systemctl --user disable $(DATABASE).service
	-systemctl --user disable $(NEXTCLOUD).service
	-systemctl --user disable $(ONLYOFFICE).service
	-systemctl --user disable $(PROXY).service

remove:
	-podman container rm $(DATABASE)
	-podman container rm $(NEXTCLOUD)
	-podman container rm $(ONLYOFFICE)
	-podman container rm $(PROXY)

clean: stop remove disable
	-rm $(SERVICE_DIR)/$(DATABASE).service
	-rm $(SERVICE_DIR)/$(NEXTCLOUD).service
	-rm $(SERVICE_DIR)/$(ONLYOFFICE).service
	-rm $(SERVICE_DIR)/$(PROXY).service

help:
	@echo "USAGE: make TARGET [TARGET...]"
	@echo "Targets:"
	@echo -e "   help\t\t\tDisplay this help message"
	@echo -e "   all (default)\tCreate and start containers"
	@echo -e "   list\t\t\tList containers"
	@echo -e "   start\t\tStart containers"
	@echo -e "   stop\t\t\tStop containers"
	@echo -e "   install\t\tInstall systemd service files for containers"
	@echo -e "   enable\t\tEnable systemd service files for containers"
	@echo -e "   remove\t\tRemove all containers"
	@echo -e "   disable\t\tDisable systemd service files for containers"
	@echo -e "   clean\t\tClean up everything"
	@echo -e "   update\t\tTo update use the command: podman auto-update"

.PHONY: 
	all
	help
	list
	database
	nextcloud
	onlyoffice 
	proxy 
	start 
	stop 
	install 
	enable 
	disable
	remove
	clean
