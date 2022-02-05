.DEFAULT_GOAL := help

help:
	@awk 'BEGIN {FS = ":##"; printf "\033[36m\033[0m\n"} /^##/ { printf "\033[36m%-20s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST) | sed "s/## //g"

## +---------------------------+
## |  Task: build-scaffolding  |
## +---------------------------+
##
## >> Create the scaffolding of a new TAS project
##
## * Required environment variable
##
## - PROJECT_PATH
##

build-scaffolding:
	@if [ '$(PROJECT_PATH)' == '' ]; then echo "Environment variable PROJECT_PATH missing"; exit 1; fi
	[ -d $(PROJECT_PATH) ] || mkdir $(PROJECT_PATH)
	rm -f tas-scaffolding.tar.gz
	touch tas-scaffolding.tar.gz
	tar -zcf tas-scaffolding.tar.gz --exclude=tas-scaffolding.tar.gz -X .tarignore .
	cp tas-scaffolding.tar.gz $(PROJECT_PATH)
	rm -f tas-scaffolding.tar.gz
	cd $(PROJECT_PATH) \
	    && tar zxvf tas-scaffolding.tar.gz \
	    && rm -f tas-scaffolding.tar.gz \
	    && mv configuration/play.lua.dist configuration/play.lua \
	    && mv assets/templates/README.md README.md \
	    && mv assets/templates/Makefile Makefile \
	    && mv assets/templates/.gitignore .gitignore \
	    && make install \
	    && cp lua_modules/share/lua/5.*/mediator.lua mediator.lua

## +-----------------+
## |  Task: install  |
## +-----------------+
##
## >> Install dependencies used when developing
##

install:
	luarocks install luaunit --tree lua_modules

## +--------------+
## |  Task: test  |
## +--------------+
##
## >> Launch unit tests
##
## * Optional environment variable
##
## - LUA_TEST
##

LUA_TEST=lua -e 'package.path="./lua_modules/share/lua/5.1/?.lua;"..package.path;'
test:
	@echo "" ; $(LUA_TEST) tests/src/test_input.lua -v
	@echo "" ; $(LUA_TEST) tests/scripts/test_bizhawk.lua -v
	@echo ""

## +--------------------------+
## |  Task: code-style-check  |
## +--------------------------+
##
## >> Check if the code style is respected
##

code-style-check:
	selene assets/templates/new-inputs-file.lua configuration src scripts tas tests start.lua