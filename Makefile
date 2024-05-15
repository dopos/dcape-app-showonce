## dcape-app-template Makefile
## This file extends Makefile.app from dcape
#:

SHELL               = /bin/bash
CFG                ?= .env
CFG_BAK            ?= $(CFG).bak

#- App name
APP_NAME           ?= showonce
#- Docker image name
IMAGE              ?= ghcr.io/lekovr/showonce
#- Docker image tag
IMAGE_VER          ?= v1.1.2

# -----------------------------------------------------------------------------
# App config

#- Auth service type
AS_TYPE       ?= gitea
#- Auth service URL
AS_HOST       ?= https://git.dev.test
#- Auth service org
AS_TEAM       ?= dcape
#- Auth service client_id
AS_CLIENT_ID  ?= you_should_get_id_from_as
#- Auth service client key
AS_CLIENT_KEY ?= you_should_get_key_from_as

#- Auth service cookie sign key
AS_COOKIE_SIGN_KEY   ?= $(shell openssl rand -hex 16; echo)

#- Auth service cookie crypt key
AS_COOKIE_CRYPT_KEY  ?= $(shell openssl rand -hex 16; echo)

#- URL scheme (calculated by make)
DCAPE_SCHEME  ?=

# ------------------------------------------------------------------------------

# if exists - load old values
-include $(CFG_BAK)
export

-include $(CFG)
export

# ------------------------------------------------------------------------------
# Find and include DCAPE_ROOT/Makefile
DCAPE_COMPOSE   ?= dcape-compose
DCAPE_ROOT      ?= $(shell docker inspect -f "{{.Config.Labels.dcape_root}}" $(DCAPE_COMPOSE))

ifeq ($(shell test -e $(DCAPE_ROOT)/Makefile.app && echo -n yes),yes)
  include $(DCAPE_ROOT)/Makefile.app
else
  include /opt/dcape/Makefile.app
endif

# ------------------------------------------------------------------------------
