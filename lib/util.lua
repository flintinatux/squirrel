local insert = table.insert
local remove = table.remove
local unpack = table.unpack

local add, compose, concat, curry, curryN, head, init, last, partial, pipe, prop, reduce, reverse, tail

-- Internal

function _curryN(n, fn)
  if n <= 1 then return fn end
  return function (...)
    local args = {...}
    if #args < n then
      return _curryN(n - #args, partial(fn, args))
    else
      return fn(...)
    end
  end
end

function _length(fn)
  return debug.getinfo(fn, 'u').nparams
end

-- API

-- add : number -> number -> number
add = _curryN(2, function (a, b)
  return a + b
end)

-- compose : ((y -> z), (x -> y), ..., (a -> b)) -> a -> z
compose = function (...)
  return pipe(unpack(reverse({...})))
end

-- concat : [a] -> [a] -> [a]
concat = _curryN(2, function (a, b)
  local c = {}
  for i,v in ipairs(a) do insert(c, v) end
  for i,v in ipairs(b) do insert(c, v) end
  return c
end)

-- curry : ((a, b, ...) -> z) -> a -> b -> ... -> z
curry = function (fn)
  return _curryN(_length(fn), fn)
end

-- curryN : number -> ((a, b, ...) -> z) -> a -> b -> ... -> z
curryN = _curryN(2, _curryN)

-- head : [a] -> a
head = function(list)
  return list[1]
end

-- init : [a] -> [a]
init = function(a)
  local b = {}
  for i, v in ipairs(a) do insert(b, v) end
  remove(b)
  return b
end

-- last : [a] -> a
last = function(list)
  return list[#list]
end

-- partial : ((a, b, ...) -> z) -> [a, b, ...] -> ((c, d, ...) -> z)
partial = _curryN(2, function (fn, args)
  return function (...)
    return fn(unpack(concat(args, {...})))
  end
end)

-- pipe : ((a -> b), (b -> c), ..., (y -> z)) -> a -> z
pipe = function (...)
  local fs = {...}
  local first = remove(fs, 1)
  return function (...)
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
reverse = function (a)
  local b = {}
  for i = #a, 1, -1 do
    insert(b, a[i])
  end
  return b
end

-- tail : [a] -> [a]
tail = function(a)
  local b = {}
  for i, v in ipairs(a) do insert(b, v) end
  remove(b, 1)
  return b
end

-- Testing

local addFive = compose(add(2), add(3))
assert(addFive(6) == 11)

local five = partial(head, { { 5 } })
assert(five() == 5)

local sum = reduce(add, 0)
assert(sum(tail({ 1, 2, 3, 4 })) == 9)

-- Export

return {
  add     = add,
  compose = compose,
  concat  = concat,
  curry   = curry,
  curryN  = curryN,
  head    = head,
  init    = init,
  last    = last,
  partial = partial,
  pipe    = pipe,
  prop    = prop,
  reduce  = reduce,
  reverse = reverse,
  tail    = tail
}
