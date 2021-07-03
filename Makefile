#
# -- Task: build-scaffolding --
#
# >> Create the scaffolding of a new tas <<
#
# !! Required variable !!
# TAS_FOLDER : Absolute path of the folder where the scaffolding will be created
#

build-scaffolding:
	@if [ '$(TAS_FOLDER)' == '' ]; then echo "Environment variable TAS_FOLDER missing"; exit 1; fi
	[ -d $(TAS_FOLDER) ] || mkdir $(TAS_FOLDER)
	rm -f tas-scaffolding.tar.gz
	touch tas-scaffolding.tar.gz
	tar -zcf tas-scaffolding.tar.gz --exclude=tas-scaffolding.tar.gz -X .tarignore .
	cp tas-scaffolding.tar.gz $(TAS_FOLDER)
	rm -f tas-scaffolding.tar.gz
	cd $(TAS_FOLDER) \
	    && tar zxvf tas-scaffolding.tar.gz \
	    && rm -f tas-scaffolding.tar.gz \
	    && mv configuration/play.lua.dist configuration/play.lua \
	    && mv assets/templates/README.md README.md \
	    && mv assets/templates/Makefile Makefile \
	    && mv assets/templates/.gitignore .gitignore \
	    && make install \
	    && cp lua_modules/share/lua/5.*/mediator.lua mediator.lua
	@echo "\n\n==>> Before starting, you can configure your tas with this command (example) : \n"
	@echo "make GAME=\"Devil Dice\" CONSOLE=\"PSX\" BIZHAWK=\"2.5.2\" CATEGORY=\"Any%\" describe-tas\n\n"

#
# -- Task: code-style-check --
#
# >> Check if the code style is respected <<
#

code-style-check:
	selene assets/templates/new-tas-file.lua configuration core plugins scripts tests start.lua

#
# -- Task: install --
#
# >> Install dependencies used when developing <<
#

install:
	luarocks install luaunit --tree lua_modules

#
# -- Task: test --
#
# >> Launch unit tests <<
#

LUA_TEST=lua -e 'package.path="./lua_modules/share/lua/5.1/?.lua;"..package.path;'
test:
	$(LUA_TEST) tests/core/test_input.lua -v
	$(LUA_TEST) tests/plugins/bizhawk/test_bizhawk.lua -v