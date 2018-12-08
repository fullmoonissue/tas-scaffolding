.DEFAULT_GOAL := help

build-scaffolding: ## [Build] Launch the scaffolding
	@if [ '$(TAS_FOLDER)' == '' ]; then \
        echo "Call : make TAS_FOLDER=/path/to/your/tas build-scaffolding"; \
        exit 1; \
    fi
	rm -f tas-scaffolding.tar.gz
	touch tas-scaffolding.tar.gz
	tar -zcf tas-scaffolding.tar.gz --exclude=tas-scaffolding.tar.gz -X .tarignore .
	cp tas-scaffolding.tar.gz $(TAS_FOLDER)
	rm -f tas-scaffolding.tar.gz
	cd $(TAS_FOLDER) \
	    && tar zxvf tas-scaffolding.tar.gz \
	    && rm -f tas-scaffolding.tar.gz \
	    && mv config.lua.dist config.lua \
	    && mv templates/README.md README.md \
	    && mv templates/Makefile Makefile \
	    && mv templates/.gitignore .gitignore \
	    && make install \
	    && cp lua_modules/share/lua/5.3/mediator.lua mediator.lua

cs-check: ## [CS] Launch the check of the code style
	luacheck --std=min+bizhawk bizhawk tas templates paths.lua start.lua

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## [Install] In project and global dependencies (for development purpose)
	luarocks install luafilesystem --tree lua_modules
	luarocks install luacheck
	luarocks install luaunit

test: ## [Tests] Launch them all
	lua tests/bizhawk/test_dump.lua -v
	lua tests/bizhawk/test_input.lua -v