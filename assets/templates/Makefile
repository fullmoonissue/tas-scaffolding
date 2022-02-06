.DEFAULT_GOAL := help

SCAFFOLDING_VERSION=4.1.0

help:
	@awk 'BEGIN {FS = ":##"; printf "\033[36m\033[0m\n"} /^##/ { printf "\033[36m%-20s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST) | sed "s/## //g"

PATHS_FILE=configuration/paths
BK2_FOLDER=`lua -e "c=require('$(PATHS_FILE)'); print(c['folder']['bk2']);"`
PUBLICATION_FOLDER=`lua -e "c=require('$(PATHS_FILE)'); print(c['folder']['publication']);"`
TAS_FILE_TEMPLATE=`lua -e "c=require('$(PATHS_FILE)'); print(c['template']['newFile']);"`
TAS_FOLDER=`lua -e "c=require('$(PATHS_FILE)'); print(c['folder']['tas']);"`
TAS_LFS=`lua -e "c=require('$(PATHS_FILE)'); print(c['tas']['files']);"`.lua

## +-----------------+
## |  Task: install  |
## +-----------------+
##
## >> Install dependencies used to setup a new first TAS
##

install:
	luarocks install mediator_lua --tree lua_modules

## +------------------------------------+
## |  Task: bizhawk-bk2-archive-create  |
## +------------------------------------+
##
## >> Create the bk2 archive
##
## * Required environment variables
##
## - TAS_CATEGORY
## - BK2_PATH_COMMENTS
## - BK2_PATH_HEADER
## - BK2_PATH_INPUT_LOG
## - BK2_PATH_SUBTITLES
## - BK2_PATH_SYNC_SETTINGS
##
## * Optional environment variable
##
## - BK2_FOLDER
##

bizhawk-bk2-archive-create:
	@7za a -tzip $(PWD)/$(BK2_FOLDER)/$(TAS_CATEGORY).bk2 $(BK2_PATH_COMMENTS) $(BK2_PATH_HEADER) "$(BK2_PATH_INPUT_LOG)" $(BK2_PATH_SUBTITLES) $(BK2_PATH_SYNC_SETTINGS)

## +-------------------------------------+
## |  Task: bizhawk-bk2-archive-extract  |
## +-------------------------------------+
##
## >> Extract the bk2 archive
##
## * Required environment variable
##
## - TAS_CATEGORY
##
## * Optional environment variable
##
## - BK2_FOLDER
##

bizhawk-bk2-archive-extract:
	@[ -d $(PWD)/$(BK2_FOLDER))/$(TAS_CATEGORY) ] || mkdir $(PWD)/$(BK2_FOLDER))/$(TAS_CATEGORY)
	@7z x $(PWD)/$(BK2_FOLDER)/$(TAS_CATEGORY).bk2 -o$(PWD)/$(BK2_FOLDER))/$(TAS_CATEGORY)

## +--------------------------------------+
## |  Task: bizhawk-bk2-update-input-log  |
## +--------------------------------------+
##
## >> Update the "Input Log.txt" file into an existing bk2 archive
##
## * Required environment variables
##
## - TAS_CATEGORY
## - BK2_PATH_INPUT_LOG
##
## * Optional environment variable
##
## - BK2_FOLDER
##

bizhawk-bk2-update-input-log:
	@make TAS_CATEGORY=$(TAS_CATEGORY) bizhawk-bk2-archive-extract
	@make TAS_CATEGORY=$(TAS_CATEGORY) BK2_PATH_COMMENTS=$(PWD)/$(BK2_FOLDER)/Comments.txt BK2_PATH_HEADER=$(PWD)/$(BK2_FOLDER)/Header.txt BK2_PATH_INPUT_LOG=$(BK2_PATH_INPUT_LOG) BK2_PATH_SUBTITLES=$(PWD)/$(BK2_FOLDER)/Subtitles.txt BK2_PATH_SYNC_SETTINGS=$(PWD)/$(BK2_FOLDER)/SyncSettings.json bizhawk-bk2-archive-create
	@rm -f $(PWD)/$(BK2_FOLDER)/Comments.txt $(PWD)/$(BK2_FOLDER)/Header.txt "$(PWD)/$(BK2_FOLDER)/Input Log.txt" $(PWD)/$(BK2_FOLDER)/Subtitles.txt $(PWD)/$(BK2_FOLDER)/SyncSettings.json

## +----------------------+
## |  Task: bizhawk-dump  |
## +----------------------+
##
## >> Export your lua inputs into the BizHawk's `Input Log.txt` file
##
## * Required environment variable
##
## - TAS_CATEGORY
##
## * Optional environment variables
##
## - TAS_LFS
## - TAS_FOLDER
## - BK2_FOLDER
##

bizhawk-dump:
	@if [ '$(TAS_CATEGORY)' == '' ]; then \
        echo "Call : make TAS_CATEGORY=any% bizhawk-dump"; \
        exit 1; \
    fi
	@[ -d $(BK2_FOLDER)/$(TAS_CATEGORY) ] || mkdir $(BK2_FOLDER)/$(TAS_CATEGORY)
	@lua scripts/bizhawk-dump.lua $(TAS_CATEGORY) $(TAS_LFS) $(TAS_FOLDER) $(BK2_FOLDER)
	@if [ '$(COMMENTS_FILE)' != '' && '$(HEADER_FILE)' != '' && '$(SUBTITLES_FILE)' != '' && '$(SYNC_SETTINGS_FILE)' != '' ]; then \
        @make TAS_CATEGORY=$(TAS_CATEGORY) BK2_PATH_COMMENTS=$(COMMENTS_FILE) BK2_PATH_HEADER=$(HEADER_FILE) BK2_PATH_INPUT_LOG=$(PWD)/$(BK2_FOLDER)/Input\ Log.txt BK2_PATH_SUBTITLES=$(SUBTITLES_FILE) BK2_PATH_SYNC_SETTINGS=$(SYNC_SETTINGS_FILE) bizhawk-bk2-archive-create; \
        echo "Archive created !"; \
    fi

## +-----------------------+
## |  Task: bizhawk-parse  |
## +-----------------------+
##
## >> Export your BizHawk's `Input Log.txt` file into lua inputs
##
## * Required environment variable
##
## - TAS_CATEGORY
##
## * Optional environment variables
##
## - TAS_FOLDER
## - BK2_FOLDER
##

bizhawk-parse:
	@if [ '$(TAS_CATEGORY)' == '' ]; then \
        echo "Call : make TAS_CATEGORY=any% bizhawk-parse"; \
        exit 1; \
    fi
	@[ -d $(TAS_FOLDER)/$(TAS_CATEGORY) ] || mkdir $(TAS_FOLDER)/$(TAS_CATEGORY)
	@lua scripts/bizhawk-parse.lua $(TAS_FOLDER) $(TAS_CATEGORY) "$(PWD)/$(BK2_FOLDER)/$(TAS_CATEGORY)/Input Log.txt"

## +---------------------+
## |  Task: bizhawk-lfs  |
## +---------------------+
##
## >> (Re)Write the file listing the files for each TAS category
##
## * Optional environment variables
##
## - TAS_LFS
## - TAS_FOLDER
##

bizhawk-lfs:
	@lua scripts/bizhawk-lfs.lua $(TAS_LFS) $(TAS_FOLDER)

## +------------------+
## |  Task: register  |
## +------------------+
##
## >> Register a new file for a specific TAS
##
## * Required environment variables
##
## - TAS_CATEGORY
## - FILE
##
## * Optional environment variables
##
## - TAS_FOLDER
## - TAS_FILE_TEMPLATE
##

register:
	@if [ '$(TAS_CATEGORY)' == '' ] || [ '$(FILE)' == '' ]; then \
        echo "Call (example) : make TAS_CATEGORY=any% FILE=0-init.lua register"; \
        exit 1; \
    fi
	@[ -d $(TAS_FOLDER)/$(TAS_CATEGORY) ] || mkdir $(TAS_FOLDER)/$(TAS_CATEGORY)
	@lua scripts/register.lua $(TAS_CATEGORY) $(FILE) $(TAS_FOLDER) $(TAS_FILE_TEMPLATE)
	@make bizhawk-lfs

## +---------+
## |  Video  |
## +---------+
##
## Easy setup to produce youtube videos :
##
## > Writer : FFMPEG Writer
## > Video Format : MP4
##
## +--------------------------+
## |  Task: video-glue-parts  |
## +--------------------------+
##
## >> Create one video by joining fragments using ffmpeg
##
## * Required environment variables
##
## - FFMPEG
## - GAME
## - TAS_CATEGORY
##

video-glue-parts:
	@$(FFMPEG) -f concat -safe 0 -i $(PWD)/$(PUBLICATION_FOLDER)/$(TAS_CATEGORY)/$(GAME)-video-parts.txt -c copy $(PWD)/$(PUBLICATION_FOLDER)/tas-$(GAME)-$(TAS_CATEGORY).avi

## +-----------------------------+
## |  Task: video-prepare-parts  |
## +-----------------------------+
##
## >> Create the file needed by ffmpeg to glue video parts together
##
## * Required environment variable
##
## - GAME
##

video-prepare-parts:
	@ls $(PWD)/$(PUBLICATION_FOLDER)/$(TAS_CATEGORY)/$(GAME)* | sed "s/^/file '/" | sed "s/$$/'/" > $(PWD)/$(PUBLICATION_FOLDER)/$(TAS_CATEGORY)/$(GAME)-video-parts.txt