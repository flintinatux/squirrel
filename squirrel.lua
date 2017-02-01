local getinfo = debug.getinfo
local insert, remove, unpack = table.insert, table.remove, table.unpack
local ipairs, pairs = ipairs, pairs

local add, compose, concat, curry, curryN, flip, evolve, head, init, is, last, map, partial, pick, pipe, prop, reduce, reverse, tail

-- Internal

function _assign(a, b)
  for k, v in pairs(b) do a[k] = v end
  return a
end

function _cloneArray(a)
  local b = {}
  for k, v in ipairs(a) do insert(b, v) end
  return b
end

function _cloneTable(a)
  local b = {}
  return _assign(b, a)
end

function _curryN(n, fn)
  if n <= 1 then return fn end
  return function(...)
    local args = {...}
    if #args < n then
      return _curryN(n - #args, partial(fn, args))
    else
      return fn(...)
    end
  end
end

function _length(fn)
  return getinfo(fn, 'u').nparams
end

-- API

-- add : number -> number -> number
add = _curryN(2, function(a, b)
  return a + b
end)

-- compose : ((y -> z), (x -> y), ..., (a -> b)) -> a -> z
compose = function(...)
  return pipe(unpack(reverse({...})))
end

-- concat : [a] -> [a] -> [a]
concat = _curryN(2, function(a, b)
  local c = _cloneArray(a)
  for i, v in ipairs(b) do insert(c, v) end
  return c
end)

-- curry : ((a, b, ...) -> z) -> a -> b -> ... -> z
curry = function(fn)
  return _curryN(_length(fn), fn)
end

-- curryN : number -> ((a, b, ...) -> z) -> a -> b -> ... -> z
curryN = _curryN(2, _curryN)

-- evolve : { k = (v -> v) } -> { k = v } -> { k = v }
evolve = _curryN(2, function(xfrms, obj)
  local res = {}
  for key, val in pairs(obj) do
    local xfrm = xfrms[key]
    res[key] = type(xfrm) == 'function' and xfrm(val)
            or type(xfrm) == 'table'    and evolve(xfrm, val)
            or val
  end
  return res
end)

-- flip : (a -> b -> ... -> z) -> b -> a -> ... -> z
flip = function(fn)
  fn = curry(fn)
  return _curryN(2, function(a, b, ...)
    return fn(b, a, ...)
  end)
end

-- head : [a] -> a
head = function(list)
  return list[1]
end

-- init : [a] -> [a]
init = function(a)
  local b = _cloneArray(a)
  remove(b)
  return b
end

-- is : string -> a -> boolean
is = _curryN(2, function(typestring, a)
  return type(a) == typestring
end)

-- last : [a] -> a
last = function(list)
  return list[#list]
end

-- map : (a -> b) -> [a] -> [b]
map = _curryN(2, function(fn, a)
  local b = {}
  for i, v in ipairs(a) do insert(b, fn(v)) end
  return b
end)

-- partial : ((a, b, ...) -> z) -> [a, b, ...] -> ((c, d, ...) -> z)
partial = _curryN(2, function(fn, args)
  return function(...)
    return fn(unpack(concat(args, {...})))
  end
end)

-- pick : [string] -> { k = v } -> { k = v }
pick = _curryN(2, function(keys, a)
  local b = {}
  for i, key in ipairs(keys) do b[key] = a[key] end
  return b
end)

-- pipe : ((a -> b), (b -> c), ..., (y -> z)) -> a -> z
pipe = function(...)
  local fs = {...}
  local first = remove(fs, 1)
  return function(...)
    local val = first(...)
    for i, fn in ipairs(fs) do
      val = fn(val)
    end
    return val
  end
end

-- prop : (string | number) -> table -> *
prop = _curryN(2, function(key, table)
  return table[key]
end)

-- reduce : (b -> a -> b) -> b -> [a] -> b
reduce = _curryN(3, function(fn, acc, list)
  for i, val in ipairs(list) do
    acc = fn(acc, val)
  end
  return acc
end)

-- reverse : [a] -> [a]
reverse = function(a)
  local b = {}
  for i = #a, 1, -1 do
    insert(b, a[i])
  end
  return b
end

-- tail : [a] -> [a]
tail = function(a)
  local b = _cloneArray(a)
  remove(b, 1)
  return b
end

local squirrel = {
  add     = add,
  compose = compose,
  concat  = concat,
  curry   = curry,
  curryN  = curryN,
  evolve  = evolve,
  flip    = flip,
  head    = head,
  init    = init,
  is      = is,
  last    = last,
  map     = map,
  partial = partial,
  pick    = pick,
  pipe    = pipe,
  prop    = prop,
  reduce  = reduce,
  reverse = reverse,
  tail    = tail
}

squirrel.import = function(ctx)
  ctx = ctx or _G
  return _assign(ctx, squirrel)
end

return squirrel
