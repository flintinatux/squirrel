DEV_ROCKS = busted inspect ldoc luacheck penlight

build: test lint doc min

dev:
	@for rock in $(DEV_ROCKS) ; do \
		if ! luarocks list | grep $$rock > /dev/null ; then \
      echo $$rock not found, installing via luarocks... ; \
      luarocks install $$rock ; \
    else \
      echo $$rock already installed, skipping ; \
    fi \
	done;
	@yarn global add luamin

doc:
	@ldoc .

install:
	@luarocks make

lint:
	@luacheck squirrel.lua

min:
	@luamin -f squirrel.lua > squirrel_min.lua

test:
	@busted -v -o plainTerminal --helper=spec/helper.lua spec/
