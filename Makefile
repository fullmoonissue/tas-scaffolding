dump-lua-table:
	lua -l utils/dump -e "d = Dump('$(FILE)'); d:process('$(SECTION)'); d:write();"