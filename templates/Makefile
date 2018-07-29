.DEFAULT_GOAL := install

install:
	luarocks install mediator_lua --tree lua_modules
	luarocks install luafilesystem --tree lua_modules

bizhawk-dump:
	@if [ '$(TAS)' == '' ]; then \
        echo "Call : make TAS=tas-name bizhawk-dump"; \
        exit 1; \
    fi
	[ -d bizhawk/$(TAS) ] || mkdir bizhawk/$(TAS)
	lua -e "d=require('tas/dump')(); f=io.open('bizhawk/$(TAS)/Input Log.txt', 'w'); f:write(d.fromLuaInputsToBizhawksLog(d.fromLuaFilesToLuaInputs('tas', require('bizhawk/files'), '$(TAS)'))); f:close();"

bizhawk-lfs:
	@lua -e "f=io.open('bizhawk/files.lua', 'w'); f:write(require('tas/dump')().lfsForBizhawk('tas')); f:close();"

register:
	@if [ '$(TAS)' == '' ]; then \
        echo "Call : make TAS=tas-name FILE=example.lua register"; \
        exit 1; \
	elif [ '$(FILE)' == '' ]; then \
        echo "Call : make TAS=tas-name FILE=example.lua register"; \
        exit 1; \
    fi
	[ -d tas/$(TAS) ] || mkdir tas/$(TAS)
	lua -e "f=io.open('templates/new-tas-file.lua', 'rb'); c=f:read('*all'); f:close(); f=io.open('tas/$(TAS)/$(FILE)', 'w'); f:write(c); f:close();"
	@make bizhawk-lfs