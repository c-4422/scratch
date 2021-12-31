#########################################################
# TEST MAKEFILE
#########################################################
IP_ADDRESS=192.168.1.232

SUBDIRS := $(wildcard *containers/*.mk)

all:
	@export IP_ADDRESS
	@$(foreach file, $(SUBDIRS), make -f $(file);)

start:
	@$(foreach file, $(SUBDIRS), make -f $(file) start;)

stop:
	@$(foreach file, $(SUBDIRS), make -f $(file) stop;)

install:
	@$(foreach file, $(SUBDIRS), make -f $(file) install;)

enable:
	@$(foreach file, $(SUBDIRS), make -f $(file) enable;)

disable:
	@$(foreach file, $(SUBDIRS), make -f $(file) disable;)

clean:
	@$(foreach file, $(SUBDIRS), make -f $(file) clean;)

list:
	@printf '+-------------------+---------------------------------------+----------\n'
	@printf '|NAME               |CONTAINER MAKE COMMAND                 |PORT\n'
	@printf '+-------------------+---------------------------------------+----------\n'
	@$(foreach file, $(SUBDIRS), printf '|%s\t|make -f %s\t|%s\n' "$(shell make -f $(file) name)" \
	"$(file)" "$(shell make -f $(file) port)" | expand -t 20;)
	@printf '\n'

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

.PHONY: all start stop install enable disable clean list help