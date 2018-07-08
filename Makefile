install:
	luarocks install mediator_lua --tree lua_modules
	luarocks install luafilesystem --tree lua_modules

install-dev:
	luarocks install luaunit
	luarocks install luacheck

init:
	@mv config.lua.dist config.lua
	@mv doc/README-template.md README.md
	@rm -rf doc
	@rm -f tas-scaffolding.tar.gz
	@cp lua_modules/share/lua/5.3/mediator.lua mediator.lua

bizhawk-dump:
	@if [ '$(TAS)' == '' ]; then \
        echo "Call : make TAS=tas-name bizhawk"; \
    else \
        [ -d bizhawk/$(TAS) ] || mkdir bizhawk/$(TAS); \
        lua -e "d=require('tas/dump')(); f=io.open('bizhawk/$(TAS)/Input Log.txt', 'w'); f:write(d.fromLuaInputsToBizhawksLog(d.fromLuaFilesToLuaInputs('tas', require('bizhawk/files'), '$(TAS)'))); f:close();"; \
	fi

bizhawk-lfs:
	@lua -e "f=io.open('bizhawk/files.lua', 'w'); f:write(require('tas/dump')().lfsForBizhawk('tas')); f:close();"

build-scaffolding:
	@rm -f tas-scaffolding.tar.gz
	@touch tas-scaffolding.tar.gz
	@tar -zcf tas-scaffolding.tar.gz --exclude=tas-scaffolding.tar.gz -X .tarignore .
	@cat doc/build-scaffolding.md

check:
	luacheck --std=min+bizhawk bizhawk tas templates paths.lua start.lua

register:
	@if [ '$(TAS)' == '' ]; then \
        echo "Call : make TAS=tas-name FILE=example.lua register"; \
	elif [ '$(FILE)' == '' ]; then \
        echo "Call : make TAS=tas-name FILE=example.lua register"; \
    else \
        [ -d tas/$(TAS) ] || mkdir tas/$(TAS); \
        lua -e "f=io.open('templates/new-tas-file.lua', 'rb'); c=f:read('*all'); f:close(); f=io.open('tas/$(TAS)/$(FILE)', 'w'); f:write(c); f:close();"; \
	fi
	@make bizhawk-lfs