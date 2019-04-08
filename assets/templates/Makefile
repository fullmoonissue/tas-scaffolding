.DEFAULT_GOAL := install

# ### ### ### #
#  Variables  #
# ### ### ### #

# Path to the file containing all the paths to important files or folders
PATHS_FILE=configuration/paths

# Path to the file which list the files of the different tas
LFS_TAS_FILE=`lua -e "c=require('$(PATHS_FILE)'); print(c['files']);"`.lua

# Path to the tas folder
TAS_FOLDER=`lua -e "c=require('$(PATHS_FILE)'); print(c['tas']);"`

# Path to the bk2 folder
BK2_FOLDER=`lua -e "c=require('$(PATHS_FILE)'); print(c['bk2']);"`

# Path to the tas file template
TAS_FILE_TEMPLATE=`lua -e "c=require('$(PATHS_FILE)'); print(c['tpl_new_file']);"`

# ### ### #
# Scripts #
# ### ### #

#
# -- Task: bizhawk-dump --
#
# >> Export your inputs into the BizHawk's `Input Log.txt` file <<
#
# Required variable
# TAS : Name of the tas (ex: any%)
#
# Optional variable
# LFS_TAS_FILE
# TAS_FOLDER
# BK2_FOLDER
#

bizhawk-dump:
	@if [ '$(TAS)' == '' ]; then \
        echo "Call : make TAS=any% bizhawk-dump"; \
        exit 1; \
    fi
	@[ -d $(BK2_FOLDER)/$(TAS) ] || mkdir $(BK2_FOLDER)/$(TAS)
	@lua scripts/bizhawk-dump.lua $(TAS) $(LFS_TAS_FILE) $(TAS_FOLDER) $(BK2_FOLDER)

#
# -- Task: bizhawk-lfs --
#
# >> (Re)Write the file listing the files of the different tas <<
#
# Optional variable
# LFS_TAS_FILE
# TAS_FOLDER
#

bizhawk-lfs:
	@lua scripts/bizhawk-lfs.lua $(LFS_TAS_FILE) $(TAS_FOLDER)

#
# -- Task: register --
#
# >> Add a new file <<
#
# Required variable
# TAS : Name of the tas (ex: any%)
# FILE : Name of the file (ex: 0-init.lua)
#
# Optional variable
# TAS_FOLDER
# TAS_FILE_TEMPLATE
#

register:
	@if [ '$(TAS)' == '' ] || [ '$(FILE)' == '' ]; then \
        echo "Call (example) : make TAS=any% FILE=0-init.lua register"; \
        exit 1; \
    fi
	@[ -d $(TAS_FOLDER)/$(TAS) ] || mkdir $(TAS_FOLDER)/$(TAS)
	@lua scripts/register.lua $(TAS) $(FILE) $(TAS_FOLDER) $(TAS_FILE_TEMPLATE)
	@make bizhawk-lfs

# ### ### #
#  Utils  #
# ### ### #

install: ## [Install] Project dependencies
	luarocks install mediator_lua --tree lua_modules
	luarocks install luafilesystem --tree lua_modules