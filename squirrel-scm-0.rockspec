package = "squirrel"
version = "scm-0"
source = {
   url = "git://github.com/flintinatux/squirrel",
   tag = version
}
description = {
   summary = "A practical functional library for lua",
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