package = "squirrel"
version = "scm-0"
source = {
   url = "git://github.com/flintinatux/squirrel",
   tag = version
}
description = {
   summary = "A nimble functional library for Lua",
   homepage = "https://flintinatux.github.io/squirrel",
   license = "MIT"
}
dependencies = {
   "lua >= 5.2"
}
build = {
   type = "builtin",
   modules = {
      squirrel = "squirrel.lua"
   }
}
