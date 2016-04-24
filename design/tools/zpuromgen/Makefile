#################
## DESCRIPTION ##
#################

# Makefile to generate ROM contents
# from a bin file generated through SW
# compilation

##############
## INCLUDES ##
##############

include ../Makefile.common

####################
## DIRECTORY INFO ##
####################

##################
## PROJECT INFO ##
##################

###########
## TOOLS ##
###########

################
## FILE NAMES ##
################
ZPUROMGEN_RUN_FILE = zpuromgen.x

######################
## ENVIRONMENT INFO ##
######################

#############
## SOURCES ##
#############

ZPUROMGEN_SOURCES = zpuromgen.c

###########
## OTHER ##
###########

##############
## COMMANDS ##
##############

commands:
	@echo ""
	@echo "$(HEAD) Available commands: $(TAIL)"
	@echo
	@echo "  CLEAN   : Show information on the database"
	@echo "  COMPILE : Clean database"
	@echo "  INSTALL : Installs tool"
	@echo ""

#############
## ACTIONS ##
#############

CLEAN:
	@echo "Cleaning zpuromgen..."
	@-\rm $(ZPUROMGEN_RUN_FILE)

COMPILE:
	@echo "Compiling zpuromgen..."
	$(GCC) -o $(ZPUROMGEN_RUN_FILE) $(ZPUROMGEN_SOURCES)

INSTALL:
	@echo "Installing zpuromgen..."
	cp ./$(ZPUROMGEN_RUN_FILE) ../bin/$(ZPUROMGEN_RUN_FILE)
