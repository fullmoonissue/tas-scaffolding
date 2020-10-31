.DEFAULT_GOAL := install

SCAFFOLDING_VERSION=3.3.0
SCAFFOLDING_URL=https://github.com/fullmoonissue/tas-scaffolding/tree/$(SCAFFOLDING_VERSION)

install: ## [Install] Project dependencies
	luarocks install mediator_lua --tree lua_modules
	luarocks install luafilesystem --tree lua_modules

# ### ### ### #
#  Variables  #
# ### ### ### #

# Path to the file containing all the paths to important files or folders
PATHS_FILE=configuration/paths

# Path to the bk2 folder (see "Archive bk2" section into the README.md of tas-scaffolding project)
BK2_FOLDER=`lua -e "c=require('$(PATHS_FILE)'); print(c['bk2']);"`

# Path to the tas file template (see "Introduction" section into the README.md of tas-scaffolding project)
TAS_FILE_TEMPLATE=`lua -e "c=require('$(PATHS_FILE)'); print(c['tpl_new_file']);"`

# Path to the tas folder (see "Introduction" section into the README.md of tas-scaffolding project)
TAS_FOLDER=`lua -e "c=require('$(PATHS_FILE)'); print(c['tas']);"`

# Path to the file which list the files for each tas
# (see "Technical difficulties" section into the README.md of tas-scaffolding project)
TAS_LFS=`lua -e "c=require('$(PATHS_FILE)'); print(c['files']);"`.lua

# ### ### #
# Scripts #
# ### ### #

#
# -- Task: bizhawk-dump --
#
# >> Export your lua inputs into the BizHawk's `Input Log.txt` file <<
#
# Required variable
# TAS : Name of the tas category (ex: any%)
#
# Optional variable (see "Variables" section above for explanations)
# TAS_LFS
# TAS_FOLDER
# BK2_FOLDER
#

bizhawk-dump:
	@if [ '$(TAS)' == '' ]; then \
        echo "Call : make TAS=any% bizhawk-dump"; \
        exit 1; \
    fi
	@[ -d $(BK2_FOLDER)/$(TAS) ] || mkdir $(BK2_FOLDER)/$(TAS)
	@lua scripts/bizhawk-dump.lua $(TAS) $(TAS_LFS) $(TAS_FOLDER) $(BK2_FOLDER)

#
# -- Task: bizhawk-lfs --
#
# >> (Re)Write the file listing the files for each tas <<
#
# Optional variable (see "Variables" section above for explanations)
# TAS_LFS
# TAS_FOLDER
#

bizhawk-lfs:
	@lua scripts/bizhawk-lfs.lua $(TAS_LFS) $(TAS_FOLDER)

#
# -- Task: register --
#
# >> Register a new file for a specific tas <<
#
# Required variable
# TAS : Name of the tas (ex: any%)
# FILE : Name of the file (ex: 0-init.lua)
#
# Optional variable (see "Variables" section above for explanations)
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