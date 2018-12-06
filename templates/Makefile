.DEFAULT_GOAL := help

bizhawk-dump: ## [Dump] Export your inputs into the BizHawk Input Log.txt file
	@if [ '$(TAS)' == '' ]; then \
        echo "Call : make TAS=tas-name bizhawk-dump"; \
        exit 1; \
    fi
	[ -d bizhawk/dump/$(TAS) ] || mkdir bizhawk/dump/$(TAS)
	lua -e "d=require('bizhawk/dump')(); f=io.open('bizhawk/dump/$(TAS)/Input Log.txt', 'w'); f:write(d.fromLuaInputsToBizhawksLog(d.fromLuaFilesToLuaInputs('tas/categories', require('bizhawk/files'), '$(TAS)'))); f:close();"

bizhawk-lfs: ## [Dump] (Re)Write the bizhawk/files.lua file
	@lua -e "f=io.open('bizhawk/files.lua', 'w'); f:write(require('bizhawk/dump')().lfsForBizhawk('tas/categories')); f:close();"

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## [Install] Project dependencies
	luarocks install mediator_lua --tree lua_modules
	luarocks install luafilesystem --tree lua_modules

register: ## [TAS] Add a new file
	@if [ '$(TAS)' == '' ] || [ '$(FILE)' == '' ]; then \
        echo "Call (example) : make TAS=any% FILE=0-init.lua register"; \
        exit 1; \
    fi
	[ -d tas/categories/$(TAS) ] || mkdir tas/categories/$(TAS)
	lua -e "f=io.open('templates/new-tas-file.lua', 'rb'); c=f:read('*all'); f:close(); f=io.open('tas/categories/$(TAS)/$(FILE)', 'w'); f:write(c); f:close();"
	@make bizhawk-lfs