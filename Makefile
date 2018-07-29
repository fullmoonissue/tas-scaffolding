.DEFAULT_GOAL := install

install:
	luarocks install mediator_lua --tree lua_modules
	luarocks install luafilesystem --tree lua_modules

build-scaffolding:
	@if [ '$(TAS_FOLDER)' == '' ]; then \
        echo "Call : make TAS_FOLDER=/path/to/tas build-scaffolding"; \
        exit 1; \
    fi
	rm -f tas-scaffolding.tar.gz
	touch tas-scaffolding.tar.gz
	tar -zcf tas-scaffolding.tar.gz --exclude=tas-scaffolding.tar.gz -X .tarignore .
	cp tas-scaffolding.tar.gz $(TAS_FOLDER)
	rm -f tas-scaffolding.tar.gz
	cd $(TAS_FOLDER) && tar zxvf tas-scaffolding.tar.gz
	cd $(TAS_FOLDER) && rm -f tas-scaffolding.tar.gz
	cd $(TAS_FOLDER) && mv config.lua.dist config.lua
	cd $(TAS_FOLDER) && mv templates/README.md README.md
	cd $(TAS_FOLDER) && mv templates/Makefile Makefile
	cd $(TAS_FOLDER) && make install
	cd $(TAS_FOLDER) && cp lua_modules/share/lua/5.3/mediator.lua mediator.lua

check:
	luacheck --std=min+bizhawk bizhawk tas templates paths.lua start.lua

install-dev:
	luarocks install luacheck
	luarocks install luaunit

test:
	lua tests/tas/test_dump.lua -v
	lua tests/tas/test_input.lua -v