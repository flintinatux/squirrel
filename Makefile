DEV_ROCKS = busted ldoc luacheck penlight

dev: install
	@for rock in $(DEV_ROCKS) ; do \
		if ! luarocks list | grep $$rock > /dev/null ; then \
      echo $$rock not found, installing via luarocks... ; \
      luarocks install $$rock ; \
    else \
      echo $$rock already installed, skipping ; \
    fi \
	done;
	@yarn global add luamin

install:
	@luarocks make

min:
	@luamin -f squirrel.lua > squirrel_min.lua

test:
	@busted -v -o plainTerminal spec/
