.DEFAULT_GOAL := help

build-scaffolding: ## [Build] Launch the scaffolding
	@if [ '$(TAS_FOLDER)' == '' ]; then \
        echo "Call : make TAS_FOLDER=/path/to/your/tas build-scaffolding"; \
        exit 1; \
    fi
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
	    && cp lua_modules/share/lua/5.3/mediator.lua mediator.lua

cs-check: ## [CS] Launch the check of the code style
	luacheck --std=min+bizhawk assets/templates/new-tas-file.lua configuration core plugins scripts tas start.lua

install: ## [Install] In project and global dependencies (for development purpose)
	luarocks install luafilesystem --tree lua_modules
	luarocks install luacheck
	luarocks install luaunit

test: ## [Tests] Launch them all
	lua tests/core/test_input.lua -v
	lua tests/plugins/bizhawk/test_bizhawk.lua -v